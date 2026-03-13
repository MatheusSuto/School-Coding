import random as rd

print("Tente o número da Sorte!")
print("O número da sorte está entre" . format(1,50))
numero_secreto = rd.randint(1,50)
total_de_tentaivas = 5
for rodada in range (1,total_de_tentaivas+1):
    print("Tentativa {} de {}" .format(rodada, total_de_tentaivas))
    chute_str = input("Digite o seu número da sorte \n")
    print("Você digitou", chute_str)
    chute = int(chute_str)
    acertou = numero_secreto == chute
    maior= chute > numero_secreto
    menor = chute < numero_secreto
    if(acertou):
        print("Você acertou!")
        break
    else:
        if(maior):
            print("Você errou! Seu chute foi maior que o número secreto")
        elif (menor): 
            print("Você errou! Seu chute foi menor que o número secreto")
print("Fim de Jogo")
print(f'O número da sorte era {numero_secreto}')
