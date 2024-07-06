; The Cho lo-res movie

; by deater (Vince Weaver) <vince@deater.net>

.include "../zp.inc"
.include "../hardware.inc"
.include "../qload.inc"

.include "disk00_defines.inc"


NUM_OVERLAYS	=	21


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

	lda	#<captured_cage_bg
	sta	scene_bg_l_smc+1

	lda	#>captured_cage_bg
	sta	scene_bg_h_smc+1

	lda	#0
	sta	WHICH_OVERLAY

cho_loop:

	jsr	draw_scene

	jsr	flip_pages

	inc	WHICH_OVERLAY
	lda	WHICH_OVERLAY
	cmp	#NUM_OVERLAYS
	beq	done_cho

	; in theory we are 500ms (10*50) long here...

	ldx	#7
	jsr	wait_a_bit

	jmp	cho_loop


done_cho:


	;======================
	; done, move on to next
	;======================

	bit     KEYRESET

	lda     #LOAD_CHO
	sta     WHICH_LOAD

	lda     #$1
	sta     LEVEL_OVER

	rts

	.include "flip_pages.s"
	.include "draw_scene.s"

frames_l:
	.byte <empty			; 0
	.byte <empty			; 1
	.byte <empty			; 2
	.byte <empty			; 3
	.byte <empty			; 4
	.byte <empty			; 5
	.byte <cho_overlay006,<cho_overlay007,<cho_overlay008	; 6,7,8
	.byte <cho_overlay009,<cho_overlay010,<cho_overlay011	; 9,10,11
	.byte <cho_overlay012,<cho_overlay013,<cho_overlay014	; 12,13,14
	.byte <cho_overlay015,<cho_overlay016,<cho_overlay017	; 15,16,17
	.byte <cho_overlay018,<cho_overlay019,<cho_overlay020	; 18,19,20

frames_h:
	.byte >empty			; 0
	.byte >empty			; 1
	.byte >empty			; 2
	.byte >empty			; 3
	.byte >empty			; 4
	.byte >empty			; 5
	.byte >cho_overlay006,>cho_overlay007,>cho_overlay008	; 6,7,8
	.byte >cho_overlay009,>cho_overlay010,>cho_overlay011	; 9,10,11
	.byte >cho_overlay012,>cho_overlay013,>cho_overlay014	; 12,13,14
	.byte >cho_overlay015,>cho_overlay016,>cho_overlay017	; 15,16,17
	.byte >cho_overlay018,>cho_overlay019,>cho_overlay020	; 18,19,20

cho_graphics:
	.include	"graphics_cho/cho_graphics.inc"

