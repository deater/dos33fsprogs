; Peasant's Quest Trgodor scene

; From when the sword hits Trogdor on

; by Vince `deater` Weaver	vince@deater.net

.include "hardware.inc"
.include "zp.inc"

.include "qload.inc"

trogdor:
	lda	#0
	sta	GAME_OVER

	jsr	setup_speech

	jsr	hgr_make_tables

	jsr	hgr2


	lda	#0
	sta	FRAME

	; update score

	jsr	update_score

trogdor_cave:

	lda	#<trogdor_cave_lzsa
	sta	getsrc_smc+1
	lda	#>trogdor_cave_lzsa
	sta	getsrc_smc+2

	lda	#$40

	jsr	decompress_lzsa2_fast

	;======================
	; draw rather dashing

	lda	#12
	sta	CURSOR_X
	lda	#142
	sta	CURSOR_Y

	lda	#<dashing0_sprite
	sta	INL
	lda	#>dashing0_sprite
	sta	INH

	jsr	hgr_draw_sprite


	jsr	update_top

	jsr	wait_until_keypress

	;==============================
	;==============================
	; print honestly say message
	;==============================
	;==============================

	lda	#<trogdor_string
	sta	OUTL
	lda	#>trogdor_string
	sta     OUTH
        jsr     hgr_text_box

	;==================================
	; text to speech, where available!

speech_loop:

        ; trogdor

        lda     #<trogdor_honestly
        sta     SPEECH_PTRL
        lda     #>trogdor_honestly
        sta     SPEECH_PTRH

        jsr     ssi263_speak

wait_for_speech:
	lda	speech_busy
	bmi	wait_for_speech


;	jsr	wait_until_keypress

	jsr	hgr_partial_restore


	;==============================
	;==============================
	; print nice of him message
	;==============================
	;==============================

	lda	#<trogdor_string2
	sta	OUTL
	lda	#>trogdor_string2
	sta     OUTH
        jsr     hgr_text_box

	jsr	wait_until_keypress

	jsr	hgr_partial_restore


	; UPDATE SCORE

	lda	#$43
	sta	SCORE_TENSONES
	jsr	update_score

;	jsr	update_top


	;===========================
	; weep-boom sound

	lda     #32
        sta     speaker_duration
        lda     #NOTE_E4
        sta     speaker_frequency
        jsr     speaker_beep
	lda     #64
        sta     speaker_duration
        lda     #NOTE_F4
        sta     speaker_frequency
        jsr     speaker_beep
	lda     #128
        sta     speaker_duration
        lda     #NOTE_F3
        sta     speaker_frequency
        jsr     speaker_beep

trogdor_open:

	lda	#<trogdor_open_lzsa
	sta	getsrc_smc+1
	lda	#>trogdor_open_lzsa
	sta	getsrc_smc+2

	lda	#$40

	jsr	decompress_lzsa2_fast

	;======================
	; draw rather dashing

	lda	#12
	sta	CURSOR_X
	lda	#142
	sta	CURSOR_Y

	lda	#<dashing0_sprite
	sta	INL
	lda	#>dashing0_sprite
	sta	INH

	jsr	hgr_draw_sprite

	jsr	update_top

;	jsr	wait_until_keypress


trogdor_flame1:

	lda	#<trogdor_flame1_lzsa
	sta	getsrc_smc+1
	lda	#>trogdor_flame1_lzsa
	sta	getsrc_smc+2

	lda	#$40

	jsr	decompress_lzsa2_fast

trogdor_flame2:

	lda	#<trogdor_flame2_lzsa
	sta	getsrc_smc+1
	lda	#>trogdor_flame2_lzsa
	sta	getsrc_smc+2

	lda	#$20

	jsr	decompress_lzsa2_fast


	ldx	#32
	stx	BABY_COUNT

burninate_loop:
	bit	PAGE1

	lda     #16
        sta     speaker_duration
        lda     #NOTE_C3
        sta     speaker_frequency
        jsr     speaker_beep

;	jsr	wait_until_keypress

	bit	PAGE2

	lda     #16
        sta     speaker_duration
        lda     #NOTE_D3
        sta     speaker_frequency
        jsr     speaker_beep

