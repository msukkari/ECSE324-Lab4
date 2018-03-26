	.text
	.equ HEX_03, 0xFF200020
	.equ HEX_45, 0xFF200030
	.global HEX_clear_ASM
	.global HEX_flood_ASM
	.global HEX_write_ASM

// INPUT:
// R0 Displays to change
// R1 Set

// OUTPUT:
// R0 hex_mask

// TEMP VARS:
// R3 mask
// R4 counter
// R5 hex_mask

HEX_genHexMask:
		PUSH {R3, R4, R5, LR}
		MOV R3, #1
		MOV R4, #0
		MOV R5, #0
LOOP:	CMP R4, #3
		BGT DONE
		TST R0, R3
		BEQ NEXT
		PUSH {R0}
		MOV R0, R4
		BL	HEX_set
		POP {R0}
NEXT:	LSL R3, #1
		ADD R4, R4, #1
		B LOOP
DONE:	MOV R0, R5
		POP {R3, R4, R5, LR}
		BX LR

// INPUT
// R0 display #
// R1 set
HEX_set:
		PUSH {R1, LR}
		LSL R0, R0, #3	
		LSL R1, R1, R0
		ORR R5, R5, R1
		POP {R1, LR}
		BX LR

HEX_clear_ASM:
		PUSH {R1, R2, R3, R4, LR}
		LDR R2, =HEX_03
		MOV R1, #127
		MOV R3, R0
		BL HEX_genHexMask
		LDR R4, [R2]
		MVN R0, R0
		AND R0, R0, R4
		STR R0, [R2]
		LSR R0, R3, #4
		BL HEX_genHexMask
		LDR R4, [R2, #16]
		MVN R0, R0
		AND R0, R0, R4
		STR R0, [R2, #16]
		POP {R1, R2, R3, R4, LR}
		BX LR

HEX_flood_ASM:
		PUSH {R1, R2, R3, R4, LR}
		LDR R2, =HEX_03
		MOV R1, #127
		MOV R3, R0
		BL HEX_genHexMask
		LDR R4, [R2]
		ORR R0, R0, R4
		STR R0, [R2]
		LSR R0, R3, #4
		BL HEX_genHexMask
		LDR R4, [R2, #16]
		ORR R0, R0, R4
		STR R0, [R2, #16]
		POP {R1, R2, R3, R4, LR}
		BX LR

HEX_write_ASM:
		PUSH {R0, LR}
		BL HEX_clear_ASM
		POP {R0, LR}
		PUSH {R1, R2, R3, R4, LR}
		LDR R2, =HEX_03
		MOV R3, R0
		BL HEX_genHexMask
		LDR R4, [R2]
		ORR R0, R0, R4
		STR R0, [R2]
		LSR R0, R3, #4
		BL HEX_genHexMask
		LDR R4, [R2, #16]
		ORR R0, R0, R4
		STR R0, [R2, #16]
		POP {R1, R2, R3, R4, LR}
		BX LR

	.end
	
