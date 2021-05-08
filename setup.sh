# Couleur
RED='\e[0;31m'
GREEN='\e[0;32m'
YELLOW='\e[0;33m'
BLUE='\e[0;34m'
PURPLE='\e[0;35m'
CYAN='\e[0;36m'
END='\e[0;0m'

# Kill tout les processes.
minikube delete
killall -TERM kubectl minikube VBoxHeadless

# Demarre Minikube
minikube start --vm-driver=docker

# Pointe le client docker vers le daemon docker de la VM permettant ainsi d'acceder au images en local
eval $(minikube docker-env)

# Recupere l'adress IP attribuer par minikube
SERVER_IP=$(minikube ip | grep -oE "\b([0-9]{1,3}\.){3}\b")

# Remplace dans les fichiers IP par l'IP minikube
sed -i.bak "s/IP/"$SERVER_IP"/g" srcs/metallb-configmap.yaml > /dev/null
sed -i.bak "s/IP/"$SERVER_IP"/g" srcs/nginx/srcs/index.html > /dev/null

# Construction des images dockers utilise par les services generer ensuite par Kubernetes
# "> /dev/null 2>&1" redirige la sortie du programme vers /dev/null.
# Incluant à la fois l'erreur standard et la sortie standard
echo "${CYAN}🐳${END}  ${BLUE}Build des images Docker...${END}"
docker build -t service_nginx ./srcs/nginx > /dev/null 2>&1
docker build -t service_mysql ./srcs/mysql 
docker build -t service_phpmyadmin ./srcs/phpmyadmin > /dev/null 2>&1
docker build -t service_wordpress ./srcs/wordpress > /dev/null 2>&1
docker build -t service_ftps ./srcs/ftps > /dev/null 2>&1
docker build -t service_influxdb ./srcs/influxdb > /dev/null 2>&1
docker build -t service_grafana ./srcs/grafana > /dev/null 2>&1
docker build -t service_telegraf ./srcs/telegraf > /dev/null 2>&1
echo "${GREEN}😄  ${GREEN}Done${END}"

# Creer les secrets pour influxdb et telegraf
echo "${YELLOW}✨${END}  ${BLUE}Generation de la cle secrete necessaire a InfluxDB et Telegraf...${END}"
kubectl create secret generic influxdb-secret \
    --from-literal=influxdb_admin_user='user' --from-literal=influxdb_admin_password='password' \
    --from-literal=influxdb_config_path='/etc/influxdb.conf'
kubectl create secret generic telegraf-secret \
    --from-literal=influxdb_db='telegraf' --from-literal=influxdb_url='http://influxdb-svc:8086'
echo "${GREEN}😄  ${GREEN}Done${END}"

sh ./srcs/generate_ssl.sh

kubectl create secret tls ftps-ssl --cert ./srcs/ftps/srcs/vsftpd.crt --key ./srcs/ftps/srcs/vsftpd.key

kubectl create configmap ftps-config --from-file=./srcs/ftps/srcs/vsftpd.conf
kubectl create configmap mysql-config --from-file=./srcs/mysql/srcs/my.cnf

# Creation et deploiments des pods, replicaset, service, deployment et namespace a partir des fichier de configuration yaml
echo "${RED}🚀${END}  ${BLUE}Creation des differents pods/services...${END}"
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/namespace.yaml > /dev/null 2>&1
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/metallb.yaml > /dev/null 2>&1
kubectl apply -f srcs/metallb-configmap.yaml > /dev/null 2>&1
kubectl apply -f srcs/mysql.yaml
kubectl apply -f srcs/phpmyadmin.yaml > /dev/null 2>&1
kubectl apply -f srcs/wordpress.yaml > /dev/null 2>&1
kubectl apply -f srcs/ftps.yaml > /dev/null 2>&1
kubectl apply -f srcs/nginx.yaml > /dev/null 2>&1
kubectl apply -f srcs/influxdb.yaml > /dev/null 2>&1
kubectl apply -f srcs/grafana.yaml > /dev/null 2>&1
kubectl apply -f srcs/telegraf.yaml > /dev/null 2>&1
echo "${GREEN}😄  ${GREEN}Done${END}"


echo "${YELLOW}✨${END}  ${BLUE}Generation de la cle secrete necessaire a Metallb...${END}"
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)" 
echo "${GREEN}😄  ${GREEN}Done${END}"


# Active les addons dashboard
minikube addons enable dashboard
# Certaines features du Dashboard necessite des addons metrics-server
minikube addons enable metrics-server
# Lancement du Dashboard Kubernetes pour la gestion du Cluster
minikube dashboard