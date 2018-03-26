#ifndef __HEX_DISPLAYS
#define __HEX_DISPLAYS

	int generateNumber(int x) {
		if(x==0) return 63;
		else if(x==1) return 6;
		else if(x==2) return 91;
		else if(x==3) return 79;
		else if(x==4) return 102;
		else if(x==5) return 109;
		else if(x==6) return 125;
		else if(x==7) return 7;
		else if(x==8) return 127;
		else if(x==9) return 111;
		else if(x==10) return 119;
		else if(x==11) return 127;
		else if(x==12) return 57;
		else if(x==13) return 63;
		else if(x==14) return 121;
		else return 113;
	}

	typedef enum {
	HEX0 = 0x00000001,
	HEX1 = 0x00000002,
	HEX2 = 0x00000004,
	HEX3 = 0x00000008,
	HEX4 = 0x00000010,
	HEX5 = 0x00000020
	}HEX_t;

	extern int HEX_clear_ASM(HEX_t hex);
	extern int HEX_flood_ASM(HEX_t hex);
	extern int HEX_write_ASM(HEX_t hex, char val);

#endif
