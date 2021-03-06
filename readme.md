# Exercise. Kubernetes (GKE). WordPress, Moodle as example.

#### Task: Terraform deploy infrascrukture. Standart yaml descriptors for objects. 

## Description

Terraform v0.12.18    
GKE 1.14.9-gke.2    

***kube-conf*** will be genereted by terraform from template. It allows access to the cluster with ***kubectl***.   

Apache and MySql images is built - Dockerfiles are here.   
In MySql conteiner user is *****mysql*****, but Apache  user is *****root*****.

At first each component is initialized by Workload ***kind: Job*** then runs as ***Deployment*** or ***ReplicationSet***.   
But the startup order doesn't ***matter***, because the ***initial containers*** provide the correct sequence.    

***HorizontalPodAutoscaler*** for Moodle and ***VerticalPodAutoscaler*** for WordPress deployment. ***LimitRange*** for VerticalPodAutoscaler.    

Script ***moodle_init.sh*** is ***`mounted`*** in Pod directly from github whith ***gitRepo volume***.    
***wp-config.php*** is mounted as ***secret***.   

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
There are yaml descriptors in directory ***pick_up*** which was genereted during work and they're can be usefull.   

## Note   
Start ingress takes 10 minutes or more.   
There are problems whith ***Ingress Health Check***.

