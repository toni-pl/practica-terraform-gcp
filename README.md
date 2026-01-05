# Práctica Terraform GCP: Infraestructura Básica

Práctica de Infraestructura como Código (IaC) en Google Cloud Platform utilizando Terraform.

**Autor:** Antonio Prado Lorenzo
**Entorno:** WSL (Ubuntu)

## Contenido del Repositorio

| Archivo | Descripción |
|---------|-------------|
| `main.tf` | Código Terraform que define toda la infraestructura en GCP |
| `memoria-terraform.md` | Memoria técnica con justificación de decisiones, proceso de ejecución y conclusiones |
| `documentacion.pdf` | Documentación completa de la práctica en formato PDF |
| `arquitectura-gcp.jpg` | Captura de la consola de GCP mostrando los recursos desplegados |

## Infraestructura Desplegada

El archivo `main.tf` define los siguientes recursos en GCP:

| Recurso | Nombre | Descripción |
|---------|--------|-------------|
| VPC | `vpc-terraform` | Red virtual en modo personalizado |
| Subred | `subred-terraform` | Rango `10.0.1.0/24` en `europe-west1` |
| Firewall | `allow-ssh-terraform` | Permite tráfico SSH (TCP/22) |
| Bucket | `bucket-terraform-anzeni-481408` | Almacenamiento en EU |
| VM | `vm-terraform` | Instancia Debian 12, tipo e2-micro |

## Uso

1. Crear una Service Account en GCP y descargar las credenciales como `credentials.json`

2. Ejecutar el ciclo de vida de Terraform:
```bash
terraform init      # Inicializar
terraform plan      # Revisar cambios
terraform apply     # Desplegar
terraform destroy   # Eliminar infraestructura
```

## Seguridad

Los siguientes archivos están excluidos del repositorio via `.gitignore`:
- `credentials.json` - Credenciales de la Service Account
- `*.tfstate` - Estado de Terraform (contiene datos sensibles)
