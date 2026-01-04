# Práctica Terraform GCP: Infraestructura Básica

Proyecto de Infraestructura como Código (IaC) en Google Cloud Platform utilizando Terraform.

**Autor:** Antonio Prado Lorenzo

## Descripción

Este repositorio contiene la configuración de Terraform para desplegar una infraestructura básica en GCP que incluye:

- **VPC personalizada** con subred en `europe-west1`
- **Regla de firewall** para permitir SSH
- **Bucket de almacenamiento** en la región EU
- **Máquina virtual** (Debian 12, e2-micro)

## Requisitos

- Terraform >= 1.5
- Cuenta de Google Cloud Platform
- Service Account con permisos de administración

## Uso

1. Crear una Service Account en GCP y descargar las credenciales como `credentials.json`

2. Inicializar Terraform:
```bash
terraform init
```

3. Revisar el plan de ejecución:
```bash
terraform plan
```

4. Aplicar la infraestructura:
```bash
terraform apply
```

5. Destruir la infraestructura:
```bash
terraform destroy
```

## Estructura del Proyecto

```
.
├── main.tf                          # Configuración principal de Terraform
├── credentials.json                 # Credenciales GCP (no incluido en el repo)
├── 01_memoria-terraform.md          # Documentación técnica detallada
├── practica-gcp-documentacion.pdf   # Documentación en PDF
└── Practica GCP.jpg                 # Diagrama de arquitectura
```

## Arquitectura

| Recurso | Nombre | Descripción |
|---------|--------|-------------|
| VPC | `vpc-terraform` | Red virtual en modo personalizado |
| Subred | `subred-terraform` | Rango `10.0.1.0/24` en `europe-west1` |
| Firewall | `allow-ssh-terraform` | Permite tráfico TCP/22 |
| Bucket | `bucket-terraform-anzeni-481408` | Almacenamiento en EU |
| VM | `vm-terraform` | Debian 12, e2-micro |

## Seguridad

- El archivo `credentials.json` está excluido del repositorio via `.gitignore`
- Los archivos de estado de Terraform (`.tfstate`) también están excluidos
