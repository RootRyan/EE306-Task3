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
StartCheck	JSR Pop
	LD R1, U
	ADD R1, R1, R0
	BRnp Loop
	JSR Pop
	LD R1, A
	ADD R1, R1, R0
	BRnp Loop
	LD R0, Pipe
	TRAP x21
	ADD R5, R5, #1
	BRnzp Loop
FirstEnd
	LD R1, U
	ADD R1, R1, R0
	BRnp Loop
	ADD R4, R4, #1
	BRnzp Loop

SecondEnd
	LD R1, A
	ADD R1, R1, R0
	BRnp checknext
	ADD R3, R3, #1
	BRnzp Loop
checknext	LD R1, G
	ADD R1, R1, R0
	BRnp reset
	ADD R2, R2, #1
	BRnzp Loop
reset	AND R4, R4, #0
	BRnzp FirstEnd

CheckA
	LD R1, A
	ADD R1, R1, R0
	BRnp reset1
	AND R2, R2, #0
	AND R3, R3, #0
	AND R4, R4, #0
	AND R5, R5, #0
	TRAP x25
reset1	AND R4, R4, #0
	AND R2, R2, #0
	BRnzp FirstEnd

CheckAG
	LD R1, A
	ADD R1, R1, R0
	BRnp checknext1
	AND R2, R2, #0
	AND R3, R3, #0
	AND R4, R4, #0
	AND R5, R5, #0
	TRAP x25
checknext1	LD R1, G
	ADD R1, R1, R0
	BRnp reset2
	AND R2, R2, #0
	AND R3, R3, #0
	AND R4, R4, #0
	AND R5, R5, #0
	TRAP x25
reset2	AND R4, R4, #0
	AND R3, R3, #0
	BRnzp FirstEnd





; Symbol Initiations
      Buffer .FILL x4600
 Stack_Start .FILL x4000
    ISR_Addr .FILL x2600
IntEnableBit .FILL x4000
IntVectTable .FILL x0180
	KBSR .FILL xFE00
	KBDR .FILL XFE02
	   A .FILL #-65
	   C .FILL #-67
	   U .FILL #-85
	   G .FILL #-71
	Pipe .FILL x7C


;STACK SUBROUTINES
;Push
Push
	ADD R6, R6, #-1
	STR R0, R6, 0
	RET

;Pop
Pop
	LDR R0, R6, 0
	ADD R6, R6, #1
	RET
.END