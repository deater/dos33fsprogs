; Riven -- chair room

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
	.include "../zp.inc"
	.include "../hardware.inc"
	.include "../common_defines.inc"
	.include "../qload.inc"
	.include "disk05_defines.inc"

chair_start:

	;===================
	; init screen
	;===================

;	bit	KEYRESET

;	bit	SET_GR
;	bit	PAGE1
;	bit	HIRES
;	bit	FULLGR

	;===============================
	; load sound into language card
	;===============================

	lda	SOUND_STATUS
	and	#SOUND_IN_LC
	beq	do_not_load_audio

	; load sounds into LC

	; read ram, write ram, use $d000 bank1
	bit	$C08B
	bit	$C08B

	lda	#<chair_close_audio
	sta	ZX0_src
	lda	#>chair_close_audio
	sta	ZX0_src+1

	lda	#$D0    ; decompress to $D000

	jsr	full_decomp

	; read rom, nowrite, use $d000 bank1
	bit	$C08A

do_not_load_audio:

	;========================
	; set up location
	;========================

	lda	#<locations
	sta	LOCATIONS_L
	lda	#>locations
	sta	LOCATIONS_H

	lda	#0
	sta	DRAW_PAGE
	sta	LEVEL_OVER

	lda	#0
	sta	JOYSTICK_ENABLED
	sta	UPDATE_POINTER

	lda	#1
	sta	CURSOR_VISIBLE

	lda	#20
	sta	CURSOR_X
	sta	CURSOR_Y




	;===================================
	; init
	;===================================


	jsr	change_location

	jsr     save_bg_14x14           ; save old bg

	;===================
	; init screen
	;===================

	bit	KEYRESET

	bit	SET_GR
	bit	PAGE1
	bit	HIRES
	bit	FULLGR


game_loop:

	;===================================
	; draw pointer
	;===================================

	jsr	draw_pointer

	;===================================
	; handle keypress/joystick
	;===================================

	jsr	handle_keypress

	;===================================
	; increment frame count
	;===================================

	inc	FRAMEL
	bne	frame_no_oflo

	inc	FRAMEH
frame_no_oflo:

	;====================================
	; check level over
	;====================================

	lda	LEVEL_OVER
	bne	really_exit

	jmp	game_loop

really_exit:

	rts


	;===================================
	; play exit audio
	;===================================

play_exit_audio:

	; only play sound if language card

	lda	SOUND_STATUS
	and	#SOUND_IN_LC
	bne	do_play_audio

	; wait a bit instead

	ldx	#20
	jsr	wait_50xms

	jmp	done_play_audio

do_play_audio:
	; switch in language card
	; read/write RAM $d000 bank 1

	bit	$C08B
	bit	$C08B

	; call the btc player

	lda	#$00
	sta	BTC_L

	lda	#$D0
	sta	BTC_H

	ldx	#36		; length

	jsr	play_audio

	; read ROM/no-write

	bit	$c08A		; restore language card

done_play_audio:


	lda	#RIVEN_ENTRANCE
	sta     LOCATION

        lda     #LOAD_CHAIR
        sta     WHICH_LOAD

        lda     #DIRECTION_S
        sta     DIRECTION

        lda     #1
        sta     LEVEL_OVER

        rts


	;==========================
	; includes
	;==========================


.include "graphics_chair/chair_graphics.inc"

.include "leveldata_chair.inc"

	.include "../audio.s"

chair_close_audio:
	.incbin	"audio/chair_close.btc.zx02"




