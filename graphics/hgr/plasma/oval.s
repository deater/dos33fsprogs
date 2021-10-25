; Ovals


; inner loop after lots of ops = 49 cycles (376320) = 2.6fps
;		optimized to 38 (256-entry sine table) = (291840) = 3.4fps
;		optimized to 37 (row_sum smc) = (284160) = 3.5fps

; zero page
GBASL	= $26
GBASH	= $27
YY	= $69
ROW_SUM = $70

HGR_X           = $E0
HGR_XH          = $E1
HGR_Y           = $E2
HGR_COLOR       = $E4
HGR_PAGE        = $E6

FRAME	= $FC
SUM	= $FD
SAVEX	= $FE
SAVEY	= $FF

; soft-switches
FULLGR	= $C052
PAGE1	= $C054

; ROM routines

HGR2	= $F3D8
HPOSN	= $F411		; (Y,X),(A)  (values stores in HGRX,XH,Y)

	;================================
	; Clear screen and setup graphics
	;================================
oval:

	jsr	HGR2		; set hi-res 140x192, page2, fullscreen

	;====================
	; create sinetable

.if 0
	ldy	#0
sinetable_loop:
	tya							; 2
	and	#$3f	; wrap sine at 63 entries		; 2

	tax							; 2
	cmp	#$20	; see if negative			; 2
	bcc	sin_pos						; 2/3

sin_neg:
	lda	#0						; 2
	sbc	sinetable_base-32,X				; 4+
	jmp	sin_done					; 3

sin_pos:
	; carry already clear
	lda	sinetable_base,X				; 4+

sin_done:
	sta	sinetable,Y
	iny
	bne	sinetable_loop
.endif



	ldy	#0
sinetable_loop:
	tya							; 2
	and	#$3f	; wrap sine at 63 entries		; 2

	cmp	#$20
	php

	and	#$1f

	cmp	#$10
	bcc	sin_blah

sin_right:
	sec
	eor	#$FF
	adc	#$20		; 32-X
sin_blah:
	tax
	lda	sinetable_base,X				; 4+

	plp
	bcc	sin_done

sin_negate:
	clc
	eor	#$ff
	adc	#1

sin_done:
	sta	sinetable,Y
	iny
	bne	sinetable_loop



	;============================
	; main loop
	;============================

draw_oval:
	inc	FRAME

	ldx	#191		; YY
	stx	HGR_Y

create_yloop:
	lda	HGR_Y
	ldx	#39
	ldy	#0

	jsr	HPOSN		; (Y,X),(A)  (values stores in HGRX,XH,Y)

	; restore values

	ldy	#39		; XX

	lda	HGR_Y		; YY

calcsine_div2:
	lsr							; 2
	tax
	clc
	lda	sinetable,X
	adc	FRAME
	sta	row_sum_smc+1

	ldx	HGR_Y		; YY


create_xloop:

	;=====================
	; critical inner loop
	;   every cycle here is 40x192 cycles
	;=====================

	lda	sinetable,Y					; 4+
	clc							; 2
row_sum_smc:
	adc	#$dd			; row base value	; 2

	lsr				; double colors		; 2
	and	#$7			; mask			; 2
	tax							; 2
	lda	colorlookup,X		; lookup in table	; 5

ror_nop_smc:
	ror				; $6A/$EA		; 2
;	and	#$7f			; make all purple
	sta	(GBASL),Y					; 6

	lda	ror_nop_smc		; toggle ror/nop	; 4
	eor	#$80						; 2
	sta	ror_nop_smc					; 4

	dey							; 2
	bpl	create_xloop					; 2/3

	dec	HGR_Y
	bne	create_yloop

	; we skip drawing line 0 as it makes it easier

	beq	draw_oval


colorlookup:

.byte $11,$55,$5d,$7f,$5d,$55,$11	; use 00 from sinetable
;.byte $00

sinetable_base:
; this is actually (32*sin(x))

.byte $00,$03,$06,$09,$0C,$0F,$11,$14
.byte $16,$18,$1A,$1C,$1D,$1E,$1F,$1F
.byte $20
;,$1F,$1F,$1E,$1D,$1C,$1A,$18
;.byte $16,$14,$11,$0F,$0C,$09,$06,$03


	; for bot

	jmp	oval

sinetable=$6000
