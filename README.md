# HandSight – Hands-Free Computer Control via Gesture Recognition

## Problem Description

Traditional desktop interaction relies heavily on keyboard and mouse input, which can be limiting or inconvenient in many real-world scenarios:

- **Presenting slides** while standing away from the laptop
- **Controlling media** during a video call without constantly reaching for the mouse
- **Wanting a more natural, low-contact way** to trigger a small set of actions

**HandSight** explores how a standard webcam and computer vision can create a lightweight, hands-free interaction layer on top of existing applications. The goal is not to replace traditional input devices, but to enable a small vocabulary of robust hand gestures that can be mapped to common actions.

Beyond the gesture recognition model itself, this project demonstrates a **production-ready MLOps pipeline** with experiment tracking, orchestration, deployment, monitoring, and infrastructure automation.

---

## Project Background

This project builds an end-to-end machine learning system with:

- **Exploratory Data Analysis (EDA)** and data preprocessing on the HaGRID dataset
- **Model training and evaluation** with MLflow experiment tracking
- **Automated training pipelines** orchestrated with Airflow
- **Real-time inference** from webcam feed using OpenCV
- **Model serving** via FastAPI and Docker containerization
- **Infrastructure provisioning** with Terraform (cloud deployment ready)
- **Monitoring and drift detection** with Evidently AI
- **CI/CD automation** using GitHub Actions

This project follows best practices from the [MLOps Zoomcamp](https://github.com/DataTalksClub/mlops-zoomcamp) course, covering experiment tracking, workflow orchestration, deployment, and monitoring.

---

## Dataset

This project uses the **HaGRID** (HAnd Gesture Recognition Image Dataset):

- **Repository**: [github.com/hukenovs/hagrid](https://github.com/hukenovs/hagrid)
- **Variant**: Lightweight version (images resized to 512px)
- **Dataset Size**: ~126 GB of images + 4 GB annotations

### Gesture Classes

HaGRID contains 18 gesture classes. This project focuses on a **subset of practical gestures** to keep the vocabulary focused and the real-time system responsive:

- `palm` – open hand, palm facing camera
- `fist` – closed fist
- `like` (thumbs up) – approval/next action
- `dislike` (thumbs down) – rejection/previous action
- `stop` – stop hand gesture
- `no_gesture` – neutral state (no hand detected)

### Data Structure

```
Data/
├── annotations/           # JSON annotations for train/val/test splits
│   ├── train/
│   ├── val/
│   └── test/
└── Images/
    └── HaGRIDv2_dataset_512/
        ├── palm/
        ├── fist/
        ├── like/
        ├── dislike/
        ├── stop/
        ├── no_gesture/
        └── ... (other gesture classes)
```

---

## Goal

Build a **robust, production-ready gesture recognition system** that:

- Trains and evaluates deep learning models (CNNs) with MLflow tracking
- Logs metrics, model artifacts, and preprocessing pipelines
- Performs real-time inference from webcam feed
- Serves predictions via a REST API for integration with applications
- Monitors model performance and data drift over time
- Deploys infrastructure to the cloud in a reproducible way
- Maps recognized gestures to system actions (keyboard shortcuts, media control, etc.)

---

## Technologies and Tools

### ML & Data Processing
- **PyTorch / TensorFlow** – deep learning framework for CNN training
- **OpenCV** – real-time video capture and image preprocessing
- **Albumentations** – data augmentation library
- **Scikit-learn** – metrics and evaluation

### MLOps & Orchestration
- **MLflow** – experiment tracking and model registry
- **Airflow** – orchestration of training and batch inference workflows
- **DVC** (seeing later) – data version control for large datasets

### Deployment & Infrastructure
- **FastAPI** – lightweight REST API for model serving
- **Docker** – containerization of inference service
- **Terraform** – infrastructure as code (cloud deployment)
- **Evidently AI** – model monitoring and drift detection

### CI/CD & Quality
- **GitHub Actions** – continuous integration and deployment
- **pytest** – unit and integration testing
- **Black / Flake8** – code formatting and linting

---

## Project Structure

```bash
.
├── data/                          # Dataset storage (gitignored due to size)
│   ├── annotations/               # HaGRID JSON annotations
│   └── Images/                    # HaGRID image dataset (512px)
├── notebooks/                     # Jupyter notebooks for EDA & prototyping
│   ├── 01_eda.ipynb              # Exploratory data analysis
├── src/
│   ├── data/                      # Data loading and preprocessing
│   │   ├── dataset.py            # PyTorch dataset class
│   │   └── augmentation.py       # Data augmentation pipeline
│   ├── models/                    # Model architectures
│   ├── training/                  # Training pipeline
│   │   ├── train.py              # Main training script
│   │   └── evaluate.py           # Model evaluation
│   └── inference/                 # Real-time inference
│       ├── webcam_demo.py        # Live webcam gesture recognition
│       └── gesture_mapper.py     # Map gestures to system actions
├── deployment/
│   ├── api/
│   │   ├── main.py               # FastAPI application
│   │   └── schemas.py            # Request/response models
│   ├── Dockerfile                # API containerization
│   └── test_api.py               # API integration tests
├── orchestration/
│   ├── airflow/                   # Airflow DAGs
│   │   ├── training_dag.py       # Automated training pipeline
│   │   └── batch_inference_dag.py # Batch prediction workflow
│   └── docker-compose.yml         # Local Airflow setup
├── monitoring/
├── tests/
├── .github/
├── Makefile                       # Automation commands
├── requirements.txt               # Python dependencies
├── setup.py                       # Package installation
└── README.md                      # Project documentation
```

---

## Makefile Usage Summary

| Command | Description |
| ------- | ----------- |
| `make install` | Install Python dependencies |
| `make setup-data` | Download and prepare HaGRID dataset |
| `make lint` | Run code quality checks (black, flake8) |
| `make test` | Run all tests (unit + integration) |
| `make run-mlflow` | Start MLflow tracking server (localhost:5000) |
| `make run-airflow` | Start Airflow orchestration (localhost:8080) |
| `make train` | Train model with MLflow tracking |
| `make webcam-demo` | Run live webcam gesture recognition |
| `make run-api` | Start FastAPI server in Docker |
| `make test-api` | Test API endpoints |
| `make build-image` | Build Docker image |
| `make deploy-cloud` | Deploy to cloud using Terraform |
| `make monitoring` | Run Evidently monitoring report |

TO IMPLEMENT

---

## Model Architecture & Performance

### Approach

The project experiments with multiple architectures:

TODO

### Metrics

Models are evaluated on:
- **Accuracy** – overall classification accuracy
- **Precision/Recall/F1** – per-class performance
- **Inference Speed** – FPS on CPU and GPU
- **Model Size** – for edge deployment considerations

### Best Model

TODO

---

## Usage Guide

TODO

## Gesture Vocabulary

| Gesture | Description | Mapped Action |
| ------- | ----------- | ------------- |
| `palm` | Open hand, palm facing camera | Volume up |
| `fist` | Closed fist | Volume down |
| `like` | Thumbs up | Next slide / Confirm |
| `dislike` | Thumbs down | Previous slide / Cancel |
| `stop` | Stop hand gesture | Pause/Play media |
| `no_gesture` | No hand detected | No action |

---

## Future Improvements

TODO

---

## References

- [HaGRID Dataset](https://github.com/hukenovs/hagrid)

---


