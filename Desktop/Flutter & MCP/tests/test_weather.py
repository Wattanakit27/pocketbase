# mcp/tests/test_weather.py
import subprocess
import sys
from pathlib import Path

def run_client(city):
    client_path = Path(__file__).resolve().parents[1] / "mcp-client" / "client.py"
    p = subprocess.Popen(
        ["python", str(client_path), city],
        stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True
    )
    out, _ = p.communicate(timeout=10)
    return out.strip()

def test_bangkok():
    out = run_client("Bangkok")
    assert "Bangkok" in out and "33" in out
