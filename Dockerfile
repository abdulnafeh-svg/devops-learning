FROM python:3.12-slim

WORKDIR /app

COPY app/requirements.txt .

RUN pip install -r requirements.txt

COPY app/ .

EXPOSE 5000

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:5000', timeout=3)" || exit 1

CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]
