import io

from duckdb.duckdb import DuckDBPyConnection
from tabulate import tabulate

from .session_data_storage import SessionDataStorage, SessionData


class DataService(SessionDataStorage):
    def set_dataset(self, sid:  str, dataset, table_name: str):
        user = self.session(sid)
        buffer = io.StringIO(dataset)

        # language=POSTGRES-PSQL
        table_query: str = f"CREATE TABLE {table_name} AS SELECT * FROM read_csv_auto(?)"
        user.cursor.execute(table_query,(buffer,))

        user.table_name = table_name
        user.data_structure = _get_structure(user)

    def execute_query(self, sid:  str, query: str) -> str:
        return _md(self.session(sid).cursor.execute(query))

def _get_structure(user:  SessionData):

    # language=SQLITE-SQL
    structure_query = """
    SELECT column_name, data_type
    FROM information_schema.columns
    WHERE table_name = ?
    ORDER BY ordinal_position;
    """

    result = user.cursor.execute(structure_query, (user.table_name.upper(),))

    return f"#Table name: {user.table_name}\n{_md(result)}"

def _md(cursor:  DuckDBPyConnection) -> str:
    return tabulate(
        cursor.fetchall(),
        headers=[col[0] for col in cursor.description],
        tablefmt="github"
    )