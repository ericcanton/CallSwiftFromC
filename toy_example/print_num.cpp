// #include <stdio.h>
#include <cstdint>

extern "C" void print_num(std::int32_t);

int main(void) {
    print_num(2);
    return 0;
}
