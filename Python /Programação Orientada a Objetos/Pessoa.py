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

# 3 - HERANÇA - Classe Advogado herda da classe Pessoa
class Advogado(Pessoa):
    def __init__ (self, nome: str, idade:int, oab:str):
        # Método super() invoca o construtor da classe mãe (Pessoa)
        super().__init__(nome, idade)
        self.oab = oab #Só interessa à classe Advogado
    #4 - POLIMORFISMO -  Classse Advogado cria sua prórpia forma
    def peticionar(self):
        return f'Advogado {self.obterNome()} peticionou o protocolo 286/26'

# Criação da classe filha Médico. Essa classe irá herdar tudo da classe Pessoa.
class Médico (Pessoa):
    def __init__ (self, nome:str, idade:int, crm: str):
        super()._init_(nome, idade)
        self.crm = crm # Atributo exclusivo da classe Médico
    # 4 - POLIMORFISMO - Executando o MNétodo Medicar
    def medicar(self):
        return f'O médico{self.obterNome()} medicou o paciente às 9:45'
    
# PP - Criando os Ojetos de Instanciação e Respectivos Funcionamentos dos Métodos anteriormente construídos
advogada_ana = Advogado("Ana", 32, "OAB-458") # Instanciação
medico_jorge = Médico("Jorge", 39, "CRM-281") # Instanciação

# Invocando os métodos através dos Encapsulamentos
print(f'Nome do Advogado: {advogada_ana.obterNome()}')
# OBS: Para idade negativa, apresentará um erro já previsto no código
# 4 - POLIMORFISMO - Utilizando uma lsitra de nomes
print("Lista de pessoas profissionais: ")
listaPessoas = [advogada_ana, medico_jorge]
for pessoa in listaPessoas:
    print(pessoa.patrocinar())
    print(pessoa.medicar(()))
