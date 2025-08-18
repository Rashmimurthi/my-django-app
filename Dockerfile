FROM python:3-slim
WORKDIR /app/backend 
COPY requirements.txt  /app/backend 
RUN pip install --upgrade pip && pip install -r requirements.txt
COPY . /app/backend
EXPOSE 8000
CMD ["python","manage.py","runserver","0.0.0.0:8000"]

