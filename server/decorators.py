from functools import wraps

from flask import request, jsonify


def endpoint(app, route):
    def decorator(func):
        @app.route(route, methods=["POST"])
        @wraps(func)
        def wrapped():
            return jsonify(func(request.get_json()))
        return wrapped
    return decorator