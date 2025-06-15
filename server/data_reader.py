from concurrent.futures import ThreadPoolExecutor

from flask import Flask

from server.agents.agent import Agent
from server.data_service import DataService
from server.decorators import endpoint


class DataReader:
    def __init__(
            self,
            app: Flask,
            data_service: DataService,
            query_generator: Agent,
            query_describer: Agent,
            data_summarizer: Agent,
    ):
        self.app = app
        self.data_service = data_service
        self.generate_query = query_generator
        self.describe_query = query_describer
        self.summarize_data = data_summarizer

    def listen(self):
        @endpoint(self.app, "/setup/")
        def setup(data):
            Agent.model = data.get("model")
            return dict(message="setup completed")

        @endpoint(self.app, '/data/')
        def set_dataset(data):
            self.data_service.set_dataset(data.get('dataset'), data.get('table_name'))
            Agent.data_structure = self.data_service.get_structure()
            return dict(message="dataset transferred")

        @endpoint(self.app, "/call/")
        def call(data):
            query: str = self.generate_query(data.get('prompt'))

            # * Executing simultaneously
            with ThreadPoolExecutor() as executor:
                future_desc = executor.submit(self.describe_query, query)
                future_result = executor.submit(self.data_service.execute_query, query)

                description = future_desc.result()
                result = future_result.result()

            summarization: str = self.summarize_data(result)
            return dict(
                message="success",
                description=description,
                summarization=summarization
            )

    def run(self):
        self.listen()
        self.app.run(host='0.0.0.0')