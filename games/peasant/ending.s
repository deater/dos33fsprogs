; Peasant's Quest Ending

; The credits scenes

; by Vince `deater` Weaver	vince@deater.net

.include "hardware.inc"
.include "zp.inc"

.include "qload.inc"

ending:
;	lda	#0
;	sta	GAME_OVER

	jsr	hgr_make_tables

	jsr	HGR2		; Hi-res graphics, no text at bottom
				; Y=0, A=0 after this called


	lda	#0
	sta	FRAME

	; update score

	jsr	update_score


	;=====================
	; re-start music
	;=====================
	; need to un-do any patching
	; reset to beginning of song
	; and start interrupts

	; FIXME: only if mockingboard enabled

	cli


	;=====================
	;=====================
	; boat scene
	;=====================
	;=====================
boat:

	lda	#<lake_e_boat_lzsa
	sta	getsrc_smc+1
	lda	#>lake_e_boat_lzsa
	sta	getsrc_smc+2

	lda	#$40

	jsr	decompress_lzsa2_fast

	jsr	update_top

	; draw rectangle

	lda     #$80            ; color is black2
	sta     VGI_RCOLOR

	lda     #12
	sta     VGI_RX1
	lda     #38
	sta     VGI_RY1
	lda	#202
	sta	VGI_RXRUN
	lda	#20
        sta     VGI_RYRUN
        jsr     vgi_simple_rectangle

	lda     #214
	sta     VGI_RX1
	lda     #38
	sta     VGI_RY1
	lda	#45
	sta	VGI_RXRUN
	lda	#20
        sta     VGI_RYRUN
        jsr     vgi_simple_rectangle


	lda	#<boat_string
	sta	OUTL
	lda	#>boat_string
	sta	OUTH

	jsr	disp_put_string


	;======================
	; animate catching fish


	jsr	wait_until_keypress


	;=======================
	;=======================
	; waterfall
	;=======================
	;=======================

waterfall:
	lda	#0
	sta	FRAME

	lda	#<waterfall_lzsa
	sta	getsrc_smc+1
	lda	#>waterfall_lzsa
	sta	getsrc_smc+2

	lda	#$40

	jsr	decompress_lzsa2_fast

	jsr	update_top

	; draw rectangle

	lda     #$80            ; color is black2
	sta     VGI_RCOLOR

	lda     #44
	sta     VGI_RX1
	lda     #48
	sta     VGI_RY1
	lda	#192
	sta	VGI_RXRUN
	lda	#20
        sta     VGI_RYRUN
        jsr     vgi_simple_rectangle

	lda	#<waterfall_string
	sta	OUTL
	lda	#>waterfall_string
	sta	OUTH

	jsr	disp_put_string

	;=========================
	; animate baby

	ldx	#0
	stx	BABY_COUNT
	lda	#14
	sta	h1414_smc_len+1

	; initial bg save
	lda	#0
	sta	CURSOR_X
	sta	CURSOR_Y
	jsr	save_bg_14x14

baby_loop:
	ldx	BABY_COUNT
	lda	baby_progress,X
	bmi	done_baby
	cmp	FRAME
	bne	same_baby

	lda	BABY_COUNT
	clc
	adc	#4		; point to next
	sta	BABY_COUNT

	; make sprite length smaller after fall
	lda	FRAME
	cmp	#41
	bcs	same_baby
	lda	#8
	sta	h1414_smc_len+1

same_baby:

	jsr	restore_bg_14x14

	ldx	BABY_COUNT

	lda	baby_progress+2,X
	sta	CURSOR_X
	lda	baby_progress+3,X
	sta	CURSOR_Y

	; save background so we can restore when move

	jsr	save_bg_14x14

	ldx	BABY_COUNT

	lda	baby_progress+1,X
	bmi	no_draw_baby
	tax

	lda	baby_pointers_l,X
	sta	INL
	lda	baby_pointers_h,X
	sta	INH

	jsr	hgr_draw_sprite_14x14

