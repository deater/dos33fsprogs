; New Demo

; by Vince `deater` Weaver

; zero page locations
HGR_SHAPE	=	$1A
HGR_SHAPE2	=	$1B
HGR_BITS	=	$1C
GBASL		=	$26
GBASH		=	$27
A5H		=	$45
XREG		=	$46
YREG		=	$47

PHASE		=	$6C
FRAME		=	$6D
PAGE		=	$6E
LINE		=	$6F
OUTL		=	$74
OUTH		=	$75
COUNT		=	$76

			; C0-CF should be clear
			; D0-DF?? D0-D5 = HGR scratch?
HGR_DX		=	$D0	; HGLIN
HGR_DX2		=	$D1	; HGLIN
HGR_DY		=	$D2	; HGLIN
HGR_QUADRANT	=	$D3
HGR_E		=	$D4
HGR_E2		=	$D5
HGR_X		=	$E0
HGR_X2		=	$E1
HGR_Y		=	$E2
HGR_COLOR	=	$E4
HGR_HORIZ	=	$E5
HGR_PAGE	=	$E6
HGR_SCALE	=	$E7
HGR_SHAPE_TABLE	=	$E8
HGR_SHAPE_TABLE2=	$E9
HGR_COLLISIONS	=	$EA


; soft-switch
SPEAKER		= $C030
SET_GR		= $C050
SET_TEXT	= $C051
FULLGR		= $C052
PAGE1		= $C054
PAGE2		= $C055
LORES		= $C056		; Enable LORES graphics

; ROM calls
HGR2		= $F3D8
HGR		= $F3E2
HCLR		= $F3F2		; A=0, Y=0 after, X unchanged
HPOSN		= $F411
XDRAW0		= $F65D
XDRAW1		= $F661
PLOT		= $F800		; PLOT AT Y,A (A colors output, Y preserved)
GBASCALC	= $F847		; Y in A, put addr in GBASL/GBASH
SETGR		= $FB40
WAIT		= $FCA8		; delay 1/2(26+27A+5A^2) us
RESTORE		= $FF3F


pattern1	= $d000		; location in memory to use as
				; background pixel pattern


	;========================================
	;========================================
	; actual start
	;========================================
	;========================================

dsr_scroll_intro:

	jsr	HGR2		; Hi-res, full screen
				; Y=0, A=0 after this call

	sta	PAGE		; needed?
	sta	PHASE
	sta	FRAME
	sta	OUTL

	lda	#8
	sta	HGR_SCALE	; init scale to 8


	;=========================================
	; hi-res loop
	;=========================================

hires_setup:

	jsr	xdraw		; non-rotate, HGR2

	; flip draw page $20/$40
        lda     HGR_PAGE
        eor     #$60
        sta     HGR_PAGE

	lda	#2
	sta	rot_smc+1
	jsr	xdraw

;hires_loop:
;	lda	#200
;	jsr	WAIT

;	jsr	flip_page

;	dec	COUNT
;	bne	hires_loop




lo_res_scroll:

;	bit	LORES		; set LORES
;	lda	#0		; set OUTL to 0, also PAGE
;	sta	OUTL


	;===============================
	;===============================
	; main loop
	;===============================
	;===============================

main_loop:
	; current page is in A at this point

	sta	PAGE

	asl		; make OUTH $4 or $8 depending on value in PAGE
			; which we have in A above or at end of loop
	asl		; C is 0
	adc	#4

	sta	OUTH

;	bit	SPEAKER

	lda	#200
	jsr	WAIT

	inc	FRAME

	lda	FRAME
	and	#$3f
	bne	no_inc_bg

	inc	pattern_smc+2

no_inc_bg:

	;============================
	; draw an interleaved line
full_loop:
	ldx	#3

line_loop:
	ldy	#119

screen_loop:

	tya			; extrapolate X from Y
;	and	#$7		; could be bigger?
;	tax

pattern_smc:
	lda	pattern1,Y

inner_loop_smc:

	sta	(OUTL),Y

	dey
	bpl	screen_loop

	;=================================
	; move to next pattern

scroll_pattern:
	clc
	lda	pattern_smc+1
	adc	#8
	and	#$1f
	sta	pattern_smc+1

	; move to next line by adding $80
	;  we save a byte by using EOR instead

	lda	OUTL
	eor	#$80			; add $80
	sta	OUTL

	bne	line_loop

	; we overflowed, so increment OUTH

	inc	OUTH

;	lda	OUTH			; check if at end
;	and	#$3
;	bne	line_loop

	dex
	bpl	line_loop


done_bg:

	;=======================================
	; done drawing frame
	;=======================================


	;======================
	; draw bitmap

	ldx	#7
boxloop:
	txa
	jsr	GBASCALC		; calc address of X
					; note we center to middle of screen
					; by noting the middle 8 lines
					; are offset by $28 from first 8 lines

	; GBASL is in A at this point

	clc
	adc	#12+$28
	sta	GBASL		; center x-coord and y-coord at same time


	lda	PAGE		; want to add 0 or 4 (not 0 or 1)
	asl
	asl			; this sets C to 0
	adc	GBASH
	sta	GBASH


	ldy	#15
draw_line_loop:

	lda	bitmap2,X	; get low bit of bitmap2 into carry
	lsr

	lda	#$00		; black is default color

	ror	bitmap,X	; 16-bit rotate (in memory)
	ror	bitmap2,X

	bcc	its_black

	lda	#$ff
its_black:
	sta	(GBASL),Y		; partway down screen

	dey
	bpl	draw_line_loop

	dex
	bpl	boxloop


	;=========================
	; scroll one line

	; to scroll up need to add 8?
	inc	pattern_smc+1


	; switch page
flip_page:

	lda	PAGE

	tax
	ldy	PAGE1,X			; flip page

	eor	#$1

	bpl	main_loop		; bra



	;=======================
	; xdraw
	;=======================
xdraw:
	; setup X and Y co-ords

	ldy	#0		; XPOSH always 0 for us
	ldx	#140
	lda	#80		; 96 would be halfway?
	jsr	HPOSN		; X= (y,x) Y=(a)
				; after, A=COLOR.BITS
				; Y = xoffset (140/7=20?)
				; X = remainder?

	jsr	HCLR		; A=0 and Y=0 after, X=unchanged

	ldx	#<shape_dsr	; point to our shape
	ldy	#>shape_dsr	; this is always zero since in zero page

rot_smc:
	lda	#$0		; set rotation

	jmp	XDRAW0		; XDRAW 1 AT X,Y


; updated desire logo thanks to 

;012|456|012|456|
;@@@@@@@@@@@@@@@@'
;@   @@    @   @@'
;@@@  @@@@@@@@  @'
;@ @  @    @   @@'
;@ @  @@@  @@@  @'
;@    @    @ @  @'
;@@@@@@@@@@@@@@@@'
;

bitmap:
	.byte $FF ;,$FF
	.byte $8C ;,$23
	.byte $E7 ;,$F9
	.byte $A4 ;,$23
	.byte $A7 ;,$39
	.byte $84 ;,$29
	.byte $FF ;,$FF
	.byte $00 ;,$00

bitmap2:
	.byte $FF
	.byte $23
	.byte $F9

	.byte $23
	.byte $39
	.byte $29
	.byte $FF
	.byte $00




shape_dsr:
.byte	$2d,$36,$ff,$3f
.byte	$24,$ad,$22,$24,$94,$21,$2c,$4d
.byte	$91,$3f,$36,$00
