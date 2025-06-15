import io

import duckdb
from duckdb.duckdb import DuckDBPyConnection
from tabulate import tabulate


class DataService:
    def __init__(self):
        self._db = duckdb.connect()
        self. _table_name: str | None = None

    def set_dataset(self, dataset, table_name: str):
        buffer = io.StringIO(dataset)

        # language=POSTGRES-PSQL
        table_query: str = f"CREATE TABLE {table_name} AS SELECT * FROM read_csv_auto(?)"
        self._db.execute(table_query,(buffer,))

        self._table_name = table_name

    def get_structure(self):
        # language=SQLITE-SQL
        structure_query = """
        SELECT column_name, data_type
        FROM information_schema.columns
        WHERE table_name = ?
        ORDER BY ordinal_position;
        """

        result = self._db.execute(structure_query, (self._table_name.upper(),))

        return f"#Table name: {self._table_name}\n{md(result)}"

    def execute_query(self, query: str) -> str:
        return md(self._db.execute(query))

def md(cursor:  DuckDBPyConnection) -> str:
    return tabulate(
        cursor.fetchall(),
        headers=[col[0] for col in cursor.description],
        tablefmt="github"
    )