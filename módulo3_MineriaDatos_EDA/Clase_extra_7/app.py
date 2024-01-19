import streamlit as st
import pandas as pd
import requests

#st.write("""
        # HOLA IMF
        ## Título 2
       #Esta es nuestra primera app en streamlit sobre el tiempo
        #""")"""
st.title("IMF APP del tiempo")

def get_weather(_lat, _long):
    url = f"https://api.open-meteo.com/v1/forecast?latitude={_lat}&longitude={_long}&daily=temperature_2m_max,temperature_2m_min,rain_sum,windspeed_10m_max&current_weather=true&timezone=Europe%2FBerlin"
    req = requests.get(url).json()
    
    return pd.DataFrame(req["daily"])

st.dataframe(get_weather(40.4165, -3.7026))






