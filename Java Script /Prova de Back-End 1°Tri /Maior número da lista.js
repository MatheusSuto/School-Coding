let vetor = [32, 9, 2, 45, 18];
let maior = 0;
for (let i = 0; vetor.length; i+1){
    if (vetor[i+1] > vetor[maior]){
        maior = i+1
    }
}

console.log("O maior número é", vetor[maior]);
