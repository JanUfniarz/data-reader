FROM python:latest

WORKDIR /usr/src

COPY . .

RUN pip install flask duckdb tabulate requests

CMD ["python", "run.py"]