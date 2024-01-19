from flask import Flask, request, jsonify

from v1 import register_v1

app = Flask(__name__)

register_v1(app)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5001, debug=True)