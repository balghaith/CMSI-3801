#ifndef STACK_H
#define STACK_H

#include <stdexcept>
#include <memory>

#define MAX_CAPACITY 32768
#define INITIAL_CAPACITY 16

template <typename T>
class Stack {
    std::unique_ptr<T[]> elements;
    int capacity;
    int top;
    void reallocate(int new_capacity) {
        if (new_capacity < INITIAL_CAPACITY) new_capacity = INITIAL_CAPACITY;
        if (new_capacity > MAX_CAPACITY) new_capacity = MAX_CAPACITY;
        if (new_capacity == capacity) return;
        std::unique_ptr<T[]> new_arr(new T[new_capacity]);
        for (int i = 0; i < top; i++) {
            new_arr[i] = elements[i];
        }
        elements = std::move(new_arr);
        capacity = new_capacity;
    }
    Stack(const Stack&) = delete;
    Stack& operator=(const Stack&) = delete;
    Stack(Stack&&) = delete;
    Stack& operator=(Stack&&) = delete;
public:
    Stack() : elements(new T[INITIAL_CAPACITY]),
              capacity(INITIAL_CAPACITY),
              top(0) {}
    int size() const { return top; }
    bool is_empty() const { return top == 0; }
    bool is_full() const { return top == MAX_CAPACITY; }
    void push(const T& item) {
        if (is_full()) {
            throw std::overflow_error("Stack has reached maximum capacity");
        }
        if (top == capacity) {
            int new_cap = capacity * 2;
            if (new_cap > MAX_CAPACITY) new_cap = MAX_CAPACITY;
            reallocate(new_cap);
        }
        elements[top++] = item;
    }
    T pop() {
        if (is_empty()) {
            throw std::underflow_error("cannot pop from empty stack");
        }
        T value = elements[top - 1];
        top--;
        if (capacity > INITIAL_CAPACITY && top < capacity / 4) {
            int new_cap = capacity / 2;
            if (new_cap < INITIAL_CAPACITY) new_cap = INITIAL_CAPACITY;
            reallocate(new_cap);
        }
        return value;
    }
};

#endif