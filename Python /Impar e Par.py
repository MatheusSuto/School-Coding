lista = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]

def impar ():
    for impar in range (len(lista)):
        if(impar%2 != 0 and impar!= 0):
            print(impar, end=" ")
    print()
    
def par ():
    for par in range (len(lista)):
        if(par%2 == 0 and par != 0):
            print(par, end=" ")
    print()

impar()
par()
