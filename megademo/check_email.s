; Display e-mail demo

; 40x96 graphics as well as half-screen text manipulation


check_email:

	;===================
	; init screen
	jsr	TEXT
	jsr	HOME
	bit	KEYRESET

	;===================
	; init vars

	lda	#0
	sta	DRAW_PAGE

init_email_letters:
        lda     #<em_letters
        sta     LETTERL
        lda     #>em_letters
        sta     LETTERH
        lda     #18
        sta     LETTERX
        lda     #4
        sta     LETTERY
        lda     #4
        sta     LETTERD


	;=============================
	; Load graphic page0

	lda	#$0c
	sta	BASH
	lda	#$00
	sta	BASL                    ; load image to $c00


	lda	#<email_low
	sta	GBASL
	lda	#>email_low
	sta	GBASH
	jsr	load_rle_gr

	lda	#4
	sta	DRAW_PAGE

	jsr	gr_copy_to_current	; copy to page1

	; GR part
	bit	PAGE1
	bit	LORES							; 4
	bit	SET_GR							; 4
	bit	FULLGR							; 4

	;=============================
	; Load graphic page1

	lda	#$0c
	sta	BASH
	lda	#$00
	sta	BASL                    ; load image to $c00

	lda	#<email_high
	sta	GBASL
	lda	#>email_high
	sta	GBASH
	jsr	load_rle_gr

	lda	#0
	sta	DRAW_PAGE

	jsr	gr_copy_to_current

	; GR part
	bit	PAGE0


	;==============================
	; setup graphics for vapor lock
	;==============================

	jsr	vapor_lock						; 6

	; vapor lock returns with us at beginning of hsync in line
	; 114 (7410 cycles), so with 5070 lines to go

	jsr	gr_copy_to_current		; 6+ 9292

	; now we have 322 left

	; GR part
	bit	LORES							; 4
	bit	SET_GR							; 4
	bit	FULLGR							; 4

	; 322 - 12 = 310
	; - 3 for jmp
	; 307

	; Try X=9 Y=6 cycles=307

        ldy	#6							; 2
celoopA:ldx	#9							; 2
celoopB:dex								; 2
	bne	celoopB							; 2nt/3
	dey								; 2
	bne	celoopA							; 2nt/3

	jmp	em_begin_loop
.align  $100


	;================================================
	; Email Loop
	;================================================
	; each scan line 65 cycles
	;       1 cycle each byte (40cycles) + 25 for horizontal
	;       Total of 12480 cycles to draw screen
	; Vertical blank = 4550 cycles (70 scan lines)
	; Total of 17030 cycles to get back to where was


	; For this part we want on Apple II/II+
	; On Apple IIe and newer want  T 000/11111
	; because the font is shifted upwards a line

	; T00000000000000000000 G0000000000000000000000
	; T00000000000000000000 G0000000000000000000000
	; T00000000000000000000 G1111111111111111111111
	; T00000000000000000000 G1111111111111111111111
	; T11111111111111111111 G0000000000000000000000
	; T11111111111111111111 G0000000000000000000000
	; T11111111111111111111 G1111111111111111111111
	; T11111111111111111111 G1111111111111111111111

	; 0,1,0,1 0,0,1,1
	; 54,55,54,55  54,54,55,55

em_begin_loop:

em_display_loop:

	ldy	#24
em_outer_loop:

	;== line0
	bit	PAGE0			; 4
	lda	#$54			; 2
	sta	draw_line_p1+1		; 4
	jsr	draw_line_1		; 6
	;== line1
	bit	PAGE0			; 4
	lda	#$54			; 2
	sta	draw_line_p1+1		; 4
	jsr	draw_line_1		; 6
	;== line2
	bit	PAGE0			; 4
	lda	#$55			; 2
	sta	draw_line_p1+1		; 4
	jsr	draw_line_1		; 6
	;== line3
ce_patch:
	bit	PAGE1	;IIe		; 4
