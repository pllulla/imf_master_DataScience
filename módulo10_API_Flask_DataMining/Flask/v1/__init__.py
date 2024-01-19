# Importar los Blueprints creados
from .open_weather import open_weather
from .auth import auth

def register_v1(app):
    # Registrar los Blueprints creados
    app.register_blueprint(open_weather)
    app.register_blueprint(auth)