# Trataremos da classe Pessoa
# 1 - ABSTRAÇÃO - Criação da Classe Mãe (Base)
class Pessoa:
    def __init__ (self, nome:str, idade:int):
        # 2  - ENCAPSULAMENTO - Proteção dos dados usando prefixos
        self.nome = nome #Protegido (), onde as classes filhas serão ativadas
        self._idade = idade # É só um underline #Privado (__), somente dentro da classe (desta classe)
        # Métodos de ENCAPSULAMENTO: uso dos Getters e Setters
    def obterNome (self): 
        # Ler o nome verdadeiramente
        return self._nome
    def obterIdade (self):
        return self.__idade
    #Alterando a idade privada com validação de segurança
    def postaIdade (self, novaIdade):
        if novaIdade > 0:
            self.__idade = novaIdade
        else: 
            print("Idade com erro!")
