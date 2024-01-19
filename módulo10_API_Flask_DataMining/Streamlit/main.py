import streamlit as st
import requests
import pandas as pd


coordinates = {
    'Madrid': {'lat': 40.4167, 'long': -3.70325},
    'Barcelona': {'lat': 41.38879, 'long': 2.15899}
}

#st.write()

st.title("Consultar el tiempo de una ciudad")
drop_select = st.selectbox("Ciudad", ['Madrid', 'Barcelona'])
selected_city = coordinates[drop_select]

apiUrl = f"https://api.open-meteo.com/v1/forecast?latitude={selected_city['lat']}&longitude={selected_city['long']}&daily=temperature_2m_max,temperature_2m_min,precipitation_sum&timezone=Europe%2FBerlin"
req = requests.get(apiUrl)
data = req.json()

df = pd.DataFrame(data['daily'])
st.line_chart(df, x = 'time')
