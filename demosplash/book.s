; Display a 40x48d lo-res image

; Uses the 40x48d page1/page2 every-1-scanline pageflip mode

; by deater (Vince Weaver) <vince@deater.net>


end_book:

	;===================
	; init screen
	jsr	TEXT
	jsr	HOME
	bit	KEYRESET

	;===================
	; init vars

	lda	#0
	sta	DRAW_PAGE

	;===================
	; setup grahics

	jsr	create_update_type1

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

	jsr	$9000	; cycle-counted page0/page1 flip code

	;======================================================
	; We have 4550 cycles in the vblank, use them wisely
	;======================================================
	; do_nothing should be
	;     4550
	;      -12   -- enter/leave flip code
	;      -10   -- keypress code
	;   =======
	;    4528 cycles


	;=================================
	; do nothing
	;=================================
	; and take 4528

book_do_nothing:

	; Try X=4 Y=174 cycles=4525 R3

	lda	TEMP	; 3

	ldy	#174							; 2
bloop1:
	ldx	#4							; 2
bloop2:
	dex								; 2
	bne	bloop2							; 2nt/3

	dey								; 2
	bne	bloop1							; 2nt/3



	lda	KEYPRESS				; 4
	bpl	book_no_keypress			; 3
	rts						; 6
book_no_keypress:

	jmp	book_loop				; 3



