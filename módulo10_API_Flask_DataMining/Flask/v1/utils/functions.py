import jwt, datetime
from flask import Blueprint, jsonify, request
from functools import wraps

def holi():
    
    return 'Holita'

SECRETO = 'Nodigasnada'

def fence(f):
    @wraps(f)
    def decorator(*args, **kwargs):
        try:
            jwt_token = request.headers['Authorization']
            if jwt_token:
                resp = auth.check_jwt(jwt_token.split(' ')[1])
                if resp['result']:
                    return f(*args, **kwargs)
                else:
                    return jsonify({'result': False, 'response':resp}), 401
            else:
                return jsonify({'result': False, 'response': 'No se ha enviado el token'}), 401
        except Exception as e:
            return jsonify({'result': False, 'response': str(e)}), 401
    
    return decorator

#Introduzco el parámetro city para meterlo en el token jwt
class auth:
    
    def issue_jwt(_user, _city):
        
        payload = {
            'user': _user,
            'city': _city,
            'exp': datetime.datetime.utcnow() + datetime.timedelta(hours=2),
            'iat': datetime.datetime.utcnow()
        }
        
        jwt_token = jwt.encode(payload, SECRETO, algorithm='HS256')
        
        return jwt_token
    
    def check_jwt(_jwt):
        
        try:
            return {'result': True, 'response': jwt.decode(_jwt, SECRETO, algorithms=['HS256'])}
        except jwt.ExpiredSignatureError:
            return {'result': False, 'response': 'Token expirado'}
        except jwt.InvalidTokenError:
            return {'result': False, 'response': 'Token invalido'}
    