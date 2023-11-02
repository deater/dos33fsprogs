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

	; in case we re-run for some reason
;	lda	#$E6			; INC =$E6, DEC=$C6
;	sta	direction_smc
;	sta	direction2_smc

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
direction2_smc:
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

restart_ocean:
direction_smc:
	inc	COUNT

	lda	COUNT
	beq	really_done_ocean

	cmp	#32
	bne	no_count_oflo

	lda	#6			; reset to 6
	sta	COUNT
no_count_oflo:

end_smc:
	lda	#75			; really 76, finish one early
	jsr	wait_for_pattern
	bcs	done_ocean		; bge

	jmp	ocean_loop		; loop


	; here done one early
	; reverse flow so we back out

done_ocean:
	lda	#76
	sta	end_smc+1

	lda	#$C6			; INC =$E6, DEC=$C6
	sta	direction_smc
	sta	direction2_smc

	lda	#6
	sta	COUNT

	jmp	ocean_loop

	; here once we've gone backwards to end

really_done_ocean:

	lda     #0
	jsr     hgr_page1_clearscreen
	jsr     hgr_page2_clearscreen

	lda	#76
	jsr	wait_for_pattern
	bcs	really_done_ocean

	rts

	.include	"../wait_keypress.s"
;	.include	"../zx02_optim.s"
	.include	"../hgr_clear_screen.s"

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

