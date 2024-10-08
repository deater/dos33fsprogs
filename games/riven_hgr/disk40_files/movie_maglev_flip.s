; Lo-res movie player of sorts

; maglev flip for disk40 (arrival on jungle island)

; by deater (Vince Weaver) <vince@deater.net>

.include "../zp.inc"
.include "../hardware.inc"
.include "../common_defines.inc"
.include "../qload.inc"
.include "disk40_defines.inc"

overlays	=	$2000

	;=================================
	; so, movie.  each frame is 1/5 second (200ms)
	;	25..28 displays initial for 4 frames
	;	29..35 displays handle moving (8 frames)
	;	36..52 sits there	; 16 frames
	;	53..87 rotates
	;	88..97 sits there
	;	98 control returns to user
	; space?
	;	188*8=overlays (1.5k)
	;	 35 rotations * 188 = (7k) not so bad?

	; timing, want whole thing to finish in 200ms or so
	;
	; decompressing:
	;	ade2 = 44,514 cycles
	; do_overlay:
	;	9c78 = 40,056 cycles

movie_maglev_flip_start:


	;===================
	; Setup graphics
	;===================

	lda	#0
	sta	DRAW_PAGE
	jsr	clear_gr_all

	bit	SET_GR
	bit	LORES
	bit	FULLGR
	bit	PAGE1

	lda	#0
	sta	SCENE_COUNT

	lda	#4
	sta	DRAW_PAGE

	bit	KEYRESET

	;===============================
	;===============================
	; set up graphics
	;===============================
	;===============================

	;=============================
	; load overlay mask to $c00
	;=============================

	lda	#<overlay_mask_zx02
	sta	ZX0_src
	lda	#>overlay_mask_zx02
        sta	ZX0_src+1

	lda	#$0c

	jsr	full_decomp


	;=============================
	; load overlays to $2000-$2FFF
	;=============================

	lda	#<combined_overlays_zx02
	sta	ZX0_src
	lda	#>combined_overlays_zx02
        sta	ZX0_src+1

	lda	#$20

	jsr	full_decomp


	lda	STATE_MAGLEV
	and	#MAGLEV1_DIRECTION
	bne	maglev_forward_flip


	;===============================
	;===============================
	; Backward flip (face west)
	;===============================
	;===============================
maglev_backward_flip:

	;===============================
	; initial screen
	;===============================

	lda	#30
	sta	SCENE_COUNT

	lda	#7				; start at end
	sta	WHICH_OVERLAY

	jsr	draw_scene

	jsr	flip_pages

	;===============================
	; wait 4 frames (800ms)

	ldx	#16
	jsr	wait_50xms

	;===============================
	;===============================
	; move the handle
	;===============================
	;===============================

	lda	#7
	sta	WHICH_OVERLAY

move_handle_backward_loop:

	jsr	draw_scene

	jsr	flip_pages

	dec	WHICH_OVERLAY
	bmi	done_move_handle_backward

backward_overlay_good:

	ldx	#2
	jsr	wait_50xms

	jmp	move_handle_backward_loop


done_move_handle_backward:
	lda	#0			; point to first one
	sta	WHICH_OVERLAY

	;===============================
	; wait 16 frames (3.2s?)

	ldx	#64
	jsr	wait_50xms


	;===============================
	;===============================
	; play the movie
	;===============================
	;===============================

	lda	#30
	sta	SCENE_COUNT

movie1_backward_loop:

	jsr	draw_scene

	jsr	flip_pages

	dec	SCENE_COUNT
	lda	SCENE_COUNT
;	cmp	#0
	bmi	done_play_movie1_backward

	ldx	#2
	jsr	wait_50xms

	jmp	movie1_backward_loop


done_play_movie1_backward:

	;===============================
	; wait 9 frames (1.8s?)

	ldx	#36
	jsr	wait_50xms


done_movie1_bacward:
	bit	KEYRESET


	;=============================
	; return back to game

	lda	#LOAD_MAGLEV
	sta	WHICH_LOAD

	lda	#DIRECTION_W
	sta	DIRECTION

	lda	#RIVEN_INSEAT
	sta	LOCATION

	; needed?

        lda     #1
        sta     LEVEL_OVER

	rts



	;===============================
	;===============================
	; Forward flip (face east)
	;===============================
	;===============================
