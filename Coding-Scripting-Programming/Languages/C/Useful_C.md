

Structs
```c
struct rectangle {
  int width;
  int height;
};
 struct rectangle my_rec = { 1, 2 }; // Fields can be initialized immediately

  // Access struct members with .
  my_rec.width = 10;
  my_rec.height = 20;

  // You can declare pointers to structs
  struct rectangle *my_rec_ptr = &my_rec;

  // Use dereferencing to set struct pointer members...
  (*my_rec_ptr).width = 30;

  // ... or even better: prefer the -> shorthand for the sake of readability
  my_rec_ptr->height = 10; // Same as (*my_rec_ptr).height = 10;
```

Processes - Unix
```c
#include <signal.h>
// This is more portable
#include <sigaction.h>


// Handler is a function
// User defined signals
SIGUSR1;
SIGUSR2;
// SegFault Signal
SIGSEGV;

sigaction(SIGINT, handler);
sigaction(SIGTERM, handler);

signal(SIGINT, handler);
signal(SIGTERM, handler);
// SIGKILL cannot be handler - oreder not a request
```


[GCC](https://linux.die.net/man/1/gcc)
[XinYminutesC](https://learnxinyminutes.com/docs/c/)
[Jacob Sorber Programming with Processes](https://www.youtube.com/playlist?list=PL9IEJIKnBJjFNNfpY6fHjVzAwtgRYjhPw)