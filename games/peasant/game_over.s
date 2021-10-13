; IT'S OVER!!!!!!!!

; game over screen for peasant's quest

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

	; pause a bit at first

	lda	#10
	jsr	wait_a_bit

	; loop through

	lda	#0
	sta	FRAME
animate_loop:

	lda	#19
	sta	CURSOR_X
	lda	#116
	sta	CURSOR_Y

	ldx	FRAME
	lda	animation_steps_l,X
	sta	INL

	ldx	FRAME
	lda	animation_steps_h,X
	sta	INH

	jsr	hgr_draw_sprite

	; play tone
	ldx	FRAME
	lda	animation_notes,X
	bne	make_beep

	; delay instead
	lda	#2
	jsr	wait_a_bit
	jmp	done_beep

make_beep:

	sta	speaker_frequency
	lda	animation_note_lens,X
	sta	speaker_duration
	jsr	speaker_beep

	ldx	FRAME
	lda	animation_pause_lens,X
	jsr	wait_a_bit

done_beep:
;	jsr	wait_until_keypress

	inc	FRAME
	lda	FRAME
	cmp	#15
	bne	animate_loop


	;=====================
	; play music

	; G FF EE D C (an octave lower for the C?)

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

.include "hgr_sprite.s"
.include "speaker_beeps.s"

.include "wait_keypress.s"

.include "score.s"

.include "wait.s"
.include "wait_a_bit.s"

.include "loadsave_menu.s"

.include "graphics_over/game_over_graphics.inc"

.include "graphics_over/game_over_animation.inc"

game_over_text:
.byte 34,"Thanks so much for playing",13
.byte "this game here! Don't get too",13
.byte "frustrated. Take some time",13
.byte "for yourself. Have a refreshing",13
.byte "coffee. Relax. Then come back",13
.byte "and try again maybe!",34,13
.byte "          -The Videlectrix Guys",0


animation_steps_l:
	.byte <over_anim0
	.byte <over_anim1
	.byte <over_anim2
	.byte <over_anim3
	.byte <over_anim4
	.byte <over_anim5
	.byte <over_anim6
	.byte <over_anim7
	.byte <over_anim8
	.byte <over_anim8
	.byte <over_anim8
	.byte <over_anim8
	.byte <over_anim9
	.byte <over_anim10
	.byte <over_anim11

animation_steps_h:
	.byte >over_anim0	; face
	.byte >over_anim1	; shoulders
	.byte >over_anim2	; waist
	.byte >over_anim3	; thighs
	.byte >over_anim4	; ankles
	.byte >over_anim5	; all
	.byte >over_anim6	; fall1
	.byte >over_anim7	; fall2
	.byte >over_anim8	; skull float
	.byte >over_anim8	; skull float
	.byte >over_anim8	; skull float
	.byte >over_anim8	; skull float
	.byte >over_anim9	; skull fall
	.byte >over_anim10	; skull mostly
	.byte >over_anim11	; skull down

animation_notes:
	.byte	NOTE_G4	; 0
	.byte	NOTE_F4	; 1
	.byte	NOTE_F4	; 2
	.byte	NOTE_E4	; 3
	.byte	NOTE_E4	; 4
	.byte	NOTE_D4	; 5
	.byte	NOTE_C4	; 6
	.byte	0	; 7
	.byte	0	; 8
	.byte	0	; 8
	.byte	0	; 8
	.byte	0	; 8
	.byte	0	; 9
	.byte	NOTE_C3	; 10
	.byte	0	; 11

animation_note_lens:
	.byte	150	;	NOTE_G4	; 0
	.byte	50	;	NOTE_F4	; 1
	.byte	100	;	NOTE_F4	; 2
	.byte	50	;	NOTE_E4	; 3
	.byte	100	;	NOTE_E4	; 4
	.byte	50	;	NOTE_D4	; 5
	.byte	150	;	NOTE_C4	; 6
	.byte	0	; 7
	.byte	0	; 8
	.byte	0	; 8
	.byte	0	; 8
	.byte	0	; 8
	.byte	0	; 9
	.byte	150	;	NOTE_C3	; 10
	.byte	0	; 11

animation_pause_lens:
	.byte	1	;	NOTE_G4	; 0
	.byte	1	;	NOTE_F4	; 1
	.byte	1	;	NOTE_F4	; 2
	.byte	1	;	NOTE_E4	; 3
	.byte	1	;	NOTE_E4	; 4
	.byte	1	;	NOTE_D4	; 5
	.byte	1	;	NOTE_C4	; 6
	.byte	0	; 7
	.byte	0	; 8
	.byte	0	; 8
	.byte	0	; 8
	.byte	0	; 8
	.byte	0	; 9
	.byte	1	;	NOTE_C3	; 10
	.byte	0	; 11

