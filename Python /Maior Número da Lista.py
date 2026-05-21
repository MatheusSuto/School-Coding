lista = []

# Inputs do Usuário
for i in range(1, 8):
    num = int(input("Digite um número: "))
    lista.append(num)

print("Número digitados:", lista)

# Função Principal
maior = 0
for i in range(len(lista)):
    if lista[i] > lista[maior]:
        maior = i
    else:
        continue

# Finalização
print("O maior número é", lista[maior])
