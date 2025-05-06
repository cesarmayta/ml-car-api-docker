# Usa una imagen base oficial de Python
FROM python:3.10-slim

# Variables de entorno
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Crear directorio de trabajo
WORKDIR /app

# Copiar dependencias
COPY requirements.txt /app/
COPY dependencies/car_predictor-0.1-py3-none-any.whl /app/dependencies/

# Instalar dependencias
RUN pip install --upgrade pip && \
    pip install -r requirements.txt && \
    pip install /app/dependencies/car_predictor-0.1-py3-none-any.whl

# Copiar el resto del código
COPY . /app/

# Comando para iniciar Gunicorn
CMD ["gunicorn", "-b", "0.0.0.0:5000", "run:app"]