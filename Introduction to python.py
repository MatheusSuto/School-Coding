
a = 2
b = 10
c = 16.8
print(a + b)
print(a + c)

result = a + b * 2
print(result)

result = a + b * (2 / 3)
print(f'resultado é igual a {result}.')
print(f'resultado é igual a {result: .3f}.') #the .3f stands for formatation of the decimal section, limiting it to only 3 decimal points
print("resultado é igual a %.2f" % result)
print("resultado é igual a %d" % result)

result = a + b * (2 / 3)
nome = 'nome'
print("o resultado é", nome, result, ".")

def opera(n1, n2):
    resultSoma = n1 + n2
    resultMult = n1 * n2
    resultDivInt = n1 // n2
    resultDivFrac = n1 / n2
    resultSub = n1 - n2
    
    return f'Os resultados são: {resultSoma}, {resultMult}, {resultDivInt}, {resultDivFrac}, {resultSub}.'

num1 = 2
num2 = 10

resultado = opera(num1, num2)
print(resultado)
