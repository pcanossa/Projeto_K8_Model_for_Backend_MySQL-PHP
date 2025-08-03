echo "Crindo as imagens do Docker Compose...."

docker build -t patcanossa/projeto-backend:1.0 backend/.
docker build -t patcanossa/projeto-database:1.0 database/.

echo "Realizando o push das imagens para o Docker Hub..."

docker push patcanossa/projeto-backend:1.0
docker push patcanossa/projeto-database:1.0

echo "Criando serviços no cluster Kubernetes..."

kubectl apply -f ./service.yml

echo "Criando os deployments no cluster Kubernetes..."

kubectl apply -f ./deployment.yml

