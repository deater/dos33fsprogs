
.align	$100




	;====================================
	; mb_write_frame
	;====================================
	; cycle counted

	; 2 + 13*(70) + 74 + 5  = 991

mb_write_frame:

	ldx	#0		; set up reg count			; 2
								;============
								;	  2

	;==================================
	; loop through the 14 registers
	; reading the value, then write out
	;==================================

mb_write_loop:
	;=============================
	; not r13 	-- 4+5+28+26+7		= 70
	; r13, not ff	-- 4+5+ 4 +28+26+7	= 74
	; r13 is ff 	-- 4+5+3+1=[61] 	= 74


	lda	AY_REGISTERS,X	; load register value			; 4

	; special case R13.  If it is 0xff, then don't update
	; otherwise might spuriously reset the envelope settings

	cpx	#13							; 2
	bne	mb_not_13						; 3

									; -1
	cmp	#$ff							; 2
	bne	mb_not_13						; 3
									; -1


	; delay 61
	inc	TEMP		; 5
	inc	TEMP		; 5
	inc	TEMP		; 5
	inc	TEMP		; 5
	inc	TEMP		; 5
	inc	TEMP		; 5
	inc	TEMP		; 5
	inc	TEMP		; 5
	inc	TEMP		; 5
	inc	TEMP		; 5
	inc	TEMP		; 5
	lda	TEMP		; 3
	jmp	mb_skip_13	; 3

mb_not_13:


	; address
	stx	MOCK_6522_ORA1		; put address on PA1		; 4
	stx	MOCK_6522_ORA2		; put address on PA2		; 4
	ldy	#MOCK_AY_LATCH_ADDR	; latch_address for PB1		; 2
	sty	MOCK_6522_ORB1		; latch_address on PB1          ; 4
	sty	MOCK_6522_ORB2		; latch_address on PB2		; 4
	ldy	#MOCK_AY_INACTIVE	; go inactive			; 2
	sty	MOCK_6522_ORB1						; 4
	sty	MOCK_6522_ORB2						; 4
								;==========
								;	28
        ; value
	sta	MOCK_6522_ORA1		; put value on PA1		; 4
	sta	MOCK_6522_ORA2		; put value on PA2		; 4
	lda	#MOCK_AY_WRITE		;				; 2
	sta	MOCK_6522_ORB1		; write on PB1			; 4
	sta	MOCK_6522_ORB2		; write on PB2			; 4
	sty	MOCK_6522_ORB1						; 4
	sty	MOCK_6522_ORB2						; 4
								;===========
								; 	26
mb_no_write:
	inx				; point to next register	; 2
	cpx	#14			; if 14 we're done		; 2
	bmi	mb_write_loop		; otherwise, loop		; 3
								;============
								; 	7
mb_skip_13:
									; -1
	rts								; 6


pt3_loop_smc:
	.byte $0,$0
