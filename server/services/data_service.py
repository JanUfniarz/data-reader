import io

from duckdb.duckdb import DuckDBPyConnection
from tabulate import tabulate

from server.services.user_data_storage import UserDataStorage, UserData


class DataService(UserDataStorage):
    def set_dataset(self, uid:  str, dataset, table_name: str):
        user = self.user(uid)
        buffer = io.StringIO(dataset)

        # language=POSTGRES-PSQL
        table_query: str = f"CREATE TABLE {table_name} AS SELECT * FROM read_csv_auto(?)"
        user.cursor.execute(table_query,(buffer,))

        user.table_name = table_name
        user.data_structure = _get_structure(user)

    def execute_query(self, uid:  str, query: str) -> str:
        return _md(self.user(uid).cursor.execute(query))

def _get_structure(user:  UserData):

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