from requests import post

class Agent:
    model: str | None = None
    data_structure: str | None = None

    def __init__(self):
        self.path: str = "http://ollama:11434/api/generate"


    def __call__(self, input_: str) -> str:
        if not self.model:
            raise Exception("model not provided")

        data = dict(
            model=self.model,
            prompt=input_,
            stream=False
        )

        response = post(self.path, json=data, stream=True)
        return response.json()["response"]