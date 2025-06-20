from dataclasses import dataclass

from duckdb.duckdb import DuckDBPyConnection, connect


@dataclass
class SessionData:
    model: str | None = "gemma3"
    data_structure: str | None = None
    table_name: str | None = None
    cursor: DuckDBPyConnection = connect()

class SessionDataStorage:
    _sessions: dict[str, SessionData] = {}

    def _new_session(self, sid: str) -> SessionData:
        new: SessionData = SessionData()
        self._sessions[sid] = new
        return new

    def session(self, sid: str) -> SessionData:
        return self._sessions.get(sid) or self._new_session(sid)