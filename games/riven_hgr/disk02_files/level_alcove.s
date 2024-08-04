; Riven -- Alcove

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
	.include "../zp.inc"
	.include "../hardware.inc"
	.include "../common_defines.inc"
	.include "../qload.inc"
	.include "disk02_defines.inc"

alcove_start:

	;===================
	; init screen
	;===================

;	jsr	TEXT
;	jsr	HOME
	bit	KEYRESET

	bit	SET_GR
	bit	PAGE1
	bit	HIRES
	bit	FULLGR

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

	lda	#<rotate_audio
	sta	ZX0_src
	lda	#>rotate_audio
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

	jsr	update_exit		; update rotation


	jsr	change_location

	jsr     save_bg_14x14           ; save old bg

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

	;==========================
	; update exit
	;==========================

update_exit:
	ldx	ROOM_ROTATION

	lda	room_bg_l,X
	sta	location0+14

	lda	room_bg_h,X
	sta	location0+15

	lda	room_exits,X
	sta	location0+3

	rts

	; rotates clockwise

room_bg_l:
	.byte	<alcove_w_zx02		; opening
	.byte	<alcove3_w_zx02		; blocked
	.byte	<alcove3_w_zx02		; blocked
	.byte	<alcove_w_zx02		; opening
	.byte	<alcove3_w_zx02		; blocked

room_bg_h:
	.byte	>alcove_w_zx02		; opening
	.byte	>alcove3_w_zx02		; blocked
	.byte	>alcove3_w_zx02		; blocked
	.byte	>alcove_w_zx02		; opening
	.byte	>alcove3_w_zx02		; blocked

room_exits:
	.byte	$E3			; 0
	.byte	$FF			; 1
	.byte	$FF			; 2
	.byte	$E3			; 3
	.byte	$FF			; 4


	;==========================
	; alcove button
	;==========================

alcove_button:

	; rotate, mod5

	inc	ROOM_ROTATION
	lda	ROOM_ROTATION
	cmp	#5
	bne	room_no_wrap
	lda	#0
	sta	ROOM_ROTATION

room_no_wrap:

	; update the pointers

	jsr	update_exit

	; display "rotation" animation

	lda	#<alcove2_w_zx02
	sta	ZX0_src
	lda	#>alcove2_w_zx02
	sta	ZX0_src+1

	lda	#$20

	jsr	full_decomp

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

	ldx	#45		; length

	jsr	play_audio

	; read ROM/no-write

	bit	$c08A		; restore language card

done_play_audio:

	; re-display exit graphic

	lda	location0+14
	sta	ZX0_src

	lda	location0+15
	sta	ZX0_src+1

	lda	#$20

	jsr	full_decomp

	; TODO: tail call

	rts

	;==========================
	; includes
	;==========================


.include "graphics_alcove/alcove_graphics.inc"

.include "leveldata_alcove.inc"

.include "../audio.s"

rotate_audio:
	.incbin "audio/rotate.btc.zx02"
