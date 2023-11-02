; Dancing dots

; this one is a tough one

; TODO:
;	16 of them?  Start by falling in, bouncing when hit bottom
;	slowly spool out at first
;	have 24 of them, increase part way?

;	wide, sine wave it up
;	narrow, sine wave it up
;	at end, just stop deleting them?  draw random

;
; by deater (Vince Weaver) <vince@deater.net>

.include "../zp.inc"
.include "../hardware.inc"
.include "../qload.inc"
.include "../music.inc"

dots_start:
	;=====================
	; initializations
	;=====================

	;===================
	; Load graphics
	;===================

	jsr	clear_screens	; clear both pages of LORES

	bit	SET_GR
	bit	LORES
	bit	FULLGR
	bit	PAGE1

	lda	#4
	sta	DRAW_PAGE

dots_loop:
	jsr	clear_top
	jsr	clear_bottom


	ldx	#12
horizon_loop:
	lda	gr_offsets_l,X
	sta	OUTL
	lda	gr_offsets_h,X
	clc
	adc	DRAW_PAGE
	sta	OUTH

	ldy	#39
	lda	#$55
horizon_inner:
	sta	(OUTL),Y
	dey
	bpl	horizon_inner

	inx
	cpx	#24
	bne	horizon_loop

	lda	#15
	sta	COUNT
dot_loop:
	; Xcoord in XPOS
        ; Ycoord in YPOS
        ; color in COLOR

	ldx	COUNT
	lda	wide_points_x,X
	sta	XPOS
	lda	wide_points_y,X
	sta	YPOS
	lda	#$66			; light blue
	sta	COLOR

	jsr	plot

	dec	COUNT
	bpl	dot_loop

	jsr	page_flip


	; move dots

	ldx	#15
move_dot_loop:
	lda	wide_points_y,X
	clc
	adc	dot_direction,X
	sta	wide_points_y,X
	cmp	#40
	bcs	dot_reverse		; bge
	cmp	#1
	bcc	dot_reverse		; blt
	bcs	dot_good
dot_reverse:
	lda	dot_direction,X
	eor	#$FF
	sta	dot_direction,X
	inc	dot_direction,X

dot_good:
	dex
	bpl	move_dot_loop


	lda	#68
	jsr	wait_for_pattern
	bcs	dots_done

	jmp	dots_loop

dots_done:
	rts



	.include "../gr_pageflip.s"
;	.include "../gr_fast_clear.s"
	.include "../gr_copy.s"
	.include "../gr_offsets_split.s"
	.include "../gr_offsets.s"
	.include "../gr_plot.s"


	.include	"../wait_keypress.s"
;	.include	"../zx02_optim.s"
;	.include	"../hgr_table.s"
;	.include	"../hgr_clear_screen.s"
;	.include	"../hgr_copy_fast.s"

	.include	"../irq_wait.s"


wide_points_x:
	.byte	8,11,17,25,30,28,20,13
	.byte	9,14,21,28,30,24,17,11
wide_points_y:
;	.byte	19,16,12,11,14,18,20,21
;	.byte	18,13,11,12,16,19,20,20

	.byte	 9, 6 ,2,1,4,8,10,11
	.byte	15,12, 8,7,10,14,16,17

dot_direction:
	.byte	 1, 1, 1, 1, 1, 1, 1, 1
	.byte	 1, 1, 1, 1, 1, 1, 1, 1
