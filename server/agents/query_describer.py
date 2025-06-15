from server.agents.agent import Agent


class QueryDescriber(Agent):
    SYSTEM_PROMPT = """
    You are a query describer. 
    Your task is to provide a brief description based on an SQL query. 
    Explain what the query does. 
    Write in the first person, e.g., "I found this data, I sorted it this way," etc. 
    Do not include anything except the description.
    """

    def __call__(self, query) -> str:
        return super()("\n".join([
            f"System prompt: {self.SYSTEM_PROMPT}",
            f"Table structure {self.data_structure}",
            f"Query: {query}"
        ]))