"""
Construa uma matriz com a seguinte formação:

|5            |
|6 12         |
|7 14 21      |
|8 16 24 32   |
|9 18 27 36 45|
"""


def matriz(size):
    result = []
    for i in range(size):
        lista = []
        for j in range(size):
            if j > i:
                continue
            lista.append((j + 1) * (i + 5))
        result.append(lista)
    return result
        


tamanho = input("Digite o tamanho da matriz: ")
tamanho = int(tamanho)
for i in matriz(tamanho):
    print(i)
