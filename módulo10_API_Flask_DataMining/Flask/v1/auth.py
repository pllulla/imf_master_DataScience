from flask import Blueprint, jsonify, request
from .utils import functions

auth = Blueprint('auth', __name__)

baseURL = '/v1/auth/'

usuario_demo = "Pedro"
password_demo = "dzWM9sXhe02dUBqBw2hyZPwxFeDW9vIs"

@auth.route(baseURL + 'login', methods=['POST'])
def login():
    
    try:
        inData = request.get_json()
        
        if inData['usuario'] == usuario_demo and inData['password'] == password_demo:
            #Dentro de los datos que introduzco para la creación del token en POST /login, cojo la información de la ciudad
            return jsonify({'result': True, 'response': functions.auth.issue_jwt(inData['usuario'], inData['ciudad'])}), 200
        else:
            return jsonify({'result': False, 'response': 'Usuario o contraseña incorrectos'}), 401
    
    except Exception as e:
        return jsonify({'result': False, 'response': f'Peticion malformada - {str(e)}'}), 400
    