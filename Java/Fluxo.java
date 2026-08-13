public class Fluxo {
    public static void main(String[] args) {
        System.out.println("Ini do main");
        metodo1();
        System.out.println("Fim do main");
    }

    private static void metodo1() {
        System.out.println("Ini do método 1");
        metodo2();
        System.out.println("Fim do método 1");
    }

    private static void metodo2() {
        System.out.println("Ini do método 2");
        for (int i = 1; i <= 5; i++) {
            System.out.println(i);
        }
        System.out.println("Fim do método 2");
    }
}

/*
Ini do main // acessando o método 1() através da chamada
Ini do método 1 //Foi acessado(invocado) o método 2()
Ini do método 2 //Foi acessado o método 2(); Agora a instrução interna do laço executará um loop (1 a 5)
1
2
3
4
5
Fim do método 2
Fim do método 1
Fim do main
*/
