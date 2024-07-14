from flask import Flask, jsonify, request


app = Flask(__name__)


@app.route('/')
def home():
    return "Bem-vindo à API Flask!"

@app.route('/api/v1/message', methods=['GET'])
def get_message():
    return jsonify({"message": "Ola, este eh um exemplo de API Flask!"})

@app.route('/api/v1/sum', methods=['POST'])
def sum_numbers():
    data = request.get_json()
    num1 = data.get('num1')
    num2 = data.get('num2')
    return jsonify({"sum": num1 + num2})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
