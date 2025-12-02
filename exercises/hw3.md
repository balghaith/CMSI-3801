Credit for this HW: ChatGPT  
Used ChatGPT to help me when I got stuck while programming, and for explaining some of the questions in the written portion.

---

## Q1
Type of trees of elements of type t can be built taking one step at a time. Each tree could be either a leaf which has the ability to hold one value of type t, or could be a node that has the ability to connect two smaller trees. To define this type while programming, we can refer to it as:

Tree t = t + (Tree t x Tree t)

---

## Q2
Exponentiation of natural numbers can be defined by two cases:

**1st Case:**  
m^0 = 1  
This means there could only be one possible outcome.

**2nd Case:**  
m^(n+1) = m × m^n  
This means multiplying one more m by the previous result.

---

## Q3
**A:** This means the result could be either a boolean or the one value from the unit type. This results in either `inl true`, `inl false`, or `inr ()` as possible values.

**B:** Same idea as A — the result could be either a boolean or the single value from the unit type.

---

## Q4
**A:** This represents one pair that consists of a boolean and unit. Because unit has only one possible value as its outcome (which is `()`), the pair could result in either `(true, ())` or `(false, ())`.

**B:** This represents a boolean that returns a unit. Since unit only has one possible value (`()`), the outcome will always be the same no matter what the boolean is.

---

## Q5
The article basically says that most programming languages handle strings incorrectly. It explains how strings often behave like simple arrays of characters instead of actual text. This leads to errors especially when using special characters or emojis, making things difficult for users who type emojis daily or rely on non-ASCII characters.

---

## Q6
No. Because in order to type `x x`, the `x` would need a type that represents both a function and an argument to itself. That would give a type equation like:

T = T -> U

This breaks strong normalization.

---

## Q7
`not (A x)`

---

## Q8
A pure function is a function that always returns the same output when given the same input. This makes code easier to implement, test, reduces hidden bugs, and makes it more effective to work with in general.

---

## Q9
Haskell uses pure code by default. This means it separates code that prints, reads files, or interacts with the outside world from regular code. If a piece of code needs to print or read files, it uses types like `IO`, `State`, or `Maybe` to indicate when code is not pure. This helps keep side effects controlled.

---

## Q10
`&` is closer since it combines types. This makes the result include all the methods of the types we're working with.

Example:

```ts
type Animal = { eat(): void }
type Flyer  = { fly(): void }
type Bat    = Animal & Flyer
```



