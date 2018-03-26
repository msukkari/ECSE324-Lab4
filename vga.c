#include "./drivers/inc/vga.h"
#include "./drivers/inc/pushbuttons.h"
#include "./drivers/inc/slider_switches.h"

void test_char()
{
	int x,y;
	char c;
	VGA_clear_charbuff_ASM();
	c=0;
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

void VGA()
{
	while(1)
	{
		int pb = read_PB_edgecap_ASM();	
		if(pb) PB_clear_edgecap_ASM(15);
		int pb0 = pb & 1;
		int pb1 = pb & 2;
		int pb2 = pb & 4;
		int pb3 = pb & 8;

		int switches = read_slider_switches_ASM();

		if(pb0 && switches) test_byte();
		else if(pb0) test_char();
		else if(pb1) test_pixel();
		else if(pb2) VGA_clear_charbuff_ASM();
		else if(pb3) VGA_clear_pixelbuff_ASM();
	}
}

void keyboard()
{
	int x = 0, y = 0;
	char input;

	while(1)
	{
		if(read_PS2_data_ASM(&input)) 
		{
			VGA_write_byte_ASM(x, y, input);
			x += 3;
			if(x > 79)
			{
				if(y == 59) VGA_clear_charbuff_ASM();
	
				x = 0;
				y++;
				if(y > 59) y = 0;
			}
		}
	}
}

void audio() {
	while(1)
	{
		int i = 0;	
		for(i = 0; i < 240; i++) if(write_audio_data_ASM(0x00FFFFFF) == 0) i--;
		for(i = 0; i < 240; i++) if(write_audio_data_ASM(0x00000000) == 0) i--;
	}
}

void main()
{
	VGA();
	//keyboard();
	//audio();
}


	
