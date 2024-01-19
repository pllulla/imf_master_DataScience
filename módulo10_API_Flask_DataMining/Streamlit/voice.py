import streamlit as st
import os
from google.cloud import texttospeech


os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = "C:\\AccesGCloud\\p_gcloud.json"

st.title("IMF Text to Speech")

text = st.text_area("Introduce tu texto para reproducir en voz", value="Hola, escribe lo que quieras")

speed = st.slider("Velocidad de reproducción", 0.5, 1.5, 1.0)

if st.button("Generar Voz"):
    client = texttospeech.TextToSpeechClient()

    synthesis_input = texttospeech.SynthesisInput(text=text)

    voice = texttospeech.VoiceSelectionParams(
        language_code="es-ES",
        ssml_gender=texttospeech.SsmlVoiceGender.NEUTRAL
    )

    audio_config = texttospeech.AudioConfig(
        audio_encoding=texttospeech.AudioEncoding.MP3,
        speaking_rate=speed
    )

    response = client.synthesize_speech(
        input=synthesis_input, 
        voice=voice, 
        audio_config=audio_config
    )

    with open("output.mp3", "wb") as out:
        out.write(response.audio_content)
        st.audio("output.mp3")



