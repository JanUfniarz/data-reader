from functools import wraps

from flask import request


def endpoint(app, route):
    def decorator(func):
        @app.route(route, methods=["POST"])
        @wraps(func)
        def wrapped():
            return func(request.get_json())
        return wrapped
    return decorator