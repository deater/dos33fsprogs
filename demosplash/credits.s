; Uses the 40x48d page1/page2 every-1-scanline pageflip mode

; self modifying code to get some extra colors (pseudo 40x192 mode)

; by deater (Vince Weaver) <vince@deater.net>

credits:

	;===================
	; init screen
	jsr	TEXT
	jsr	HOME
	bit	KEYRESET

	;===================
	; init vars

	lda	#0
	sta	DRAW_PAGE
	sta	FRAME

	lda	#<credits_text
	sta	CREDITS_POINTERL
	lda	#>credits_text
	sta	CREDITS_POINTERH

	;==================
	; setup graphics

	jsr	create_update_type1
	jsr	setup_rasterbars

	;=============================
	; Load graphic page0

	lda	#<credits_low
	sta	GBASL
	lda	#>credits_low
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

;	jsr	wait_until_keypressed


	;=============================
	; Load graphic page1

	lda	#<credits_high
	sta	GBASL
	lda	#>credits_high
	sta	GBASH
	lda	#$c			; load to $c00
	jsr	load_rle_gr

	lda	#0
	sta	DRAW_PAGE

	jsr	gr_copy_to_current

;	; GR part
	bit	PAGE0

;	jsr	wait_until_keypressed


	;==============================
	; setup graphics for vapor lock
	;==============================

	jsr	vapor_lock

	; vapor lock returns with us at beginning of hsync in line
	; 114 (7410 cycles), so with 5070 lines to go

	; GR part
	bit	LORES							; 4
	bit	SET_GR							; 4
	bit	FULLGR							; 4

	jsr	gr_copy_to_current			; 6+ 9292

	; 5070 + 4550 = 9620
	;		9292
	;		  12
	;		   6
	;		====
	;		 310

	; - 3 for jmp
	; 307

	; Try X=9 Y=6 cycles=307

	ldy	#6							; 2
tloopA:	ldx	#9							; 2
tloopB:	dex								; 2
	bne	tloopB							; 2nt/3
	dey								; 2
	bne	tloopA							; 2nt/3

	jmp	credits_loop						; 3

.align  $100

	;================================================
	; Display Loop
	;================================================
	; each scan line 65 cycles
	;       1 cycle each byte (40cycles) + 25 for horizontal
	;       Total of 12480 cycles to draw screen
	; Vertical blank = 4550 cycles (70 scan lines)
	; Total of 17030 cycles to get back to where was

	; We want to alternate between page1 and page2 every 65 cycles
        ;       vblank = 4550 cycles to do scrolling


credits_loop:

	jsr	$9000

	;======================================================
	; We have 4550 cycles in the vblank, use them wisely
	;======================================================

	; 4550	-- VBLANK
	; -582	-- erase     22+4*(8+6+126) = 582
	; -696  -- move+draw 4*(16+26+6+126) = 696
	;  -10  -- keypress
	;  -12  -- call/return of draw code
	; -377  -- do_words
	;=======
	; 2873

