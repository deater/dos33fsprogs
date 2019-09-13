; Uses the 40x48d page1/page2 every-1-scanline pageflip mode

; self modifying code to get some extra colors (pseudo 40x192 mode)

; try adding some sound support

; by deater (Vince Weaver) <vince@deater.net>

.include "zp.inc"
.include "hardware.inc"

PT3_LOC = song

PT3_USE_ZERO_PAGE = 1

start_rasterbars:

	;===================
	; init screen
	jsr	TEXT
	jsr	HOME
	bit	KEYRESET

	;===================
	; init vars

	lda	#0
	sta	DRAW_PAGE
	sta	DONE_PLAYING
	sta	DONE_SONG

	lda	#1
	sta	LOOP


	;=======================
        ; Detect mockingboard
        ;========================

	jsr	mockingboard_detect_slot4

        ;============================
        ; Init the Mockingboard
        ;============================

        jsr     mockingboard_init
        jsr     reset_ay_both
        jsr     clear_ay_both

        ;==================
        ; init song
        ;==================

        jsr     pt3_init_song

	;=============================
	; Load graphic page0

	lda	#$0c
	sta	BASH
	lda	#$00
	sta	BASL                    ; load image to $c00

	ldy	#0

	lda	pictures,Y
	sta	GBASL
	lda	pictures+1,Y
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

;	jsr	wait_until_keypressed


	;=============================
	; Load graphic page1

	lda	#$0c
	sta	BASH
	lda	#$00
	sta	BASL                    ; load image to $c00

	ldy	#0

	lda	pictures+2,Y
	sta	GBASL
	lda	pictures+3,Y
	sta	GBASH
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

	; -3 for jmp
	; 307

	; Try X=14 Y=4 cycles=305R2

	nop

	ldy	#4							; 2
loopA:	ldx	#14							; 2
loopB:	dex								; 2
	bne	loopB							; 2nt/3
	dey								; 2
	bne	loopA							; 2nt/3



	jmp	display_loop						; 3

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


display_loop:

.include "rasterbars_screen.s"

	;======================================================
	; We have 4550 cycles in the vblank, use them wisely
	;======================================================

	; 4550	-- VBLANK
	; -582	-- erase     22+4*(8+6+126) = 582
	; -696  -- move+draw 4*(16+26+6+126) = 696
	;  -10  -- keypress
	; -387	-- calc values
	; -997  -- mockingboard out
	;=======
	; 1878

pad_time:

	; we erase, then draw
	; doing a blanket erase of all 128 lines would cost 3459 cycles!

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

	lda	yellow_x			; 4
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
	; Play music
	;============================


	jsr	pt3_make_frame		; 6+381	= 387
	jsr	mb_write_frame		; 6+991 = 997


	;============================
	; WAIT for VBLANK to finish
	;============================

	; Try X=6 Y=54 cycles=1945R5
;	nop
;	lda	TEMP

	; Try X=6 Y=52 cycles=1873R5
	nop
	lda	TEMP

	; Try X=124 Y=3 cycles=1879R4



	ldy	#52							; 2
loop1:	ldx	#6							; 2
loop2:	dex								; 2
	bne	loop2							; 2nt/3
	dey								; 2
	bne	loop1							; 2nt/3
wait_loop_end:

	lda	KEYPRESS				; 4
	bpl	no_keypress				; 3
	jmp	display_loop
no_keypress:

	jmp	display_loop				; 3

.assert >loop1 = >(wait_loop_end-1), error, "wait_loop crosses page"






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



.include "gr_simple_clear.s"
.include "gr_offsets.s"
.include "gr_unrle.s"

.align $100
.include "rasterbars_table.s"
.include "movement_table.s"
.include "gr_copy.s"
.include "vapor_lock.s"
.include "delay_a.s"

pictures:
	.word rb_bg_low,rb_bg_high

.include "rb_bg.inc"

red_x:		.byte $10
yellow_x:	.byte $20
green_x:	.byte $30
blue_x:		.byte $40

.include "pt3_lib_core.s"
.include "pt3_lib_init.s"
.include "pt3_lib_mockingboard.s"
.include "pt3_write_frame.s"

;=============
; include song
;=============
.align	256		; must be on page boundary
			; this can be fixed but some changes would have
			; to be made throughout the player code
song:
.incbin "../pt3_player/music/EA.PT3"
