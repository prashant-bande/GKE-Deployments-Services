FROM python:3.5

COPY . /app
WORKDIR /app

RUN /usr/local/bin/python -m pip install --upgrade pip && pip install -r requirements.txt

CMD ["python", "-u", "server.py"]
