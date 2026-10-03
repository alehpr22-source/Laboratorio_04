# Laboratorio 04: Terraform y Docker con DEV y QA

Desplegar con Terraform, encima de Docker, una mini aplicación con tres piezas: un frontend, un backend y una base de datos. 

Hacer los ambientes:
- DEV : 4000
- QA : 5000

## Stack

- Docker abierto
- Terraform
- Git

## Ambientes

Uso dos workspaces, dev y qa. El código es el mismo y lo que cambia es el workspace activo. El nombre de cada recurso lleva el ambiente (como api-dev-1 y api-qa-1) para que no se choquen, y los valores de cada ambiente salen de mapas en terraform.tfvars.

## Réplicas

| Servicio | DEV | QA |
| :--- | :---: | :---: |
| Frontend | 1 | 2 |
| Backend | 1 | 2 |
| Base de datos | 1 | 1 |

En DEV con una copia se gastan menos recursos y es más fácil de revisar. En QA puse dos para parecerme más a producción y probar que todo funciona con más de una instancia. La base de datos es una sola en cada ambiente porque duplicarla necesita configurar replicación, pero DEV y QA no comparten datos.

## Puertos

| Servicio | DEV | QA |
| :--- | :---: | :---: |
| Frontend | 4001 | 5001 y 5002 |
| Backend | 4002 | 5011 y 5012 |
| Base de datos | 4003 | 5021 |

En QA no pude usar los puertos del diagrama (5002 y 5003) porque con dos réplicas se pisaban entre servicios, así que separé el rango de cada uno.

## Comandos

```bash
terraform init

terraform workspace new dev
terraform apply

terraform workspace new qa
terraform apply
```
Para cambiar de ambiente: terraform workspace select dev (o qa).


Cómo comprobar que funciona

```bash
docker ps
curl http://localhost:4001
curl http://localhost:4002
curl http://localhost:4003

curl http://localhost:5001
curl http://localhost:5002

curl http://localhost:5011
curl http://localhost:5012

curl http://localhost:5021
```