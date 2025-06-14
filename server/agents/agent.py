from requests import post

class Agent:
    model: str | None = None

    def __init__(self, data_structure: str):
        self.path: str = "http://ollama:11434/api/generate"
        self.structure = data_structure


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


class QueryGenerator(Agent):
    pass


    def generate_query(self, prompt: str) -> str:
        pass

    def describe_query(self, query) -> str:
        pass

    def summarize(self, data: str) -> str:
        pass
