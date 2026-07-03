# Sintaxe e Utilização de Códigos Novos

## CONSTRAIN
Evita a inserção de dados inválidos, garantindo segurança à utilização dos dados.
Se houver alguma violação do CONSTRAIN, a ação é abortada

### Tipos
- NOT NULL - Não pode ter valor nulo
- UNIQUE - Todos os valores devem ser únicos
- PRIMARY KEY - Indificador único (uma "combinação" do NOT NULL e UNIQUE)
- FOREIGN KEY - Cria um link entre 2 tableas e previque que esse seja quebrado.
- CHECK - Cria uma condição específica a ser checada
- DEFAULT - Ceia um valor padrão (para caso não haja inserção de valores)
