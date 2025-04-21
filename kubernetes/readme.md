# Story Stream Kubernetes

Порядок применения конфигураций

### 1. Environment configs
```bash
kubectl apply -f env-configs/
```
### 2. Persistent volumes
```bash
kubectl apply -f volumes/
```
### 3. Database services
```bash
kubectl apply -f database/
```
### 4. Application services
```bash
kubectl apply -f applications/
```
### 5. Supporting tools
```bash
kubectl apply -f tools/
```
