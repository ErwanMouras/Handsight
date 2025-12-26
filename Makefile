.PHONY: help install setup-data lint test run-mlflow run-airflow train train-gpu webcam-demo run-api test-api build-image deploy-cloud monitoring clean

help:
	@echo "HandSight - Hand Gesture Recognition MLOps Pipeline"
	@echo ""
	@echo "Available commands:"
	@echo "  make install          - Install Python dependencies"
	@echo "  make setup-data       - Download and prepare HaGRID dataset"
	@echo "  make lint             - Run code quality checks (black, flake8)"
	@echo "  make test             - Run all tests"
	@echo "  make run-mlflow       - Start MLflow tracking server"
	@echo "  make run-airflow      - Start Airflow orchestration"
	@echo "  make train            - Train model (CPU, small batch)"
	@echo "  make train-gpu        - Train model (GPU, large batch)"
	@echo "  make webcam-demo      - Run live webcam gesture recognition"
	@echo "  make run-api          - Start FastAPI server in Docker"
	@echo "  make test-api         - Test API endpoints"
	@echo "  make build-image      - Build Docker image"
	@echo "  make deploy-cloud     - Deploy to cloud using Terraform"
	@echo "  make monitoring       - Run Evidently monitoring report"
	@echo "  make clean            - Clean temporary files"

install:
	pip install -r requirements.txt
	pip install -e .

setup-data:
	@echo "Downloading HaGRID dataset..."
	@echo "Note: This dataset is very large (~126GB). Make sure you have enough space."
	@echo "Visit https://github.com/hukenovs/hagrid for download instructions"

lint:
	black src/ deployment/ tests/ --check
	flake8 src/ deployment/ tests/ --max-line-length=100

test:
	pytest tests/ -v --cov=src

run-mlflow:
	mlflow server --host 0.0.0.0 --port 5000

run-airflow:
	cd orchestration && docker-compose up -d
	@echo "Airflow UI available at http://localhost:8080"

train:
	python src/training/train.py \
		--data_dir Data \
		--model mobilenet_v2 \
		--batch_size 8 \
		--epochs 5 \
		--lr 0.001 \
		--num_workers 2 \
		--experiment_name HandSight

train-gpu:
	python src/training/train.py \
		--data_dir Data \
		--model mobilenet_v2 \
		--batch_size 64 \
		--epochs 20 \
		--lr 0.001 \
		--num_workers 4 \
		--experiment_name HandSight_GPU

webcam-demo:
	python src/inference/webcam_demo.py --model_path models/best_model.pth

run-api:
	docker build -t handsight-api -f deployment/Dockerfile .
	docker run -p 8000:8000 handsight-api

test-api:
	python deployment/test_api.py

build-image:
	docker build -t handsight-api:latest -f deployment/Dockerfile .

deploy-cloud:
	cd infrastructure/terraform && terraform apply

monitoring:
	python monitoring/monitor.py \
		--reference_data data/reference_predictions.parquet \
		--current_data data/current_predictions.parquet \
		--output_dir monitoring/reports

clean:
	find . -type d -name "__pycache__" -exec rm -rf {} +
	find . -type f -name "*.pyc" -delete
	find . -type f -name "*.pyo" -delete
	find . -type d -name "*.egg-info" -exec rm -rf {} +
	rm -rf .pytest_cache
	rm -rf .coverage
	rm -rf htmlcov
