; Moving
;   moving, orange and green


; this is plotting
;	sin(y/4-FRAME) + sin(x) + sin(x+frame)
; or at least I think so.  Comment your code!

	;================================
	; Clear screen and setup graphics
	;================================
moving:
	lda	#0
	sta	FRAME

	;============================
	; main loop
	;============================

draw_moving:
	inc	FRAME

moving_size_smc:
	lda	#191		; YY

create_yloop:
	; HGR_Y (YY) is in A here

;	ldx	#39		; X is don't care?
;	ldy	#0		; Y is also don't care?

	jsr	HPOSN		; (Y,X),(A)  (values stores in HGRX,XH,Y)

	; restore values

	lda	HGR_Y		; YY in X
	tax

calcsine_div4:
	lsr			; YY/4
	lsr							; 2
	sec
	sbc	FRAME		; YY/4-FRAME
	tay
	lda	sinetable,y	; A=SIN(YY/4-FRAME)
	sta	row_sum_smc+1

;	ldx	HGR_Y		; YY

	ldy	#39		; XX
create_xloop:

	;=====================
	; critical inner loop
	;   every cycle here is 40x192 cycles
	;=====================

	clc
	tya				; XX
	adc	FRAME			; XX+FRAME
	tax
	lda	sinetable,X		; SIN(XX+FRAME)

	adc	sinetable,Y		; SIN(XX)+SIN(XX+FRAME)	; 4+
row_sum_smc:
	adc	#$dd			; row base value	; 2
					; this is SIN(YY/4-FRAME)

	lsr				; double colors		; 2
					; also puts bit in carry
					; which helps proper color gen
	and	#$7						; 2
	tax							; 2
colorlookup_smc:
	lda	colorlookup,X		; lookup in table	; 5

ror_nop_smc:
	ror				; $6A/$EA		; 2
	sta	(GBASL),Y					; 6

	lda	ror_nop_smc		; toggle ror/nop	; 4
	eor	#$80						; 2
	sta	ror_nop_smc					; 4

	dey							; 2
	bpl	create_xloop					; 2/3

	dec	HGR_Y
	lda	HGR_Y
	cmp	#$ff		; blah want to draw line 0
	bne	create_yloop

	jsr	flip_page

	lda	FRAME
	cmp	#$1b		; NOTE: NEEDS TO BE ODD
	bne	draw_moving	; bra

;	rts

;colorlookup:
;.byte $22,$aa,$ba,$ff,$ba,$aa,$22	; use 00 from sinetable
;;.byte $00

;;.byte $11,$55,$5d,$7f,$5d,$55,$11	; use 00 from sinetable
;;.byte $00

;sinetable_base:
;; this is actually (32*sin(x))
;.byte $00,$03,$06,$09,$0C,$0F,$11,$14
;.byte $16,$18,$1A,$1C,$1D,$1E,$1F,$1F
;.byte $20

;sinetable=$8000


