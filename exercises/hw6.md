## Q1
Concurrency means a program can handle many things at the same time by switching between them quickly. On the other hand, parallelism means the computer is actually doing multiple things at the same exact time using more than one CPU.

---

## Q2
A thread basically corresponds to the "worker" or "employee" that is responasbile to run the code itself. However, the "task" is the "job" that the "worker" or "employee" is responabile to get done. In Java, a user usually write tasks using Runnable or Callable and the user must give them to an excutor ehich then runs them on threads. For example, a task could be "send an email" and a thread is the worker that actually sends it.

---

## Q3
It does nothing special, the thread will not run again since it has already been completed. However, in Ada, if a user calls an entry on a task that has already ended, the program raises an exception since the task is no longer available to accept calls.

---

## Q4
In both Java and Go, the program ends only after the main thread finishes and all other non daemon (which could be seen in Java), as well as running goroutines (which could be seen in Go) also finish. However, in Ada, the main program waits for all its tasks to complete unless they are marked as "independent". Therefore, all three wait for important background work to finish before the program ends.

---

## Q5
An unbuffered channel makes the sender and reciever wait for each other, the value moves only when both sides are ready. For example, a user must signal "done" to main before main continues. However, a buffered channel can store some values without waiting, for example, a sender wouldnt wait even when no one is recieving yet.

---

## Q6
A regular mutex lets only one goroutine access something at a given time. However, a read write mutex allows many readers at once, however having only one writer and no readers while writing. Therefore, a user could use a read write mutex when reading happens a lot and writing is rare, leading to a faster program running. Otherwise, they can use the regular mutex.

---

## Q7
Reading from a closed channel gives the user the last values which then comes the zero value with an extra flag telling the user it is closed.

To detect it, you can use:

```go
value, ok := <-ch
if !ok {
}
```
Used ChatGPT to help me for the example.

---

## Q8
Select chooses one channel operation that is ready to run. It picks a code branch based on a value. Therefore, if many channels in a select are already at the same time, Go picks one at random to keep things fair.


