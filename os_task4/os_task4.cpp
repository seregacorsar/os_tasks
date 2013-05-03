#include <stdio.h>
#include <pthread.h>

void * inc( void * arg);
void * dec( void * arg);

int common_var = 0;

int main(int argc, const char * argv[]) {
	
	pthread_t t1, t2;
	pthread_create(&t1, NULL, inc, NULL);
	pthread_create(&t2, NULL, dec, NULL);
	
	printf("common_var is %d", common_var);
	
	return 0;
}

void * inc( void * arg ) {
	for (int i=0; i<1000000; ++i)
		common_var++;
	return 0;
}

void * dec( void * arg ) {
	for (int i=0; i<1000000; ++i)
		common_var--;
	return 0;
}