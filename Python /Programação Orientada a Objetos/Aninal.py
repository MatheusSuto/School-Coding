class Animal:
    def __init__(self, nome, idade, especie):
        self.nome = nome
        self.idade = idade
        self.especie = especie
    def __imprimir__info__ (self):
        print("nome", self.nome)
        print("espécie", self.especie)

meu_animal = Animal("Leão", 5, "Felino")

meu_animal.__imprimir__info__()
