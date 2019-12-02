rem create persistent Volume Claims as  Standart for WordPress, Moodle and MySql
kubectl create -f ./yaml/dp_pvc_all.yaml --kubeconfig="./kube-conf"

rem Secret - config wordpress
kubectl create secret generic wp-conf --from-file=wp-config.php --kubeconfig="./kube-conf"

rem initialization MySql
kubectl create -f ./yaml/mysql_initial_job.yaml  --kubeconfig="./kube-conf"

rem initialization WordPress
kubectl create -f ./yaml/wp-initial_job.yaml --kubeconfig="./kube-conf"

rem pause for initialization MySql completed
timeout /T 30
kubectl create -f ./yaml/mysql_rs.yaml --kubeconfig="./kube-conf"
kubectl create -f ./yaml/mysql_svc.yaml --kubeconfig="./kube-conf"

rem initialization Moodle - copy and run script
kubectl create -f ./yaml/moodle-initial-pod.yaml --kubeconfig="./kube-conf"
timeout /T 35
kubectl cp ./moodle_init.sh moodle-initial:/moodle_init.sh --kubeconfig="./kube-conf"
kubectl exec -it moodle-initial --kubeconfig="./kube-conf" -- chmod +x /moodle_init.sh  
kubectl exec -it moodle-initial --kubeconfig="./kube-conf" -- /moodle_init.sh 

rem timeout for moodle
timeout /T 20

kubectl create -f ./yaml/wp-deployment.yaml --kubeconfig="./kube-conf"
kubectl create -f ./yaml/moodle-deployment.yaml --kubeconfig="./kube-conf"

rem Services
kubectl create -f ./yaml/moodle-svc-loadbalancer.yaml  --kubeconfig="./kube-conf"
kubectl create -f ./yaml/wp-svc-loadbalancer.yaml --kubeconfig="./kube-conf"

rem Ingress
kubectl create -f ./yaml/main-ingress.yaml --kubeconfig="./kube-conf"

rem kubectl delete pod moodle-initial --kubeconfig="./kube-conf"
rem kubectl delete jobs mysql-initial-job wp-initial-job --kubeconfig="./kube-conf"

