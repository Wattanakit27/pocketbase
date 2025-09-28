# weather/weather_api.py
from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route("/weather", methods=["GET"])
def weather():
    city = request.args.get("city", "Bangkok")
    data = {
        "Bangkok": "🌤️ Hot & Humid ~33°C",
        "Chiang Mai": "🌥️ Mild Cloud ~27°C",
        "Phuket": "⛈️ Showers ~29°C",
        "Khon Kaen": "☀️ Dry Sunny ~31°C",
    }
    return jsonify({"city": city, "result": data.get(city, f"No data for {city}")})

if __name__ == "__main__":
    app.run(port=5000)
