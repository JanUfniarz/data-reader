from dataclasses import dataclass

from duckdb.duckdb import DuckDBPyConnection, connect


@dataclass
class UserData:
    model: str | None = None
    data_structure: str | None = None
    table_name: str | None = None
    cursor: DuckDBPyConnection = connect()

class UserDataStorage:
    _users: dict[str, UserData] = {}

    def add_user(self, uid: str, **kwargs) -> UserData:
        new_user: UserData = UserData(**kwargs)
        self._users[uid] = new_user
        return new_user

    def user(self, uid: str) -> UserData:
        return self._users.get(uid)