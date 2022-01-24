	;=====================
	;=====================
	;=====================
	; ay3 write regs
	;=====================
	;=====================
	;=====================
	; write all 13 registers at AY_REGS

ay3_write_regs:

	ldx	#12
ay3_write_reg_loop:

	lda	#MOCK_AY_LATCH_ADDR     ; latch_address for PB1         ; 2
	ldy	#MOCK_AY_INACTIVE       ; go inactive                   ; 2

	stx	MOCK_6522_ORA1          ; put address on PA1            ; 4
	sta	MOCK_6522_ORB1          ; latch_address on PB1          ; 4
	sty	MOCK_6522_ORB1                                          ; 4

	; value
	lda	AY_REGS,X
	sta	MOCK_6522_ORA1          ; put value on PA1              ; 4
	lda	#MOCK_AY_WRITE          ;                               ; 2
	sta	MOCK_6522_ORB1          ; write on PB1                  ; 4
	sty	MOCK_6522_ORB1                                          ; 4

	dex
	bpl	ay3_write_reg_loop

