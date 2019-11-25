## Setting up a Dashboard

- Applying the Binaries for Kubernetes Dashboard
```
kubectl create -f https://raw.githubusercontent.com/kubernetes/kops/master/addons/kubernetes-dashboard/v1.8.3.yaml 
```

- Creating a Service Account for Kubernetes Dashboard
```
kubectl create serviceaccount dashboard -n default
```

- Assign Permission to the Service Account for Kubernetes Dashboard
```
kubectl create clusterrolebinding dashboard-admin -n default \
--clusterrole=cluster-admin \
--serviceaccount=default:dashboard
```


- Getting hold of the token
```
kubectl get secret $(kubectl get serviceaccount dashboard -o jsonpath="{.secrets[0].name}") -o jsonpath="{.data.token}" | base64 --decode 
```

- (Optional) If prompted for the user/password

```
- Username: admin
- Password: (kops get secrets kube --type secret -oplaintext )
```

- Creating Proxy Connection, by entering (kubectl proxy)
```
kubectl proxy
```

- Navigate to the URL
```
http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/#!/deploy?namespace=default
````
