from dataclasses import dataclass

from duckdb.duckdb import DuckDBPyConnection, connect


@dataclass
class SessionData:
    model: str | None = None
    data_structure: str | None = None
    table_name: str | None = None
    cursor: DuckDBPyConnection = connect()

class SessionDataStorage:
    _users: dict[str, SessionData] = {}

    def add_user(self, sid: str, **kwargs) -> SessionData:
        new_user: SessionData = SessionData(**kwargs)
        self._users[sid] = new_user
        return new_user

    def user(self, sid: str) -> SessionData:
        return self._users.get(sid)