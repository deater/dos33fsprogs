; thick sine

; TODO: could we get this down to 64 bytes?
;	put the sine table in the zero page?
;	only generate 64 bytes of sine?


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


; to generate sine table:
;	48  bytes -- initial implementation

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
	tya							; 1
	and	#$f						; 2
	tax							; 1

	lda	sinetable_base,X				; 3
	sta	sinetable,Y					; 3

	eor	#$FF						; 1
	sta	sinetable+32,Y					; 3

	txa							; 1
	eor	#$FF						; 2
	sec							; 1
	adc	#15						; 2
	tax							; 1

	lda	sinetable_base,X				; 3
	sta	sinetable+16,Y					; 3

	eor	#$FF						; 2
	sta	sinetable+48,Y					; 3


	iny							; 1
	cpy	#$10						; 2
	bne	sinetable_loop					; 2

						; 37+17=54

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
	lda	SAVEX
	and	#$3f
	tax
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


sinetable_base:
; this is actually (32*sin(x))
.byte $00,$03,$06,$09,$0C,$0F,$11,$14
.byte $16,$18,$1A,$1C,$1D,$1E,$1F,$1F
.byte $20

	; for bot
	; 3F5 - 7d = 378
;	jmp	oval

sinetable=$6000
;sinetable_base=$F5BA
