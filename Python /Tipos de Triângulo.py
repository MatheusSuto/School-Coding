nlados = input("Entre com 3 lados ").split()
n1 = int(nlados[0])
n2 = int(nlados[1])
n3 = int(nlados[2])


def triangle_type():
    if (n1 == n2 and n2 == n3):
        print("Triângulo equilátero")
    elif (n1 != n2 and n2 != n3 and n1 != n3):
        print("Triângulo escaleno")
    else:
        print("Triângulo isósceles")

if (n1+n2>n3 and n2+n3>n1 and n1+n3>n2):
    triangle_type()
else:
    print("Não é triângulo")
