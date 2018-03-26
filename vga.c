#include "./drivers/inc/vga.h"
#include "./drivers/inc/pushbuttons.h"
#include "./drivers/inc/slider_switches.h"

void test_char()
{
	int x,y;
	char c;

	for(y = 0; y <= 59; y++)
	{
		for(x = 0; x <= 79; x++) VGA_write_char_ASM(x,y,c++);
	}
}

void test_clear()
{
	int x,y;
	char c = 32;

	for(y = 0; y <= 59; y++)
	{
		for(x = 0; x <= 79; x++) VGA_write_char_ASM(x,y,c);
	}
}

void test_byte()
{
	int x, y;
	char c = 0;

	for(y = 0; y <= 59; y++)
	{
		for(x = 0; x <= 79; x+=3) VGA_write_byte_ASM(x, y, c++);
	}
}

void test_pixel()
{
	int x, y;
	unsigned short colour = 0;

	for(y = 0; y <= 239; y++)
	{
		for(x = 0; x <= 319; x++) VGA_draw_point_ASM(x, y, colour++);
	}
}

void main()
{

	while(1)
	{
		int pb0 = PB_data_is_pressed_ASM(PB0);
		int pb1 = PB_data_is_pressed_ASM(PB1);
		int pb3 = PB_data_is_pressed_ASM(PB2);
		int pb4 = PB_data_is_pressed_ASM(PB3);
		int switches = read_slider_switches_ASM();

		if(pb0 && switches) 
		test_byte();
		else if(pb0) test_char();
		else if(pb1) test_pixel();
		else if(pb3) VGA_clear_charbuff_ASM();
		else if(pb4) VGA_clear_pixelbuff_ASM();
	}
}


	
