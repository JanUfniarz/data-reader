from requests import post

from server.services.user_data_storage import UserDataStorage


class Agent(UserDataStorage):
    def __init__(self):
        self.path: str = "http://ollama:11434/api/generate"

    def __call__(self, input_: str, uid: str) -> str:
        model: str = self.user(uid).model
        if not model:
            raise Exception("model not provided")

        data = dict(
            model=model,
            prompt=input_,
            stream=False
        )

        response = post(self.path, json=data, stream=True)
        return response.json()["response"]