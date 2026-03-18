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

def is_rectangle (c1, c2, h):
    rectangle = c1**2 + c2**2 == h**2
    if rectangle:
        print("É retângulo")
    else:
        print("Não é retângulo")

def rectangle_hypotenuse ():
    if (n1>n2 and n1>n3):
        is_rectangle(n2, n3, n1)
    elif (n2>n1 and n2>n3):
        is_rectangle(n1, n3, n2)
    elif(n3>n1 and n3>n2):
        is_rectangle(n1, n2, n3)

if (n1+n2>n3 and n2+n3>n1 and n1+n3>n2):
    triangle_type()
    rectangle_hypotenuse()
else:
    print("Não é triângulo")
