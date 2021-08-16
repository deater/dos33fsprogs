; A Peasant's Quest????

; by Vince `deater` Weaver	vince@deater.net

; with apologies to everyone

.include "hardware.inc"
.include "zp.inc"

.include "qload.inc"


ENDING_COPY = 1


peasant_quest:
	lda	#0
	sta	GAME_OVER

	jsr	hgr_make_tables

	jsr	HGR2		; Hi-res graphics, no text at bottom
				; Y=0, A=0 after this called





	lda	#0
	sta	FRAME

	;=========================
	; init peasant position
	; draw at 18,107

	lda	#18
	sta	PEASANT_X
	lda	#107
	sta	PEASANT_Y

	lda	#PEASANT_DIR_RIGHT
	sta	PEASANT_DIR

	lda	#0
	sta	PEASANT_XADD
	sta	PEASANT_YADD

	; setup map location

	lda	#4
	sta	MAP_X
	lda	#1
	sta	MAP_Y
	jsr	update_map_location


	;=============================
	;=============================
	; new screen location
	;=============================
	;=============================

new_location:
	lda	#0
	sta	GAME_OVER

	;=====================
	; load bg

	ldx	MAP_LOCATION
	lda	map_backgrounds_low,X
	sta	getsrc_smc+1
	lda	map_backgrounds_hi,X
	sta	getsrc_smc+2

	lda	#$40

	jsr	decompress_lzsa2_fast

	; put peasant text

	lda	#<peasant_text
	sta	OUTL
	lda	#>peasant_text
	sta	OUTH

	jsr	hgr_put_string

	; put score

	lda	#<score_text
	sta	OUTL
	lda	#>score_text
	sta	OUTH

	jsr	hgr_put_string


	; draw rectangle on bottom

;	jsr	clear_bottom

;	jsr	hgr_save

	;====================
	; save background

	lda	PEASANT_X
	sta	CURSOR_X
	lda	PEASANT_Y
	sta	CURSOR_Y

	;=======================
	; draw initial peasant

	jsr	save_bg_7x30

	jsr	draw_peasant

game_loop:

	; redraw peasant if moved

	lda	PEASANT_XADD
	ora	PEASANT_YADD
	beq	peasant_the_same

	; restore bg behind peasant

	lda	PEASANT_X
	sta	CURSOR_X

	lda	PEASANT_Y
	sta	CURSOR_Y

	jsr	restore_bg_7x30

	; move peasant

	clc
	lda	PEASANT_X
	adc	PEASANT_XADD
	bmi	peasant_x_negative
	cmp	#40
	bcs	peasant_x_toobig		; bge
	bcc	done_movex

	;============================
peasant_x_toobig:

	inc	MAP_X

	jsr	new_map_location

	lda	#0		; new X location

	jmp	done_movex

	;============================
peasant_x_negative:

	dec	MAP_X

	jsr	new_map_location

	lda	#39		; new X location

	jmp	done_movex

	; check edge of screen
done_movex:
	sta	PEASANT_X


	; Move Peasant Y

	clc
	lda	PEASANT_Y
	adc	PEASANT_YADD
	cmp	#45
	bcc	peasant_y_negative		; blt
	cmp	#150
	bcs	peasant_y_toobig		; bge
	bcc	done_movey


	;============================
peasant_y_toobig:

	inc	MAP_Y

	jsr	new_map_location

	lda	#45		; new X location

	jmp	done_movey


	;============================
peasant_y_negative:

	dec	MAP_Y

	jsr	new_map_location

	lda	#150		; new X location

	jmp	done_movey

	; check edge of screen
done_movey:
	sta	PEASANT_Y




	; save behind new position

	lda	PEASANT_X
	sta	CURSOR_X

	lda	PEASANT_Y
	sta	CURSOR_Y

	jsr	save_bg_7x30

	; draw peasant

	jsr	draw_peasant

peasant_the_same:

;	lda	#3
;	jsr	wait_a_bit

	inc	FRAME

	jsr	check_keyboard

	lda	GAME_OVER
	bmi	oops_new_location
	bne	game_over


	; delay

	lda	#200
	jsr	WAIT


	jmp	game_loop

oops_new_location:
	jmp	new_location


	;************************
	; copy protection check
	;************************
game_over:
exit_copy_check:
	lda	#LOAD_COPY_CHECK
	sta	WHICH_LOAD

	rts


peasant_text:
	.byte 25,2,"Peasant's Quest",0

score_text:
	.byte 0,2,"Score: 0 of 150",0




parse_input:
;	jsr	hgr_save

	lda	input_buffer		; get first char FIXME
	and	#$DF			; make uppercase 0110 0001 -> 0100 0001

parse_copy:
	cmp	#'C'
	bne	parse_look

	; want copy
	lda	#ENDING_COPY
	sta	GAME_OVER
	jmp	done_parse_message


parse_look:
	cmp	#'L'
        bne     parse_talk

        lda     #<fake_error1
        sta     OUTL
        lda     #>fake_error1
	jmp	finish_parse_message


parse_talk:
	cmp	#'T'
        bne     parse_version

        lda     #<fake_error2
        sta     OUTL
        lda     #>fake_error2
	jmp	finish_parse_message


