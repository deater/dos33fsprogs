; Ocean

;
; by deater (Vince Weaver) <vince@deater.net>

.include "../zp.inc"
.include "../hardware.inc"
.include "../qload.inc"
.include "../music.inc"

ocean_start:
	;=====================
	; initializations
	;=====================

	; debug
	lda     #72
        sta     current_pattern_smc+1
        jsr     pt3_set_pattern


	;===================
	; Load graphics
	;===================
load_loop:

	bit	SET_GR
	bit	HIRES
	bit	FULLGR
	bit	PAGE1

	lda	#0
	sta	COUNT

ocean_loop:

	; logo 1
	ldx	COUNT

	lda	frame_data_l,X
	sta	zx_src_l+1

	lda	frame_data_h,X
	sta	zx_src_h+1

	lda	#$40

	jsr	zx02_full_decomp


	bit	PAGE2
	inc	COUNT

	; right logo

	ldx	COUNT

	lda	frame_data_l,X
	sta	zx_src_l+1

	lda	frame_data_h,X
	sta	zx_src_h+1

	lda	#$20

	jsr	zx02_full_decomp

	bit	PAGE1

	inc	COUNT
	lda	COUNT
	cmp	#32
	bne	no_count_oflo

	lda	#6
	sta	COUNT
no_count_oflo:

	lda	#76
	jsr	wait_for_pattern
	bcs	done_ocean

;	lda	KEYPRESS
;	bmi	done_ocean

	jmp	ocean_loop
done_ocean:
	rts

	.include	"../wait_keypress.s"
	.include	"../zx02_optim.s"

	.include	"../irq_wait.s"

frame_data_l:
	.byte <frame02_data,<frame03_data,<frame04_data,<frame05_data
	.byte <frame06_data,<frame07_data

	.byte <frame18_data,<frame19_data
	.byte <frame20_data,<frame21_data,<frame22_data,<frame23_data
	.byte <frame24_data,<frame25_data,<frame26_data,<frame27_data
	.byte <frame28_data,<frame29_data,<frame30_data,<frame31_data

	.byte <frame30_data,<frame29_data
	.byte <frame28_data,<frame27_data,<frame26_data,<frame25_data
	.byte <frame24_data,<frame23_data,<frame22_data,<frame21_data
	.byte <frame20_data,<frame19_data

frame_data_h:
	.byte >frame02_data,>frame03_data,>frame04_data,>frame05_data
	.byte >frame06_data,>frame07_data

	.byte >frame18_data,>frame19_data
	.byte >frame20_data,>frame21_data,>frame22_data,>frame23_data
	.byte >frame24_data,>frame25_data,>frame26_data,>frame27_data
	.byte >frame28_data,>frame29_data,>frame30_data,>frame31_data

	.byte >frame30_data,>frame29_data
	.byte >frame28_data,>frame27_data,>frame26_data,>frame25_data
	.byte >frame24_data,>frame23_data,>frame22_data,>frame21_data
	.byte >frame20_data,>frame19_data

frame02_data:
	.incbin "graphics/frame00000002.hgr.zx02"
frame03_data:
	.incbin "graphics/frame00000003.hgr.zx02"
frame04_data:
	.incbin "graphics/frame00000004.hgr.zx02"
frame05_data:
	.incbin "graphics/frame00000005.hgr.zx02"
frame06_data:
	.incbin "graphics/frame00000006.hgr.zx02"
frame07_data:
	.incbin "graphics/frame00000007.hgr.zx02"

frame18_data:
	.incbin "graphics/frame00000018.hgr.zx02"
frame19_data:
	.incbin "graphics/frame00000019.hgr.zx02"
frame20_data:
	.incbin "graphics/frame00000020.hgr.zx02"
frame21_data:
	.incbin "graphics/frame00000021.hgr.zx02"
frame22_data:
	.incbin "graphics/frame00000022.hgr.zx02"
frame23_data:
	.incbin "graphics/frame00000023.hgr.zx02"
frame24_data:
	.incbin "graphics/frame00000024.hgr.zx02"
frame25_data:
	.incbin "graphics/frame00000025.hgr.zx02"
frame26_data:
	.incbin "graphics/frame00000026.hgr.zx02"
frame27_data:
	.incbin "graphics/frame00000027.hgr.zx02"
frame28_data:
	.incbin "graphics/frame00000028.hgr.zx02"
frame29_data:
	.incbin "graphics/frame00000029.hgr.zx02"
frame30_data:
	.incbin "graphics/frame00000030.hgr.zx02"
frame31_data:
	.incbin "graphics/frame00000031.hgr.zx02"

