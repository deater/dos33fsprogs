; random scroll bot 128

; 141 bytes -- bot version
; 138 bytes -- no need for back jump
; 140 bytes -- load at 0x70
; 134 bytes -- enforce ZP addresses
; 133 bytes -- convert JMP to BPL
; 131 bytes -- make OUTL live in program
; 130 bytes -- use EOR instead of ADD
; 127 bytes -- don't wrap pattern lookup at 8
; 126 bytes -- use X for loop


; by Vince `deater` Weaver

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

OUTL		= $74
OUTH		= $75

FRAME		= $6D
PAGE		= $6E
LINE		= $6F

pattern1	= $d000		; location  in memory

.zeropage
.globalzp       pattern_smc
.globalzp	bitmap
.globalzp	bitmap2
.globalzp	inner_loop_smc



random:

	jsr	SETGR		; set LORES			; 70 71 72

	lda	#0		; also OUTL=0/OUTH		; 73 74

	bit	FULLGR		; set FULL 48x40		; 75 76 77

;	bit	SETTEXT

main_loop:
	sta	PAGE		; start at page 1

	asl		; make OUTH $4 or $8 depending on value in PAGE
			; which we have in A above or at end of loop
	asl		; C is 0
	adc	#4

	sta	OUTH

	bit	SPEAKER

	lda	#100
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
	lda	PAGE

	tax
	ldy	PAGE1,X			; flip page

	eor	#$1

	bpl	main_loop		; bra


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



;012|456|012|456|
;@@@@@@@@@@@@@@@@'
;@@@@ @    @@@@@@'
;@@@@ @ @@@@@@@@@'
;@    @    @    @'
;@ @@ @@@@ @ @@@@'
;@    @    @ @@@@'
;@@@@@@@@@@@@@@@@'
;

;bitmap:
;	.byte $FF ;,$FF
;	.byte $F4 ;,$3F
;	.byte $F5 ;,$FF
;	.byte $84 ;,$21
;	.byte $B7 ;,$AF
;	.byte $84 ;,$2F
;	.byte $FF ;,$FF
;	.byte $00 ;,$00

;bitmap2:
;	.byte $FF
;	.byte $3F
;	.byte $FF
;	.byte $21
;	.byte $AF
;	.byte $2F
;	.byte $FF
;	.byte $00



;01234567|01234567
;
;   @@@@   @@@@
;     @@   @@
;     @@   @@
;     @@   @@
;   @@@@   @@@@
;
;@@@@@@@@@@@@@@@@
.if 0
bitmap:
	.byte $FF ;,$FF
	.byte $E1 ;,$87
	.byte $F9 ;,$9F
	.byte $F9 ;,$9F
	.byte $F9 ;,$9F
	.byte $E1 ;,$87
	.byte $FF ;,$FF
	.byte $00 ;,$00

bitmap2:
	.byte $FF
	.byte $87
	.byte $9F
	.byte $9F
	.byte $9F
	.byte $87
	.byte $FF
	.byte $00
.endif
