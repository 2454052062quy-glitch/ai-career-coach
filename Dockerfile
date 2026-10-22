# SPDX-License-Identifier: MIT
# Image cho backend AI Career Coach (FastAPI).
# Model Ollama KHÔNG nhúng vào image: Ollama chạy ở dịch vụ riêng trong docker-compose.yml.
FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

# Cài thư viện trước để tận dụng cache của Docker
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Chép mã nguồn và dữ liệu
COPY . .

# Chạy bằng người dùng thường, không dùng root
RUN useradd --create-home appuser && chown -R appuser /app
USER appuser

EXPOSE 8000

# Giả định điểm vào là app/main.py có biến app (FastAPI). Sửa nếu khác.
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