;	bit	PAGE0	;II/II+		; 4

	lda	#$55			; 2
	sta	draw_line_p1+1		; 4
	jsr	draw_line_1		; 6

	;== line4
	bit	PAGE1			; 4
	lda	#$54			; 2
	sta	draw_line_p1+1		; 4
	jsr	draw_line_1		; 6
	;== line5
	bit	PAGE1			; 4
	lda	#$54			; 2
	sta	draw_line_p1+1		; 4
	jsr	draw_line_1		; 6
	;== line6
	bit	PAGE1			; 4
	lda	#$55			; 2
	sta	draw_line_p1+1		; 4
	jsr	draw_line_1		; 6

	;== line7
	bit	PAGE1			; 4
	lda	#$55			; 2
	sta	draw_line_p2+1		; 4
	jsr	draw_line_2		; 6


	dey							; 2
	bne	em_outer_loop					; 3
								; -1


	;======================================================
	; We have 4550 cycles in the vblank, use them wisely
	;======================================================

	; do_nothing should be      4550
	;			      +1 fallthrough from above
	;			     -10 keypress
	;			      -2 ldy at top
	;			    -132 move letters
	;			===========
	;			    4407

	; Try X=13 Y=62 cycles=4403 R4

	nop								; 2
	nop

	ldy	#62							; 2
emloop1:ldx	#13							; 2
emloop2:dex								; 2
	bne	emloop2							; 2nt/3
	dey								; 2
	bne	emloop1							; 2nt/3


	jsr	move_letters				; 6+126

	lda	KEYPRESS				; 4
	bpl	em_no_keypress				; 3
	jmp	em_start_over
em_no_keypress:

	jmp	em_display_loop				; 3

em_start_over:
	bit	KEYRESET	; clear keypress	; 4
	rts						; 6



	;======================
	; Draw split line
	; with no room for rec/jump at end

draw_line_1:	; line0

	; come in with 16
	lda	$0
	bit	SET_TEXT					; 4

	nop							; 2
	nop							; 2
	nop							; 2
	nop							; 2
	nop							; 2

							;==============
							;	33


	nop
	nop

	bit	SET_GR						; 4
draw_line_p1:
	bit	PAGE0						; 4



	lda	$0
	lda	$0
	lda	$0
	lda	$0

;	nop
;	nop
	nop
	rts

							;==============
							;	32


	;======================
	; Draw split line
	; with room for 5 cycles of dec/jump at end

draw_line_2:	; line0

	; come in with 16
	lda	$0						; 3

	bit	SET_TEXT					; 4
	nop							; 2
	nop							; 2
	nop							; 2
	nop							; 2
	nop							; 2

	nop
	nop

							;==============
							;	33

	bit	SET_GR						; 4
draw_line_p2:
	bit	PAGE0						; 4
	lda	$0
	lda	$0
	lda	$0
;	lda	$0
;	nop
;	nop
;	nop
;	lda	$0
;	lda	$0
	rts
							;==============
							;	32



em_letters:
	; note it is y,x
;       .byte	4,4,
	.byte	        "DA LA ",128		; DEATER
	.byte	4+128,4,"DE&FEF",198

	.byte	5,4,    " S C  !.",128		; IS COOL
	.byte	5+128,4,"YS C88I.",128

	.byte	7,3,    "W   M",$22,"SSE  J A",128
	.byte	7+128,3,"WYF MGSSEH 8YE",128

	.byte	8,3,    " A SAS LA KS",128
	.byte	8+128,3,"FEYSESEHEEKS",128

	.byte	9,3,    "A  !",$22,"SA .",128
	.byte	9+128,3,"EYHIOSEH.",128

	.byte	12,4,    "        /I",128
	.byte	12+128,4,"        /Y",128
	.byte	13,4,    "  __ __/_I",128
	.byte	13+128,4,"  __ __/_Y",128
	.byte	14,4,    " /__]    I/",128
	.byte	14+128,4," /__]    Y/",128
	.byte	15,4,    "/_____   I\",128
	.byte	15+128,4,"/_____EEEE\"
	.byte	255


.include "email_40_96.inc"



