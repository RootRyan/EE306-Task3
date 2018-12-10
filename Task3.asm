;Program for Task 3 (EE306)
;Names: Ryan Root and Ben Kim

.ORIG x4000
; Initialize the Stack Pointer
	LD R6, Stack_Start	;R6 is the Stack Pointer (I think)
; Set up the Keyboard Interrupt Vector Table Entry
	LD R0, ISR_Addr
	STI R0, IntVectTable	;Stores Location of the ISR in the Interrupt Vector Table
; Enable Keyboard Interrupts
	LD R0, IntEnableBit
	STI R0, KBSR		;Sets the Interrupt Enable Bit in the Keyboard Status Register to 1

	AND R5, R5, #0
	AND R4, R4, #0
	AND R3, R3, #0
	AND R2, R2, #0
; Start of Actual Program
Loop	LDI R0, Buffer
	BRz Loop
	TRAP x21
	AND R1, R1, #0
	STI R1, Buffer
	AND R2, R2, #1
	BRp CheckA
	AND R3, R3, #1
	BRp CheckAG
	AND R4, R4, #1
	BRp SecondEnd
	AND R5, R5, #1
	BRp FirstEnd
	LD R1, G
	ADD R1, R1, R0
	BRz StartCheck
	JSR Push
	BRnzp Loop
.END