; The Cho lo-res movie

; by deater (Vince Weaver) <vince@deater.net>

.include "../zp.inc"
.include "../hardware.inc"
.include "../qload.inc"

.include "disk00_defines.inc"


NUM_OVERLAYS	=	61


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
	.byte <cho_overlay021,<cho_overlay022,<cho_overlay023	; 21,22,23
	.byte <cho_overlay024,<cho_overlay025,<cho_overlay026	; 24,25,26
	.byte <cho_overlay027,<cho_overlay028,<cho_overlay029	; 27,28,29
	.byte <cho_overlay030,<cho_overlay031,<cho_overlay032	; 30,31,32
	.byte <cho_overlay033,<cho_overlay034,<cho_overlay035	; 33,34,35
	.byte <cho_overlay036,<cho_overlay037,<cho_overlay038	; 36,37,38
	.byte <cho_overlay039,<cho_overlay040,<cho_overlay041	; 39,40,41
	.byte <cho_overlay042,<cho_overlay043,<cho_overlay044	; 42,43,44
	.byte <cho_overlay045,<cho_overlay046,<cho_overlay047	; 45,46,47
	.byte <cho_overlay048,<cho_overlay049,<cho_overlay050	; 48,49,50
	.byte <cho_overlay051,<cho_overlay052,<cho_overlay053	; 51,52,53
	.byte <cho_overlay054,<cho_overlay055,<cho_overlay056	; 54,55,56
	.byte <cho_overlay057,<cho_overlay058,<cho_overlay059	; 57,58,59
	.byte <cho_overlay060					; 60,61,62


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
	.byte >cho_overlay021,>cho_overlay022,>cho_overlay023	; 21,22,23
	.byte >cho_overlay024,>cho_overlay025,>cho_overlay026	; 24,25,26
	.byte >cho_overlay027,>cho_overlay028,>cho_overlay029	; 27,28,29
	.byte >cho_overlay030,>cho_overlay031,>cho_overlay032	; 30,31,32
	.byte >cho_overlay033,>cho_overlay034,>cho_overlay035	; 33,34,35
	.byte >cho_overlay036,>cho_overlay037,>cho_overlay038	; 36,37,38
	.byte >cho_overlay039,>cho_overlay040,>cho_overlay041	; 39,40,41
	.byte >cho_overlay042,>cho_overlay043,>cho_overlay044	; 42,43,44
	.byte >cho_overlay045,>cho_overlay046,>cho_overlay047	; 45,46,47
	.byte >cho_overlay048,>cho_overlay049,>cho_overlay050	; 48,49,50
	.byte >cho_overlay051,>cho_overlay052,>cho_overlay053	; 51,52,53
	.byte >cho_overlay054,>cho_overlay055,>cho_overlay056	; 54,55,56
	.byte >cho_overlay057,>cho_overlay058,>cho_overlay059	; 57,58,59
	.byte >cho_overlay060					; 60,61,62


cho_graphics:
	.include	"graphics_cho/cho_graphics.inc"

