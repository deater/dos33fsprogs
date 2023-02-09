; love duck + bouncing hearts

; by Vince `deater` Weaver <vince@deater.net>
; -- dSr--

; Lovebyte 2023


; soft switches
SPEAKER		= $C030
SET_GR		= $C050
SET_TEXT	= $C051
FULLGR		= $C052
PAGE1		= $C054
PAGE2		= $C055
LORES		= $C056		; Enable LORES graphics

HGR2		= $F3D8
HGR		= $F3E2
HPOSN		= $F411		; (Y,X),(A)  (valued stores in HGRX,XH,Y)
XDRAW0		= $F65D
PLOT		= $F800		; PLOT AT Y,A (A colors output, Y preserved)
PLOT1		= $F80E         ; PLOT at (GBASL),Y (need MASK to be $0f or $f0)
GBASCALC	= $F847		; Y in A, put addr in GBASL/GBASH (what is C?)
SETCOL		= $F864		; COLOR=A
SETGR		= $FB40
WAIT		= $FCA8		; delay 1/2(26+27A+5A^2) us


GBASL		= $26
GBASH		= $27
MASK		= $2E
COLOR		= $30


hgr_lookup_h    =       $40             ; $40-$70
hgr_lookup_l    =       $70             ; $70-$A0
gr_lookup_l	=	$A0		; $A0-$B8
gr_lookup_h	=	$B8		; $B8-$C0

HGR_X           = $E0
HGR_Y           = $E2
HGR_COLOR       = $E4
HGR_HORIZ       = $E5
HGR_PAGE        = $E6
HGR_SCALE       = $E7

YPOS		= $F0
XPOS		= $F1
DRAW_PAGE	= $F2
ROTATION	= $FA
FRAME		= $FB
FRAMEH		= $FC
YY              = $FD
BB              = $FE
XX              = $FF



love_duck:

.include "dsr_lores.s"

;	bit	SET_GR		; switch to lo-res mode
;	bit	FULLGR		; set full screen

;	inc	FRAME		; want frame #0
				; maybe not necessary

main_loop:


	;======================
	; flip page
	;======================

	jsr	flip_page

	;===============
	; handle duck
	;===============

	lda	FRAME
	and	#$7f
	bne	check_beep

	ldx	#NOTE_D3
	ldy	#50
	jsr	speaker_xy

	ldx	#NOTE_E3
	ldy	#50
	jsr	speaker_xy

	ldx	#10
long_wait:
	lda	#200
	jsr	WAIT
	dex
	bne	long_wait

;	beq	no_beep

	;===================
	; handle click
	;===================
check_beep:
	and	#$3
	bne	no_beep
	; every 4th cycle beep

	ldx	#NOTE_C4
	ldy	#10
	jsr	speaker_xy

	; Y zero here?
no_beep:

	;=====================
	; handle color cycle
	;=====================

	lda	FRAME
	and	#$1f	; cycle colors ever 32 frames
	bne	no_color_cycle

	inc	bg_smc+1

no_color_cycle:

	lda	#100	; pause a bit
	jsr	WAIT

	sta	GBASL	; A is 0

	; increment frame

	inc	FRAME	; increment frame #
	bne	frame_noflo
	inc	FRAMEH
frame_noflo:

	lda	FRAMEH
	cmp	#3
	bne	keep_going

	jmp	big_loop	; back to beginning
keep_going:





; 0000 -> 0100
; 0100 -> 1000



	;=================================
	; clear lo-res screen, page1/page2
	;=================================
	; proper with avoiding screen holes is ~25 instructions
	; this is more like 16
	; assume GBASL/GBASH already points to proper $400 or $800

	ldx	#4		; lores is 1k, so 4 pages
	txa
	clc
	adc	DRAW_PAGE
	sta	GBASH

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

	; X=0
	; Y=0
	; A=color

	;====================
	; draw the hearts
	;====================

	lda	#32		; start from right to save a byte

	;=======================
	; draw 8x8 bitmap hearts
	;=======================
	; A is XPOS on entry
