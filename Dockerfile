# Указываем базовый образ Python (например, используем Python 3.12)
FROM python:3.12-slim

# Устанавливаем Poetry
RUN pip install poetry

# Устанавливаем переменные среды для Poetry
# --no-root отключает создание по умолчанию пакета для проекта, а virtualenvs.create=false отключает создание окружения внутри контейнера
ENV POETRY_VIRTUALENVS_CREATE=false \
    POETRY_NO_INTERACTION=1

# Создаем рабочую директорию внутри контейнера
WORKDIR /app

# Копируем pyproject.toml и poetry.lock для установки зависимостей
COPY pyproject.toml poetry.lock /app/

# Устанавливаем зависимости через Poetry
RUN poetry install --no-dev

# Копируем код проекта внутрь контейнера
COPY . /app

# Указываем точку входа для приложения. Предположим, что основной скрипт называется "main.py"
ENTRYPOINT ["poetry", "run", "python", "main.py"]
