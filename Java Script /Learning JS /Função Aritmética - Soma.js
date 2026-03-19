//subprograma
function operaNum (num_1, num_2){
    let soma = num_1 + num_2;
    return "A soma entre " + num_1 + " e " + num_2 + " é igual a " + soma;
}

//programa principal
let num_1 = parseInt(prompt("Digite o 1° número: "));
let num_2 = parseInt(prompt("Digite o 2° número: "));
console.log(operaNum(num_1, num_2))
