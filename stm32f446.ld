ENTRY(_start)     /* setting "_start" as entry point*/

_MIN_STACK_SIZE = 0x400;      /* Minimum size reserved for stack */
_MIN_HEAP_SIZE = 0x200;       /* Minimum size reserved for heap */

_sp_init = ORIGIN(RAM) + LENGTH(RAM);      /* Starting value for StackPointer (SP) = End address of RAM bc. Stack grows downward */

MEMORY      /* Setting memory of stm32f446 according to chapters 2.2.3 and 2.2.4 of stm32f446 reference manual */
{
    RAM     (rwx) :     ORIGIN = 0x20000000,  LENGTH = 128K
    FLASH   (rx)  :     ORIGIN = 0x08000000,  LENGTH = 512K
}

SECTIONS    /* Defining sections of program. Only .text, .rodata, .data, .bss needed for pure C / asm. */
{
    .isr_vtable :       /* Section containint the interrupt vector table */
    {
        . = ALIGN(4);   /* Aligning to 4 Bytes since stm32f446 is 32 Bit system and 32 Bit = 4 Bytes */
        _start_isr_vtable = .;      /* symbol containing start-VMA of this section */
        KEEP(*(.isr_vtable))        /* KEEP to ensure vector table gets included in executable even if not referenced */
        . = ALIGN(4);               
        _end_isr_vtable = .;        /* symbol containing end-VMA of this section */
    } > FLASH

    .text :       /* Section containing all instructions / code of program */
    {
        . = ALIGN(4);
        _stext = .;
        *(.text)
        *(.text*)
        . = ALIGN(4);
        _etext = .;
    } > FLASH

    .rodata :
    {
        . = ALIGN(4);
        _srodata = .;
        *(.rodata)
        *(.rodata*)
        . = ALIGN(4);
        _erodata = .;
    } > FLASH

    _sidata = LOADADDR(.data);

    .data :
    {
        . = ALIGN(4);
        _sdata = .;
        *(.data)
        *(.data*)
        . = ALIGN(4);
        _edata = .;
    } > RAM AT> FLASH

    .bss :
    {
        . = ALIGN(4);
        _sbss = .;
        *(.bss)
        *(.bss*)
        . = ALIGN(4);
        _ebss = .;
    } > RAM

    ._user_heap_stack :
    {
        . = ALIGN(8);
        . = . + _MIN_HEAP_SIZE;
        . = . + _MIN_STACK_SIZE;
        . = ALIGN(8);
    } > RAM

    /DISCARD/ :
    {
        *(.ARM.attributes)
    }
}
