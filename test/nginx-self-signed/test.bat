@echo off
echo ---
echo Ensuer all deployments, services and ingresses are deleted
echo ---
kubectl delete -f nginx-ingress-selfsigned.yaml -n kibo --create-namespace
kubectl delete -f nginx-service-selfsigned.yaml -n kibo
kubectl delete -f nginx-deploy-selfsigned.yaml -n kibo

echo ---
echo Create all deployments, services and ingresses are deleted
echo ---
kubectl apply -f nginx-deploy-selfsigned.yaml -n kibo
kubectl apply -f nginx-service-selfsigned.yaml -n kibo
echo --- Give time for the services to be created
timeout /t 5 /nobreak > NUL
kubectl apply -f nginx-ingress-selfsigned.yaml -n kibo

echo ---
echo Test using Curl to see if app1 and app2 are vislble even though they are running in ClusterIP services
echo ---
echo --- Give time for ingress to find the services
timeout /t 5 /nobreak > NUL
curl -klv http://kibo.org/app1
curl -klv http://kibo.org/app2

echo ---
echo If you see two time Response 200 OK, then the test is successful
echo ---
