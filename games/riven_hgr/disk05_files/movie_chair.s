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
	;===============================
	; play sound effect?
	;===============================
	;===============================


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

	; in theory we are 500ms (10*50) long here...

	ldx	#7
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
	.byte <empty			; 5
	.byte <empty			; 6
	.byte <empty			; 7
	.byte <empty			; 8
	.byte <empty			; 9
	.byte <empty			; 10
	.byte <empty			; 11
	.byte <empty			; 12
	.byte <empty			; 13
	.byte <empty			; 14

frames_h:
	.byte >overlay04		; 0
	.byte >overlay05		; 1
	.byte >overlay06		; 2
	.byte >overlay07		; 3
	.byte >overlay08		; 4
	.byte >empty			; 5
	.byte >empty			; 6
	.byte >empty			; 7
	.byte >empty			; 8
	.byte >empty			; 9
	.byte >empty			; 10
	.byte >empty			; 11
	.byte >empty			; 12
	.byte >empty			; 13
	.byte >empty			; 14

chair_graphics:
	.include	"movie_chair/movie_chair.inc"

