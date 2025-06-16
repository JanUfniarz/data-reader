from .agent import Agent


class QueryGenerator(Agent):
    SYSTEM_PROMPT = """
    You are an SQL query generator. 
    You will receive a prompt and, based on it, 
    you must generate a SELECT query to retrieve the data requested by the user. 
    Return only the SQL query. 
    You are not allowed to return anything else or anything beyond the SQL query 
    that searches the table according to the user's prompt.
    """

    def __call__(self, prompt: str, uid: str) -> str:
        return super()("\n".join([
            f"System prompt: {self.SYSTEM_PROMPT}",
            f"Table structure {self.user(uid).data_structure}",
            f"User prompt: {prompt}"
        ]), uid)