Skimmed the readings.  
I would like to give credit to ChatGPT for helping me in this assignment.  
— **Bader Al Ghaith**

---

## Q1
**A:** An array of pointers identified as n, and each pointer points to a double.  
**B:** A pointer to an array of doubles identified as n.  
**C:** An array of pointers identified as n to functions, and each function returns a double and takes no parameters.  
**D:** A function that returns a pointer to an array of doubles identified as n.

---

## Q2
Arrays turn into pointers when used in expressions. For instance, this happens when a user passes them to a function or assigns them to a pointer. They only stay arrays when used with sizeof, &array, or when they are first defined.

---

## Q3
- **Memory leak:** Allocated memory never freed.  
- **Dangling pointer:** Pointer to freed or invalid memory.  
- **Double free:** Freeing the same memory twice.  
- **Buffer overflow:** Writing past array bounds.  
- **Stack overflow:** Stack memory used up.  
- **Wild pointer:** A pointer that doesn’t point to valid memory.

---

## Q4
C++ move constructors and move assignment only make sense on r values since r values are temporary objects that are about to be destroyed. Therefore, it is safe to “steal” their internal resources and leave them empty. L values, on the other hand, are normal named variables that the program will still use, so stealing from them would leave them in a broken state.

**Example:**

```cpp
Vector(Vector&& other) {
    data = other.data;
    other.data = nullptr;
}
```

---

## Q5
C++ has moves to make programs faster and more efficient. One example recalled is that instead of copying large objects which takes time and memory a move lets one object reuse another object's internal data when that object is only temporary and would be destroyed anyway.

---

## Q6
The rule basically says:  
If a class manages some resource and the user defines one of the big special functions, then the user must define*all five, which include:

- destructor  
- copy constructor  
- copy assignment operator  
- move constructor  
- move assignment operator  

---

## Q7
1. Every value in Rust has exactly one owner.  
2. When the owner goes out of scope, the value is automatically dropped.  
3. Ownership can move from one variable to another, but at any moment there is only one true owner.

---

## Q8
1. A user may have either many immutable references or exactly one mutable reference to a value at the same time, but not both.  
2. References must never outlive the data they point to, so they are always valid.  
3. Borrowing does not change who owns the value; it just lets other code temporarily access it through references.
