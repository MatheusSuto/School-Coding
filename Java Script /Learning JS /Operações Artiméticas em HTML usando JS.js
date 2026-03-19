<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Exercício 1</title>
    <script>
        let num_1 = prompt("Entre com o número 1: " ,100); // o número que vem depois das aspas indica um valor padrão, uma base. testar a página para melhor compreensão.
        let num_2 = prompt("Entre com o número 2: " ,200);
        if (num_1 > num_2) {
            mensagem = "O 1° número é maior que o 2°";
        } else if (num_2 > num_1) {
            mensagem = "O 2° número é maior que o 1°";
        } else {
            mensagem = "Os números são iguais ou nada foi informado";
        }
        alert(mensagem)
    </script>
</head>
</html>
