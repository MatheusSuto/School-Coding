#include <stdio.h>
float converte(float Celsius){
    return Celsius*1.8+32;
}

int main()
{
    printf("Convertor Celsius para Fahreinheit\n");
    printf("Qual é o sua temperatura? ");
    
    float Celsius;
    
    scanf("%f", &Celsius);
    printf("Sua temperatura foi %.2f\n", Celsius);
    
    float Fahreinheit = converte(Celsius);
    
    printf("A temperatura em Fahreinheit é de %.2f", Fahreinheit);
    return 0;
}
