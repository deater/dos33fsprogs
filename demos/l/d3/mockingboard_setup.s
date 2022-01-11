
	;=====================
	;=====================
	;=====================
	; ay3 write regs
	;=====================
	;=====================
	;=====================
	; write all 13 registers
	; address in X
	; data in A

ay3_write_regs:

	ldx	#13
ay3_write_reg_loop:

	lda	#MOCK_AY_LATCH_ADDR     ; latch_address for PB1         ; 2
	ldy	#MOCK_AY_INACTIVE       ; go inactive                   ; 2

	stx	MOCK_6522_ORA1          ; put address on PA1            ; 4
	sta	MOCK_6522_ORB1          ; latch_address on PB1          ; 4
	sty	MOCK_6522_ORB1                                          ; 4

	; value
	lda	$70,X
	sta	MOCK_6522_ORA1          ; put value on PA1              ; 4
	lda	#MOCK_AY_WRITE          ;                               ; 2
	sta	MOCK_6522_ORB1          ; write on PB1                  ; 4
	sty	MOCK_6522_ORB1                                          ; 4

	dex
	bpl	ay3_write_reg_loop

	rts



init_addresses:
	.byte <MOCK_6522_DDRB1,<MOCK_6522_DDRA1		; set the data direction for all pins of PortA/PortB to be output
	.byte <MOCK_6522_ACR,<MOCK_6522_IER		; Continuous interrupts, clear all interrupts
	.byte <MOCK_6522_IFR,<MOCK_6522_IER		; enable interrupt on timer overflow
	.byte <MOCK_6522_T1CL,<MOCK_6522_T1CH		; set oflow value, start counting
	.byte <MOCK_6522_ORB1,<MOCK_6522_ORB1		; reset ay-3-8910

	; note, terminated by the $ff below

init_values:
	.byte $ff,$ff	; set the data direction for all pins of PortA/PortB to be output
	.byte $40,$7f
	.byte $C0,$C0
	.byte $CE,$C7	; c7ce / 1.023e6 = .050s, 20Hz
	.byte MOCK_AY_RESET,MOCK_AY_INACTIVE

