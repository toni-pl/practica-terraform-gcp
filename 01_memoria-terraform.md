# Práctica: Infraestructura como Código (IaC) en Google Cloud con Terraform

**Autor:** Antonio Prado Lorenzo  
**Entorno de Ejecución:** WSL (Ubuntu)  

---

## 1. Introducción y Objetivos

El propósito de esta práctica es la automatización del ciclo de vida de una infraestructura en la nube pública (Google Cloud Platform) utilizando **Terraform**. 

Se busca cumplir con los siguientes requisitos funcionales y técnicos:
1.  Configuración del proveedor de GCP utilizando autenticación por Service Account (JSON).
2.  Centralización de la definición de infraestructura en un único fichero (`main.tf`).
3.  Aprovisionamiento de recursos de red (VPC), almacenamiento (Storage Bucket) y computación (Compute Engine).
4.  Gestión completa del ciclo de vida: `init` -> `plan` -> `apply` -> `destroy`.

---

## 2. Preparación del Entorno

Para la realización de la práctica se ha configurado un entorno local de desarrollo simulando un flujo de trabajo profesional.

*   **Sistema Operativo:** Windows Subsystem for Linux (WSL).
*   **Herramienta IaC:** Terraform v1.5.7 (linux_amd64).
*   **Autenticación:**
    *   Se ha creado una **Service Account** en GCP con permisos de administración.
    *   Se ha descargado la clave privada en formato JSON (`credentials.json`).
    *   *Nota de seguridad:* El fichero `credentials.json` ha sido excluido del repositorio mediante `.gitignore` para evitar brechas de seguridad.

### Datos del Proyecto GCP
*   **Project ID:** `silver-fragment-481408-c9`
*   **Región seleccionada:** `europe-west1` (Bélgica).
*   **Zona:** `europe-west1-c`.

---

## 3. Arquitectura Desplegada

La definición técnica se encuentra en el archivo **[main.tf](./main.tf)**. A continuación se detallan los recursos que componen la solución:

| Recurso Terraform | Identificador | Descripción |
| :--- | :--- | :--- |
| `google_compute_network` | `vpc_terraform` | Red virtual privada (VPC) en modo personalizado. |
| `google_compute_subnetwork` | `subred_terraform` | Subred ubicada en Europa con rango `10.0.1.0/24`. |
| `google_compute_firewall` | `allow_ssh` | Regla de seguridad para permitir tráfico TCP/22 (SSH) entrante. |
| `google_storage_bucket` | `bucket_terraform` | Bucket de objetos (Standard Class) con acceso uniforme. |
| `google_compute_instance` | `vm_terraform` | Servidor virtual (Debian 12) tipo `e2-micro`. |

---

## 4. Justificación de Decisiones Técnicas

Para garantizar una infraestructura funcional, segura y operativa, se han tomado decisiones de diseño que van más allá de los requisitos mínimos del enunciado.

### 4.1. Red Virtual Personalizada (Custom VPC)
Se ha configurado la VPC con `auto_create_subnetworks = false`.
*   **Motivo:** Evitar la creación automática de subredes innecesarias en todas las regiones del mundo, optimizando la gestión de la red y simulando un entorno de producción controlado.

### 4.2. Conectividad y Acceso (Firewall e IP Pública)
Aunque no era un requisito explícito, se han añadido:
1.  **Regla de Firewall (SSH):** GCP bloquea todo el tráfico por defecto. Sin esta regla, la máquina virtual sería inaccesible.
2.  **IP Pública Efímera (`access_config`):** Necesaria para que la instancia pueda descargar paquetes de internet (actualizaciones) y ser administrada remotamente.
*   **Justificación:** Entregar una máquina aislada ("sorda y muda") no cumple con el propósito funcional de un servidor en la nube.

### 4.3. Seguridad y Ciclo de Vida del Almacenamiento
Se ha configurado el bucket con `force_destroy = true` y `uniform_bucket_level_access = true`.
*   **Motivo:** Asegura que el comando `terraform destroy` no falle si el bucket contiene archivos residuales y cumple con los estándares modernos de seguridad de Google Cloud (deshabilitando ACLs antiguas).

### 4.4. Sistema Operativo
Se ha seleccionado la imagen `debian-cloud/debian-12`.
*   **Motivo:** Uso de la última versión estable (Bookworm) frente a versiones anteriores (Debian 11), garantizando mayor soporte y seguridad.

---

## 5. Ejecución del Proyecto

### 5.1. Inicialización
Ejecución de `terraform init` para descargar el proveedor `hashicorp/google` (v7.14.1).

### 5.2. Despliegue (Apply)
Durante el despliegue se resolvieron las siguientes incidencias:
*   Corrección de tipografía en el *Project ID*.
*   Habilitación manual de la **Compute Engine API** en la consola de GCP.

**Resultado:**
> `Apply complete! Resources: 5 added, 0 changed, 0 destroyed.`

### 5.3. Análisis de Costes (FinOps)
Se ha realizado una estimación de costes para la región `europe-west1`. El coste principal deriva de la **IP Pública** ($0.005/hora) y la instancia de cómputo. Dado que la infraestructura se destruye tras la práctica, el coste total estimado es inferior a **0.02€**.

### 5.4. Limpieza (Destroy)
Para finalizar la práctica y evitar costes recurrentes, se ejecutó la destrucción de la infraestructura.

**Resultado:**
> `Destroy complete! Resources: 5 destroyed.`

---

## 6. Conclusiones

La práctica ha permitido validar el flujo de trabajo completo de Infraestructura como Código. Se ha demostrado cómo Terraform permite versionar, desplegar y destruir entornos complejos de manera determinista, gestionando dependencias entre recursos (como la necesidad de que la red exista antes que la subred y la instancia) de forma automática.