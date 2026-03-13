print("O numero da sorte está entre {} e {}" .format(1,100))
numero_secreto = 42
total_de_tentativas = 3
for rodada in range (1, total_de_tentativas+1):
    print("Tentativa {} de {}" .format(rodada, total_de_tentativas))
    chute_str = input("Digite o seu número: ")
    print("Você digitou: ", chute_str)
    chute = int(chute_str)
    acertou = numero_secreto == chute
    maior = chute > numero_secreto
    menor = chute < numero_secreto
    if (acertou):
        print("Parabéns, você acertou o número da sorte")
        break
    else: 
        if (maior):
            print("Você errou! O seu chute foi maior.")
        elif (menor):
            print ("Você errou! O seu chute foi menor.")
print("Fim do jogo")
