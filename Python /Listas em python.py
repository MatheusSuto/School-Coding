def soma ():
    soma = 0
    for indice in range (1,8):
        soma += indice
    print(soma)
    print()

def valores ():
    valores = input("digite os elementos do vetor:")
    print(valores)
    print()

def vals ():
    vals = [None]*10
    for indice in range (len(vals)):
        vals[indice] = input("Digite um número: ")
    print(vals)
    print()

def vetor ():
    vetor = [4, 8, 10, 12]
    soma = 0
    for indice in vetor:
        soma += indice
        print(indice, end=" ")
    print(soma)

