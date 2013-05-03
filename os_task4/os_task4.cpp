#include <stdio.h>
#include <pthread.h>

void * inc( void * arg);
void * inc_p( void * arg);
void * dec( void * arg);
void * dec_p( void * arg);

volatile int common_var = 0;
int ptr = 0;

void enter_critical_section() {
	while( __sync_val_compare_and_swap( &ptr, 0, 1 ) == 1 ) {}
	return;
}

void leave_critical_section() {
	ptr = 0;
	return;
}

int main(int argc, const char * argv[]) {
	
	pthread_t t1, t2;
	for (int i=0; i<5; ++i) {
		pthread_create(&t1, NULL, inc_p, NULL);
		pthread_create(&t2, NULL, dec_p, NULL);
		pthread_join(t1, NULL);
		pthread_join(t2, NULL);
		printf("common_var with lock is %d\n", common_var);
	}
	
	for (int i=0; i<5; ++i) {
		pthread_t t1, t2;
		pthread_create(&t1, NULL, inc, NULL);
		pthread_create(&t2, NULL, dec, NULL);
		pthread_join(t1, NULL);
		pthread_join(t2, NULL);	
		printf("common_var is %d\n", common_var);
	}
	
	return 0;
}

void * inc( void * arg ) {
	for (int i=0; i<1000000; ++i)
		common_var++;
	return 0;
}

void * inc_p( void * arg ) {
	enter_critical_section();
	for (int i=0; i<1000000; ++i)
		common_var++;
	leave_critical_section();
	return 0;
}


void * dec( void * arg ) {
	for (int i=0; i<1000000; ++i)
		common_var--;
	return 0;
}

void * dec_p( void * arg ) {
	enter_critical_section();
	for (int i=0; i<1000000; ++i)
		common_var--;
	leave_critical_section();
	return 0;
}