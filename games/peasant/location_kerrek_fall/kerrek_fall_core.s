; Peasant's Quest

; Downfall of the Kerrek

; separate file as can't really fit all 22k of sprites
; in the normal space

; by Vince `deater` Weaver	vince@deater.net

.include "../location_common/include_common.s"

;VERB_TABLE = kerrek_verb_table

kerrek_fall:

        ;=======================
	; load proper sprites
	;=======================

;	jsr	load_shooting_sprites

;	jsr	load_kerrek_walking_sprites

;	jsr	load_kerrek_hit_sprites

	jsr	patch_sprite_tables

        ;=======================
	; draw header offscreen
	;=======================

	lda	DRAW_PAGE
	sta	DRAW_PAGE_SAVE

	lda	#$40			; draw to $6000
	sta	DRAW_PAGE

        ; put peasant text

        lda     #<peasant_text
        sta     OUTL
        lda     #>peasant_text
        sta     OUTH

        jsr     hgr_put_string

	; update / print score

	jsr	update_score

	jsr	print_score

	; show prompt

	jsr	setup_prompt


	lda	DRAW_PAGE_SAVE
	sta	DRAW_PAGE


	;================================
	; setup pointer to update_screen

	lda	#<update_screen
	sta	update_screen_smc+1
	lda	#>update_screen
	sta	update_screen_smc+2




	;========================================
	;========================================
	;========================================
	; main loop
	;========================================
	;========================================
	;========================================

game_loop:

	;==================================
	; do the shooting animation

	jsr	draw_peasant_bow


	;=================================
	; done with animation


	; actual game happenings:
	;  kerrek falls
	;	"arrowed!" message and score goes up
	;	three peals of thunder, BOOM (pause) BOOM (pause) BOOM (pause)
	;	"a light rain" message appears while the rain starts in bg

	; turn peasant back on
	;	real game keep holding bow until moved??

	lda	SUPPRESS_DRAWING
	and	#<(~SUPPRESS_PEASANT)
	sta	SUPPRESS_DRAWING

	; update score
	lda	#5
	jsr	score_points

	; print "arrowed" message
	ldx	#<kerrek_kill_message2
	ldy	#>kerrek_kill_message2
	jsr	partial_message_step

	; make kerrek dead

	lda	GAME_STATE_3
	ora	#KERREK_DEAD
	sta	GAME_STATE_3

	; pause a bit

	lda	#1
	jsr	wait_a_bit

	; sound: three thunders

	jsr     thunder_sound

	; pause

	lda	#5
	jsr	wait_a_bit

	jsr     thunder_sound

	; pause
	lda	#5
	jsr	wait_a_bit

	jsr     thunder_sound

	; make the puddle wet

	lda	GAME_STATE_1
	ora	#(PUDDLE_WET)
	sta	GAME_STATE_1

	; start the rain
	; we should start the rain *before* / while message shown

	lda	#6			; should this be 5?
	sta	RAIN_COUNT

	; print rain message

	ldx     #<kerrek_kill_message3
	ldy     #>kerrek_kill_message3
	jsr	partial_message_step




	;==========================================
	; return to level we were called from

	; this sets WHICH_LOAD to proper place

	lda	PREVIOUS_LOCATION
	jsr	update_map_location

	; skip updating our location as if we were
	; loading from save game

	lda	#NEW_FROM_LOAD
	sta	LEVEL_OVER

	;========================
	; exit level
	;========================
oops_new_location:
level_over:

	;===============================
	; handle end of level
	;===============================

.include "../location_common/end_of_level_common.s"


really_level_over:

	;===========================================
	; HACK!  adjust kerrek body position
	;	where we draw it here is slightly different
	;	than where the kerrek1/kerrek2 code draws it

	; left ff/right fb		y draws+34
	;				kerrek1 adds 40?

	lda	KERREK_Y
	clc
	adc	#$FA
	sta	KERREK_Y

	lda	KERREK_STATE
	and	#KERREK_DIRECTION       ; 0 = left
	beq	kerrek_body_x_adjust_left


kerrek_body_x_adjust_right:

	clc
	lda	KERREK_X
	adc	#$fb
	jmp	done_kerrek_body_x_adjust

kerrek_body_x_adjust_left:
	clc
	lda	KERREK_X
	adc	#$ff

done_kerrek_body_x_adjust:
	sta	KERREK_X

	rts



.include "../location_common/include_bottom.s"

.include "../wait_a_bit.s"
.include "../hgr_routines/hgr_sprite.s"
.include "../hgr_routines/hgr_sprite_mask.s"
.include "kerrek_fall_actions.s"

.include "../sound/mud_splat.s"
.include "../sound/thunder.s"
.include "../sound/raise_up.s"
.include "../sound/falling.s"
.include "../sound/arrow_shoot.s"

;.include "sprites_kerrek_fall/kerrek_walk_sprites_right.inc"
;.include "sprites_kerrek_fall/kerrek_walk_sprites_left.inc"
;.include "sprites_kerrek_fall/kerrek_hit_sprites.inc"
;.include "sprites_kerrek_fall/peasant_shoot_sprites_left.inc"
;.include "sprites_kerrek_fall/peasant_shoot_sprites_right.inc"
;.include "load_shooting_sprites.s"

.include "patch_sprite_table.s"

	;==========================
	; update screen
	;==========================
update_screen:


	;===========================
	; copy bg to current screen

	jsr	hgr_copy_faster


	; peasant is ~30 tall, kerrek ~48 tall
	sec
	lda	PEASANT_Y
	sbc	#18
	cmp	KERREK_Y
	bcs	kerrek1_draw_kerrek_first

kerrek1_draw_peasant_first:

	lda	SUPPRESS_DRAWING
	and	#SUPPRESS_PEASANT
	bne	skip_draw_peasant_first

	jsr	draw_peasant
skip_draw_peasant_first:
	jsr	kerrek_draw		; draw kerrek

	rts

kerrek1_draw_kerrek_first:

	jsr	kerrek_draw		; draw kerrek

	lda	SUPPRESS_DRAWING
	and	#SUPPRESS_PEASANT
	bne	skip_draw_peasant_second
	jsr	draw_peasant
skip_draw_peasant_second:

	jsr	draw_rain

	rts





; FIXME: use the compressed versions of these to save a few bytes


kerrek_kill_message2:
.byte "ARROWED!! Nice shot. You",13
.byte "smote the Kerrek! He lay",13
.byte "there stinking.",0

; start the rain

; pause
kerrek_kill_message3:
.byte "A light rain heralds the",13
.byte "washing free of the",13
.byte "Kerrek's grip on the land.",13
.byte "You're feeling pretty",13
.byte "good, though, so the",13
.byte "artless symbolism doesn't",13
.byte "bug you.",0
