; The Chair lo-res movie

; by deater (Vince Weaver) <vince@deater.net>

.include "../zp.inc"
.include "../hardware.inc"
.include "../qload.inc"

.include "disk05_defines.inc"

NUM_OVERLAYS	= 15

captured_bg = chair_base

chair_start:

	;===================
        ; Setup lo-res graphics
        ;===================

	; clear it first

	jsr	clear_gr_all

        bit     SET_GR
        bit     LORES
        bit     FULLGR
        bit     PAGE1

        lda     #0
        sta     SCENE_COUNT

        lda     #4
        sta     DRAW_PAGE

        bit     KEYRESET

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

	lda	#<chair_open_audio
	sta	ZX0_src
	lda	#>chair_open_audio
	sta	ZX0_src+1

	lda	#$D0    ; decompress to $D000

	jsr	full_decomp

	; read rom, nowrite, use $d000 bank1
	bit	$C08A

do_not_load_audio:


	;===============================
	;===============================
	; chair opens
	;===============================
	;===============================

	lda	#<chair_base
	sta	scene_bg_l_smc+1

	lda	#>chair_base
	sta	scene_bg_h_smc+1

	lda	#0
	sta	WHICH_OVERLAY
chair_loop:

	; see if play sound

	lda	WHICH_OVERLAY
	cmp	#1
	bne	no_open_sound

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

	ldx	#44		; length

	jsr	play_audio

	; read ROM/no-write

	bit	$c08A		; restore language card

done_play_audio:



no_open_sound:

	; draw scene with overlay
	; switch background

	lda	WHICH_OVERLAY

	jsr	draw_scene

	; flip pages

	jsr	flip_pages

	inc	WHICH_OVERLAY
	lda	WHICH_OVERLAY
	cmp	#NUM_OVERLAYS
	beq	done_chair

	; in theory we are 5 fps, so 200ms here
	;	wait_a_bit is *50? so should be 4?

	ldx	#3
	jsr	wait_a_bit

	jmp	chair_loop


done_chair:


	;======================
	; done, move on to next
	;======================

	bit     KEYRESET

	lda     #LOAD_CHAIR
	sta     WHICH_LOAD

	lda	#RIVEN_CHAIR
	sta	LOCATION

	lda     #$1
	sta     LEVEL_OVER

	rts

	.include "../flip_pages.s"
	.include "../disk00_files/draw_scene.s"

frames_l:
	.byte <overlay04		; 0
	.byte <overlay05		; 1
	.byte <overlay06		; 2
	.byte <overlay07		; 3
	.byte <overlay08		; 4
	.byte <overlay09		; 5
	.byte <overlay10		; 6
	.byte <overlay11		; 7
	.byte <overlay12		; 8
	.byte <overlay13		; 9
	.byte <overlay14		; 10
	.byte <overlay15		; 11
	.byte <overlay16		; 12
	.byte <overlay17		; 13
	.byte <overlay18		; 14

frames_h:
	.byte >overlay04		; 0
	.byte >overlay05		; 1
	.byte >overlay06		; 2
	.byte >overlay07		; 3
	.byte >overlay08		; 4
	.byte >overlay09		; 5
	.byte >overlay10		; 6
	.byte >overlay11		; 7
	.byte >overlay12		; 8
	.byte >overlay13		; 9
	.byte >overlay14		; 10
	.byte >overlay15		; 11
	.byte >overlay16		; 12
	.byte >overlay17		; 13
	.byte >overlay18		; 14

chair_graphics:
	.include	"movie_chair/movie_chair.inc"

	.include	"../audio.s"

chair_open_audio:
	.incbin		"audio/chair_open.btc.zx02"
