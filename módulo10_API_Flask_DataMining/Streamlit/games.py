import requests
from bs4 import BeautifulSoup
import streamlit as st

def obtener_precio_videojuego(nombre_juego):
    nombre_juego_url = nombre_juego.replace(' ', '-')
    url = f"https://www.pricecharting.com/es/game/pal-playstation-5/{nombre_juego_url}"

    response = requests.get(url)

    if response.status_code == 200:
        soup = BeautifulSoup(response.content, 'html.parser')
        
        precio_elemento = soup.find('span', class_='price js-price')
        if precio_elemento:
            precio = precio_elemento.text
            return precio
        else:
            return "Precio no encontrado"
    else:
        return "No disponible"

st.title("Consulta de Precios de Videojuegos")

nombre_juego = st.text_input("Ingresa el nombre del videojuego")

if st.button("Consultar Precio"):
    precio = obtener_precio_videojuego(nombre_juego)
    if precio != "No disponible":
        st.success(f"El precio de {nombre_juego} es: {precio}")
    else:
        st.error("Precio no disponible o juego no encontrado.")

