# mcp/mcp-client/client.py
import subprocess
import json
import sys
from pathlib import Path

def main():
    city = sys.argv[1] if len(sys.argv) > 1 else "Bangkok"

    server_path = Path(__file__).resolve().parents[1] / "weather" / "weather.py"

    proc = subprocess.Popen(
        ["python", str(server_path)],
        stdin=subprocess.PIPE,
        stdout=subprocess.PIPE,
        text=True
    )

    req = {"method": "check_weather", "params": {"city": city}}
    proc.stdin.write(json.dumps(req) + "\n")
    proc.stdin.flush()

    resp_line = proc.stdout.readline()
    try:
        resp = json.loads(resp_line.strip())
    except Exception:
        print(f"Bad response: {resp_line}")
        proc.terminate()
        return

    if "result" in resp:
        print(f"Weather in {city}: {resp['result']}")
    else:
        print(f"Error: {resp.get('error')}")

    proc.terminate()

if __name__ == "__main__":
    main()
