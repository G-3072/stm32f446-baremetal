/*
todo:
 - set SP
 - set PC
 - define vector table
 - copy .data to ram
 - copy & zero .bss in ram
*/
.cpu cortex-m4
.fpu fpv4-sp-d16
.thumb

.global _start

.word _sp_init

.word _sidata
.word _sbss
.word _ebss

_start:
    mov SP, _sp_init     ; set stack-pointer to end of RAM. _sp_init defined in stm32f446.ld 
    

