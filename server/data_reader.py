from flask import Flask

from server.agents.agent import Agent
from server.decorators import endpoint


class Reader:
    def __init__(self, app: Flask):
        self.app = app

    def listen(self):
        @endpoint(self.app, "/setup/")
        def setup(data):
            Agent.model = data.get("model")

        @endpoint(self.app, "/call/")
        def call(data):
            pass



if __name__ == '__main__':
    pass