no_draw_baby:

	lda	#150
	jsr	WAIT

	inc	FRAME

	jmp	baby_loop

done_baby:
	;
	;===========================

;	jsr	wait_until_keypress


	;=========================
	;=========================
	; jhonka
	;=========================
	;=========================

jhonka:

	lda	#<jhonka_lzsa
	sta	getsrc_smc+1
	lda	#>jhonka_lzsa
	sta	getsrc_smc+2

	lda	#$40

	jsr	decompress_lzsa2_fast

	jsr	update_top

	; draw rectangle

	lda     #$80            ; color is black2
	sta     VGI_RCOLOR

	lda     #44
	sta     VGI_RX1
	lda     #58
	sta     VGI_RY1
	lda	#180
	sta	VGI_RXRUN
	lda	#12
        sta     VGI_RYRUN
        jsr     vgi_simple_rectangle

;	lda     #214
;	sta     VGI_RX1
;	lda     #58
;	sta     VGI_RY1
;	lda	#8
;	sta	VGI_RXRUN
;	lda	#20
 ;       sta     VGI_RYRUN
  ;      jsr     vgi_simple_rectangle


	lda	#<jhonka_string
	sta	OUTL
	lda	#>jhonka_string
	sta	OUTH

	jsr	disp_put_string

	;=================
	; animate jhonka

	jsr	wait_until_keypress

	;========================
	;========================
	; cottage
	;========================
	;========================

cottage:

	lda	#<cottage_lzsa
	sta	getsrc_smc+1
	lda	#>cottage_lzsa
	sta	getsrc_smc+2

	lda	#$40

	jsr	decompress_lzsa2_fast

	jsr	update_top


	; draw rectangle

	lda     #$80            ; color is black2
	sta     VGI_RCOLOR

	lda     #40
	sta     VGI_RX1
	lda     #48
	sta     VGI_RY1
	lda	#192
	sta	VGI_RXRUN
	lda	#32
        sta     VGI_RYRUN
        jsr     vgi_simple_rectangle


	lda	#<cottage_string
	sta	OUTL
	lda	#>cottage_string
	sta	OUTH

	jsr	disp_put_string

	lda	#42
	jsr	wait_a_bit

	;====================
	; second message

	lda     #11
	sta     VGI_RX1
	lda     #48
	sta     VGI_RY1
	lda	#192
	sta	VGI_RXRUN
	lda	#32
        sta     VGI_RYRUN
        jsr     vgi_simple_rectangle

	lda     #203
	sta     VGI_RX1
	lda     #48
	sta     VGI_RY1
	lda	#60
	sta	VGI_RXRUN
	lda	#32
        sta     VGI_RYRUN
        jsr     vgi_simple_rectangle


	lda	#<cottage_string2
	sta	OUTL
	lda	#>cottage_string2
	sta	OUTH

	jsr	disp_put_string

	lda	#42
	jsr	wait_a_bit


	;========================
	;========================
	; final screen
	;========================
	;========================
final_screen:

	lda	#<the_end_lzsa
	sta	getsrc_smc+1
	lda	#>the_end_lzsa
	sta	getsrc_smc+2

	lda	#$40

	jsr	decompress_lzsa2_fast

	jsr	update_top

	jsr	wait_until_keypress

game_over:

	jmp	boat


peasant_text:
	.byte 25,2,"Peasant's Quest",0


.include "decompress_fast_v2.s"
.include "wait_keypress.s"

.include "hgr_font.s"
.include "draw_box.s"
.include "hgr_rectangle.s"

.include "hgr_1x5_sprite.s"
.include "hgr_partial_save.s"
.include "hgr_input.s"
.include "hgr_tables.s"
.include "hgr_text_box.s"

;.include "draw_peasant.s"
;.include "hgr_save_restore.s"
;.include "clear_bottom.s"
;.include "gr_offsets.s"
;.include "gr_copy.s"
;.include "version.inc"

.include "hgr_14x14_sprite_mask.s"

.include "score.s"

.include "wait_a_bit.s"

