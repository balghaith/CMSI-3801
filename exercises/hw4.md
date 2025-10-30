Skimmed the course notes, however some of the refrence materials were too long so I read what I could.
Credit for HW4 that helped me when I got stuck throught the assignment: ChatGPT & Dr. Toal (Office Hours)


Q1: "Abstract" is a class that is not able to be created immediatly while "enum" limits the number of instances to a fixed number which is then listed in the program. "Final" stops other classes from extending to yours as it stops subclasses completly. However, if you want a specific number of subclasses, you may use "sealed" to list exactly which ones are permitted.


Q2: Classes:              Structs:
-are refrence types       -are type values
-support inheritance      -they don't
-may have deinitializers  -they can't
-use reference counting   -they copy when passing or assigned


Q3: It doesn't. It uses optionals to clearly mark when a value might be missing, which is a way to prevent the "billion dollar mistake" since it forces programmers to safely check values before using them at all times so the program dosen't crash as a result of nulls.


Q4: No we can't. Despite the fact that "Dog" is a type of "Animal", Java treats both cases(List<Dog> & List<Animal>) as diffrent types. Treating both cases as diffrent types prevents a programmer from accidentally adding another type of animal(e.g. "Cat") to the list since we're only allowed to have "Dog".


Q5: It's weirdly named since it represents an empty tuple. This means it can represent one value which carries no information. Another big reason for this choice of name was to familirize developers who are coming from the C language since "void" means "no return value" in that respective programming langauge.


Q6: A function type with no parameters that returns a value.
Ex: () -> T


Q7: Because he didn't want to use the word "object" since he thought the word was actually perfect because programs are supposed to be made from small and independent objects that have the ability to talk to each other by sending messages, similar to real world objects.


Q8: "Class based" requires the programmer to first create a class as a blue print to make objects from it, while "prototype based" requires the programmer to start with one object and make new ones by copying and changing it without needing a class.


Q9: Private final fields, a main constructor, getter methods for each field, equal method, hashCode method, and toString method.


Q10: They use static methods and variables inside a class. Therefore, if they ever needed one shared object for the whole program, they usually make a singleton using a static instance or an enum.