docker build -t viaches/multi-client:latest -t viaches/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t viaches/multi-server:latest -t viaches/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t viaches/multi-worker:latest -t viaches/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push viaches/multi-client:latest
docker push viaches/multi-server:latest
docker push viaches/multi-worker:latest

docker push viaches/multi-client:$SHA
docker push viaches/multi-server:$SHA
docker push viaches/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=viaches/multi-server:$SHA
kubectl set image deployments/client-deployment client=viaches/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=viaches/multi-worker:$SHA