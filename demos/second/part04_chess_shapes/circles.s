; Zooming Circles, based on the code in Hellmood's Memories

; by deater (Vince Weaver) <vince@deater.net>

; 103 bytes

;.globalzp squares_table_y
;.globalzp color_lookup
;.globalzp smc1,smc2,smc3,smc4


zooming_circles:

	;===================
	; init screen
	bit	LORES
	bit	FULLGR
	bit	PAGE1
	lda	#0
	sta	DRAW_PAGE
						; 3
						;====
						; 6
circle_forever:

	inc	FRAME				; 2

	ldx	#24				; 2
	stx	Y2				; 2
	dex					; 1

yloop:
	ldy	#20				; 2
	sty	X2				; 2
	dey					; 1

xloop:

	clc					; 1
	lda	squares_table_y+4,y		; 3
	asl					; 1
	asl					; 1
	adc	squares_table_y,x		; 2

	lsr					; 1
	adc	FRAME				; 2
	and	#$1f				; 2

; and	#$18
; 00, 10 = black
; 01  = grey 55 or aa
; 11  = light blue 77

	lsr					; 1
	lsr					; 1
	lsr					; 1
	sty	TEMPY				; 2
	tay					; 1
	lda	color_lookup,Y			; 3
	sta	COLOR				; 2

	ldy	X2	; Y==X2			; 2
	txa		; A==Y1			; 1
	jsr	plot_compat	; (X2,Y1)		; 3
	lda	Y2	; A==Y2			; 2
	jsr	plot_compat	; (X2,Y2)		; 3

	ldy	TEMPY	; Y==X1			; 2
	txa		; A==Y1			; 1
	jsr	plot_compat	; (X1,Y1)		; 3
	lda	Y2	; A==Y2			; 2
	jsr	plot_compat	; (X1,Y2)		; 3

	inc	X2				; 2

	dey					; 1
	bpl	xloop				; 2

	inc	Y2				; 2

	dex					; 1
	bpl	yloop				; 2

	lda	KEYPRESS
	bmi	done_circles

	bpl	circle_forever		; bra

done_circles:
	bit	KEYRESET
	rts



; 24 bytes
squares_table_y:
.byte $24,$21,$1e,$1b,$19,$16,$14,$12
.byte $10,$0e,$0c,$0a,$09,$07,$06,$05
.byte $04,$03,$02,$01,$01,$00,$00

color_lookup:
.byte	$00		; also last byte of squares table
.byte	$55,$00,$77

.include "../gr_plot.s"
.include "../gr_offsets.s"
