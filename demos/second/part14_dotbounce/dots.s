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

	lda	#0
	sta	MAX_DOTS
	sta	FRAME
	sta	Y_OFFSET

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
	jsr	clear_bottom		; not necessary as we over-write?

	;============================
	; draw the grey background
	;============================

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


	;==========================
	; draw the dots
	;==========================


	lda	MAX_DOTS
	sta	COUNT
dot_loop:
	; Xcoord in XPOS
        ; Ycoord in YPOS
        ; color in COLOR

	lda	COUNT
	clc
	adc	Y_OFFSET
	and	#31
	tax
;	ldx	COUNT
	lda	wide_points_x,X
	sta	XPOS

;	lda	COUNT
;	clc
;	adc	Y_OFFSET
;	and	#31
;	tax
	ldx	COUNT
	lda	wide_points_y,X
	sta	YPOS
	lda	#$66			; light blue
	sta	COLOR

	jsr	plot

	dec	COUNT
	bpl	dot_loop

	jsr	page_flip


	;============================
	; move dots

	ldx	MAX_DOTS
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

	;============================
	; see if hit end
	;============================
	; runs from #60-68

	;=============================
	; let dots out one by one
	inc	FRAME

	lda	FRAME
	and	#$7
	bne	dots_good

	lda	MAX_DOTS
	cmp	#15
	bcs	dots_good

	inc	MAX_DOTS

dots_good:

	;=======================
	; increase dots at 64

	lda	#64
	cmp	current_pattern_smc+1
	bne	dot_count_good64

	lda	#23
	sta	MAX_DOTS

dot_count_good64:

	;=======================
	; increase dots at 66

	lda	#66
	cmp	current_pattern_smc+1
	bne	dot_count_good66

	lda	#31
	sta	MAX_DOTS

dot_count_good66:

	lda	#31
	cmp	MAX_DOTS
	bne	not_31

	lda	FRAME
	and	#$f
	bne	not_31
	inc	Y_OFFSET

not_31:
	;======================
	; check for end

	lda	#68
	jsr	wait_for_pattern
	bcs	dots_done

	jmp	dots_loop

dots_done:
	jsr	clear_top
	jsr	clear_bottom

;	lda	#50
;	jsr	wait

	rts



	.include "../gr_pageflip.s"
;	.include "../gr_fast_clear.s"
	.include "../gr_copy.s"
	.include "../gr_offsets_split.s"
	.include "../gr_offsets.s"
	.include "../gr_plot.s"


	.include	"../wait_keypress.s"

	.include	"../irq_wait.s"


wide_points_x:
	.byte	 8,11,17,25,30,28,20,13
	.byte	 9,14,21,28,30,24,17,11
	.byte	14,16,19,22,25,24,20,17
	.byte	15,17,20,21,24,23,20,18

wide_points_y:
;	.byte	19,16,12,11,14,18,20,21
;	.byte	18,13,11,12,16,19,20,20

	.byte	 9, 6 ,2,1,4,8,10,11
	.byte	15,12, 8,7,10,14,16,17
	.byte	 1, 3 ,5,7,9,11,13,15
	.byte	 2, 6,10,14,14,10,6,2

dot_direction:
	.byte	 1, 1, 1, 1, 1, 1, 1, 1
	.byte	 1, 1, 1, 1, 1, 1, 1, 1
	.byte	 1, 1, 1, 1, 1, 1, 1, 1
	.byte	 1, 1, 1, 1, 1, 1, 1, 1
