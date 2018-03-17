# ThreadGroup

ThreadGroup provides a means of keeping track of a number of threads as a
group.

A given Thread object can only belong to one ThreadGroup at a time; adding a
thread to a new group will remove it from any previous group.

Newly created threads belong to the same group as the thread from which they
were created.