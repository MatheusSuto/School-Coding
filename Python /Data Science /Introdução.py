import pandas as pd #import panda

notas = pd.read_csv("ratings.csv") #lê o arquivo

notas.head() #mostra os 5 primerios elementos
#Na tabela, o índice (números em negrito) não são uma coluna

notas.shape # mostra a quantidade de linhas x colunas

notas.columns = ["Coluna 1", "Coluna 2", "Coluna 3", "Coluna 4"] #renomeia as colunas

notas.head() #para visualizar

notas["Coluna"] #mostra apenas os dados do índice e da coluna especificada

notas['Coluna'].unique() #mostra os valores únicos da coluna

notas["Coluna"].value_counts() #conta a quantidade de vezes que um valor aparece na coluna

notas["Coluna"].mean() #média
notas.columns.median() #mediana
# notas.columns ou notas["column"] dá na mesma.

notas.columns.describe() #Descreve (quantidade, média, mínimo, máximo, mediana, etc)
