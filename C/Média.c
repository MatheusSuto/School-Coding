#include <stdio.h>

float tiraMedia(float num1, float num2) {
	return (num1+num2)/2;
}

int main() {
	printf("Média\n");
	printf("Qual o 1° número?\n");

	float num1;

	scanf("%f", &num1);
    printf("E o 2° número?\n");
    
    float num2;
    
    scanf("%f", &num2);

	float media = tiraMedia(num1, num2);

	printf("A média entre os 2 números é %.2f", media);
	return 0;
}