draw_heart:

	; calculate YPOS
	sta	XPOS

	lsr			; make middle star offset+4 from others
	lsr

	adc	FRAME		; look up bounce amount
	and	#$7
	tax
	lda	bounce,X
	sta	YPOS

	ldx	#<heart_bitmap
;	stx	sprite_smc+1

	ldy	#$11		; red
;	sty	color_smc+1

	jsr	draw_sprite


	lda	XPOS		; move to next position
				; going right to left saves 2 bytes for cmp
	sec
	sbc	#16

	; X is $FF here
	; Y is $FF here
	; A is -16 here

	bpl	draw_heart

	;===============
	; draw duck

	lda	FRAME
	and	#$7f
	bne	no_duck

	lda	#32
	sta	XPOS
	lda	#1
	sta	YPOS

	ldx	#<duck_bitmap_left
	ldy	#$44		; green
	jsr	draw_sprite

	lda	#24
	sta	XPOS

	ldx	#<duck_bitmap_left_beak
	ldy	#$99		; orange
	jsr	draw_sprite


no_duck:



	jmp	main_loop



	;===========================
	; draw_sprite
	;===========================
	; x is low byte of bitmap
	; y is color
draw_sprite:
	stx	sprite_smc+1
	sty	color_smc+1

	ldx	#7		; draw 7 lines
boxloop:
	txa
	clc
	adc	YPOS
	jsr	GBASCALC	; calc address of line in X (Y-coord)

	; GBASL is in A at this point
	; is C always 0?

;	clc
	adc	XPOS		; adjust to X-coord
	sta	GBASL

	; adjust for proper page

	lda	GBASH		 ;carry still set from above
	adc	DRAW_PAGE
	sta	GBASH

	;=================
	; draw line


	ldy	#7		; 8-bits wide
sprite_smc:
	lda	bitmap,X	; get low bit of bitmap into carry
draw_line_loop:
	lsr

	pha

	bcc	its_transparent

color_smc:
	lda	#$11		; color to draw
	sta	(GBASL),Y	; draw on screen
its_transparent:

	pla

	dey
	bpl	draw_line_loop

	dex
	bpl	boxloop

	rts


	;=================
	; page flip
flip_page:
	ldx	#0
	lda	DRAW_PAGE
	beq	done_page
	inx
done_page:
	ldy	PAGE1,X		; set display page to PAGE1 or PAGE2

	eor	#$4		; flip draw page between $400/$800
	sta	DRAW_PAGE

	rts



;012|456|
; @   @@  ;
;@@@ @@@@ ;
;@@@@@@@@ ;
;@@@@@@@@ ;
; @@@@@@@ ;
;  @@@@@  ;
;   @@@   ;
;    @    ;

heart_bitmap:
bitmap:
	.byte $46
	.byte $EF
	.byte $FF
	.byte $FF
	.byte $7f
	.byte $3e
	.byte $1c
	.byte $08


;012|456|
; @@@@    ;
;@@@@@@   ;
;@@ @@@   ;
;@@@@@@   ;
;@@@@@@   ;
;@@@@@@@@ ;
;  @@@@@@ ;
;  @@@@@@ ;

duck_bitmap_left:
	.byte $78
	.byte $FC
	.byte $DC
	.byte $FC
	.byte $FC
	.byte $FF
	.byte $3F
	.byte $3F


shape_dsr:
.byte   $2d,$36,$ff,$3f
.byte   $24,$ad,$22,$24,$94,$21,$2c,$4d
.byte   $91,$3f,$36;,$00

;012|456|
;         ;
;         ;
;    @@   ;
;      @@ ;
;      @@ ;
;    @@   ;
;         ;
;         ;
duck_bitmap_left_beak:
	.byte $00
	.byte $00
	.byte $0c
	.byte $03
	.byte $03
	.byte $0c
	.byte $00
	.byte $00



bounce:
	.byte 10,11,12,13,13,12,11,10


.include "speaker_beeps.s"







