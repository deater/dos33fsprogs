; Solaris scrolling code

; 150 bytes = from solaris2
; 102 bytes = drop half terms from lookup table
; 122 bytes = page flipping
; 144 bytes = got some stars going
; 143 bytes = re-arrange color assignment

; zero page
GBASL	= $26
GBASH	= $27

HGR_X           = $E0
HGR_XH          = $E1
HGR_Y           = $E2
HGR_COLOR       = $E4
HGR_PAGE        = $E6
HGR_SCALE	= $E7

; soft-switches
FULLGR	= $C052
PAGE1	= $C054

; ROM routines

HGR	= $F3E2
HGR2	= $F3D8
HPOSN	= $F411		; (Y,X),(A)  (values stores in HGRX,XH,Y)
			; put in GBASL/GBASH

WAIT    = $FCA8                 ;; delay 1/2(26+27A+5A^2) us

DRAW0  = $F601
XDRAW0  = $F65D

COUNT	= $FE
FRAME	= $FF

solaris4:

	jsr	HGR
	jsr	HGR2

draw_stars:

	ldx	#32
	lda	#1
draw_stars_loop:
	ldy	$D000,X
stars1_smc:
	sta	$2000,Y
stars2_smc:
	sta	$4000,Y
	inc	stars1_smc+2
	inc	stars2_smc+2
	dex
	bpl	draw_stars_loop


	; X = FF here

outer_loop:

	dex			; decrement offset
	txa
	and	#$7		; make sure stays less than 8
	tax

	ldy	#0
;	sty	COUNT		; reset count to 0
inner_loop:
	; count is in Y here
	sty	COUNT
	sec
	lda	#191
	sbc	COUNT		; YY = 160-COUNT

	jsr	HPOSN		; calculate line addr in GBASL/H, trashes all

	ldx	HGR_X		; restore offset

	lda	#$ff		; default is white

	ldy	lookup,X	; see if match count
	cpy	COUNT

	bne	skip_color

;	clc			; needed?
				; carry always set here
	txa
	adc	#7
	tax

	lda	#$00		; draw black

skip_color:


	ldy	#39			; draw horizontal line at GBASL
inner_inner_loop:
	sta	(GBASL),Y
	dey
	bpl	inner_inner_loop

	; Y is FF here

	ldy	COUNT
	iny
	cpy	#84
	bne	inner_loop


flip_pages:

        ; Y should be 84 here

        lda     HGR_PAGE        ; will be $20/$40
	eor	#$60            ; flip draw page between $2000/$4000
	sta	HGR_PAGE

        cmp     #$40
        bne     done_page
        dey
done_page:
	lda     PAGE1-83,Y     ; set display page to PAGE1 or PAGE2

	jmp	outer_loop

lookup:
.byte	 2, 8,14,19,23,27,31,34
.byte	37,40,43,45,47,49,51,53
.byte	55,57,58,60,61,62,64,65
.byte	66,67,68,69,70,71,71,72
.byte	73,74,75,75,76,77,77,78
.byte	78,79,79,80,80,81,81,82
