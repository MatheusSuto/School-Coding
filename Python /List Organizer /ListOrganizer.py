def listaOrdenada(lista):
    for i in range(len(lista)- 1):
        menor = i
        posAtual = i
        for posAtual in range(posAtual, len(lista) - 1):
            if(lista[posAtual + 1] < lista[menor]):
                menor = posAtual + 1
        temp = lista[i]
        lista[i] = lista[menor]
        lista[menor] = temp
    return lista
    
#Programa Principal
lista = [9, 76, 12, 34, 23, 1, 29, 98, 54, 3]
resultado = listaOrdenada(lista)
print(resultado)
    