pad_time:

	; we erase, then draw
	; doing a blanket erase of all 128 lines would cost 3459 cycles!

	;=========================
	; do words
	;=========================

	jsr	draw_credits

	;=========================
	; ERASE
	;=========================

	lda	#$00				; 2
	sta	smc_raster_color1_1+1		; 4
	sta	smc_raster_color1_2+1		; 4
	sta	smc_raster_color2_1+1		; 4
	sta	smc_raster_color2_2+1		; 4
	sta	smc_raster_color3_1+1		; 4
					;=============
					;	22

	; erase red

	lda	red_x				; 4
	and	#$7f				; 2
	tax					; 2

	jsr	draw_rasterbar			; 6+126

	; erase yellow

	lda	yellow_x				; 4
	and	#$7f				; 2
	tax					; 2

	jsr	draw_rasterbar			; 6+126

	; erase green

	lda	green_x				; 4
	and	#$7f				; 2
	tax					; 2

	jsr	draw_rasterbar			; 6+126

	; erase red

	lda	blue_x				; 4
	and	#$7f				; 2
	tax					; 2

	jsr	draw_rasterbar			; 6+126


	;=========================
	; MOVE and DRAW
	;=========================


	;============
	; move red

	ldy	red_x				; 4
	lda	movement_table,Y		; 4
	sta	red_x				; 4
	and	#$7f				; 2
	tax					; 2
					;==========
					;	 16

	; draw red

	lda	#$33				; 2
	sta	smc_raster_color1_1+1		; 4
	sta	smc_raster_color1_2+1		; 4
	lda	#$bb				; 2
	sta	smc_raster_color2_1+1		; 4
	sta	smc_raster_color2_2+1		; 4
	lda	#$ff				; 2
	sta	smc_raster_color3_1+1		; 4
					;=============
					;	26


	jsr	draw_rasterbar			; 6+126


	;============
	; move yellow

	ldy	yellow_x			; 4
	lda	movement_table,Y		; 4
	sta	yellow_x			; 4
	and	#$7f				; 2
	tax					; 2
					;==========
					;	 16

	; draw yellow

	lda	#$88				; 2
	sta	smc_raster_color1_1+1		; 4
	sta	smc_raster_color1_2+1		; 4
	lda	#$dd				; 2
	sta	smc_raster_color2_1+1		; 4
	sta	smc_raster_color2_2+1		; 4
	lda	#$ff				; 2
	sta	smc_raster_color3_1+1		; 4
					;=============
					;	26


	jsr	draw_rasterbar			; 6+126

	;============
	; move green

	ldy	green_x				; 4
	lda	movement_table,Y		; 4
	sta	green_x				; 4
	and	#$7f				; 2
	tax					; 2
					;==========
					;	 16

	; draw green

	lda	#$44				; 2
	sta	smc_raster_color1_1+1		; 4
	sta	smc_raster_color1_2+1		; 4
	lda	#$cc				; 2
	sta	smc_raster_color2_1+1		; 4
	sta	smc_raster_color2_2+1		; 4
	lda	#$ff				; 2
	sta	smc_raster_color3_1+1		; 4
					;=============
					;	26


	jsr	draw_rasterbar			; 6+126

	;============
	; move blue

	ldy	blue_x				; 4
	lda	movement_table,Y		; 4
	sta	blue_x				; 4
	and	#$7f				; 2
	tax					; 2
					;==========
					;	 16

	; draw blue

	lda	#$22				; 2
	sta	smc_raster_color1_1+1		; 4
	sta	smc_raster_color1_2+1		; 4
	lda	#$66				; 2
	sta	smc_raster_color2_1+1		; 4
	sta	smc_raster_color2_2+1		; 4
	lda	#$ff				; 2
	sta	smc_raster_color3_1+1		; 4
					;=============
					;	26


	jsr	draw_rasterbar			; 6+126




	;============================
	; WAIT for VBLANK to finish
	;============================

	; Try X=7 Y=70 cycles=2871 R2

	nop

	ldy	#70							; 2
tloop1:	ldx	#7							; 2
tloop2:	dex								; 2
	bne	tloop2							; 2nt/3
	dey								; 2
	bne	tloop1							; 2nt/3


	lda	KEYPRESS				; 4
	bpl	cno_keypress				; 3
	jmp	credits_loop
cno_keypress:

	jmp	credits_loop				; 3


	;========================
	; Draw a rasterbar
	;	unroll as memory is free!  haha
	;========================
	; X is location

	; 2+22+24+24+24+24+6 = 126

draw_rasterbar:

	ldy	#0			; 2
					;====

	lda	y_lookup_l,X		; 4
	sta	OUTL			; 3
	lda	y_lookup_h,X		; 4
	sta	OUTH			; 3

smc_raster_color1_1:
	lda	#$33			; 2
	sta	(OUTL),Y		; 6
				;============
				;	22

	inx				; 2
	lda	y_lookup_l,X		; 4
	sta	OUTL			; 3
	lda	y_lookup_h,X		; 4
	sta	OUTH			; 3

