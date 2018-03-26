	.text

	.equ PS2_DATA, 0xFF200100
	.global read_PS2_data_ASM

read_PS2_data_ASM:
			PUSH {LR, R1-R9}
			LDR R1, =PS2_DATA
			LDR R5, [R1]
			LDR R2, =32768
			TST R5, R2
			BEQ INVALID
			LDRB R4, [R1]
			STRB R4, [R0]
			MOV R0, #1
			B DONE

INVALID:	MOV R0, #0
DONE:		POP {LR, R1-R9}
			BX LR
	