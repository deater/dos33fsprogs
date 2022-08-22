; Solaris scrolling code

; 150 bytes = from solaris2
; 102 bytes = drop half terms from lookup table
; 122 bytes = page flipping
; 158 bytes = add spaceship

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

solaris2:

	jsr	HGR
	jsr	HGR2

	lda	#2
	sta	HGR_SCALE

outer_loop:
	ldy	#0
	sty	COUNT		; reset count to 0 (first) or FF (from loop)

	dex			; decrement offset
	txa
	and	#$7		; make sure stays less than 16
	tax

inner_loop:
	sec
	lda	#160
	sbc	COUNT		; YY = 160-COUNT

	jsr	HPOSN		; calculate line addr in GBASL/H, trashes all

	ldx	HGR_X		; restore offset

	lda	lookup,X	; see if match count
	cmp	COUNT

	bne	skip_color

	clc			; needed?
	txa
	adc	#8
	tax

	lda	#$00		; draw black

	.byte	$2C
;	jmp	no_color

skip_color:
	lda	#$FF

no_color:
	ldy	#39			; draw horizontal line at GBASL
inner_inner_loop:
	sta	(GBASL),Y
	dey
	bpl	inner_inner_loop

	; Y is FF here

	inc	COUNT
	lda	COUNT
	cmp	#84
	bne	inner_loop

	txa
	pha

	ldy	#0		; XPOSH always 0 for us
	ldx	#135
	lda	#150
	jsr	HPOSN		; X= (y,x) Y=(a)

        ldx     #<ship_table
        ldy     #>ship_table

        lda     #0              ; set rotation

        jsr	XDRAW0          ; XDRAW 1 AT X,Y
                                ; Both A and X are 0 at exit

	pla
	tax


	ldy	#$FF
flip_pages:

        ; Y should be $FF here

        lda     HGR_PAGE        ; will be $20/$40
	eor	#$60            ; flip draw page between $2000/$4000
	sta	HGR_PAGE

        cmp     #$40
        bne     done_page
        dey
done_page:
	lda     PAGE1-$FE,Y     ; set display page to PAGE1 or PAGE2

	jmp	outer_loop

lookup:
.byte	 2, 8,14,19,23,27,31,34
.byte	37,40,43,45,47,49,51,53
.byte	55,57,58,60,61,62,64,65
.byte	66,67,68,69,70,71,71,72
.byte	73,74,75,75,76,77,77,78
.byte	78,79,79,80,80,81,81,82


ship_table:
        .byte   $23     ; 00 100 011    NLT UP X
        .byte   $25     ; 00 100 101    RT  UP X
        .byte   $25     ; 00 100 101    RT  UP X
        .byte   $2D     ; 00 101 101    RT  RT X
        .byte   $2E     ; 00 101 110    DN  RT X
        .byte   $2E     ; 00 101 110    DN  RT X
        .byte   $0E     ; 00 001 110    NDN RT X
        .byte   $0
