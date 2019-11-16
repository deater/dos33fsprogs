; Uses the 40x48d page1/page2 every-1-scanline pageflip mode

; self modifying code to get some extra colors (pseudo 40x192 mode)

; by deater (Vince Weaver) <vince@deater.net>

credits:

	;===================
	; init vars

	lda	#0
	sta	DRAW_PAGE
	sta	FRAME

;	sta	FRAME_PLAY_OFFSET
;	sta	FRAME_PLAY_PAGE
;	jsr	update_pt3_play
;	jsr     pt3_write_lc_5

	nop
	nop
	nop
	nop
	nop
	nop

	lda	#<credits_text
	sta	CREDITS_POINTERL
	lda	#>credits_text
	sta	CREDITS_POINTERH



	;==================
	; setup graphics

	jsr	create_update_type1

	; setup_rasterbars_page_smc=4
        ; setup_rasterbars_offset_smc=13
	lda	#13
	sta	setup_rasterbars_offset_smc+1
        ; setup_rasterbars_bars_start_smc=46
	lda	#46
	sta	setup_rasterbars_bars_start_smc+1
        ; setup_rasterbars_bars_end_smc=184
	lda	#184
	sta	setup_rasterbars_bars_end_smc+1
        ; setup_rasterbars_start_addr1_smc:=#<(UPDATE_START+(BARS_START*49))
	lda	#<(UPDATE_START+(BARS_START*49))
	sta	setup_rasterbars_start_addr1_smc+1
        ; setup_rasterbars_start_addr2_smc:=#>(UPDATE_START+(BARS_START*49))
	lda	#>(UPDATE_START+(BARS_START*49))
	sta	setup_rasterbars_start_addr2_smc+1

	jsr	setup_rasterbars

	; change to page0/page0/page1/page1 for first 32 lines
	; 0101010101010101010101010101010101010101
	; 1100110011001100110011001100110011001100
	; |  *|  *|  *|  *--------|  *|  *|  *|  *
	; 0  34  78  12  5        4  78  12  56  9
	;            11  1        2  22  33  33  3
	lda	#$54
	sta	UPDATE_START+1+(49*3)
	sta	UPDATE_START+1+(49*7)
	sta	UPDATE_START+1+(49*11)
	sta	UPDATE_START+1+(49*15)
	sta	UPDATE_START+1+(49*27)
	sta	UPDATE_START+1+(49*31)
	sta	UPDATE_START+1+(49*35)
	sta	UPDATE_START+1+(49*39)

	lda	#$55
	sta	UPDATE_START+1+(49*0)
	sta	UPDATE_START+1+(49*4)
	sta	UPDATE_START+1+(49*8)
	sta	UPDATE_START+1+(49*12)
	sta	UPDATE_START+1+(49*24)
	sta	UPDATE_START+1+(49*28)
	sta	UPDATE_START+1+(49*32)
	sta	UPDATE_START+1+(49*36)

;	jsr	play_frame_compressed	; 6+1237

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

	jsr	play_frame_compressed	; 6+1237

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

	jsr	play_frame_compressed	; 6+1237

	; GR part
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

	jsr	$9800

	;======================================================
	; We have 4550 cycles in the vblank, use them wisely
	;======================================================

	; 4550	-- VBLANK
	; -582	-- erase     22+4*(8+6+126) = 582
	; -696  -- move+draw 4*(16+26+6+126) = 696
	;  -10  -- keypress
	;  -12  -- call/return of draw code
	; -446  -- do_words
	;-1246  -- play music
	;  -7   -- wrap
	;=======
	; 1551		//2804


	; 3+2+2+6+1237 play music
	; 3+2+3+6+1237 play fake (-1)

	lda	FRAME_PLAY_PAGE		; 3
	cmp	#$8			; 2		; FIXME
	beq	play_fake		; 3
					; -1
play_actual:
	jsr	play_frame_compressed	; 6+1237 \
	jmp	pad_time		; 3      / 1245
play_fake:
	jsr	fake_music_play		; 6+1239


pad_time:

	; we erase, then draw
	; doing a blanket erase of all 128 lines would cost 3459 cycles!

	;=========================
	; do words
	;=========================

	jsr	draw_credits			; 6+440

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

	; want 1551

	; Try X=102 Y=3 cycles=1549R2

	nop

	ldy	#3							; 2
tloop1:	ldx	#102							; 2
tloop2:	dex								; 2
	bne	tloop2							; 2nt/3
	dey								; 2
	bne	tloop1							; 2nt/3


	lda	KEYPRESS				; 4
	bpl	cno_keypress				; 3
	rts

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
	;
	; noframe: 13 = 13 (need 427)			+12
	; end:     13+12= 25 (need 415)			+83
	; newchar: 13+12+4+79 = 108 (need 333)		+332
	; putchar: 13+12+4+377+28+6 = 440

draw_credits:
	inc	FRAME				; 5
	lda	FRAME				; 3
	and	#$7				; 2
	beq	credits_handle_next		; 3
						;====
						; 13
credits_long_delay:
						; -1
	; 12+1 = 13 cycles

	lda	TEMP 	; 3
	lda	TEMP 	; 3
	lda	TEMP 	; 3
	nop		; 2
	nop		; 2

credits_skip:
	; 83 cycles
	lda	#56		; 2
	jsr	delay_a		; delay 25+a (81)

