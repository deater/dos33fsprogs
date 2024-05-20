; Lo-res movie player of sorts

; by deater (Vince Weaver) <vince@deater.net>

.include "zp.inc"
.include "hardware.inc"


overlays	=	$2000

	;=================================
	; so, movie.  each frame is 1/5 second (200ms)
	;	25..28 displays initial for 4 frames
	;	29..35 displays handle moving (8 frames)
	;	36..52 sits there
	;	53..87 rotates
	;	88..97 sits there
	;	98 control returns to user
	; space?
	;	188*8=overlays (1.5k)
	;	 35 rotations * 188 = (7k) not so bad?
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

movie1_start:


	;===================
	; Setup graphics
	;===================

	bit	SET_GR
	bit	LORES
	bit	FULLGR
	bit	PAGE1

	lda	#0
;	sta	DRAW_PAGE
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


	;===============================
	;===============================
	; move the handle
	;===============================
	;===============================

.if 0
	;===============================
	; decompress initial background
	;===============================

before:
	lda	#<img025_bg_zx02
	sta	ZX0_src
	lda	#>img025_bg_zx02
        sta	ZX0_src+1

	lda	#$04			; decompress page1 (dangerous? holes?)

	jsr	full_decomp
after:
.endif
	;=============================
	; load overlays to $2000-$2FFF
	;=============================

	lda	#0
	sta	WHICH_OVERLAY

load_overlay_loop:
	ldx	WHICH_OVERLAY
	lda	overlays_l,X
	sta	ZX0_src
	lda	overlays_h,X
        sta	ZX0_src+1

	lda	WHICH_OVERLAY
	asl
	asl
	clc
	adc	#>overlays

	jsr	full_decomp

	inc	WHICH_OVERLAY
	lda	WHICH_OVERLAY
	cmp	#8
	bne	load_overlay_loop

	; could save bytes going backwards?
	lda	#0
	sta	WHICH_OVERLAY

scene_loop:


	jsr	draw_scene

	;============================
	; flip pages
	;============================
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


	lda	KEYPRESS
	bmi	done_movie1

	inc	WHICH_OVERLAY
	lda	WHICH_OVERLAY
	cmp	#8
	bne	overlay_good

	lda	#0
	sta	WHICH_OVERLAY

overlay_good:

	ldx	#2
	jsr	wait_50xms

	inc	SCENE_COUNT
;	bne	scene_loop
	jmp	scene_loop

done_movie1:
	bit	KEYRESET

	jmp	movie1_start

	rts

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


	;===============================
	;===============================
draw_scene:


	;===============================
	; decompress background
	;===============================

before:
	lda	#<img025_bg_zx02
	sta	ZX0_src
	lda	#>img025_bg_zx02
        sta	ZX0_src+1

	clc
	lda	DRAW_PAGE
	adc	#$4

	jsr	full_decomp
after:

	jmp	do_overlay

;===================================

;	.include	"../wait_keypress.s"

;	.include	"draw_boxes.s"


	.include	"zx02_optim.s"

	.include	"wait.s"

	.include	"movie1/movie1.inc"

overlays_l:
	.byte <overlay25,<overlay29,<overlay30
	.byte <overlay31,<overlay32,<overlay33
	.byte <overlay34,<overlay35

overlays_h:
	.byte >overlay25,>overlay29,>overlay30
	.byte >overlay31,>overlay32,>overlay33
	.byte >overlay34,>overlay35

overlay_mask_zx02:
	.incbin		"movie1/overlays/maglev_overlay_mask.gr.zx02"

overlay25:
	.incbin		"movie1/overlays/overlay25.gr.zx02"
overlay29:
	.incbin		"movie1/overlays/overlay29.gr.zx02"
overlay30:
	.incbin		"movie1/overlays/overlay30.gr.zx02"
overlay31:
	.incbin		"movie1/overlays/overlay31.gr.zx02"
overlay32:
	.incbin		"movie1/overlays/overlay32.gr.zx02"
overlay33:
	.incbin		"movie1/overlays/overlay33.gr.zx02"
overlay34:
	.incbin		"movie1/overlays/overlay34.gr.zx02"
overlay35:
	.incbin		"movie1/overlays/overlay35.gr.zx02"


