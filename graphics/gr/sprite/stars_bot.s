; bouncing stars

; by Vince `deater` Weaver

; 119 bytes -- single star original
; 143 bytes -- three stars
; 141 bytes -- optimize init
; 140 bytes -- 0 is already in X
; 143 bytes -- stars move independently
; 140 bytes -- optimize XPOS in multiple calls to draw_stars
; 145 bytes -- color changing background
; 139 bytes -- re-inline draw_star
; 143 bytes -- speed up the color transition
; 144 bytes -- tried to share adjust_page in subroutine, backfired
; 143 bytes -- revert last change

SPEAKER		= $C030
SET_GR		= $C050
SET_TEXT	= $C051
FULLGR		= $C052
PAGE1		= $C054
PAGE2		= $C055
LORES		= $C056		; Enable LORES graphics

HGR2		= $F3D8
PLOT		= $F800		; PLOT AT Y,A (A colors output, Y preserved)
GBASCALC	= $F847		; Y in A, put addr in GBASL/GBASH
SETGR		= $FB40
WAIT		= $FCA8		; delay 1/2(26+27A+5A^2) us

GBASL		= $26
GBASH		= $27

YPOS		= $76
XPOS		= $77

FRAME		= $6D
PAGE		= $6E


;.zeropage
;.globalzp	pattern_smc


stars:
	jsr	HGR2		; sets graphics/full-screen/hires/PAGE2
				; sets A and Y to 0

	bit	LORES		; switch to lo-res mode

	; A should be 0 here

main_loop:
	sta	PAGE	; save PAGE value (PAGE in A here)

	asl		; make OUTH $4 or $8 depending on value in PAGE
			; which we have in A above or at end of loop
	asl		; C is 0
	adc	#4

	sta	GBASH

	inc	FRAME	; increment frame #
	lda	FRAME
	and	#$1f	; cycle colors ever 32 frames
	bne	no_cs

	inc	bg_smc+1

no_cs:

	lda	#100	; pause a bit
	jsr	WAIT

	sta	GBASL	; A is 0


	;=================================
	; clear lo-res screen, page1/page2
	;=================================
	; proper with avoiding screen holes is ~25 instructions

	ldx	#4		; lores is 1k, so 4 pages
;	stx	GBASH
;	jsr	adjust_page
full_loop:
	ldy	#$00		; clear whole page
bg_smc:
	lda	#$54		; color
inner_loop:
	sta	(GBASL),Y
	dey
	bne	inner_loop

	inc	GBASH		; point to next page
	dex
	bne	full_loop


	;====================
	; draw the stars
	;====================

	txa			; X is zero here

	;======================
	; draw 8x8 bitmap star
	;======================
	; A is XPOS on entry
draw_star:

	; calculate YPOS
	sta	XPOS

;	lda	XPOS
	lsr			; make middle star offset+4 from others
	lsr

	adc	FRAME		; look up bounce amount
	and	#$7
	tax
	lda	bounce,X
	sta	YPOS


	ldx	#7		; draw 7 lines
boxloop:
	txa
	clc
	adc	YPOS
	jsr	GBASCALC	; calc address of line in X (Y-coord)


	; GBASL is in A at this point

	clc
	adc	XPOS		; adjust to X-coord
	sta	GBASL

	; adjust for proper page

;	jsr	adjust_page

	lda	PAGE		; want to add 0 or 4 (not 0 or 1)
	asl
	asl			; this sets C to 0
	adc	GBASH
	sta	GBASH

	;=================
	; draw line


	ldy	#7		; 8-bits wide
	lda	bitmap,X	; get low bit of bitmap into carry
draw_line_loop:
	lsr

	pha

	bcc	its_transparent

	lda	#$dd		; yellow
	sta	(GBASL),Y	; draw on screen
its_transparent:

	pla

	dey
	bpl	draw_line_loop

	dex
	bpl	boxloop

	lda	XPOS
	clc
	adc	#16

	cmp	#48
	bne	draw_star


	; X is $FF here
	; Y is $FF here
	; A is 48 here

	;======================
	; flip page
	;======================

	lda	PAGE

	tax
	ldy	PAGE1,X			; flip page

	eor	#$1			; invert (leaving in A)

	bpl	main_loop		; bra


	; GBASL in A
;adjust_page:
;	sta	GBASL
;	lda	PAGE		; want to add 0 or 4 (not 0 or 1)
;	asl
;	asl			; this sets C to 0
;	adc	GBASH
;	sta	GBASH
;	rts



; star bitmap

;012|456|
;   @     ;
;   @@    ;
;   @@@@@ ;
;@@@@@@@  ;
; @@@@@   ;
;  @@@@@  ;
; @@  @@  ;
;@@    @@ ;

bitmap:
	.byte $10
	.byte $18
	.byte $1f
	.byte $fe
	.byte $7c
	.byte $3e
	.byte $66
	.byte $C3

bounce:
	.byte 10,11,12,13,13,12,11,10

	; for apple II bot

	jmp	stars
