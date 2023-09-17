; Not actually 3D at all
;  is really a lo-res shape plotter that can play movie-like things

; o/~ We went to Threed to see the Queen o/~

;
; by deater (Vince Weaver) <vince@deater.net>

.include "../zp.inc"
.include "../hardware.inc"
.include "../qload.inc"
;.include "music.inc"

threed_start:

	;=======================
	; wait for keypress
	;=======================

;	jsr	wait_until_keypress

;	lda	#25
;	jsr	wait_a_bit



	;===================
	; Load graphics
	;===================
load_loop:
	bit	SET_GR
	bit	LORES
	bit	FULLGR
	bit	PAGE0

	lda	#0
	sta	DRAW_PAGE


forever:

	lda	#num_scenes
	sta	SCENE_COUNT

	lda	#<frame15
	sta	INL
	lda	#>frame15
	sta	INH

scene_loop:
	jsr	draw_scene

	jsr	wait_until_keypress

	dec	SCENE_COUNT
	bne	scene_loop

	jmp	forever

	.include	"../wait_keypress.s"

	.include	"draw_boxes.s"
	.include	"3d.inc"

