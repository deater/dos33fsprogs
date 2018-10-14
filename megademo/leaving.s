; Leaving house

; Simple Text/GR split


; STATE1 = Walk over to bird
; STATE2 = get on bird
; STATE3 = ride off on bird


leaving_home:


	;===================
	; init screen
	bit	KEYRESET

setup_leaving:


	;===================
	; init vars

	lda	#8
	sta	DRAW_PAGE


	;=============================
	; Load graphic page0

	lda	#$0c
	sta	BASH
	lda	#$00
	sta	BASL                    ; load image to $c00


	lda	#<leaving
	sta	GBASL
	lda	#>leaving
	sta	GBASH
	jsr	load_rle_gr

	lda	#$a0
	ldy	#10
	jsr	clear_page_loop			; make top 6 lines spaces

	lda	#0
	sta	DRAW_PAGE

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

	jsr	draw_moon_sky						; 6+54

	; 322 - 12 = 310
	; - 3 for jmp
	; 307	- 60 for sky = 247

	; Try X=9 Y=6 cycles=307
	; Try X=7 Y=6 cycles=247

        ldy	#6							; 2
lvloopA:ldx	#7							; 2
lvloopB:dex								; 2
	bne	lvloopB							; 2nt/3
	dey								; 2
	bne	lvloopA							; 2nt/3

	jmp	lv_begin_loop
.align  $100


	;================================================
	; Leaving Loop
	;================================================
	; each scan line 65 cycles
	;       1 cycle each byte (40cycles) + 25 for horizontal
	;       Total of 12480 cycles to draw screen
	; Vertical blank = 4550 cycles (70 scan lines)
	; Total of 17030 cycles to get back to where was

	; want 12*4 = 48 lines of HIRES = 3120-4=3116
	; want 192-48=144 lines of LORES = 9360-4=9356



lv_begin_loop:

	bit	SET_TEXT						; 4

	; Try X=11 Y=51 cycles=3112 R4

	nop
	nop
	ldy	#51							; 2
lvloop8:ldx	#11							; 2
lvloop9:dex								; 2
	bne	lvloop9							; 2nt/3
	dey								; 2
	bne	lvloop8							; 2nt/3

	bit	SET_GR			; 4

	; Try X=10 Y=167 cycles=9353 R3

	lda	$0

	ldy	#167							; 2
lvloop6:ldx	#10							; 2
lvloop7:dex								; 2
	bne	lvloop7							; 2nt/3
	dey								; 2
	bne	lvloop6							; 2nt/3


	;======================================================
	; We have 4550 cycles in the vblank, use them wisely
	;======================================================

	; do_nothing should be      4550
	;			     -10 keypress
	;			===========
	;			    4540

	; Try X=9 Y=89 cycles=4540

	ldy	#89							; 2
lvloop1:ldx	#9							; 2
lvloop2:dex								; 2
	bne	lvloop2							; 2nt/3
	dey								; 2
	bne	lvloop1							; 2nt/3

	lda	KEYPRESS				; 4
	bpl	lv_no_keypress				; 3
	jmp	lv_start_over
lv_no_keypress:

	jmp	lv_begin_loop				; 3

lv_start_over:
	bit	KEYRESET	; clear keypress	; 4
	rts						; 6





