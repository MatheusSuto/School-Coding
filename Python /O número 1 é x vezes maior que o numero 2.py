def quantas_vezes_maior ():
    n1 = int(input("Número 1: "))
    n2 = int(input("Número 2: "))
    n3 = int(input("Número 3: "))

    if n1>n2 and n1>n3:
        value1 = n1/n2
        value2 = n1/n3
        print(f'O número 1 é {value1: .1f} vezes maior que o número 2, e também {value2: .1f} vezes maior que o número 3.')

    elif n2>n1 and n2>n3:
        value1 = n2/n1
        value2 = n2/n3
        print(f'O número 2 é {value1: .1f} vezes maior que o número 1, e também {value2: .1f} vezes maior que o número 3.')

    else:
        value1 = n3/n1
        value2 = n3/n2
        print(f'O número 3 é {value1: .1f} vezes maior que o número 1, e também {value2: .1f} vezes maior que o número 2')

quantas_vezes_maior()
