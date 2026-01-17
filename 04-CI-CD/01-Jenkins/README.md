# Ejercicios Jenkins CI/CD

## Ejercicio 1: Pipeline Básico 

### Pasos realizados:

1. **Levantar Jenkins con Docker:**
   ```bash
   cd 03-cd/01-jenkins/00-instalando-jenkins
   docker-compose up -d
   ```

2. **Configurar proyecto en Jenkins:**
   - Crear nuevo item: `ejercicio-jenkins-ci`
   - Tipo: Pipeline
   - SCM: Git - `https://github.com/aligegi/bootcampexercises.git`
   - Script Path: `04-CI-CD/01-Jenkins/calculator/Jenkinsfile`

3. **Crear Jenkinsfile** con stages:
   - Checkout
   - Compile: `./gradlew compileJava`
   - Unit Tests: `./gradlew test`

### Problemas encontrados y soluciones:

**1. Incompatibilidad de versión de Java:**

**Error:** `Unsupported class file major version 61`

**Causa:** Gradle 6.6.1 no es compatible con Java 17

**Solución:** 
- Cambiar imagen base en `00-instalando-jenkins/Dockerfile`: 
  - De: `FROM jenkins/jenkins:lts-jdk11`
  - A: `FROM jenkins/jenkins:lts-jdk17`
- Actualizar Gradle a 7.6.4 (compatible con Java 17 y el plugin maven)

Archivos modificados:
- `00-instalando-jenkins/Dockerfile` → JDK17
- `calculator/gradle/wrapper/gradle-wrapper.properties` → Gradle 7.6.4
- `calculator/gradle.Dockerfile` → Versión 7.6.4

### Resultado:
✅ Pipeline ejecuta correctamente con Gradle 7.6.4

---

## Ejercicio 2: Docker-in-Docker ✅

### Pasos realizados:

1. **Instalar plugins en Jenkins:**
   - Docker Commons Plugin
   - Docker Pipeline

2. **Crear Jenkinsfile-docker** usando agent Docker:
   ```groovy
   agent {
       docker {
           image 'gradle:6.6.1-jre14-openj9'
       }
   }
   ```
   - Cambiar `./gradlew` por `gradle`
   - Mantener mismos stages que Ejercicio 1

3. **Configurar nuevo proyecto en Jenkins:**
   - Crear nuevo item: `ejercicio-jenkins-ci-docker`
   - Script Path: `04-CI-CD/01-Jenkins/calculator/Jenkinsfile-docker`

### Resultado:
✅ Pipeline ejecuta dentro de contenedor Docker con imagen gradle:6.6.1-jre14-openj9

---

## Resumen

| Ejercicio | Jenkinsfile | Agent | Gradle |
|-----------|-------------|-------|--------|
| 1 | `Jenkinsfile` | any | 7.6.4 (wrapper) |
| 2 | `Jenkinsfile-docker` | docker | 6.6.1 (imagen) |

Ambos ejercicios completados y funcionando correctamente.