rem initialization Moodle - copy and run script
kubectl create -f ./yaml/moodle-initial-pod.yaml --kubeconfig="./kube-conf"
timeout /T 35
kubectl cp ./moodle_init.sh moodle-initial:/moodle_init.sh --kubeconfig="./kube-conf"
kubectl exec -it moodle-initial --kubeconfig="./kube-conf" -- chmod +x /moodle_init.sh  
kubectl exec -it moodle-initial --kubeconfig="./kube-conf" -- /moodle_init.sh 

