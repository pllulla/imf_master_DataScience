import streamlit as st
import pandas as pd
import requests
# importing geopy library
from geopy.geocoders import Nominatim

#Intentar utilizar la libreria para gps para meter el nombre de la ciudad y sacar la info de la ciudad en dataframe
#tres gráficas, una de linea con dos datos en el eje y temp max y temp min
#Gráfica de barras con las precipitaciones

st.title("IMF APP del tiempo con localización por ciudad")
ciudad = st.text_input('Introduce una ciudad: ', 'Madrid')

# calling the Nominatim tool
loc = Nominatim(user_agent="GetLoc")
 
# entering the location name
getLoc = loc.geocode(ciudad)
    
def get_weather(_lat, _long):
    url = f"https://api.open-meteo.com/v1/forecast?latitude={_lat}&longitude={_long}&daily=temperature_2m_max,temperature_2m_min,rain_sum,windspeed_10m_max&current_weather=true&timezone=Europe%2FBerlin"
    req = requests.get(url).json()
    
    return pd.DataFrame(req["daily"])

st.dataframe(get_weather(getLoc.latitude, getLoc.longitude))

