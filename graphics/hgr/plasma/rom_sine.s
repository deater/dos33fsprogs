; Moving
;   moving, orange and green


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


.if 1

	;==========================================
	; create sinetable using ROM cosine table

	ldy	#0
sinetable_loop:
	tya							; 2
	and	#$3f	; wrap sine at 63 entries		; 2

	cmp	#$20
	php		; save pos/negative for later

	and	#$1f

	beq	sin_noadjust

	cmp	#$10
	bcc	sin_left		; blt
	bne	sin_right

	lda	#$20			; force sin(16) to $20 instead of $1F
	bne	sin_noadjust

sin_right:
	; sec	carry should be set here
	sbc	#$10		; X-16  (x=16..31)
	bne	sin_both	; bra
sin_left:
	; clc	; carry should be clear
	eor	#$FF		; 16-X (but plus one twos complement)
	adc	#$11
sin_both:
	tax
	lda	sinetable_base,X				; 4+

	lsr			; rom value is *256
	lsr			; we want *32
	lsr
sin_noadjust:

	plp
	bcc	sin_done

sin_negate:
	; carry set here
	eor	#$ff
;	adc	#0			; off by one, does it matter?

sin_done:
	sta	sinetable,Y

	iny
	bne	sinetable_loop

.else

	;==================
	; create sinetable

	ldy	#0
sinetable_loop:
	tya							; 2
	and	#$3f	; wrap sine at 63 entries		; 2

	cmp	#$20
	php		; save pos/negative for later

	and	#$1f

	cmp	#$10
	bcc	sin_left		; blt

sin_right:
	; sec	carry should be set here
	eor	#$FF
	adc	#$20			; 32-X
sin_left:
	tax
	lda	sinetable_base,X				; 4+

	plp
	bcc	sin_done

sin_negate:
	; carry set here
	eor	#$ff
	adc	#0

sin_done:
	sta	sinetable,Y

	iny
	bne	sinetable_loop
.endif

	; NOTE: making gbash/gbasl table wasn't worth it

	;============================
	; main loop
	;============================

draw_oval:
	inc	FRAME

	lda	#191		; YY

create_yloop:
	; HGR_Y (YY) is in A here

;	ldx	#39		; X is don't care?
	ldy	#0

	jsr	HPOSN		; (Y,X),(A)  (values stores in HGRX,XH,Y)

	; restore values

	lda	HGR_Y		; YY

calcsine_div4:
	lsr
	lsr							; 2
	sec
	sbc	FRAME
	tax
	lda	sinetable,X
	sta	row_sum_smc+1

	ldx	HGR_Y		; YY

	ldy	#39		; XX
create_xloop:

	;=====================
	; critical inner loop
	;   every cycle here is 40x192 cycles
	;=====================

	clc
	tya
	adc	FRAME
	tax
	lda	sinetable,X

	adc	sinetable,Y					; 4+
row_sum_smc:
	adc	#$dd			; row base value	; 2

	lsr				; double colors		; 2
					; also puts bit in carry
					; which helps make blue
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
	lda	HGR_Y
	cmp	#$ff
	bne	create_yloop

	; we skip drawing line 0 as it makes it easier

flip_pages:

	; Y should be $FF here

;	iny
	lda	HGR_PAGE
	cmp	#$20
	bne	done_page
	dey
done_page:
	ldx	PAGE1-$FE,Y	; set display page to PAGE1 or PAGE2

	eor	#$60		; flip draw page between $400/$800
	sta	HGR_PAGE

	bne	draw_oval	; bra


colorlookup:
.byte $22,$aa,$ba,$ff,$ba,$aa,$22	; use 00 from sinetable
.byte $00

;.byte $11,$55,$5d,$7f,$5d,$55,$11	; use 00 from sinetable
;.byte $00


sinetable_base = $F5BA

;sinetable_base:
; this is actually (32*sin(x))
;.byte $00,$03,$06,$09,$0C,$0F,$11,$14
;.byte $16,$18,$1A,$1C,$1D,$1E,$1F,$1F
;.byte $20
;,$1F,$1F,$1E,$1D,$1C,$1A,$18
;.byte $16,$14,$11,$0F,$0C,$09,$06,$03


	; for bot
	; 3F5 - 7d = 378
;	jmp	oval

sinetable=$6000


