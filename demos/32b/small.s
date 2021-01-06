HGR_SHAPE	=	$1A
HGR_SHAPEH	=	$1B
HGR_HPAGE	=	$E6
HGR_SCALE	=	$E7
OFFSET		=	$FE
HGR_ROTATE	=	$FF


KEYPRESS        =       $C000
KEYRESET        =       $C010

HGR		=	$F3E2
HCLR		=	$F3F2
HPOSN		=	$F411
HPLOT0		=	$F457
HGLIN		=	$F53A
XDRAW		=	$F65D
XDRAW1		=	$F661
COLORTBL	=	$F6F6

WAIT    = $FCA8                 ;; delay 1/2(26+27A+5A^2) us

start:
	;==========================
	; Setup Graphics
	;==========================

;	We can't use HGR as it clears the screen
	jsr	HGR

	;======================
	; Setup vars
	;======================

	lda	#1
	sta	HGR_SCALE
	sta	HGR_ROTATE

	; HFNS	puts X-coord in Y,X, Y-coord in A
	; HPOSN sets up GBASL/GBASH

loop:

	ldy	#0		; high byte of x position
	ldx	#140		; low byte of x position
	lda	#96		; y position
	jsr	HPOSN

	ldx	#<portal_vert
	ldy	#>portal_vert
	jsr	random_byte
;	lda	HGR_ROTATE	; rotation
	jsr	XDRAW

;	jsr	wait_until_keypress

	jsr	random_byte
;	lda	#200
	jsr	WAIT

	jsr	random_byte
	ora	#$1
	and	#$3
	sta	HGR_SCALE

;	lda	HGR_SCALE
;	eor	#$2
;	sta	HGR_SCALE

;	inc	HGR_ROTATE

	bit	$C030

	jmp	loop


; Shape 1
;
; "Portal"
;   #
;  # #
;  # #
;  # #
; #   #
; #   #
; # * #
; #   #
; #   #
;  # #
;  # #
;  # #
;   #
;
; START
; NLT NLT UP UP UP NRT UP UP UP NRT RT NDN
; DN DN DN NRT DN DN DN DN DN NLT DN DN DN NLT
; UP NLT UP UP UP NLT UP UP UP
; STOP

portal_vert:
.byte $1b,$24,$0c,$24,$0c,$15,$36,$0e,$36, $36,$1e,$36,$1e,$1c,$24,$1c,$24
.byte $04,$00

random_byte:
	inc	OFFSET
	lda	OFFSET
	and	#$1f
	tay
	lda	start,Y
	rts

wait_until_keypress:
        lda     KEYPRESS
        bpl     wait_until_keypress

        lda     KEYRESET                ; clear strobe

	rts
