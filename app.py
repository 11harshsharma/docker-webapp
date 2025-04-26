from flask import Flask

app = Flask(__name__)

@app.route('/hello', methods=['GET'])
def hello():
    return "Hello, World!"

@app.route('/goodbye', methods=['GET'])
def goodbye():
    return "Goodbye, World!"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)

