#include <stdio.h>

extern void print_num(void);
extern void print_values(void);
extern void add_num(int num);
extern void add_nums(int* nums);

int main() {
    printf("Stateful array management in Swift!\n");
    int nums[] = {1, 2, 3};
    print_num();
    add_num(2);
    print_num();
    add_nums(nums);
    print_values();
    print_num();
    return 0;
}