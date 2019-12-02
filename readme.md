# Exercise. Kubernetes (GKE). WordPress, Moodle as example.

#### Task: Terraform deploy infrascrukture. Standart yaml descriptors for objects. 

## Description
Apache and MySql images is built - Dockerfiles are here.   
At first each component is initialized whith Workload ***kind: Job*** or ***Pod*** then runs as ***Deployment*** or ***ReplicationSet***.    
In MySql conteiner user is *****mysql*****, but Apache  user is *****root*****.

***wp-config.php*** is mounted as ***secret***.   
***kube-conf*** will be genereted by terraform from template. It allows access to the cluster with ***kubectl***.   
There are yaml descriptors in directory ***pick_up*** which was genereted during work and they're can be usefull.   

External access is provided through ***LoadBalanser*** and ***Ingress*** services.   
***Ingress*** - virtual hosts are  ***wp.example.com*** and ***moodle.example.com***.   
It's need external IP for LoadBalanser. If you're limited, use ***Ingress*** service with ***nodeport*** backend - look for them in ***pick_up***.   
Moodle don't work with IP address (it's configured), please type ***moodle.example.com***  in your ***hosts***-file.   

You can give external IP:
```sh
$ kubectl get svc moodle-svc-loadbalancer --kubeconfig="./kube-conf"
$ kubectl get svc wp-svc-loadbalancer --kubeconfig="./kube-conf"
$ kubectl get ingress  --kubeconfig="./kube-conf"
```