.include "graphics_end/ending_graphics.inc"

.include "sprites/ending_sprites.inc"

boat_string:
	.byte 2,40
	.byte "         Peasant's Quest",13
	.byte "Written by Matt, Jonathan, and Mike",0

waterfall_string:
	.byte 7,50
	.byte "  Programmed by Jonathan",13
	.byte "Apple ][ support by Deater",0

jhonka_string:
	.byte 7,60
	.byte "Graphics by Mike and Matt",0

cottage_string:
	.byte 6,50
	.byte " Quality Assurance Types:",13
	.byte "      Neal Stamper,",13
	.byte "Don Chapman, and John Radle",0

cottage_string2:
	.byte 2,58
	.byte "Nice work on winning and everything.",0


baby_pointers_l:
	.byte	<baby0_sprite	; head left
	.byte	<baby1_sprite	; head down
	.byte	<baby2_sprite	; head right
	.byte	<baby3_sprite	; head up
	.byte	<baby4_sprite	; splash head
	.byte	<baby5_sprite	; splash ring
	.byte	<baby6_sprite	; baby ring
	.byte	<baby7_sprite	; baby ring2
	.byte	<baby8_sprite	; baby ring3
	.byte	<baby9_sprite	; baby high
	.byte	<baby10_sprite	; baby low

baby_pointers_h:
	.byte	>baby0_sprite
	.byte	>baby1_sprite
	.byte	>baby2_sprite
	.byte	>baby3_sprite
	.byte	>baby4_sprite
	.byte	>baby5_sprite
	.byte	>baby6_sprite
	.byte	>baby7_sprite
	.byte	>baby8_sprite
	.byte	>baby9_sprite
	.byte	>baby10_sprite


baby_progress:
	.byte 18,  $FF, 0, 0	; nothing at first?
	.byte 20, 2, 37, 44	; frame 28, head right 266,53
	.byte 22, 3, 37, 50	; frame 30, head up 266,53
	.byte 24, 0, 37, 56	; frame 32, head left 266,53
	.byte 26, 1, 37, 61	; frame 34, head down 266,53
	.byte 28, 2, 37, 67	; frame 36, head right, 266,56
	.byte 30, 3, 37, 73	; frame 38, head up, 266,73
	.byte 32, 0, 37, 79	; frame 40, head left, 259,79
	.byte 34, 1, 37, 85	; frame 42, head down, 259,85
	.byte 36, 2, 37, 97	; frame 44, head right, 259,97
	.byte 38, 3, 37, 98	; frame 46, head up, 259, 98
	.byte 41, 4, 37, 113	; frame 48, baby in water, 259, 113
	.byte 42, 5, 37, 113	; frame 51, splash
	.byte 56, $FF, 37, 113	; frame 52, nothing
	.byte 58, 5, 34, 120	; frame 66, splash, 238,120
	.byte 60, 6, 34, 120	; frame 68, head coming out 238,120
	.byte 65, 7, 34, 120	; frame 70, head more out 238,120
	.byte 67, 8, 34, 121	; frame 75, head down, 238,120
	.byte 71, 9, 33, 122	; frame 77, frame 79, moving left same
	.byte 75, 10,32, 122	; frame 81, frame 83, moving left up
	.byte 79, 9, 31, 123	; 12 frames up
	.byte 83, 10,30, 123
	.byte 87, 9, 29, 124
	.byte 91,10,28, 124
	.byte 95,9, 27, 125
	.byte 99,10,26, 125
	.byte 103,9, 25, 126
	.byte 107,10,24, 126
	.byte 111,9, 23, 127
	.byte 115,10,22, 127	; 154,127 end
	.byte 119,9, 21, 128	; 154,127 end
	.byte 123,10,20, 128	; 154,127 end
	.byte $FF,$FF,0,0


update_top:
	; put peasant text

	lda	#<peasant_text
	sta	OUTL
	lda	#>peasant_text
	sta	OUTH

	jsr	hgr_put_string

	; put score

	jsr	print_score

	rts
