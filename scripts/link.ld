/*
 * ------------------------------------------------------------------------
 *   File Name: link.ld
 *      Author: Zhao Yanbai
 *              2021-12-12 19:50:22 Sunday CST
 * Description: none
 * ------------------------------------------------------------------------
 */


OUTPUT_ARCH(riscv)
ENTRY(_start)

kernel_entry_addr = 0x80200000;

SECTIONS
{
    . = kernel_entry_addr;

    .text : {
        *(.text)
    }

    .rodata : {
        *(.rodata)
    }

    .data : {
        *(.data)
    }

    .bss : {
        *(.bss)
    }
}
