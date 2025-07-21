# Ejercicio 1 - Monolito en memoria

Este proyecto despliega una aplicación TODO en memoria dentro de un clúster de Kubernetes local, utilizando Minikube.


## 📁 Estructura del proyecto

```
├── 00-monolith-in-mem/
    └── deployment.yaml
    └── README.md
```

## Descripción de los recursos

El archivo `deployment.yaml` incluye:

- Un **Deployment** que utiliza la imagen `lemoncodersbc/lc-todo-monolith:v5-2024`
- Un **Service** de tipo `LoadBalancer` (que funciona como `NodePort` en Minikube) para exponer la aplicación

## Pasos para desplegar la aplicación

1. **Iniciar Minikube:**

```bash
minikube start
```

2. **Aplicar los manifiestos:**

```bash
kubectl apply -f 00-monolith-in-mem/deployment.yaml
```

3. **Verificar el estado del pod:**

```bash
kubectl get pods
```

Debe haber un pod llamado `todo-monolith-...` con estado `Running`.

4. **Acceder a la aplicación desde el navegador:**

```bash
minikube service todo-monolith-service
```

Este comando abrirá la app en tu navegador por defecto.

## Variables de entorno utilizadas

Las variables están definidas directamente en el manifiesto del Deployment:

- `NODE_ENV=production`
- `PORT=3000`

## Consideraciones

- La aplicación almacena los datos en memoria, por lo que se perderán si el pod se reinicia.

## Limpieza de recursos

Para eliminar todo:

```bash
kubectl delete -f k8s/todo-monolith.yaml
minikube stop
```

