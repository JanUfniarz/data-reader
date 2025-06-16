from concurrent.futures import ThreadPoolExecutor

from server.agents.agent import Agent
from server.services.data_service import DataService


class Reader:
    def __init__(
            self,
            data_service: DataService,
            query_generator: Agent,
            query_describer: Agent,
            data_summarizer: Agent,
    ):
        self.data_service = data_service
        self.generate_query = query_generator
        self.describe_query = query_describer
        self.summarize_data = data_summarizer

    def __call__(self, prompt: str, uid: str) -> tuple[
        str, # description
        str, # result
        str # summarization
    ]:
        query: str = self.generate_query(prompt, uid)

        # Executing simultaneously
        with ThreadPoolExecutor() as executor:
            future_desc = executor.submit(self.describe_query, query, uid)
            future_result = executor.submit(self.data_service.execute_query, query, uid)

            description = future_desc.result()
            result = future_result.result()

        summarization: str = self.summarize_data(result, uid)

        return description, result, summarization
