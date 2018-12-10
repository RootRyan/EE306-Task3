; ISR.asm
; Name: Ryan Root
; UTEid: rmr3494
; Keyboard ISR runs when a key is struck
; Checks for a valid RNA symbol and places it at x4600

.ORIG x2600
	LDI R0, KBDR
	LD R1, Last8
	AND R0, R0, R1
	LD R1, A
	ADD R1, R1, R0
	BRz Match
	LD R1, C
	ADD R1, R1, R0
	BRz Match
	LD R1, U
	ADD R1, R1, R0
	BRz Match
	LD R1, G
	ADD R1, R1, R0
	BRnp Return
Match	STI R0, Buffer

; RTI / Return from Interrupt
Return	RTI

; Symbol Initiations
KBDR .FILL xFE02
Last8 .FILL X00FF
A .FILL #-65
C .FILL #-67
U .FILL #-85
G .FILL #-71
Buffer .FILL x4600

.END
