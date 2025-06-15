from server.agents.agent import Agent


class DataSummarizer(Agent):
    SYSTEM_PROMPT = """
    You are a data summarizer. 
    Your task is to generate a summary based on a table of data. 
    Write a short paragraph that summarizes the data and draws conclusions from it.
    Do not return anything except the paragraph.
    """

    def __call__(self, data: str) -> str:
        return super()("\n".join([
            f"System prompt: {self.SYSTEM_PROMPT}",
            f"Data: \n{data}"
        ]))