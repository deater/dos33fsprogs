; Display Starring Message

; 1st screen = triple page flip
; 2nd/3rd = split  low/hires


starring:

	;===================
	; init screen
	jsr	TEXT
	jsr	HOME
	bit	KEYRESET

	;===================
	; init vars

	lda	#0
	sta	DRAW_PAGE

	;=============================
	; Load graphic page0

	lda	#$0c
	sta	BASH
	lda	#$00
	sta	BASL                    ; load image to $c00


	lda	#<starring1
	sta	GBASL
	lda	#>starring1
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

	lda	#<starring2
	sta	GBASL
	lda	#>starring2
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
stloopA:ldx	#9							; 2
stloopB:dex								; 2
	bne	stloopB							; 2nt/3
	dey								; 2
	bne	stloopA							; 2nt/3

	jmp	st_begin_loop
.align  $100


	;================================================
	; Starring Loop
	;================================================
	; each scan line 65 cycles
	;       1 cycle each byte (40cycles) + 25 for horizontal
	;       Total of 12480 cycles to draw screen
	; Vertical blank = 4550 cycles (70 scan lines)
	; Total of 17030 cycles to get back to where was

	; G00000000000000000000 H0000000000000000000000


st_begin_loop:

st_display_loop:

	ldy	#24
st_outer_loop:

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
	bne	st_outer_loop					; 3
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
stloop1:ldx	#13							; 2
stloop2:dex								; 2
	bne	stloop2							; 2nt/3
	dey								; 2
	bne	stloop1							; 2nt/3

	lda	KEYPRESS				; 4
	bpl	st_no_keypress				; 3
	jmp	st_start_over
st_no_keypress:

	jmp	st_display_loop				; 3

st_start_over:
	bit	KEYRESET	; clear keypress	; 4
	rts						; 6





.include "starring1.inc"
.include "starring2.inc"

