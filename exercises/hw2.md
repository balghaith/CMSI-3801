I skimmed a few course notes and done as much as I could.
I would like to give credit to ChatGPT and Professor Toal for helping me in this assignment.

---

## Q1
Because it seems like a programmer may use a line of code usefully when in reality they can't since there's actually nothing reffered to. This often leads to system crashes and harder debuggings which therefore leads those systems to be unsafe enviroments to work on.

---

## Q2
He intoduced it to allow programmers to quickly refrence functions that dosen't lead to anything. This meant that all refrence types were allowed accsess to it and made it super convinent since it could immediatly set an object to be empty. 

---

## Q3
`3**35` means \(3^{35}\). Python can compute this value exactly because it uses arbitrary-precision integers, which can grow as large as needed. JavaScript, however, represents numbers using 64-bit IEEE-754 floating-point arithmetic, so integer values are only guaranteed to be accurate up to \(2^{53} - 1\). Since \(3^{35}\) is larger than that limit, JavaScript cannot represent it exactly, while Python can.

---

## Q4
We would basically need a dictionary:

```json
{
  "x": 3,
  "y": 5,
  "z": "z"
}
```

---

## Q5
JavaScript has two different equality operators. `==` performs type coercion before comparing values, which can lead to unexpected results. `===` performs strict equality, meaning it compares both value and type without converting anything. We use `===` to avoid unwanted type coercion and ensure the comparison behaves predictably.

---

## Q6
```lua
function arithmeticsequence(start, delta)
  return coroutine.create(function()
    local current = start
    while true do
      coroutine.yield(current)
      current = current + delta
    end
  end)
end
```

*I got help from an AI tool to understand this problem.*

---

## Q7

**a.**
```
1 × 1 − 1 = 0
```

**b.**
```
1 × 3 − 1 = 2
```

---

## Q8
Static scoping is where the meaning of a variable is based on how it appears textually in the program—the scope for that particular occurrence or usage of the name, determined by where it occurs within the program. With shallow binding, however, the latest environment in which the variable was assigned at runtime is utilized.