maglev_forward_flip:

	;===============================
	; initial screen
	;===============================

	lda	#0
	sta	WHICH_OVERLAY

	jsr	draw_scene

	jsr	flip_pages

	;===============================
	; wait 4 frames (800ms)

	ldx	#16
	jsr	wait_50xms

	;===============================
	;===============================
	; move the handle
	;===============================
	;===============================

	; could save bytes going backwards?
	lda	#0
	sta	WHICH_OVERLAY

move_handle_loop:

	jsr	draw_scene

	jsr	flip_pages

;	lda	KEYPRESS
;	bmi	done_movie1

	inc	WHICH_OVERLAY
	lda	WHICH_OVERLAY
	cmp	#8
	beq	done_move_handle

overlay_good:

	ldx	#2
	jsr	wait_50xms

	jmp	move_handle_loop


done_move_handle:
	lda	#7			; point to last one
	sta	WHICH_OVERLAY

	;===============================
	; wait 16 frames (3.2s?)

	ldx	#64
	jsr	wait_50xms


	;===============================
	;===============================
	; play the movie
	;===============================
	;===============================

	lda	#1
	sta	SCENE_COUNT

movie1_loop:

	jsr	draw_scene

	jsr	flip_pages

	inc	SCENE_COUNT
	lda	SCENE_COUNT
	cmp	#31
	beq	done_play_movie1

	ldx	#2
	jsr	wait_50xms

	jmp	movie1_loop


done_play_movie1:

	;===============================
	; wait 9 frames (1.8s?)

	ldx	#36
	jsr	wait_50xms


done_movie1:
	bit	KEYRESET


	;=============================
	; return back to game

	lda	#LOAD_MAGLEV
	sta	WHICH_LOAD

	lda	#DIRECTION_E
	sta	DIRECTION

	lda	#RIVEN_READYTOGO
	sta	LOCATION

	; needed?

        lda     #1
        sta     LEVEL_OVER

;	jmp	movie1_start

	rts



	;===============================
	;===============================
	; draw_scene
	;===============================
	;===============================

draw_scene:


	;===============================
	; decompress background
	;===============================

before:
	ldx	SCENE_COUNT

	lda	frames_l,X
	sta	ZX0_src
	lda	frames_h,X
        sta	ZX0_src+1

	clc
	lda	DRAW_PAGE
	adc	#$4

	jsr	full_decomp
after:

;	jmp	do_overlay

	; fallthrough


	;===============================
	; do overlay
	;===============================
	;	INL/H   = overlay
	;	MASKL/H = mask
	;	OUTL/H  = gr location
do_overlay:
	lda	DRAW_PAGE
	clc
	adc	#$4
	sta	OUTH

	lda	WHICH_OVERLAY
	asl
	asl
	clc
	adc	#$20
	sta	INH

	lda	#$c
	sta	MASKH

	lda	#0
	sta	OUTL
	sta	INL
	sta	MASKL

do_overlay_outer:

	ldy	#0
do_overlay_inner:

overlayin_smc:
	lda	(INL),Y
	and	(MASKL),Y
	sta	TEMP

	lda	(MASKL),Y
	eor	#$ff
	and	(OUTL),Y
	ora	TEMP
	sta	(OUTL),Y

skip_write:
	dey
	bne	do_overlay_inner


	inc	OUTH
	inc	INH
	inc	MASKH
	lda	MASKH
	cmp	#$10
	bne	do_overlay_inner

	rts


	.include "../flip_pages.s"


;===================================

	.include	"movie_maglev_flip/movie_maglev_flip.inc"


frames_l:
	.byte	<img025_bg_zx02
	.byte	<img025_bg_zx02
	.byte	<img025_bg_zx02
	.byte	<img025_bg_zx02
	.byte	<img025_bg_zx02
	.byte	<img025_bg_zx02
	.byte	<img025_bg_zx02
	.byte	<img025_bg_zx02
	.byte	<img025_bg_zx02
	.byte	<img025_bg_zx02
	.byte	<img025_bg_zx02
	.byte	<img025_bg_zx02
	.byte	<img025_bg_zx02
	.byte	<img025_bg_zx02
	.byte	<img025_bg_zx02
	.byte	<img025_bg_zx02
	.byte	<img025_bg_zx02
	.byte	<img025_bg_zx02
	.byte	<img025_bg_zx02
	.byte	<img025_bg_zx02
	.byte	<img025_bg_zx02
	.byte	<img025_bg_zx02
	.byte	<img025_bg_zx02
	.byte	<img025_bg_zx02
	.byte	<img025_bg_zx02
	.byte	<img025_bg_zx02
	.byte	<img025_bg_zx02
	.byte	<img025_bg_zx02
	.byte	<img025_bg_zx02
	.byte	<img025_bg_zx02
	.byte	<img025_bg_zx02
	.byte	<img025_bg_zx02

