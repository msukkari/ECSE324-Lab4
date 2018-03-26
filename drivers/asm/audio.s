	.text

	.global write_audio_data_ASM
	.equ FIFO,	0xFF203044
	.equ LEFT_DATA,	0xFF203048
	.equ RIGHT_DATA,	0xFF20304C


write_audio_data_ASM:
		PUSH {LR, R1-R9}
		LDR R2, =FIFO

		LDRB R5, [R2, #2]
		LDRB R6, [R2, #3] 

		CMP R5,#1      
        BLT FULL           
        CMP R6,#1             
        BLT FULL           

		LDR R7,=LEFT_DATA		
        LDR R8,=RIGHT_DATA		
        STR R0,[R7]			
        STR R0,[R8]			
        MOV R0, #1			
		B END
		 
FULL:	MOV R0, #0
END:	BX LR

		.end