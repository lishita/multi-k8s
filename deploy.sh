docker build -t rooch/multi-client:latest -t rooch/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t rooch/multi-server:latest -t rooch/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rooch/multi-worker:latest -t rooch/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push rooch/multi-client:latest 
docker push rooch/multi-server:latest
docker push rooch/multi-worker:latest

docker push rooch/multi-client:$SHA 
docker push rooch/multi-server:$SHA
docker push rooch/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=rooch/multi-server:$SHA
kubectl set image deployments/client-deployment client=rooch/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=rooch/multi-worker:$SHA