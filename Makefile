# SPDX-License-Identifier: MIT
# AI Career Coach: các lệnh thường dùng. Gõ 'make help' để xem danh sách.

PYTHON ?= python3
VENV   ?= .venv
PIP    := $(VENV)/bin/pip
APP    := app.main:app
MODEL  ?= $(shell grep -E '^OLLAMA_MODEL=' .env 2>/dev/null | cut -d= -f2)

.PHONY: help install run test lint docker-up docker-down docker-logs pull-model clean

.DEFAULT_GOAL := help

help: ## Hiện danh sách lệnh
	@grep -E '^[a-zA-Z_-]+:.*## ' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*## "}; {printf "  %-14s %s\n", $$1, $$2}'

install: ## Tạo môi trường ảo và cài thư viện (không cần quyền root)
	$(PYTHON) -m venv $(VENV)
	$(PIP) install --upgrade pip
	$(PIP) install -r requirements.txt

run: ## Chạy ứng dụng ở http://localhost:8000 (cần PostgreSQL và Ollama đang chạy)
	$(VENV)/bin/uvicorn $(APP) --host 0.0.0.0 --port 8000 --reload

test: ## Chạy kiểm thử
	$(VENV)/bin/python -m pytest

lint: ## Kiểm tra định dạng code
	$(VENV)/bin/ruff check .

docker-up: ## Chạy toàn bộ bằng Docker Compose (app, PostgreSQL, Ollama)
	docker compose up --build -d

docker-down: ## Dừng các dịch vụ Docker
	docker compose down

docker-logs: ## Xem log của ứng dụng
	docker compose logs -f app

pull-model: ## Tải model Ollama trong Docker (đặt MODEL=... hoặc OLLAMA_MODEL trong .env)
	docker compose exec ollama ollama pull $(MODEL)

clean: ## Xoá môi trường ảo và file tạm
	rm -rf $(VENV) .pytest_cache .ruff_cache
	find . -name '__pycache__' -type d -prune -exec rm -rf {} +
