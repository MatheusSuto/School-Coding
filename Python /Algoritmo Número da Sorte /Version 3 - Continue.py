numero_secreto = 86
total_tentativas = 5
for rodada in range (1, total_tentativas):
    print('Tentativa {} de {}'. format(rodada, total_tentativas))
    chute = int(input("Digite um número entre 1 e 100: "))
    if chute < 1 or chute > 100:
        print("Digite um número entre 1 e 100. Tente novamente!")
        continue
    acertou = chute == numero_secreto
    maior = chute > numero_secreto
    menor = chute < numero_secreto
    
    if acertou:
        print("Você acertou!")
        break
    else:
        if maior:
            print("Você errou! Seu chute foi maior")
        elif menor:
            print("Você errou! Seu chute foi menor")
print("Game Over!")
