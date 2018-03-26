	.text
	.equ BT_DATA, 0xFF200050
	.equ INRPT_MASK, 0xFF200058
	.equ EDGE_CAP, 0x1000005C

	.global read_PB_data_ASM
	.global PB_data_is_pressed_ASM

	.global read_PB_edgecap_ASM
	.global PB_edgecap_is_pressed_ASM
	.global PB_clear_edgecap_ASM

	.global enable_PB_INT_ASM
	.global disable_PB_INT_ASM

read_PB_data_ASM:
	PUSH {R1, LR}
	LDR R1, =BT_DATA
	LDR R0, [R1]
	POP {R1, LR}
	BX LR

PB_data_is_pressed_ASM:
	PUSH {R1, LR}
	MOV R1, R0
	BL read_PB_data_ASM
	AND R0, R0, R1
	POP {R1, LR}
	BX LR

read_PB_edgecap_ASM:
	PUSH {R1, LR}
	LDR R1, =EDGE_CAP
	LDR R0, [R1]
	POP {R1, LR}
	BX LR

PB_edgecap_is_pressed_ASM:
	PUSH {R1, LR}
	MOV R1, R0
	BL read_PB_edgecap_ASM
	AND R0, R0, R1
	POP {R1, LR}
	BX LR

PB_clear_edgecap_ASM:
	PUSH {LR, R1, R3}
	LDR R3, =EDGE_CAP
	MVN R1, R0
	BL read_PB_edgecap_ASM
	AND R0, R1, R0
	STR R0, [R3]
	POP {LR, R1, R3}
	BX LR

enable_PB_INT_ASM:
	// Need to set a bit location (not specified) in this
	// register to be 1, register location is INRPT_MASK
	// there are 3 bits in mask and 4 buttons 
	PUSH {R1, LR}
	LDR R1, =INRPT_MASK
	LDR R2, [R1]
	ORR R0, R0, R2
	STR R0, [R1]
	POP {R1, LR}
	BX LR

disable_PB_INT_ASM:
	// Need to set a bit location (not specified) in this 
	// register to be 0, register location is INRPT_MASK
	PUSH {R1, LR}
	LDR R1, =INRPT_MASK
	LDR R2, [R1]
	MVN R0, R0
	AND R0, R0, R2
	STR R0, [R1]
	POP {R1, LR}
	BX LR

	.end
