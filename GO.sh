#!/bin/bash

# create persistent Volume Claims as  Standart for WordPress, Moodle and MySql
kubectl create -f ./yaml/dp_pvc_all.yaml --kubeconfig="./kube-conf"

# Secret - config wordpress
kubectl create secret generic wp-conf --from-file=wp-config.php --kubeconfig="./kube-conf"

# the startup order doesn't matter, 
#   because the initial containers provide the correct sequence

# MySql
kubectl create -f ./yaml/mysql_initial_job.yaml  --kubeconfig="./kube-conf"
kubectl create -f ./yaml/mysql_rs.yaml --kubeconfig="./kube-conf"
kubectl create -f ./yaml/mysql_svc.yaml --kubeconfig="./kube-conf"

# initialization Moodle
kubectl create -f ./yaml/moodle-initial_job.yaml --kubeconfig="./kube-conf"
# initialization WordPress
kubectl create -f ./yaml/wp-initial_job.yaml --kubeconfig="./kube-conf"

# Deployment
kubectl create -f ./yaml/wp-deployment.yaml --kubeconfig="./kube-conf"
kubectl create -f ./yaml/moodle-deployment.yaml --kubeconfig="./kube-conf"

# Services
kubectl create -f ./yaml/moodle-svc-loadbalancer.yaml  --kubeconfig="./kube-conf"
kubectl create -f ./yaml/wp-svc-loadbalancer.yaml --kubeconfig="./kube-conf"

# Ingress
kubectl create -f ./yaml/main-ingress.yaml --kubeconfig="./kube-conf"

# delete after completed
# kubectl delete jobs mysql-initial-job wp-initial-job moodle-initial-job --kubeconfig="./kube-conf"

