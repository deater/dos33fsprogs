; random scroll bot

; 162 bytes -- working code
; 158 bytes -- play with bitmap
; 156 bytes -- use HGR2 to init screen (and A)
; 155 bytes -- remove use of LINE count
; 155 bytes -- use ZP for output
; 153 bytes -- count X backwards
; 150 bytes -- use $28 to center Y trick
; 146 bytes -- inline update scroll, makes it scroll right rather than up
; 144 bytes -- share common sta OUTH
; 141 bytes -- more wrapping loop stuff

; *****  *****
; *****  *****
;    **  **                 @@  @@@@@@
;    **  **                 @@  @@
;    **  **             @@@@@@  @@@@@@  @@@@@@
; *****  *****          @@  @@      @@  @@
; *****  *****          @@@@@@  @@@@@@  @@


; by Vince `deater` Weaver

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

OUTL		= $FC
OUTH		= $FD

PAGE		= $FE
LINE		= $FF

pattern1	= $f000		; location  in memory

random:

	jsr	HGR2		; set HIRES, FULLSCREEN
	bit	LORES		; set LORES

	; A is 0 from HGR2
	sta	OUTL

;	lda	#$4

main_loop:
	sta	PAGE		; start at page 1

	asl		; make OUTH $4 or $8 depending on value in PAGE
			; which we have in A above or at end of loop
	asl		; C is 0
	adc	#4

	sta	OUTH

	lda	#200
	jsr	WAIT


	;============================
	; draw an interleaved line

line_loop:
	ldy	#119

screen_loop:

	tya			 ; extrapolate Y from X
	and	#$7
	tax

pattern_smc:
	lda	pattern1,X

inner_loop_smc:

	sta	(OUTL),Y

	dey
	bpl	screen_loop

	;=================================
	; move to next pattern

;	jsr	scroll_pattern

scroll_pattern:
	clc
	lda	pattern_smc+1
	adc	#8
	and	#$1f
	sta	pattern_smc+1
;	rts


	; move to next line

	clc
	lda	OUTL
	adc	#$80
	sta	OUTL

	bcc	line_loop

	; A is $00 if we get here

	adc	OUTH
	sta	OUTH

	and	#$3
	bne	line_loop

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

;	jsr	scroll_pattern

	; to scroll up need to add 8?
	inc	pattern_smc+1


	; switch page
	lda	PAGE

	tax
	ldy	PAGE1,X		; flip page

	eor	#$1
;	sta	PAGE		; is 0 or 1

	; reset page smc

	; OUTH is either C00 or 800
	;	want C00 to go to 400 and 800 to stay the same

;	asl
;	asl		; C is 0
;	adc	#4


;	sta	OUTH

;	lda	#200
;	jsr	WAIT

	; A is 0 after

	jmp	main_loop		; bra

.if 0
scroll_pattern:
	clc
	lda	pattern_smc+1
	adc	#8
	and	#$1f
	sta	pattern_smc+1
	rts

.endif

;01234567|01234567
;
;   @@@@   @@@@
;     @@   @@
;     @@   @@
;     @@   @@
;   @@@@   @@@@
;
;@@@@@@@@@@@@@@@@
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



; want this at $3F5

; we are 141 bytes long, so 36b

	jmp	random






.if 0
	;======================
	; draw box

	ldx	#16
boxloop:
	txa
	jsr	GBASCALC

	lda	PAGE
	asl
	asl
;	clc
	adc	GBASH
	sta	GBASH

color_smc:
	lda	#$FF			; white bar
	ldy	#30
draw_line_loop:
	sta	(GBASL),Y		; partway down screen
	dey
	cpy	#10
	bne	draw_line_loop

	dex
	cpx	#6
	bne	boxloop
.endif
