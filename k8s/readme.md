# K8S

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