smc_raster_color2_1:
	lda	#$bb			; 2
	sta	(OUTL),Y		; 6

	inx				; 2
	lda	y_lookup_l,X		; 4
	sta	OUTL			; 3
	lda	y_lookup_h,X		; 4
	sta	OUTH			; 3

smc_raster_color3_1:
	lda	#$ff			; 2
	sta	(OUTL),Y		; 6

	inx
	lda	y_lookup_l,X		; 4
	sta	OUTL			; 3
	lda	y_lookup_h,X		; 4
	sta	OUTH			; 3

smc_raster_color2_2:
	lda	#$bb			; 2
	sta	(OUTL),Y		; 6

	inx
	lda	y_lookup_l,X		; 4
	sta	OUTL			; 3
	lda	y_lookup_h,X		; 4
	sta	OUTH			; 3

smc_raster_color1_2:
	lda	#$33			; 2
	sta	(OUTL),Y		; 6

	rts				; 6


red_x:		.byte $10
yellow_x:	.byte $20
green_x:	.byte $30
blue_x:		.byte $40

	;=================================
	; draw credits
	;=================================
	; credits pointer
draw_credits:
	inc	FRAME				; 5
	lda	FRAME				; 3
	and	#$f				; 2
	beq	credits_handle_next		; 3
credits_long_delay:
						; -1
credits_skip:

credits_short_delay:

	rts


credits_handle_next:
	ldy	#0				; 2
	lda	(CREDITS_POINTERL),Y		; 5+
	cmp	#$ff				; 2
	beq	credits_skip			; 3
						; -1
	cmp	#'@'				; 2
	bcs	credits_put_char	; bge	; 3

credits_check_xy:
						; -1
	sta	CREDITS_Y
	iny
	lda	(CREDITS_POINTERL),Y
	sta	CREDITS_X
	iny
	lda	(CREDITS_POINTERL),Y
	sta	colors_hi
	iny
	lda	(CREDITS_POINTERL),Y
	sta	colors_hi+1
	iny
	lda	(CREDITS_POINTERL),Y
	sta	colors_lo
	iny
	lda	(CREDITS_POINTERL),Y
	sta	colors_lo+1

	iny
	clc
	tya
	adc	CREDITS_POINTERL
	sta	CREDITS_POINTERL
	lda	#0
	adc	CREDITS_POINTERH
	sta	CREDITS_POINTERH

	jmp	credits_short_delay

credits_put_char:
	ldx	CREDITS_X			; 2
	ldy	CREDITS_Y			; 3
	jsr	put_char			; 6+365

	clc
	lda	CREDITS_X
	adc	#4
	sta	CREDITS_X

	clc
	lda	#1
	adc	CREDITS_POINTERL
	sta	CREDITS_POINTERL
	lda	#0
	adc	CREDITS_POINTERH
	sta	CREDITS_POINTERH

draw_credits_end:
	rts					; 6

credits_text:
.byte 0,10, $C4,$CF,$FC,$4C, 'C','O','D','E','[' 	; "CODE:"
.byte 4,8, $C4,$CF,$FC,$4C, 'D','E','A','T','E','R'	; "DEATER"
.byte '@','@'						; time pad
.byte 0,10, $00,$00,$00,$00, 'C','O','D','E','[' 	; "CODE:"
.byte 4,8, $00,$00,$00,$00, 'D','E','A','T','E','R'	; "DEATER"

.byte 0,8, $C4,$CF,$FC,$4C, 'M','U','S','I','C','[' 	; "MUSIC:"
.byte 4,14, $C4,$CF,$FC,$4C, 'D','Y','A'		; "DYA"
.byte '@','@'						; time pad
.byte 0,8, $00,$00,$00,$00, 'M','U','S','I','C','[' 	; "MUSIC:"
.byte 4,14, $00,$00,$00,$00, 'D','Y','A'		; "DYA"


.byte 255	; done
