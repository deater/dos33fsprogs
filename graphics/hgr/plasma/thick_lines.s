; thick lines


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
HPLOT0	= $F457		; plot at (Y,X), (A)

	;================================
	; Clear screen and setup graphics
	;================================
thick_sine:

	jsr	HGR2		; set hi-res 140x192, page2, fullscreen
				; A and Y both 0 at end
	;==================
	; create sinetable

	;ldy	#0		; Y is 0
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
	adc	#0		; FIXME: this makes things off by 1

sin_done:
	sta	sinetable,Y

	iny
	bne	sinetable_loop

	; Y is 0 at this point?


	;============================
	; main loop
	;============================

	dey
	sty	HGR_COLOR	; required
				; though in emulator it defaults to $FF

draw_circle:

	ldy	#0
	sty	SAVEY

blah_smc:
	ldx	#0
	stx	SAVEX

circle_loop:
	ldx	SAVEX
	lda	sinetable,X

;	clc
	asl

	; $60 is midscreen
	adc	#$60
	ldx	SAVEY
	ldy	#0

	jsr	HPLOT0		; plot at (Y,X), (A)

	inc	SAVEX

	inc	SAVEY
	bne	circle_loop

done:
	inc	blah_smc+1

	lda	SAVEX
	and	#$3f
	cmp	#$3f
	bne	blah
	lda	HGR_COLOR
	eor	#$ff
	sta	HGR_COLOR
blah:

	jmp	draw_circle


;sinetable_base:
; this is actually (32*sin(x))

	; for bot
	; 3F5 - 7d = 378
;	jmp	oval

sinetable=$6000
sinetable_base=$F5BA
