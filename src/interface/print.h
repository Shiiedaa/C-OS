#pragma once

#include <stdint.h>
#include <stddef.h>

enum VGA_COLOR
{
    COLOR_BLACK = 0x0,
    COLOR_BLUE = 0x1,
    COLOR_GREEN = 0x2,
    COLOR_CYAN = 0x3,
    COLOR_RED = 0x4,
    COLOR_MAGENTA = 0x5,
    COLOR_BROWN = 0x6,
    COLOR_LIGHT_GRAY = 0x7,
    COLOR_DARK_GRAY = 0x8,
    COLOR_LIGHT_BLUE = 0x9,
    COLOR_LIGHT_GREEN = 0xA,
    COLOR_LIGHT_CYAN = 0xB,
    COLOR_LIGHT_RED = 0xC,
    COLOR_PINK = 0xD,
    COLOR_YELLOW = 0xE,
    COLOR_WHITE = 0xF
};

void print_clear();
void print_char(char character);
void print_str(char *string);
void print_set_color(uint8_t foreground, uint8_t background);