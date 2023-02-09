; bouncing hearts

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

YPOS		= $56
XPOS		= $57
PO		= $58

HGR_X           = $E0
HGR_Y           = $E2
HGR_COLOR       = $E4
HGR_HORIZ       = $E5
HGR_PAGE        = $E6
HGR_SCALE       = $E7

ROTATION	= $FA
FRAME		= $FB
FRAMEH		= $FC
YY              = $FD
BB              = $FE
XX              = $FF



love_duck:

;	.byte	2		; number of sectors to load
;	lda	$C088,X		; turn off drive motor

;	jsr	dsr_rotate


	bit	SET_GR		; switch to lo-res mode
	bit	FULLGR		; set full screen

main_loop:


	;======================
	; flip page
	;======================

page_smc:
	lda	#0			; 0 or 1

	tax
	ldy	PAGE1,X			; flip page

	eor	#$1			; invert (leaving in A)

	sta	page_smc+1	; save PAGE value (PAGE in A here)


	asl		; make OUTH $4 or $8 depending on value in PAGE
			; which we have in A above or at end of loop
	asl		; (this also sets C to 0)
	adc	#4

	sta	GBASH

	inc	FRAME	; increment frame #
	lda	FRAME
	and	#$1f	; cycle colors ever 32 frames
	bne	no_color_cycle

	inc	bg_smc+1

no_color_cycle:

	lda	#100	; pause a bit
	jsr	WAIT

	sta	GBASL	; A is 0


	;=================================
	; clear lo-res screen, page1/page2
	;=================================
	; proper with avoiding screen holes is ~25 instructions
	; this is more like 16
	; assume GBASL/GBASH already points to proper $400 or $800

	ldx	#4		; lores is 1k, so 4 pages
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

	lda	#<heart_bitmap
	sta	sprite_smc+1

	lda	#$11		; red
	sta	color_smc+1

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

	lda	#32
	sta	XPOS
	lda	#1
	sta	YPOS

	lda	#$44		; green
	sta	color_smc+1

	lda	#<duck_bitmap_left
	sta	sprite_smc+1

	jsr	draw_sprite

	lda	#24
	sta	XPOS

	lda	#$99		; orange
	sta	color_smc+1

	lda	#<duck_bitmap_left_beak
	sta	sprite_smc+1

	jsr	draw_sprite


	jmp	main_loop
;	bmi	main_loop		; bra




	;===========================
	; draw_sprite
	;===========================
draw_sprite:


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

	lda	page_smc+1	; want to add 0 or 4 (not 0 or 1)
	asl
	asl			; this sets C to 0
	adc	GBASH
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
	lda	#$11		; red
	sta	(GBASL),Y	; draw on screen
its_transparent:

	pla

	dey
	bpl	draw_line_loop

	dex
	bpl	boxloop

	rts









;=================
; star bitmap
;=================

;012|456|
;   @     ;
;   @@    ;
;   @@@@@ ;
;@@@@@@@  ;
; @@@@@   ;
;  @@@@@  ;
; @@  @@  ;
;@@    @@ ;

;bitmap:
;	.byte $10
;	.byte $18
;	.byte $1f
;	.byte $fe
;	.byte $7c
;	.byte $3e
;	.byte $66
;	.byte $C3

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

.include "dsr_lores.s"
