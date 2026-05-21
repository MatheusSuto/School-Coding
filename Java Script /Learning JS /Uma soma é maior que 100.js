function somaMaior(num1, num2) {
    let num = num1 + num2;
    if (num > 100) {
        alert("É Maior que 100")
    } else if (num == 100) {
        alert("É igual a 100")
    } else if (num < 100) {
        alert("É menor que 100")
    }
}

let num1 = parseInt(prompt("Digite o número 1: "))
let num2 = parseInt(prompt("Digite o número 2: "))

somaMaior(num1, num2)
