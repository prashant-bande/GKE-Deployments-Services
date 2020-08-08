Create image for every color
$ docker build -t myapp .

Create a tag for image with specific to the color
$ docker tag myapp  gcr.io/kubernetes-hard-cluster/myapp:blue

Push the image to gcr
$ docker push gcr.io/<project-name>/myapp:blue

Run the deployment 
$ kubectl apply -f myapp-deployment.yml

Create a service
$ kubectl apply -f myapp-service.yml

list the Deployment
$ kubectl get deployment 

list the pods
$ kubectl get pods

list the services
$ kubectl get service

sample service list output:
NAME            TYPE           CLUSTER-IP   EXTERNAL-IP     PORT(S)        AGE
kubernetes      ClusterIP      10.0.0.1     <none>          443/TCP        29m
myapp-service   LoadBalancer   10.0.7.188   34.70.239.108   80:32115/TCP   2m9s

try access the webapp in the browser
http://<LB-Service IP>

Example:
http://34.70.239.108:80

now delete one of the pods
$ kubectl delete pod <pod-name>

A new pod will be created immediately as per the replicas: 3

lets see the pods running on which node
$ kubectl get pods -o=custom-columns=NODE:.spec.nodeName,Name:.metadata.name

now lets taint the node not to run the pod
$ kubectl taint nodes gke-kubecls01-default-pool-a4420104-h8rx key=value:NoSchedule

now lets delete the existing pod which is running on the node
$ kubectl delete pod <pod-name>

now lets again see the pods running on which node
$ kubectl get pods -o=custom-columns=NODE:.spec.nodeName,Name:.metadata.name

now untaint the node
$ kubectl taint nodes gke-kubecls01-default-pool-a4420104-h8rx key=value:NoSchedule-

now update the myapp-deployment.yml and specify the "bad" image

apply the new rollout configuration. existing pods will be terminated and new pods will be created
$ kubectl apply -f myapp-deployment.yml --record

check the rollout status
$ kubectl rollout status deployment.v1.apps/myapp-deployment

check rollout history
$ kubectl rollout history deployment.v1.apps/myapp-deployment

check webapp again
http://<LB-Service IP>

Example:
http://34.70.239.108:80

rollback to our deployment
$ kubectl rollout undo deployment.v1.apps/myapp-deployment

check webapp again
http://<LB-Service IP>

Example:
http://34.70.239.108:80
