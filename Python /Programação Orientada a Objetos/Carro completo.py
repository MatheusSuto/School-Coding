class Carro:
    def __init__(self, marca, modelo, ano, potencia):
        self.__marca=marca
        self.__modelo=modelo
        self.__ano=ano
        self.__potencia=potencia
    @property
    def marca(self):
        return self.__marca
    @property
    def modelo(self):
        return self.__modelo
    @property
    def ano(self):
        return self.__ano
    @property
    def potencia(self):
        return self.__potencia
    @potencia.setter
    def potencia(self, nova_potencia):
        if nova_potencia>0:
            self.__potencia=nova_potencia
        else:
            print("Potência inválida")
    def acelerar(self):
        print(f'O {self.marca}, {self.modelo} está acelerando')
    def frear(self):
        print(f"O {self.marca}, {self.modelo} está freando")

class CarroElétrico(Carro):
    def __init__(self, marca, modelo, ano, potencia, autonomia_bateria):
        super().__init__(marca, modelo, ano, potencia)
        self.__autonomia=autonomia_bateria
    def acelerar(self):
        print(f"O {self.marca}, {self.modelo} está acelerado... tudo silenciosamente")


subaru = Carro("Subaru", "YHZ", 2014, 275)
print(f'Marca: {subaru.marca}')
print(f'Modelo: {subaru.modelo}')

subaru.acelerar()
subaru.frear()
print()

tesla = CarroElétrico("Tesla", "Modelo y", 2025, 384, 500)
tesla.acelerar()
tesla.frear()
