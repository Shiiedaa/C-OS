#include "print.h"

void kernel_main()
{
    print_clear();

    print_set_color(COLOR_YELLOW, COLOR_BLACK);

    volatile unsigned short *vga_buffer = (unsigned short *)0xB8000;
    vga_buffer[0] = (uint16_t)('X' | (0x0E << 8)); // Yellow 'X' on black background

    print_str("64-bit kernel header!");
}