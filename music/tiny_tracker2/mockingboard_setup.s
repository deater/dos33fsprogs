
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


; starts at C4
frequency_lookup_low:
.byte $E8,$CD,$B3,$9B,$83,$6E,$59,$46,$33,$22,$12,$02

;$1E8,$1CD,$1B3,$19B,$183,$16E,$159,$146,$133,$122,$112,$102,
;.byte $F4,$E6,$D9,$CD,$C1,$B7,$AC,$A3,$99,$91,$89,$81,$00,$00,$00,$00
;.byte $7A,$73,$6C,$66,$60,$5B,$56,$51,$4C,$48,$44,$40,$00,$00,$00,$00
;.byte $3D,$39,$36,$33,$30,$2D,$2B,$28,$26,$24,$22,$20,$00,$00,$00,$00


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

