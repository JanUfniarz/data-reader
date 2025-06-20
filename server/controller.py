from functools import wraps

from flask import Flask
from flask import jsonify, request

from server.services.data_service import DataService
from server.services.reader import Reader
from server.services.session_data_storage import SessionDataStorage


class Controller(SessionDataStorage):
    def __init__(
            self,
            app: Flask,
            reader: Reader,
            data_service: DataService
    ):
        self.data_service = data_service
        self.process_data = reader
        self.app = app

    def listen(self):

        @self.app.route('/data/')
        def set_dataset(data):
            self.data_service.set_dataset(
                data.get("sid"),
                data.get('dataset'),
                data.get('table_name')
            )
            return jsonify(message="dataset transferred")

        @self.app.route("/analyze/")
        def analyze(data):
            description, result, summarization = self.process_data(
                data.get("prompt"),
                data.get("sid")
            )

            return jsonify(
                message="success",
                description=description,
                result=result,
                summarization=summarization
            )