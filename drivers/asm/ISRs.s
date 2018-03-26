	.text
	
	.global A9_PRIV_TIM_ISR
	.global HPS_GPIO1_ISR
	.global HPS_TIM0_ISR
	.global HPS_TIM1_ISR
	.global HPS_TIM2_ISR
	.global HPS_TIM3_ISR
	.global FPGA_INTERVAL_TIM_ISR
	.global FPGA_PB_KEYS_ISR
	.global FPGA_Audio_ISR
	.global FPGA_PS2_ISR
	.global FPGA_JTAG_ISR
	.global FPGA_IrDA_ISR
	.global FPGA_JP1_ISR
	.global FPGA_JP2_ISR
	.global FPGA_PS2_DUAL_ISR
	.equ EDGE_CAP, 0xFF20005C

	.global hps_tim0_int_flag;
	.global pb_flag
	.global reset_flag

hps_tim0_int_flag:
	.word 0x0

pb_flag:
	.word 0x0

reset_flag:
	.word 0x0

A9_PRIV_TIM_ISR:
	BX LR
	
HPS_GPIO1_ISR:
	BX LR
	
HPS_TIM0_ISR:
	PUSH {LR}

	MOV R0, #0x1
	BL HPS_TIM_clear_INT_ASM

	LDR r0, =hps_tim0_int_flag
	MOV R1, #1
	STR R1, [R0]

	POP {LR}
	BX LR
	
HPS_TIM1_ISR:
	BX LR
	
HPS_TIM2_ISR:
	BX LR
	
HPS_TIM3_ISR:
	BX LR
	
FPGA_INTERVAL_TIM_ISR:
	BX LR
	
FPGA_PB_KEYS_ISR:
		PUSH {R0, R1, LR}
	
		LDR R0, =0xFF200050
		LDR R1, [R0, #0xC]
		STR R1, [R0, #0xC]
button0:TST R1, #1
		BEQ button1
		LDR R2, =pb_flag
		MOV R3, #1
		STR R3, [R2]
		B end
button1:TST R1, #2
		BEQ button2
		LDR R2, =pb_flag
		MOV R3, #0
		STR R3, [R2]
		B end
button2:TST R1, #4
		BEQ end
		LDR R2, =reset_flag
		MOV R3, #1
		STR R3, [R2]

end:	POP {R0, R1, LR}
		BX LR
	
FPGA_Audio_ISR:
	BX LR
	
FPGA_PS2_ISR:
	BX LR
	
FPGA_JTAG_ISR:
	BX LR
	
FPGA_IrDA_ISR:
	BX LR
	
FPGA_JP1_ISR:
	BX LR
	
FPGA_JP2_ISR:
	BX LR
	
FPGA_PS2_DUAL_ISR:
	BX LR
	
	.end
