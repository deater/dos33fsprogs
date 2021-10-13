; Game Over Screen

; by Vince `deater` Weaver	vince@deater.net

.include "hardware.inc"
.include "zp.inc"

.include "qload.inc"


game_over:
	lda	#0
	sta	GAME_OVER
	sta	FRAME

	jsr	hgr_make_tables

	jsr	hgr2		; Hi-res graphics, no text at bottom
				; Y=0, A=0 after this called


	; update score

	jsr	update_score


	;===========================
	; draw game over background
	;===========================

	lda	#<game_over_lzsa
	sta	getsrc_smc+1
	lda	#>game_over_lzsa
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

	jsr	print_score

	;=====================
	; animate ending

	; TODO

	;=====================
	; play music

	; TODO

	jsr	wait_until_keypress

	;=====================
	; draw videlectrix

	lda	#<videlectrix_lzsa
	sta	getsrc_smc+1
	lda	#>videlectrix_lzsa
	sta	getsrc_smc+2

	lda	#$40

	jsr	decompress_lzsa2_fast

	lda	#<game_over_text
	sta	OUTL
	lda	#>game_over_text
	sta	OUTH

	lda	#8
	sta	CURSOR_X

	lda	#136
        sta     CURSOR_Y

        jsr     disp_put_string_cursor



	jsr	load_menu

	rts

;forever:
;	jmp	forever

.include "wait_keypress.s"

;.include "draw_peasant.s"

;.include "gr_copy.s"

;.include "new_map_location.s"

;.include "peasant_move.s"

;.include "parse_input.s"

;.include "inventory.s"

.include "score.s"

;.include "keyboard.s"

.include "wait.s"
.include "wait_a_bit.s"

;.include "version.inc"

.include "loadsave_menu.s"

.include "graphics_over/game_over_graphics.inc"

game_over_text:
.byte "Thanks so much for playing",13
.byte "this game here! Don't get too",13
.byte "frustrated. Take some time",13
.byte "for yourself. Have a refreshing",13
.byte "coffee. Relax. Then come back",13
.byte "and try again maybe!",13
.byte "          -The Videlectrix Guys",0

