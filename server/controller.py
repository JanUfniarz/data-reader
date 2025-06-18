from functools import wraps

from flask import Flask
from flask import jsonify, request

from server.services.data_service import DataService
from server.services.reader import Reader
from server.services.session_data_storage import SessionDataStorage


def endpoint(app, route):
    def decorator(func):
        @app.route(route, methods=["POST"])
        @wraps(func)
        def wrapped():
            return jsonify(func(request.get_json()))
        return wrapped
    return decorator


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
        @endpoint(self.app, "/setup/")
        def setup(data):
            self.add_user(data.get("sid"), model=data.get("model"))
            return dict(message="setup completed")

        @endpoint(self.app, '/data/')
        def set_dataset(data):
            self.data_service.set_dataset(
                data.get("sid"),
                data.get('dataset'),
                data.get('table_name')
            )
            return dict(message="dataset transferred")

        @endpoint(self.app, "/call/")
        def call(data):
            description, result, summarization = self.process_data(
                data.get("prompt"),
                data.get("sid")
            )

            return dict(
                message="success",
                description=description,
                result=result,
                summarization=summarization
            )