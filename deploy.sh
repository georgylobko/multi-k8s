docker build -t questionmaark/multi-client:latest -t questionmaark/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t questionmaark/multi-server:latest -t questionmaark/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t questionmaark/multi-worker:latest -t questionmaark/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push questionmaark/multi-client:latest
docker push questionmaark/multi-server:latest
docker push questionmaark/multi-worker:latest

docker push questionmaark/multi-client:$SHA
docker push questionmaark/multi-server:$SHA
docker push questionmaark/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=questionmaark/multi-client:$SHA
kubectl set image deployments/server-deployment server=questionmaark/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=questionmaark/multi-worker:$SHA
