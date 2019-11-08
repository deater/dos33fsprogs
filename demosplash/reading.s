; Display a 40x48d lo-res image

; Uses the 40x48d page1/page2 every-1-scanline pageflip mode

; by deater (Vince Weaver) <vince@deater.net>


end_book:

cli
	;===================
	; init screen

	bit	PAGE0
	bit	SET_TEXT
	lda	#' '+$80
	sta	clear_all_color+1
	jsr	gr_clear_all

	;===================
	; init vars

	lda	#0
	sta	DRAW_PAGE
	lda	#255
	sta	FRAMEL

	;===================
	; setup graphics

	jsr	create_update_type1


	;======================
	; print message

	lda	#<read_book_text
	sta	OUTL

	lda	#>read_book_text
	sta	OUTH

	jsr	move_and_print
	jsr	move_and_print

	lda	#200
	jsr	long_wait
	lda	#200
	jsr	long_wait

sei

	lda     #0
	sta     FRAME_PLAY_OFFSET
	sta     FRAME_PLAY_PAGE
	sta     FRAME_OFFSET
	sta     FRAME_PAGE
	jsr     update_pt3_play

	; setup 4 frames
	jsr     pt3_write_lc_4


	;=============================
	; Load graphic page0

	lda	#<book_low
	sta	GBASL
	lda	#>book_low
	sta	GBASH

	lda	#$c			; load image to $c00

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

	lda	#<book_high
	sta	GBASL
	lda	#>book_high
	sta	GBASH
	lda	#$c			; load image to $c00
	jsr	load_rle_gr

	lda	#0
	sta	DRAW_PAGE

	jsr	gr_copy_to_current

	; GR part
	bit	PAGE0

	;==============================
	; setup graphics for vapor lock
	;==============================

	jsr	vapor_lock

	; vapor lock returns with us at beginning of hsync in line
        ; 114 (7410 cycles), so with 5070 lines to go

        ; GR part
        bit     LORES                                                   ; 4
        bit     SET_GR                                                  ; 4
        bit     FULLGR                                                  ; 4

	jsr	gr_copy_to_current			; 6+ 9292

	; now we have 322 left

	; 322 - 12 = 310
	; - 3 for jmp
	; 307

	; Try X=9 Y=6 cycles=307

	ldy	#6							; 2
loopQ:	ldx	#9							; 2
loopR:	dex								; 2
	bne	loopR							; 2nt/3
	dey								; 2
	bne	loopQ							; 2nt/3

	jmp	book_loop						; 3
.align  $100


	;================================================
	; Display Loop
	;================================================
	; We want to alternate between page1 and page2 every 65 cycles
        ;       vblank = 4550 cycles to do scrolling

book_loop:

	jsr	$9800	; cycle-counted page0/page1 flip code

	;======================================================
	; We have 4550 cycles in the vblank, use them wisely
	;======================================================
	; do_nothing should be
	;     4550
	;      -12   -- enter/leave flip code
	;      -10   -- keypress code
	;    -1239
	;   =======
	;     3289 cycles

	jsr	play_frame_compressed			; 6+1233

	;=================================
	; do nothing
	;=================================
	; and take 3289

book_do_nothing:

	; Try X=81 Y=8 cycles=3289

	ldy	#8							; 2
bloop1:
	ldx	#81							; 2
bloop2:
	dex								; 2
	bne	bloop2							; 2nt/3

	dey								; 2
	bne	bloop1							; 2nt/3

	dec	FRAMEL					; 5
	nop						; 2
	bne	book_loop				; 3

;	lda	TEMP					; 3
;	lda	KEYPRESS				; 4
;	bpl	book_loop				; 3

	rts						; 6




read_book_text:
.byte	2,11,"QUIET AT LAST",0
.byte	2,12,"FINALLY I CAN READ MY BOOK IN PEACE",0