credits_short_delay:
	; 332 cycles-6 = 326

	; 83 cycles
	lda	#56		; 2
	jsr	delay_a		; delay 25+a (81)

	; 243 cycles
	lda	#216		; 2
	jsr	delay_a		; delay 25+a (241)

	rts			; 6


credits_handle_next:
	ldy	#0				; 2
	lda	(CREDITS_POINTERL),Y		; 5
	cmp	#$ff				; 2
	beq	credits_skip			; 3
						;===
						; 12

						; -1
	cmp	#'@'				; 2
	bcs	credits_put_char	; bge	; 3
						;====
						; 4

credits_check_xy:
						; -1
	sta	CREDITS_Y			; 3
	iny					; 2
	lda	(CREDITS_POINTERL),Y		; 5
	sta	CREDITS_X			; 3
	iny					; 2
						;====
						; 14

	lda	(CREDITS_POINTERL),Y		; 5
	sta	colors_hi			; 4
	iny					; 2
	lda	(CREDITS_POINTERL),Y		; 5
	sta	colors_hi+1			; 4
	iny					; 2
	lda	(CREDITS_POINTERL),Y		; 5
	sta	colors_lo			; 4
	iny					; 2
	lda	(CREDITS_POINTERL),Y		; 5
	sta	colors_lo+1			; 4
	iny					; 2
						;===
						; 44

	clc					; 2
	tya					; 2
	adc	CREDITS_POINTERL		; 3
	sta	CREDITS_POINTERL		; 3
	lda	#0				; 2
	adc	CREDITS_POINTERH		; 3
	sta	CREDITS_POINTERH		; 3

	jmp	credits_short_delay		; 3
						;====
						; 21
credits_put_char:
	ldx	CREDITS_X			; 3
	ldy	CREDITS_Y			; 3
	jsr	put_char			; 6+365
						;======
						; 377

	clc					; 2
	lda	CREDITS_X			; 3
	adc	#4				; 2
	sta	CREDITS_X			; 3

	clc					; 2
	lda	#1				; 2
	adc	CREDITS_POINTERL		; 3
	sta	CREDITS_POINTERL		; 3
	lda	#0				; 2
	adc	CREDITS_POINTERH		; 3
	sta	CREDITS_POINTERH		; 3
						;=====
						; 28

draw_credits_end:
	rts					; 6

.align $100
credits_text:
.byte 0,10, $B1,$3F,$F3,$1B, 'C','O','D','E','[' 	; "CODE:"
.byte 6,8,  $B1,$3F,$F3,$1B, 'D','E','A','T','E','R'	; "DEATER"
.byte '@','@'						; time pad
.byte 0,10, $00,$00,$00,$00, 'C','O','D','E','[' 	; "CODE:"
.byte 6,8,  $00,$00,$00,$00, 'D','E','A','T','E','R'	; "DEATER"

.byte 0,8,  $D8,$9F,$F9,$8D, 'M','U','S','I','C','[' 	; "MUSIC:"
.byte 6,14, $D8,$9F,$F9,$8D, 'D','Y','A'		; "DYA"
.byte '@','@'						; time pad
.byte 0,8,  $00,$00,$00,$00, 'M','U','S','I','C','[' 	; "MUSIC:"
.byte 6,14, $00,$00,$00,$00, 'D','Y','A'		; "DYA"

.byte 0,8, $72,$6F,$F6,$27, 'M','A','G','I','C','[' 	; "MAGIC:"
.byte 6,8, $72,$6F,$F6,$27, 'Q','K','U','M','B','A'	; "QKUMBA"
.byte '@','@'						; time pad
.byte 0,8, $00,$00,$00,$00, 'M','A','G','I','C','[' 	; "MAGIC:"
.byte 6,8, $00,$00,$00,$00, 'Q','K','U','M','B','A'	; "QKUMBA"

.byte 0,8, $C4,$CF,$FC,$4C, 'T','H','A','N','K','S' 	; "THANKS"
.byte 6,4, $C4,$CF,$FC,$4C, 'F','R','O','G','Y','S','U','E'	; "FROGYSUE"
.byte '@'						; time pad
.byte 0,8, $00,$00,$00,$00, 'T','H','A','N','K','S' 	; "THANKS"
.byte 6,4, $00,$00,$00,$00, 'F','R','O','G','Y','S','U','E'	; "FROGYSUE"


.byte 0,10, $75,$5F,$F5,$57, 'A','@','V','M','W' 	; "A VMW"
.byte 6,0,  $75,$5F,$F5,$57, 'P','R','O','D','U','C','T','I','O','N'
							; "PRODUCTION"
.byte 255	; done
credits_text_end:

.assert >credits_text = >(credits_text_end-1), error, "credits_text crosses page"



fake_music_play:

	; 1239 - 6 (ret) = 1233



	jsr	clear_ay_both	; 6+1048

	; 1233-1054=179

	; Try X=2 Y=11 cycles=177R2

	nop

	ldy	#11							; 2
uloop1:	ldx	#2							; 2
uloop2:	dex								; 2
	bne	uloop2							; 2nt/3
	dey								; 2
	bne	uloop1							; 2nt/3

	rts

fake_music_play_end:

.assert >fake_music_play = >fake_music_play_end, error, "fake_music_play crosses page"
