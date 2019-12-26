echo on

rem create persistent Volume Claims as  Standart for WordPress, Moodle and MySql
kubectl create -f ./yaml/dp_pvc_all.yaml --kubeconfig="./kube-conf"

rem Secret - config wordpress
kubectl create secret generic wp-conf --from-file=wp-config.php --kubeconfig="./kube-conf"

rem the startup order doesn't matter, 
rem   because the initial containers provide the correct sequence

rem  MySql
kubectl create -f ./yaml/mysql_initial_job.yaml  --kubeconfig="./kube-conf"
kubectl create -f ./yaml/mysql_rs.yaml --kubeconfig="./kube-conf"
kubectl create -f ./yaml/mysql_svc.yaml --kubeconfig="./kube-conf"

rem  initialization Moodle
kubectl create -f ./yaml/moodle-initial_job.yaml --kubeconfig="./kube-conf"
rem initialization WordPress
kubectl create -f ./yaml/wp-initial_job.yaml --kubeconfig="./kube-conf"

rem Deployment
kubectl create -f ./yaml/wp-deployment.yaml --kubeconfig="./kube-conf"
kubectl create -f ./yaml/moodle-deployment.yaml --kubeconfig="./kube-conf"

rem Services
kubectl create -f ./yaml/moodle-svc-loadbalancer.yaml  --kubeconfig="./kube-conf"
kubectl create -f ./yaml/wp-svc-loadbalancer.yaml --kubeconfig="./kube-conf"

rem Ingress
kubectl create -f ./yaml/main-ingress.yaml --kubeconfig="./kube-conf"

rem Autoscalers
kubectl create -f ./yaml/limit_range.yaml  --kubeconfig="./kube-conf"
kubectl create -f ./yaml/wp_vpa.yaml --kubeconfig="./kube-conf"
kubectl create -f ./yaml/moodle_hpa.yaml --kubeconfig="./kube-conf"

rem delete after completed
rem kubectl delete jobs mysql-initial-job wp-initial-job moodle-initial-job --kubeconfig="./kube-conf"

