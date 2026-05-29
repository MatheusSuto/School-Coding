"""
Seja uma lsita de presentes: bola, lápis, caderno, skate e patins. Você deve fazer um programa em python para que aleatoriamente para que o presente escolhido seja um deles e somente um.
"""

import random as rd

listaPresentes = ["bola", "lápis", "caderno", "skate", "patins"]

escolha = rd.randrange(1, 5)

print(f"O presente escolhido foi {listaPresentes[escolha]}")
