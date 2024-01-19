#!/usr/bin/env python

import sys

#Iteramos sobre cada línea de entrada y obligamos a que sea stdin
for line in sys.stdin:
    #Eliminamos espacios en blanco y dividimos la línea en palabras
    line = line.strip()
    year, month, temperature = line.split('\t')

    #Emitimos el año y la temperatura como clave-valor
    print(f"{year}\t{temperature}")

