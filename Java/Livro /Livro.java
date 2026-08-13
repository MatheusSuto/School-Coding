public class Livro {
    private String autor;
    private int anoPublicação;

    public Livro(String autor, int anoPublicação) {
        this.autor = autor;
        this.anoPublicação = anoPublicação;
    }

    public String getAutor() {
        return this.autor;
    }

    public int getAnoPublicação() {
        return this.anoPublicação;
    }

    @Override
    public String toString() {
        return "O autor é " + autor + "e o ano de publicação é de " + anoPublicação + ".";
    }
}
