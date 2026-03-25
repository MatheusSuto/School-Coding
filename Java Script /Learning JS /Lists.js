const numeros = [5, 12, 8, 150, 44];
let achado = null;
for (let i = 0; i < numeros.length; i++) {
    if (numeros[i] === 12) {
        achado = numeros[i]; //i = 1
        break;
    };
};

if (achado !== null) {
    console.log(achado+" foi encnotrado.") // this one
} else {
    console.log("O número não foi encontrado!")
}
