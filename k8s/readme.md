# K8S

## Dashboard

```bash
kubectl -n kubernetes-dashboard port-forward svc/kubernetes-dashboard-kong-proxy 8443:443
```

Генерация токена
```bash
kubectl -n kubernetes-dashboard create token kubernetes-dashboard-api 
```


## 🚀 Развёртывание

```bash
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
kubectl apply -f ingress.yaml       # если используете Ingress
kubectl apply -f configmap.yaml     # если используете ConfigMap
```

## 🧪 Проверка
```
kubectl get pods
kubectl get services
kubectl get ingress
kubectl logs <pod-name>
```

## 🛑 Удаление ресурсов
```
kubectl delete -f deployment.yaml
kubectl delete -f service.yaml
kubectl delete -f ingress.yaml
kubectl delete -f configmap.yaml
```

## Yandex Tank
```bash
docker run -v $(pwd):/var/loadtest --net host -it yandex/yandex-tank -c ./yandex-tank/backend.load.yaml
```

## Графана

```bash
risenfrost@MacBook-Air-Ivan k8s % kubectl get pods --namespace prometheus | grep grafana 
kubectl port-forward --namespace prometheus kube-prometheus-stack-grafana-7f67dcdb75-97kht 8080:3000 
```

- admin
- prom-operator


## HPA

```bash

kubectl scale deploy backend --replicas=1 -n story-stream
```
