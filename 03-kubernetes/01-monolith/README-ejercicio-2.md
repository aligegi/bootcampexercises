# 🐘 Ejercicio 2 – Monolito con base de datos PostgreSQL

Este ejercicio despliega una aplicación TODO monolítica dividida en dos componentes:

- Un backend `todo-app` en Node.js que gestiona tareas.
- Una base de datos **PostgreSQL** que guarda los datos de forma persistente.

---

## 📁 Estructura del proyecto

```
project-root/
│
├── 01-monolith-db/         # Archivos relacionados con la base de datos
│   ├── configmap-db.yaml
│   ├── statefulset-db.yaml
│   ├── persistentvolume.yaml
│   ├── persistentvolumeclaim.yaml
│   ├── service-db.yaml
│   ├── storageclass.yaml
│   ├── seed-job.yaml
│   └── configmap-seed.yaml
│
├── 02-monolith-app/        # Archivos relacionados con la app Node.js
│   ├── deployment-app.yaml
│   ├── configmap-app.yaml
│   └── service-app.yaml
```

---

## ⚙️ Instrucciones de despliegue

### Paso 1 – Desplegar la base de datos PostgreSQL

```bash
kubectl apply -f 01-monolith-db/
```

Esto crea:

- Un `StatefulSet` con almacenamiento persistente.
- Un `ConfigMap` con variables de entorno.
- Un `Job` de inicialización para insertar datos usando un script SQL.

El script SQL vive dentro del `ConfigMap` y es montado por el Job mediante un volumen.

### Paso 2 – Desplegar la aplicación `todo-app`

```bash
kubectl apply -f 02-monolith-app/
```

Esto crea:

- Un `Deployment` de la app con su configuración vía `ConfigMap`.
- Un `Service` tipo `LoadBalancer` para exponer la app.

### Paso 3 – Acceder a la aplicación

Usamos Minikube para simular un LoadBalancer y abrir el servicio en el navegador:

```bash
minikube service todo-app-service
```

Esto abrirá una URL similar a:

```
http://127.0.0.1:xxxxx
```

---

## ✅ Verificación

### Consultar los datos insertados en la base de datos:

```bash
kubectl exec -it todo-db-0 -- psql -U postgres -d todos_db
```

Luego, en el prompt de `psql`:

```sql
SELECT * FROM todos ORDER BY id DESC LIMIT 5;
```

### Ejemplo de resultado:

```
 id  |          title           | completed |          due_date          | order
-----+--------------------------+-----------+----------------------------+-------
 100 | Seed task 1              | t         | 2025-07-14 10:00:00+00     |     1
  22 | tarea creada desde la UI | f         | 2025-07-15 19:02:30.651+00 |
  21 | Learn K8s                | f         | 2020-12-04 19:12:16.174+00 |
  13 | Learn GitLab             | t         | 2020-12-04 18:38:06.993+00 |
  12 | Learn Jenkins            | f         | 2020-12-04 18:37:44.234+00 |
(5 rows)
```


