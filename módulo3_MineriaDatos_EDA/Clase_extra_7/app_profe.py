import streamlit as st
import pandas as pd
import requests
from geopy.geocoders import Nominatim

# Función para obtener datos del tiempo
def get_weather(_lat, _long):
    
    url = f"https://api.open-meteo.com/v1/forecast?latitude={_lat}&longitude={_long}&daily=temperature_2m_max,temperature_2m_min,rain_sum,windspeed_10m_max&timezone=Europe%2FBerlin"
    req = requests.get(url).json()
    
    return pd.DataFrame(req["daily"])

# Establecer el título de la app
st.title("IMF APP del tiempo")
st.write("Esta es una app que muestra el tiempo")

# Crear input field para introducir la ciudad
ciudad = st.text_input("Introduce la ciudad")

if ciudad == None or ciudad == "":
    st.write("No has introducido ninguna ciudad")
else:
    # Traducir la ciudad a coordenadas
    coordinates = Nominatim(user_agent="myGeocoder").geocode(ciudad)

    # Obtener datos del tiempo y generar dataframe con todos los datos
    total_data = get_weather(coordinates.latitude, coordinates.longitude)

    # Seleccionar datos para cada gráfica
    data_temperatura = total_data[["time","temperature_2m_max", "temperature_2m_min"]]
    data_precipitaciones = total_data[["time","rain_sum"]]
    data_viento = total_data[["time","windspeed_10m_max"]]

    # Selector para mostrar u ocultar la tabla
    showTable = st.checkbox("Mostrar tabla con todos los datos")
    
    # Representar tabla del tiempo
    if showTable:
        st.dataframe(total_data)

    # Representar gráfica de línea con 2 datos
    st.subheader("Gráfico Temperatura")
    st.line_chart(data_temperatura, x="time")

    # Poner las gráficas siguientes en dos columnas
    col1, col2 = st.columns(2)

    with col1:
       # Representar gráfico de barras
        st.subheader("Gráfico Lluvia")
        st.bar_chart(data_precipitaciones, x="time")

    with col2:
       # Representar gráfico de línea con 1 dato
        st.subheader("Gráfico Viento")
        st.line_chart(data_viento, x="time")
    
    

    
    