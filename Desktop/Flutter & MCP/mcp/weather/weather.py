# mcp/weather/weather.py
import sys
import json

def check_weather(city: str) -> str:
    """คืนค่าสภาพอากาศจำลองตามชื่อเมือง (demo ไม่เรียก API จริง)"""
    data = {
        "Bangkok": "🌤️ Hot & Humid ~33°C",
        "Chiang Mai": "🌥️ Mild Cloud ~27°C",
        "Phuket": "⛈️ Showers ~29°C",
        "Khon Kaen": "☀️ Dry Sunny ~31°C",
        "Udon Thani": "🌤️ Warm Breeze ~30°C",
    }
    return data.get(city, f"No demo weather data for '{city}'. Try Bangkok/Phuket/etc.")

def main():
    """
    โปรโตคอลง่ายๆ: อ่าน JSON จาก stdin บรรทัดละ 1 object
    รูปแบบคำขอ: {"method":"check_weather","params":{"city":"Bangkok"}}
    ส่งกลับ: {"result":"..."}
    """
    for line in sys.stdin:
        line = line.strip()
        if not line:
            continue
        try:
            req = json.loads(line)
            method = req.get("method")
            if method == "check_weather":
                city = (req.get("params") or {}).get("city", "")
                result = check_weather(city)
                print(json.dumps({"result": result}))
                sys.stdout.flush()
            else:
                print(json.dumps({"error": f"unknown method: {method}"}))
                sys.stdout.flush()
        except Exception as e:
            print(json.dumps({"error": str(e)}))
            sys.stdout.flush()

if __name__ == "__main__":
    main()
