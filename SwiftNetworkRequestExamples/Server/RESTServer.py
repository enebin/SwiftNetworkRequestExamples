from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route('/echo', methods=['POST'])
def echo():
    # Get JSON data from the request
    print("Received data:", request.json)

    data = request.json
    return jsonify(data)

if __name__ == '__main__':
    app.run(debug=True, port=8000)