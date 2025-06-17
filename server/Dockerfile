FROM python:latest

WORKDIR /usr/src

COPY . server/

RUN pip install flask duckdb tabulate requests

CMD ["python", "-m", "server.run"]