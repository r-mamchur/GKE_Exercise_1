rem create persistent Volume Claims as  Standart for WordPress, Moodle and MySql
kubectl create -f ./yaml/dp_pvc_all.yaml --kubeconfig="./kube-conf"

rem Secret - config wordpress
kubectl create secret generic wp-conf --from-file=wp-config.php --kubeconfig="./kube-conf"

rem initialization MySql
kubectl create -f ./yaml/mysql_initial_job.yaml  --kubeconfig="./kube-conf"

rem pause for initialization MySql completed
timeout /T 30
kubectl create -f ./yaml/mysql_rs.yaml --kubeconfig="./kube-conf"
kubectl create -f ./yaml/mysql_svc.yaml --kubeconfig="./kube-conf"

rem timeout for moodle while mysql will be run
timeout /T 10

rem initialization Moodle
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

kubectl delete jobs mysql-initial-job wp-initial-job moodle-initial-job --kubeconfig="./kube-conf"

