"""
Construa uma matriz com a seguinte formação:

|5            |
|6 12         |
|7 14 21      |
|8 16 24 32   |
|9 18 27 36 45|
"""


def matriz(size):
    for i in range(size):
        for j in range(size):

            if j > i:
                continue
            elif j == j:
                print((j + 1) * (i + 5), end=" ")
                """
                elif j == 0:
                    print(i + 5, end=" ")
                elif j == 1:
                    print(2 * (i + 5), end=" ")
                elif j == 2:
                    print(3 * (i + 5), end=" ")
                elif j == 3:
                    print(4 * (i + 5), end=" ")
                elif j == 4:
                    print(5 * (i + 5), end=" ")
                """
        print()
        


tamanho = input("Digite o tamanho da matriz: ")
tamanho = int(tamanho)
matriz(tamanho)
