# Class Livro em Python
# SP
class Livro:
    def __init__(self, titulo, autor, ano_publicado):
        self.titulo = titulo
        self.autor = autor
        self.ano_publicado = ano_publicado


class Biblioteca:
    def __init__(self):
        self.livros = []

    def adicionar_livros(self, livro):
        self.livros.append(livro)

    def mostra_livros(self):
        for livro in self.livros:
            print(f"Título: {livro.titulo}")
            print(f"Autor: {livro.autor}")
            print(f"Ano Publicado: {livro.ano_publicado}")

# PP
livrolista = ["Dom Casmurro", "O Pequeno Príncipe", "Os Sertões"]

#Instanciação da classe Biblioteca
minha_biblioteca = Biblioteca()

# Criação dos objetos da classe Livro
livro1 = Livro("O Alquimista", "Paulo Coelho", 1988)
livro2 = Livro("Dom Casmurro", "Machado de Assis", 1899)

# Adicionar livros à biblioteca
minha_biblioteca.adicionar_livros(livro1)
minha_biblioteca.adicionar_livros(livro2)

#Exibir o catálogo
minha_biblioteca.mostra_livros()