parse_version:
	cmp	#'V'
        bne     parse_help

        lda     #<version_message
        sta     OUTL
        lda     #>version_message
	jmp	finish_parse_message

parse_help:
	lda	#<help_message
	sta	OUTL
	lda	#>help_message

finish_parse_message:
        sta     OUTH
        jsr     hgr_text_box

	jsr	wait_until_keypress

done_parse_message:
	jsr	hgr_partial_restore

	rts

.include "decompress_fast_v2.s"
.include "wait_keypress.s"

.include "draw_peasant.s"

.include "hgr_font.s"
.include "draw_box.s"
.include "hgr_rectangle.s"
.include "hgr_7x30_sprite.s"
.include "hgr_1x5_sprite.s"
;.include "hgr_save_restore.s"
.include "hgr_partial_save.s"
.include "hgr_input.s"
.include "hgr_tables.s"
.include "hgr_text_box.s"

.include "keyboard.s"

.include "wait_a_bit.s"

.include "graphics/graphics.inc"


help_message:
.byte   0,43,24, 0,253,82
.byte   8,41,"I don't understand. Type",13
.byte	     "HELP for assistances.",0

version_message:
.byte   0,43,24, 0,253,82
.byte   8,41,"APPLE ][ PEASANT'S QUEST",13
.byte	     "version 0.2",0


fake_error1:
.byte   0,43,24, 0,253,82
.byte   8,41,"?SYNTAX ERROR IN 1020",13
.byte	     "]",127,0

fake_error2:
.byte   0,43,24, 0,253,82
.byte   8,41,"?UNDEF'D STATEMENT ERROR",13
.byte	     "]",127,0


clear_bottom:
	; draw rectangle

	lda     #$00            ; color is black1
	sta     VGI_RCOLOR

	lda     #0
	sta     VGI_RX1
	lda     #183
	sta     VGI_RY1
	lda	#140
	sta	VGI_RXRUN
	lda	#9
        sta     VGI_RYRUN

        jsr     vgi_simple_rectangle

	lda     #140
	sta     VGI_RX1
	lda     #183
	sta     VGI_RY1
	lda	#140
	sta	VGI_RXRUN
	lda	#9
        sta     VGI_RYRUN

        jsr     vgi_simple_rectangle

	rts


	;=====================
	;
	;=====================
new_map_location:
	lda	#$FF
	sta	GAME_OVER

	; fall through

	;==================
	; update map
	;	on main map, it's (MAP_Y*5)+MAP_X
update_map_location:
	; put in map

map_wrap_x:
	; wrap X (0..4)
	lda	MAP_X
	bmi	map_x_went_negative
	cmp	#5
	bcc	map_wrap_y		; blt

	lda	#0
	beq	update_map_x		; bra

map_x_went_negative:
	lda	#4

update_map_x:
	sta	MAP_X

map_wrap_y:

	; wrap Y (0..3)
	lda	MAP_Y
	and	#$3
	sta	MAP_Y

	clc
	lda	MAP_Y
	asl
	asl
	adc	MAP_Y
	adc	MAP_X

	sta	MAP_LOCATION

	rts


map_backgrounds_low:
	.byte	<todo_lzsa	; 0
	.byte	<todo_lzsa	; 1
	.byte	<todo_lzsa	; 2
	.byte	<waterfall_lzsa	; 3	-- temp intentional bug
	.byte	<waterfall_lzsa	; 4	-- waterfall
	.byte	<todo_lzsa	; 5
	.byte	<todo_lzsa	; 6
	.byte	<todo_lzsa	; 7
	.byte	<river_lzsa	; 8	-- river
	.byte	<knight_lzsa	; 9	-- knight
	.byte	<todo_lzsa	; 10
	.byte	<cottage_lzsa	; 11	-- cottage
	.byte	<lake_w_lzsa	; 12	-- lake west
	.byte	<lake_e_lzsa	; 13	-- lake east
	.byte	<inn_lzsa	; 14	-- inn
	.byte	<todo_lzsa	; 15
	.byte	<todo_lzsa	; 16
	.byte	<todo_lzsa	; 17
	.byte	<todo_lzsa	; 18
	.byte	<todo_lzsa	; 19

map_backgrounds_hi:
	.byte	>todo_lzsa	; 0
	.byte	>todo_lzsa	; 1
	.byte	>todo_lzsa	; 2
	.byte	>todo_lzsa	; 3
	.byte	>waterfall_lzsa	; 4	-- waterfall
	.byte	>todo_lzsa	; 5
	.byte	>todo_lzsa	; 6
	.byte	>todo_lzsa	; 7
	.byte	>river_lzsa	; 8	-- river
	.byte	>knight_lzsa	; 9	-- knight
	.byte	>todo_lzsa	; 10
	.byte	>cottage_lzsa	; 11	-- cottage
	.byte	>lake_w_lzsa	; 12	-- lake west
	.byte	>lake_e_lzsa	; 13	-- lake east
	.byte	>inn_lzsa	; 14	-- inn
	.byte	>todo_lzsa	; 15
	.byte	>todo_lzsa	; 16
	.byte	>todo_lzsa	; 17
	.byte	>todo_lzsa	; 18
	.byte	>todo_lzsa	; 19

