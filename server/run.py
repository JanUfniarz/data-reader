from flask import Flask

from server.agents.data_summarizer import DataSummarizer
from server.agents.query_describer import QueryDescriber
from server.agents.query_generator import QueryGenerator
from server.data_reader import DataReader
from server.data_service import DataService


def default_reader_config():
    return DataReader(
        Flask(__name__),
        DataService(),
        QueryGenerator(),
        QueryDescriber(),
        DataSummarizer()
    )

if __name__ == "__main__":
    default_reader_config().run()