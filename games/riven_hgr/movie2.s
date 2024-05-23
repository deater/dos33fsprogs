; Lo-res movie player of sorts

; This is for the big movie, the maglev ride

; by deater (Vince Weaver) <vince@deater.net>

.include "zp.inc"
.include "hardware.inc"


overlays	=	$2000

	;===================
	; notes for movie2
	;	103..109 = overlay animation
	;	110..112 = sit there
	;	113..270 = fun animation	157! = 30k???
	;	271..285 = handle rotate
	;	286..306 = sit there


	; timing, want whole thing to finish in 200ms or so
	;
	; decompressing:
	;	ade2 = 44,514 cycles
	; do_overlay:
	;	9c78 = 40,056 cycles

movie2_start:


	;===================
	; Setup graphics
	;===================

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

	lda	#<overlays_combined_zx02
	sta	ZX0_src
	lda	#>overlays_combined_zx02
        sta	ZX0_src+1

	lda	#$20

	jsr	full_decomp

	;===============================
	;===============================
	; initial screen
	;===============================
	;===============================

	lda	#0
	sta	WHICH_OVERLAY

	jsr	draw_scene

	jsr	flip_pages

	;===============================
	; wait 2 frames (400ms)

	; needed?
	; could overlay with sound effect or decompress of overlay?

	ldx	#8
	jsr	wait_50xms

	;===============================
	;===============================
	; move the handle
	;===============================
	;===============================

	lda	#0
	sta	WHICH_OVERLAY

move_handle_loop:

	jsr	draw_scene

	jsr	flip_pages

	inc	WHICH_OVERLAY
	lda	WHICH_OVERLAY
	cmp	#7
	beq	done_move_handle

overlay_good:

	ldx	#2
	jsr	wait_50xms

	jmp	move_handle_loop


done_move_handle:
	lda	#6			; point to last one
	sta	WHICH_OVERLAY

	;===============================
	; wait 4 frames (800ms)

	ldx	#16
	jsr	wait_50xms


	;===============================
	;===============================
	; play the movie
	;===============================
	;===============================

	lda	#1
	sta	SCENE_COUNT

movie2_loop:

	jsr	draw_scene

	jsr	flip_pages

	inc	SCENE_COUNT
	lda	SCENE_COUNT
	cmp	#5
	beq	done_play_movie2

	ldx	#2
	jsr	wait_50xms

	jmp	movie2_loop


done_play_movie2:

	; TODO: complex handle movement at end

	; TODO: end with message

	;===============================
	; wait 9 frames (1.8s?)

	ldx	#36
	jsr	wait_50xms


done_movie2:
	bit	KEYRESET

	jmp	movie2_start

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



;===================================

;	.include	"../wait_keypress.s"

;	.include	"draw_boxes.s"


	.include	"zx02_optim.s"

	.include	"wait.s"

	.include	"movie2/movie2.inc"

frames_l:
	.byte	<img096_bg_zx02
	.byte	<img114_bg_zx02
	.byte	<img115_bg_zx02
	.byte	<img116_bg_zx02
	.byte	<img117_bg_zx02

frames_h:
	.byte	>img096_bg_zx02
	.byte	>img114_bg_zx02
	.byte	>img115_bg_zx02
	.byte	>img116_bg_zx02
	.byte	>img117_bg_zx02

overlay_mask_zx02:
	.incbin		"movie2/overlays/maglev_overlay_mask.gr.zx02"

overlays_combined_zx02:
	.incbin		"movie2/overlays/overlay_combined.zx02"



