## Project Goal
This is an educational DevOps project built:
- Python application, Docker containerization, Kubernetes deployment, CI/CD with GitHub Actions, IaC (Terraform, Ansible), GitOps (ArgoCD), Monitoring and logging (Prometheus, Grafana, Loki)

- The main goal is learning and building a DevOps project.
- The project is completely free and runs locally (Minikube / Kind / K3s).
---

## Static Page - Github
https://boyanantonov02.github.io/StatusBoard/
## Web Service - Render
https://statusboard-tsxx.onrender.com

## How to Run the Project Locally
You need:
Make, Docker, Minikube, kubetcl

```bash
make start

make build

make deploy

# if needed
make restart

# FYI
make logs
make clean

#Checkout, Setup Python, Run tests, Docker Buildx, Push
make ci
```
