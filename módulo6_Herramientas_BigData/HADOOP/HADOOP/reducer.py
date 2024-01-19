#!/usr/bin/env python
import sys

current_word = None
word_count = 0

# Leer la entrada desde la corriente estándar
for line in sys.stdin:
    word, count = line.strip().split('\t')
    
    if current_word == word:
        word_count += int(count)
    else:
        if current_word:
            # Emitir el resultado (palabra, contador) cuando cambia la palabra
            print(f"{current_word}\t{word_count}")
        current_word = word
        word_count = int(count)

# Asegurarse de emitir el último resultado
if current_word:
    print(f"{current_word}\t{word_count}")
