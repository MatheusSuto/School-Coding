#Trataremos da classe Pessoa
#1 - ABSTRAÇÃO - Criação da Classe Mãe (Base)
class Pessoa:
    def __init__ (self, nome:str, idade:int):
        #2  - ENCAPSULAMENTO - Proteção dos dados usando prefixos
        self.nome = nome #PRotegido (), onde as classes filhas serão ativadas
        self._idade = idade # É só um underline #Privado (__), somente dentro da classe (desta classe)