;	jsr	wait_until_keypress

	dec	BABY_COUNT
	bne	burninate_loop


	;=====================
	;=====================
	; stop fire
	; open mount
	; charred
	; smoke

	lda	#<trogdor_cave_lzsa
	sta	getsrc_smc+1
	lda	#>trogdor_cave_lzsa
	sta	getsrc_smc+2

	lda	#$40

	jsr	decompress_lzsa2_fast

	jsr	update_top

	;======================
	; draw rather dashing

	lda	#12
	sta	CURSOR_X
	lda	#142
	sta	CURSOR_Y

	lda	#1
	sta	BABY_COUNT

dashing_loop:

	ldy	BABY_COUNT
	lda	dashing_progress_l,Y
	sta	INL
	lda	dashing_progress_h,Y
	sta	INH

	jsr	hgr_draw_sprite

	lda	#220
	jsr	wait

	ldy	BABY_COUNT
	cpy	#7
	bne	no_boom

	lda     #64
        sta     speaker_duration
        lda     #NOTE_C3
        sta     speaker_frequency
        jsr     speaker_beep

no_boom:

	inc	BABY_COUNT
	lda	BABY_COUNT
	cmp	#9
	bne	dashing_loop


	; collapse with boom

	;==================
	; message

	lda	#<trogdor_string3
	sta	OUTL
	lda	#>trogdor_string3
	sta     OUTH
        jsr     hgr_text_box

	jsr	wait_until_keypress

game_over:




	; go to end credits

	lda     #LOAD_ENDING
        sta     WHICH_LOAD

        rts


peasant_text:
	.byte 25,2,"Peasant's Quest",0


;.include "decompress_fast_v2.s"
.include "wait_keypress.s"



;.include "hgr_font.s"
;.include "draw_box.s"
;.include "hgr_rectangle.s"

;.include "hgr_1x5_sprite.s"

;.include "draw_peasant.s"
;.include "hgr_7x28_sprite_mask.s"
;.include "hgr_save_restore.s"

;.include "hgr_partial_save.s"
;.include "hgr_input.s"
;.include "hgr_tables.s"
;.include "hgr_text_box.s"
;.include "clear_bottom.s"
;.include "gr_offsets.s"
;.include "hgr_hgr2.s"

.include "gr_copy.s"

.include "score.s"

.include "wait.s"
.include "wait_a_bit.s"

.include "version.inc"

.include "speaker_beeps.s"

.include "hgr_sprite.s"

.include "ssi263_simple_speech.s"
.include "trogdor_speech.s"

.include "graphics_trogdor/trogdor_graphics.inc"

.include "sprites/trogdor_sprites.inc"

trogdor_string:
	.byte   0,43,32, 0,253,82
	.byte   8,41
	.byte 34,"I can honestly say it'll",13
	.byte "be a pleasure and an honor",13
	.byte "to burninate you, Rather",13
	.byte "Dashing.",34,0

trogdor_string2:
	.byte   0,43,32, 0,253,66
	.byte   8,41
	.byte "Aw that sure was nice of",13
	.byte "him!",0

trogdor_string3:
	.byte   0,43,32, 0,253,90
	.byte   8,41
	.byte "Congratulations! You've",13
	.byte "won! No one can kill",13
	.byte "Trogdor but you came closer",13
	.byte "than anybody ever! Way to",13
	.byte "go!",0


update_top:
        ; put peasant text

        lda     #<peasant_text
        sta     OUTL
        lda     #>peasant_text
        sta     OUTH

        jsr     hgr_put_string

        ; put score

        jsr     print_score

        rts


dashing_progress_l:
	.byte <dashing0_sprite,<dashing1_sprite,<dashing2_sprite
	.byte <dashing3_sprite,<dashing4_sprite,<dashing5_sprite
	.byte <dashing6_sprite,<dashing7_sprite,<dashing8_sprite

dashing_progress_h:
	.byte >dashing0_sprite,>dashing1_sprite,>dashing2_sprite
	.byte >dashing3_sprite,>dashing4_sprite,>dashing5_sprite
	.byte >dashing6_sprite,>dashing7_sprite,>dashing8_sprite


