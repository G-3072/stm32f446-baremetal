#include <stdlib.h>
#include <stdint.h>

void _main(void){
    uint32_t* b;
    uint32_t a = 5;

    b = &a;
    if (b == &a){

    }
    for(;;){

        if (a > 4){
            a = 3;
            b += 4;
        }else {
            a = 5;
            b -= 4;
        }
    };
}
