"""
lista = [8, 15, 3, 19, 4]

# Menor Valor
menor = 0
for i in range(len(lista) - 1):
    if lista[i + 1] < lista[menor]:
        menor = i + 1
print(lista[menor])
"""

'''
def ordenaCrescente(vals):
    for i in range(len(vals)):
        menor = i
        for pos in range(i, len(vals) - 1):
            if vals[pos + 1] < vals[menor]:
                menor = pos + 1

        vals[i], vals[menor] = vals[menor], vals[i]

        """       
        temp = vals[menor]
        vals[menor] = vals[i]
        vals[i] = temp
        """
    return vals


lista = [8, 15, 3, 19, 4]
listaCrescente = ordenaCrescente(lista)
print(f"A lista Crescente é {listaCrescente}")
'''
