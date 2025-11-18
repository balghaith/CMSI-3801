

Q1:
A: An array of pointers identified as n, and each pointer points to a double.
B: A pointer to an array of doubles identifed as n.
C: An array of pointers identified as n to functions, and each function returns a double and takes no parameters.
D: A function that returns a pointer to an array of doubles identified as n.

Q2:
Arrays could turn into pointers when used in expressions. For instance, it can do so when a user passes them to a function or assign them to a pointer. They only stay arrays when used with "sizeof", "&array", or when first defined.

Q3:
Memory leak: Allocated memory never freed.
Dangling pointer: Pointer to freed or invalid memory.
Double free: Freeing the same memory twice.
Buffer overflow: Writing past arrays bounds.
Stack overflow: Stack memory used up.
Wild pointer: A pointer that doesnt point to valid memory.