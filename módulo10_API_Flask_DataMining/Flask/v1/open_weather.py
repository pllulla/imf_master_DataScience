from flask import Blueprint, jsonify, request
from geopy.geocoders import Nominatim
import requests, datetime
from .utils import functions

open_weather = Blueprint('open_weather', __name__)

baseURL = '/v1/weather/'

@open_weather.route(baseURL + 'test', methods=['GET'])
def weather_test():
    
    return jsonify({'result': True, 'response': 'Este es mi primer endpoint con Flask'}), 200

@open_weather.route(baseURL + '7days/<_ciudad>', methods=['GET'])
def weather_7days(_ciudad):
    
    return jsonify({'result': True, 'response': _ciudad}), 200

@open_weather.route(baseURL + '7days', methods=['POST'])
@functions.fence
def weather_7days_post():
    
    try:
        inData = request.get_json()
        headerAuth = request.headers['Authorization']
        
        jwtData = functions.auth.check_jwt(headerAuth.split(' ')[1])['response']
        
        query = f"SELECT * FROM movimientos_bancarios WHERE usuario = '{jwtData['user']}'"
        
        
        if inData['ciudad'] == '':
            return jsonify({'result': False, 'response': 'Debe ingresar una ciudad'}), 400
        else:
            
            geolocator = Nominatim(user_agent="imfTest")
            location = geolocator.geocode(inData['ciudad'])
            
            req = requests.get('https://api.open-meteo.com/v1/forecast?latitude={}&longitude={}&daily=temperature_2m_max,precipitation_sum&timezone=Europe%2FBerlin'.format(location.latitude, location.longitude))
            result = req.json()
            
            data = result['daily']
            
            weatherData = {}
            
            for i in range(len(data['time'])):
                weatherData[data['time'][i]] = {'temp': data['temperature_2m_max'][i], 'precipitacion': data['precipitation_sum'][i]}
            
            respuesta = {
                "user": jwtData['user'],
                "query": query,
                "city": {
                    "name": inData['ciudad'],
                    "lat": location.latitude, 
                    "lon": location.longitude
                },
                "weather": weatherData
                
            }
            
            return jsonify({'result': True, 'response': respuesta}), 200
    except Exception as e:
        return jsonify({'result': False, 'response': f'Peticion malformada - {str(e)}'}), 400

  
    
#EJERCICIO DE CLASE PARA MI CIUDAD
@open_weather.route(baseURL + 'mi_ciudad', methods=['GET'])
@functions.fence
def mi_ciudad():
    try:
        headerAuth = request.headers.get('Authorization')
        if not headerAuth:
            return jsonify({'result': False, 'response': 'No se proporcionó token de autorización'}), 401

        jwtData = functions.auth.check_jwt(headerAuth.split(' ')[1])['response']
        ciudad = jwtData.get('city') 

        if not ciudad:
            return jsonify({'result': False, 'response': 'No se encontró la ciudad en los datos del usuario'}), 404

        geolocator = Nominatim(user_agent="tiempo_ciudad")
        location = geolocator.geocode(ciudad)
        if not location:
            return jsonify({'result': False, 'response': 'No se pudo encontrar la ciudad'}), 404

        # Consultar la API de Clima para el clima actual
        # OTRA OPCION ES METER EN LA PETICIÓN: &current_weather=true' sería más sencillo pero sigo con las pautas del ejemplo anterior
        api_url = f'https://api.open-meteo.com/v1/forecast?latitude={location.latitude}&longitude={location.longitude}&daily=temperature_2m_max,precipitation_sum&timezone=Europe%2FBerlin'
        response = requests.get(api_url)
        if response.status_code != 200:
            return jsonify({'result': False, 'response': 'Error al obtener datos del clima'}), response.status_code

        datos_miciudad = response.json()

        fecha_actual = datetime.datetime.utcnow().strftime('%Y-%m-%d')
        index = datos_miciudad['daily']['time'].index(fecha_actual)

        # Datos día actual
        datos_miciudad_hoy = {
            'temperature_max': datos_miciudad['daily']['temperature_2m_max'][index],
            'precipitation_sum': datos_miciudad['daily']['precipitation_sum'][index],
            'date': datos_miciudad['daily']['time'][index]
        }

        # Devolver la respuesta con los datos del día actual
        return jsonify({'result': True, 'user': jwtData['user'], 'response': datos_miciudad_hoy}), 200

    except Exception as e:
        return jsonify({'result': False, 'response': f'Error: {str(e)}'}), 500






