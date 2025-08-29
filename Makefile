APP_NAME=statusboard
IMAGE_NAME=$(APP_NAME):latest
DEPLOYMENT=statusboard-deployment

.PHONY: ci

ci:
	@if command -v python3 &> /dev/null; then \
		PYTHON=python3; \
	elif command -v python &> /dev/null; then \
		PYTHON=python; \
	elif command -v py &> /dev/null; then \
		PYTHON=py; \
	else \
		echo "Python not found!"; exit 1; \
	fi; \
	\
	$$PYTHON -m pip install --upgrade pip; \
	$$PYTHON -m pip install -r requirements.txt; \
	\
	$$PYTHON -m pytest -q; \
	$$PYTHON -m flake8 app

start:
	minikube start || true

build:
	if command -v minikube &> /dev/null; then \
		eval $$(minikube docker-env) && docker build -t $(IMAGE_NAME) .; \
	else \
		docker build -t $(IMAGE_NAME) .; \
	fi

deploy:
	if command -v kubectl &> /dev/null; then \
		kubectl apply -f k8s-deployment.yaml || true; \
		kubectl apply -f k8s-service.yaml || true; \
		kubectl wait --for=condition=available --timeout=60s deployment/$(DEPLOYMENT) || true; \
		minikube service $(APP_NAME)-service || true; \
	else \
		docker run --rm -p 8000:8000 $(IMAGE_NAME); \
	fi

restart:
	kubectl rollout restart deployment/$(DEPLOYMENT)

logs:
	kubectl logs -l app=$(APP_NAME) --tail=100 -f

clean:
	kubectl delete -f k8s-deployment.yaml || true
	kubectl delete -f k8s-service.yaml || true
