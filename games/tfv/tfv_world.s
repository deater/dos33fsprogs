	; TFV world
	; the main part of the game


.include "zp.inc"
.include "hardware.inc"
.include "common_defines.inc"

	;================================
	; Clear screen and setup graphics
	;================================

	;================================
	; Init Variables
	;================================

	jsr	init_multiply_tables

	;=====================
	; Handle Overworld
	;=====================

	jsr	handle_overworld

	;=====================
	; Game Over
	;=====================
	; return to title screen?

	jsr	game_over

	lda	#LOAD_TITLE
	sta	WHICH_LOAD

	rts


;===============================================
; External modules
;===============================================

.include "tfv_drawmap.s"
.include "tfv_overworld.s"
.include "tfv_game_over.s"
.include "help_overworld.s"


.include "gr_fast_clear.s"
.include "gr_hlin.s"
.include "gr_vlin.s"
.include "gr_pageflip.s"
.include "gr_put_num.s"
.include "keyboard.s"
.include "joystick.s"
.include "gr_putsprite_crop.s"
.include "gr_putsprite_mask.s"
.include "text_print.s"
.include "gr_copy.s"
.include "decompress_fast_v2.s"
.include "gr_offsets.s"
.include "wait_keypressed.s"
.include "long_wait.s"

;===============================================
; Battle
;===============================================

.include "tfv_battle.s"
.include "tfv_battle_menu.s"
.include "tfv_battle_attack.s"
.include "tfv_battle_enemy.s"
.include "tfv_battle_magic.s"
.include "tfv_battle_limit.s"
.include "tfv_battle_summons.s"
.include "tfv_battle_boss.s"
.include "tfv_battle_draw_hero.s"

.include "rotate_intro.s"
.include "rotozoom.s"
.include "multiply_fast.s"
.include "c00_scrn_offsets.s"

;===============================================
; Graphics
;===============================================

.include "tfv_sprites.inc"
.include "battle_sprites.inc"
.include "graphics_map/tfv_backgrounds.inc"
.include "graphics_battle/battle_graphics.inc"

;===============================================
; Sound
;===============================================
.include "sound_effects.s"
.include "speaker_tone.s"
