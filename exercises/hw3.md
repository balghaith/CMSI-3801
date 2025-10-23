Credit for this HW: ChatGPT
Used ChatGPT to help me when I got stuck while programming, and explaining some of the questions in the written portion.



Q1: Type of trees of elements of type t can be built taking one step at a time. Each tree could be either a leaf which has the ability to hold one value of type t, or could be a node that has the ability to connect two smaller trees. To define this type while programming, we can refer it as:
Tree t = t + (Tree t x Tree t)


Q2: Exponentiation of natural numbers could be defined by two cases:

1st Case: m^0 = 1.
This means there could only be one possible outcome.

2nd Case: m^(n+1) = m x m^n
This means multiplying one more m by the previous result.


Q3:
A: This means the result could be either a boolean or the one value from the unit type. This results in either inl true, inl false, or inr () as possible values for our outcome.

B: Basically the same idea as A, the result could be either a boolean or the one value from the unit type.


Q4: 
A: This represents one pair that consists of a boolean and unit. Because unit could only have one value as its outcome (which is ()), the pair could either result in (true()) or (false()).

B: This represents a boolean that returns a unit. As mentioned above, since a unit could only have one value as its outcome(which is ()), the outcome isn't going to change no matter the value of the boolean.


Q5: The article basically says that most programming langauges take care of strings in many wrong ways. The article explains how strings could act as simple arrays of characters instead of actual texts. This leads to errors especially when using special characters or emoji's, which makes it difficult for users who use emojis on a daily basis and others who type using special characters.


Q6: No. Because, in order to type "x x", the x would need a type that represents a function and an argument to itself. If that were so, the equation would look something like T = T -> U, which results in a loss of strong normalization.


Q7: not (A x)


Q8: A pure function is a function that always results in the same output if given the same input. This makes the code easier to implement, test, reduce hidden bugs, and more effective to work with in general.


Q9: Firstly, Haskell uses pure code by default. This means that it seperates code that requires printing and reading files apart from regular code. If a piece of code of code requires printing or reading files, it uses types including IO, State, or Maybe to flag when it isn't regular pure code, which contributes to keeping code that requires printing and reading controlled by the program.


Q10: & is closer since it combines types. This leads the result to include all the methods of the types we're working with.

Ex:
type Animal = { eat(): void }
type Flyer = { fly(): void }
type Bat = Animal & Flyer


