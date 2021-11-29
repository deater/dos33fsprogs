
; Peasant's Quest Ending

; The credits scenes

; by Vince `deater` Weaver	vince@deater.net

.include "hardware.inc"
.include "zp.inc"

.include "qload.inc"
.include "music.inc"

ending:

	jsr	hgr_make_tables

	jsr	hgr2


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

	; only if mockingboard enabled
	lda     SOUND_STATUS
        and     #SOUND_MOCKINGBOARD
        beq     skip_end_music

	jsr	mockingboard_init
	jsr	reset_ay_both

	jsr	mockingboard_setup_interrupt

	lda	#$09			; don't end after 4
	sta	PT3_LOC+$C9+$4

	; 2??
	lda	#$3			; set LOOP to 2
	sta	PT3_LOC+$66

	jsr	pt3_init_song

	cli
skip_end_music:

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
	lda     #98
	sta     VGI_RY1
	lda	#202
	sta	VGI_RXRUN
	lda	#20
        sta     VGI_RYRUN
        jsr     vgi_simple_rectangle

	lda     #214
	sta     VGI_RX1
	lda     #98
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


	lda	#1
	sta	CURSOR_X
	lda	#52
	sta	CURSOR_Y

	lda	#0
	sta	BABY_COUNT
boat_loop:

	; play sound effect
	lda	BABY_COUNT
	cmp	#7
	bcc	no_sound
	cmp	#11
	bcs	no_sound

	cmp	#10
	beq	bloop

click:
	lda	#NOTE_C3
	sta	speaker_frequency
	lda	#6
	sta	speaker_duration
	jsr	speaker_beep
	jmp	no_sound

bloop:
	lda	#10
	sta	speaker_duration
	lda	#NOTE_C4
	sta	speaker_frequency
	jsr	speaker_beep

	lda	#10
	sta	speaker_duration
	lda	#NOTE_D4
	sta	speaker_frequency
	jsr	speaker_beep

	lda	#10
	sta	speaker_duration
	lda	#NOTE_E4
	sta	speaker_frequency
	jsr	speaker_beep

	lda	#10
	sta	speaker_duration
	lda	#NOTE_D4
	sta	speaker_frequency
	jsr	speaker_beep

	lda	#10
	sta	speaker_duration
	lda	#NOTE_C4
	sta	speaker_frequency
	jsr	speaker_beep
	jmp	no_sound



no_sound:


	ldy	BABY_COUNT
	lda	boat_progress_l,Y
	sta	INL
	lda	boat_progress_h,Y
	sta	INH

	jsr	hgr_draw_sprite

	lda	#4
	jsr	wait_a_bit

;	jsr	wait_until_keypress

	inc	BABY_COUNT
	lda	BABY_COUNT
	cmp	#14
	bne	boat_loop

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
	;====================
	; also animate waterfall

	lda	CURSOR_X
	pha
	lda	CURSOR_Y
	pha

	lda	#36
	sta	CURSOR_X
	lda	#93
	sta	CURSOR_Y

	lda	FRAME
	and	#$4
	beq	do_foam1

do_foam0:
	lda	#<foam0
	sta	INL
	lda	#>foam0
	jmp	do_foam
do_foam1:
	lda	#<foam1
	sta	INL
	lda	#>foam1
do_foam:
	sta	INH
	jsr	hgr_draw_sprite

	pla
	sta	CURSOR_Y
	pla
	sta	CURSOR_X

	;====================
	; actually draw baby

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
	jsr	wait

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

	lda	#<jhonka_string
	sta	OUTL
	lda	#>jhonka_string
	sta	OUTH

	jsr	disp_put_string

	;=================
	; animate jhonka

	; repeats 12 times

	lda	#19
	sta	CURSOR_X
	lda	#83
	sta	CURSOR_Y

	lda	#13
	sta	BABY_COUNT

animation_loop:

	lda	#<jhonka1
	sta	INL
	lda	#>jhonka1
	sta	INH

	jsr	hgr_draw_sprite

	lda	#2
	jsr	wait_a_bit

	lda	#<jhonka2
	sta	INL
	lda	#>jhonka2
	sta	INH

	jsr	hgr_draw_sprite

	lda	#2
	jsr	wait_a_bit


	dec	BABY_COUNT

	bne	animation_loop

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



; moved to qload

;.include "decompress_fast_v2.s"
;.include "hgr_font.s"
;.include "draw_box.s"
;.include "hgr_rectangle.s"
;.include "hgr_1x5_sprite.s"
;.include "hgr_partial_save.s"
;.include "hgr_input.s"
;.include "hgr_tables.s"
;.include "hgr_text_box.s"
;.include "wait_keypress.s"
;.include "hgr_hgr2.s"

.include "hgr_2x14_sprite_mask.s"
.include "hgr_sprite.s"


;.include "score.s"

.include "wait.s"
.include "wait_a_bit.s"

.include "speaker_beeps.inc"

.include "graphics_end/ending_graphics.inc"

.include "sprites/ending_sprites.inc"

boat_string:
	.byte 2,100
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


boat_progress_l:
	.byte <boat0,<boat1
	.byte <boat0,<boat1
	.byte <boat0,<boat1
	.byte <boat2,<boat3,<boat3
	.byte <boat4,<boat5,<boat6,<boat7,<boat7

boat_progress_h:
	.byte >boat0,>boat1
	.byte >boat0,>boat1
	.byte >boat0,>boat1
	.byte >boat2,>boat3,>boat3
	.byte >boat4,>boat5,>boat6,>boat7,>boat7


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
