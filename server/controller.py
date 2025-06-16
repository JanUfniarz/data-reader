from functools import wraps

from flask import Flask
from flask import jsonify, request

from server.services.data_service import DataService
from server.services.reader import Reader
from server.services.user_data_storage import UserDataStorage


def endpoint(app, route):
    def decorator(func):
        @app.route(route, methods=["POST"])
        @wraps(func)
        def wrapped():
            return jsonify(func(request.get_json()))
        return wrapped
    return decorator


class Controller(UserDataStorage):
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
            self.add_user(data.get("uid"), model=data.get("model"))
            return dict(message="setup completed")

        @endpoint(self.app, '/data/')
        def set_dataset(data):
            self.data_service.set_dataset(
                data.get("uid"),
                data.get('dataset'),
                data.get('table_name')
            )
            return dict(message="dataset transferred")

        @endpoint(self.app, "/call/")
        def call(data):
            description, result, summarization = self.process_data(
                data.get("prompt"),
                data.get("uid")
            )

            return dict(
                message="success",
                description=description,
                result=result,
                summarization=summarization
            )