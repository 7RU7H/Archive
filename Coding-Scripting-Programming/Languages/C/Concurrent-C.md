
## By Library 



pthread.h - POSIX
compiled with `gcc -lpthread main.c`; with semaphors `-lpthread -lrt`

```c
#include <stdio.h>
#include <pthread.h>
#include <unistd.h>
#include <semaphore.h>

// Mutexs are used to avoid race conditions
// Lock a single target from multiple operation 
pthread_mutex_t lock;
semaphor_mutex_t mutex;
int j;

// 
pthread_semaphore ;



void do_process()
{
    pthread_mutex_lock(&lock);
    int i = 0;
    j++;
    while(i < 5)
    {
        printf("%d", j);
        sleep(1);
        i++;
    }

    printf("...Done\n");
    pthread_mutex_unlock(&lock);
}

int main(void)
{
	// Initialises semaphor - or sem_open() (for IPC)
	// sem_init(semaphor_mutex_t *sem, int pshared, unsigned int value);
	sem_init(&semaphor_mutex_t, 0, 1);
	//To lock a semaphore
	sem_wait(&semaphor_mutex_t);
	// To release or signal a semaphore
	sem_post(&semaphor_mutex_t);
	// thread descriptor - a pointer a void function
    pthread_t t1, t2;
    int err;
	// create threads take pointers, , functions and/or . as arguments
    pthread_create(&t1, NULL, do_process, NULL);
    pthread_create(&t2, NULL, do_process, NULL);

	// Threads need to be joined to link current thread to another thread
	// Beware program wait till end of thread 
    pthread_join(t1, NULL);
    pthread_join(t2, NULL);

	sem_destroy(&semaphor_mutex_t);
    return 0;
}
```

CreateThread - Windows API

## References

[Basics of Multithreading in C](https://dev.to/quantumsheep/basics-of-multithreading-in-c-4pam)
[POSIX Semaphors Geeksforgeeks](https://www.geeksforgeeks.org/use-posix-semaphores-c/)