#include <stdio.h>
#include <pthread.h>

void * writeY( void * arg);

int main(int argc, const char * argv[]) {
    pthread_t t;
	pthread_create(&t, NULL, writeY, NULL);
	while (true)
		printf("x");
	
	return 0;
}

void * writeY( void * arg ) {
	while (true)
		printf("y");
	return 0;
}