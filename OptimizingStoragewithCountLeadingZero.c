#include <stdlib.h>
#include <stdio.h>

char num_p_8 = 0;
short num_p_16 = 0;
int num_p_32 = 0;

char count_leading_zeros(void *num_p){
	int x = *(int*)num_p;
    x |= (x >> 1);
    x |= (x >> 2);
    x |= (x >> 4);
    x |= (x >> 8);
    x |= (x >> 16);

    /* count ones (population count) */
    x -= ((x >> 1) & 0x55555555);
    x = ((x >> 2) & 0x33333333) + (x & 0x33333333);	
    x = ((x >> 4) + x) & 0x0f0f0f0f;
    x += (x >> 8);	
    x += (x >> 16);

    return (32 - (x & 0x7f));
}

void opt_storage(void *num_p){
	char leading_zero = count_leading_zeros(num_p);
	if(leading_zero>=24){
		num_p_8 = *(char*)num_p;
	}
	else if(leading_zero>=16){
		num_p_16 = *(short*)num_p;
	}
	else num_p_32 = *(int*)num_p;
}

int main(){
	int num = 16;
	void *num_p;
	for(int i=0; i<=3; i++){
		num_p = &num;
		opt_storage(num_p); // OUTPUT
		num = num << 5;
		printf("-------------\n");
		printf("char: %d\n", num_p_8);
		printf("short: %d\n", num_p_16);
		printf("int: %d\n", num_p_32);
	}
}