;	.byte	<img055_bg_zx02
;	.byte	<img056_bg_zx02
;	.byte	<img057_bg_zx02
;	.byte	<img058_bg_zx02
;	.byte	<img059_bg_zx02
;	.byte	<img060_bg_zx02
;	.byte	<img061_bg_zx02
;	.byte	<img062_bg_zx02
;	.byte	<img063_bg_zx02
;	.byte	<img064_bg_zx02
;	.byte	<img065_bg_zx02
;	.byte	<img066_bg_zx02
;	.byte	<img067_bg_zx02
;	.byte	<img068_bg_zx02
;	.byte	<img069_bg_zx02
;	.byte	<img070_bg_zx02
;	.byte	<img071_bg_zx02
;	.byte	<img072_bg_zx02
;	.byte	<img073_bg_zx02
;	.byte	<img074_bg_zx02
;	.byte	<img075_bg_zx02
;	.byte	<img076_bg_zx02
;	.byte	<img077_bg_zx02
;	.byte	<img078_bg_zx02
;	.byte	<img079_bg_zx02
;	.byte	<img080_bg_zx02
;	.byte	<img081_bg_zx02
;	.byte	<img082_bg_zx02
;	.byte	<img083_bg_zx02
;	.byte	<img084_bg_zx02

frames_h:
	.byte	>img025_bg_zx02
	.byte	>img025_bg_zx02
	.byte	>img025_bg_zx02
	.byte	>img025_bg_zx02
	.byte	>img025_bg_zx02
	.byte	>img025_bg_zx02
	.byte	>img025_bg_zx02
	.byte	>img025_bg_zx02
	.byte	>img025_bg_zx02
	.byte	>img025_bg_zx02
	.byte	>img025_bg_zx02
	.byte	>img025_bg_zx02
	.byte	>img025_bg_zx02
	.byte	>img025_bg_zx02
	.byte	>img025_bg_zx02
	.byte	>img025_bg_zx02
	.byte	>img025_bg_zx02
	.byte	>img025_bg_zx02
	.byte	>img025_bg_zx02
	.byte	>img025_bg_zx02
	.byte	>img025_bg_zx02
	.byte	>img025_bg_zx02
	.byte	>img025_bg_zx02
	.byte	>img025_bg_zx02
	.byte	>img025_bg_zx02
	.byte	>img025_bg_zx02
	.byte	>img025_bg_zx02
	.byte	>img025_bg_zx02
	.byte	>img025_bg_zx02
	.byte	>img025_bg_zx02
	.byte	>img025_bg_zx02
	.byte	>img025_bg_zx02

;	.byte	>img055_bg_zx02
;	.byte	>img056_bg_zx02
;	.byte	>img057_bg_zx02
;	.byte	>img058_bg_zx02
;	.byte	>img059_bg_zx02
;	.byte	>img060_bg_zx02
;	.byte	>img061_bg_zx02
;	.byte	>img062_bg_zx02
;	.byte	>img063_bg_zx02
;	.byte	>img064_bg_zx02
;	.byte	>img065_bg_zx02
;	.byte	>img066_bg_zx02
;	.byte	>img067_bg_zx02
;	.byte	>img068_bg_zx02
;	.byte	>img069_bg_zx02
;	.byte	>img070_bg_zx02
;	.byte	>img071_bg_zx02
;	.byte	>img072_bg_zx02
;	.byte	>img073_bg_zx02
;	.byte	>img074_bg_zx02
;	.byte	>img075_bg_zx02
;	.byte	>img076_bg_zx02
;	.byte	>img077_bg_zx02
;	.byte	>img078_bg_zx02
;	.byte	>img079_bg_zx02
;	.byte	>img080_bg_zx02
;	.byte	>img081_bg_zx02
;	.byte	>img082_bg_zx02
;	.byte	>img083_bg_zx02
;	.byte	>img084_bg_zx02





overlay_mask_zx02:
	.incbin		"../disk39_files/movie_maglev_flip/overlays/maglev_overlay_mask.gr.zx02"

combined_overlays_zx02:
	.incbin		"../disk39_files/movie_maglev_flip/overlays/combined_overlays.zx02"


