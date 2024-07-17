; Lo-res movie player of sorts

; this is the least efficient way of doing things but on time crunch
;	should just be drawing sprites or something

; by deater (Vince Weaver) <vince@deater.net>

.include "../zp.inc"
.include "../hardware.inc"
.include "../common_defines.inc"
.include "../qload.inc"
.include "disk41_defines.inc"

	;=================================
	; so, movie.  each frame is 1/2 second (500ms)

movie_cove_start:


	;===================
	; Setup graphics
	;===================

	; clear lores before we flip to it

	lda	#0
	sta	DRAW_PAGE
	jsr	clear_gr_all

	bit	SET_GR
	bit	LORES
	bit	PAGE1

;	jsr	GR
	bit	FULLGR

	lda	#0
	sta	SCENE_COUNT

	lda	#4
	sta	DRAW_PAGE

	bit	KEYRESET



	;===============================
	; load audio
	;===============================
	; we do this fist as our program is long enough the audio
	;	data loads up past $4000 and will get over-written
	;	by the graphics data loaded later

	lda	SOUND_STATUS
	and	#SOUND_IN_LC
	beq	do_not_load_audio

	; load sounds into LC

	; read ram, write ram, use $d000 bank1
	bit	$C08B
	bit	$C08B


	lda	#<audio_data_zx02
        sta	ZX0_src
        lda	#>audio_data_zx02
        sta	ZX0_src+1

        lda	#$D0    ; decompress to $D000

        jsr	full_decomp

	; read rom, nowrite, use $d000 bank1
        bit     $C08A

do_not_load_audio:




	;===============================
	;===============================
	; set up graphics
	;===============================
	;===============================

	;=============================
	; load huge blob to $4000
	;=============================

	lda	#<movie_data_zx02
	sta	ZX0_src
	lda	#>movie_data_zx02
	sta	ZX0_src+1

	lda	#$40

	jsr	full_decomp

	;===============================
	; initial screen
	;===============================

	lda	#0
	sta	SCENE_COUNT

	jsr	draw_scene

	jsr	flip_pages

	lda	#0
	sta	SCENE_COUNT

	jsr	draw_scene

	jsr	flip_pages


	;===============================
	; play audio
	;===============================

	lda	SOUND_STATUS
	and	#SOUND_IN_LC
	beq	do_not_play_audio

	; load sounds into LC

	; read ram, write ram, use $d000 bank1
	bit	$C08B
	bit	$C08B

	; call the btc player

	lda	#$00
	sta	BTC_L

	lda	#$D0
	sta	BTC_H

	ldx	#45             ; length

	jsr	play_audio

	; read rom, nowrite, use $d000 bank1
        bit     $C08A

do_not_play_audio:


	;===============================
	;===============================
	; play the movie
	;===============================
	;===============================

	lda	#00
	sta	SCENE_COUNT

play_movie_loop:

	jsr	draw_scene

	jsr	flip_pages

	inc	SCENE_COUNT
	lda	SCENE_COUNT
	cmp	#29
	beq	done_movie

	ldx	#10
	jsr	wait_50xms

	jmp	play_movie_loop

	;===============================
	; wait .5s

done_movie:
	ldx	#10
	jsr	wait_50xms


	bit	KEYRESET


	;=============================
	; return back to game

	lda	#LOAD_COVE
	sta	WHICH_LOAD

	lda	#DIRECTION_E
	sta	DIRECTION

	lda	#RIVEN_COVE
	sta	LOCATION

	lda	#1
	sta	BEACH_ANIMALS_SEEN

	; needed?

	lda     #1
	sta     LEVEL_OVER

	rts


	;===============================
	;===============================
	; draw_scene
	;===============================
	;===============================

draw_scene:

	lda	#0
	sta	INL
	sta	OUTL

	; load from $40 + 4*SCENE
	; copy 1k to draw page

	lda	SCENE_COUNT
	asl
	asl
	clc
	adc	#$40

	sta	INH

	lda	DRAW_PAGE
	clc
	adc	#$04
	sta	OUTH


	ldx	#4
	ldy	#0
copy_loop:
	lda	(INL),Y
	sta	(OUTL),Y
	dey
	bne	copy_loop

	inc	INH
	inc	OUTH

	dex
	bne	copy_loop

	rts



	;============================
	; flip pages
	;============================
flip_pages:
	lda	DRAW_PAGE						; 3
	beq	was_page1						; 2/3
was_page2:
	bit     PAGE2							; 4
	lda	#$0							; 2
	beq	done_pageflip						; 2/3
was_page1:
	bit	PAGE1							; 4
	lda	#$4							; 2
done_pageflip:
	sta	DRAW_PAGE						; 3

	rts


.include	"../audio.s"


;===================================

movie_data_zx02:
	.incbin		"movie_cove/combined_cove.zx02"

audio_data_zx02:
	.incbin		"audio/cove.btc.zx02"
