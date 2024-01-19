#!/usr/bin/env python

import sys

current_year = None
max_temperature = 0

#Iteramos sobre cada línea de entrada y obligamos a que sea stdin
for line in sys.stdin:
    #Eliminamos espacios en blanco y dividimos la línea en palabras
    line = line.strip()
    year, temperature = line.split('\t')

    #Pasar la temperatura a entero
    temperature = int(temperature)

    #Si se cambia de año, se imprime el resultado para el año anterior
    if current_year and current_year != year:
        print(f"En el año {current_year} la temperatura máxima fue {max_temperature}")
        current_year = year
        max_temperature = temperature
    else:
        current_year = year
        max_temperature = max(max_temperature, temperature)

#Se imprime el resultado para el último año
if current_year:
    print(f"En el año {current_year} la temperatura máxima fue {max_temperature}")
