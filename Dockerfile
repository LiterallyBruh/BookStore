# Pull base image
FROM python:3.10.4-slim-bullseye
# Set environment variables
ENV PIP_DISABLE_PIP_VERSION_CHECK 1
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
# Set work directory
WORKDIR /code
# Install dependencies
COPY ./requirements.txt .
RUN pip install -r requirements.txt
ARG key
ENV DJANGO_SECRET_KEY=$key
RUN echo '$DJANGO_SECRET_KEY'
RUN python manage.py migrate --settings=BookstoreProject.settings.dev-microservice
CMD python manage.py runserver 0.0.0.0:8001 --settings=BookstoreProject.settings.dev-microservice
COPY . .