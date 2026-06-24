# Classe Carro
class Carro:
    def __init__(self, marca, modelo, ano, potencia):
        self.marca = marca
        self.modelo = modelo
        self.ano = ano
        self.potencia = potencia

    def acelerar(self):
        print(f'O {self.marca}, {self.modelo} está acelerado')

    def frear(self):
        print(f'O {self.marca}, {self.modelo} está freado')

Subaru = Carro("Subaru","WXRT", 2025, 275)

print(f"Marca: {Subaru.marca}")
print(f"Modelo: {Subaru.modelo}")
print(f"Ano: {Subaru.ano}")
print(f"Potência: {Subaru.potencia}")
