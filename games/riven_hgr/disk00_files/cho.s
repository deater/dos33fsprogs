; The Cho lo-res movie

; by deater (Vince Weaver) <vince@deater.net>

.include "../zp.inc"
.include "../hardware.inc"
.include "../qload.inc"

.include "disk00_defines.inc"


NUM_OVERLAYS	=	6


cho_start:

	;===================
        ; Setup lo-res graphics
        ;===================

	; clear it first

;	jsr	clear_gr_all

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
	;===============================
	; cho walks in
	;===============================
	;===============================

	lda	#0
	sta	WHICH_OVERLAY

cho_loop:

	jsr	draw_scene

	jsr	flip_pages

	inc	WHICH_OVERLAY
	lda	WHICH_OVERLAY
	cmp	#NUM_OVERLAYS
	beq	done_cho

	ldx	#2
	jsr	wait_a_bit

	jmp	cho_loop


done_cho:


	;======================
	; done, move on to next
	;======================

	bit     KEYRESET

	lda     #LOAD_CAPTURED
	sta     WHICH_LOAD

	lda     #$1
	sta     LEVEL_OVER

	rts

	.include "flip_pages.s"
	.include "draw_scene.s"

frames_l:
;	.byte <trap_overlay0
;	.byte <trap_overlay1
;	.byte <trap_overlay2
;	.byte <trap_overlay3
;	.byte <trap_overlay4
;	.byte <trap_overlay5

frames_h:
;	.byte >trap_overlay0
;	.byte >trap_overlay1
;	.byte >trap_overlay2
;	.byte >trap_overlay3
;	.byte >trap_overlay4
;	.byte >trap_overlay5

cho_graphics:
	.include	"graphics_cho/cho_graphics.inc"

