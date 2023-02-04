	;=====================
	;=====================
	;=====================
	; ay3 write regs
	;=====================
	;=====================
	;=====================
	; write all 14 registers at AY_REGS

ay3_write_regs:
									; bytes
	ldx	#13							; 2
ay3_write_reg_loop:

	lda	#MOCK_AY_LATCH_ADDR     ; latch_address for PB1         ; 2
	ldy	#MOCK_AY_INACTIVE       ; go inactive                   ; 2

	stx	MOCK_6522_ORA1          ; put address on PA1            ; 3
	sta	MOCK_6522_ORB1          ; latch_address on PB1          ; 3
	sty	MOCK_6522_ORB1                                          ; 3

	; value
	lda	AY_REGS,X						; 2
	sta	MOCK_6522_ORA1          ; put value on PA1              ; 3
	lda	#MOCK_AY_WRITE          ;                               ; 2
	sta	MOCK_6522_ORB1          ; write on PB1                  ; 3
	sty	MOCK_6522_ORB1                                          ; 3

	dex								; 1
	bpl	ay3_write_reg_loop					; 2

;	rts
