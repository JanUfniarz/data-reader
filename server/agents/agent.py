from requests import post

from server.services.session_data_storage import SessionDataStorage


class Agent(SessionDataStorage):
    def __init__(self):
        self.path: str = "http://ollama:11434/api/generate"

    def __call__(self, input_: str, sid: str) -> str:
        model: str = self.session(sid).model
        if not model:
            raise Exception("model not provided")

        data = dict(
            model=model,
            prompt=input_,
            stream=False
        )

        response = post(self.path, json=data, stream=True)
        return response.json()["response"]