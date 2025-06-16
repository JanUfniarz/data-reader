from flask import Flask

from server.agents.data_summarizer import DataSummarizer
from server.agents.query_describer import QueryDescriber
from server.agents.query_generator import QueryGenerator
from server.controller import Controller
from server.services.data_service import DataService
from server.services.reader import Reader


def default_reader_config():
    data_service = DataService()
    return Controller(
        Flask(__name__),
        Reader(
            data_service,
            QueryGenerator(),
            QueryDescriber(),
            DataSummarizer()
        ),
        data_service
    )
    

if __name__ == "__main__":
    data_reader = default_reader_config()
    data_reader.listen()
    data_reader.app.run(host="0.0.0.0")