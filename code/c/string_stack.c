#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include "string_stack.h"

#define INITIAL_CAPACITY 16

struct _Stack {
    char **elements;
    int size;
    int capacity;
};

static int resize(stack s, int new_capacity) {
    if (!s) return 0;
    if (new_capacity < INITIAL_CAPACITY) new_capacity = INITIAL_CAPACITY;
    if (new_capacity > MAX_CAPACITY) new_capacity = MAX_CAPACITY;
    if (new_capacity == s->capacity) return 1;
    char **new_arr = realloc(s->elements, sizeof(char*) * new_capacity);
    if (!new_arr) return 0;
    s->elements = new_arr;
    s->capacity = new_capacity;
    return 1;
}
stack_response create() {
    stack_response r;
    stack s = malloc(sizeof(struct _Stack));
    if (!s) {
        r.code = out_of_memory;
        r.stack = NULL;
        return r;
    }
    s->capacity = INITIAL_CAPACITY;
    s->size = 0;
    s->elements = calloc(INITIAL_CAPACITY, sizeof(char*));
    if (!s->elements) {
        free(s);
        r.code = out_of_memory;
        r.stack = NULL;
        return r;
    }
    r.code = success;
    r.stack = s;
    return r;
}
int size(const stack s) {
    return s ? s->size : 0;
}
bool is_empty(const stack s) {
    return !s || s->size == 0;
}
bool is_full(const stack s) {
    return s && s->size >= MAX_CAPACITY;
}
response_code push(stack s, char* item) {
    if (!s || !item) return out_of_memory;
    size_t len = strlen(item);
    if (len >= MAX_ELEMENT_BYTE_SIZE) return stack_element_too_large;
    if (s->size >= MAX_CAPACITY) return stack_full;
    if (s->size == s->capacity) {
        int nc = s->capacity * 2;
        if (nc > MAX_CAPACITY) nc = MAX_CAPACITY;
        if (!resize(s, nc)) return out_of_memory;
    }
    char* copy = malloc(len + 1);
    if (!copy) return out_of_memory;
    strcpy(copy, item);
    s->elements[s->size++] = copy;
    return success;
}
string_response pop(stack s) {
    string_response r;
    if (!s || s->size == 0) {
        r.code = stack_empty;
        r.string = NULL;
        return r;
    }
    s->size--;
    char* val = s->elements[s->size];
    s->elements[s->size] = NULL;
    if (s->capacity > INITIAL_CAPACITY && s->size < s->capacity / 4) {
        int nc = s->capacity / 2;
        resize(s, nc);
    }
    r.code = success;
    r.string = val;
    return r;
}
void destroy(stack* sp) {
    if (!sp || !*sp) return;
    stack s = *sp;
    for (int i = 0; i < s->size; i++) free(s->elements[i]);
    free(s->elements);
    free(s);
    *sp = NULL;
}