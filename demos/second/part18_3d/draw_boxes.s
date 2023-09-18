;
;
; optional color, x1,y1 x2,y2
;
;	HLIN	x1,x2 at y1
;	VLIN	y1,y2 at X1
;	PLOT	x1,y1
;	BOX	x1,y1 to x2,y2
;	CLEAR	-

; data in INL/INH

SET_COLOR = $80
END	=	$00
CLEAR	=	$01
BOX	=	$02
HLIN	=	$03
VLIN	=	$04

BLACK		= $00
RED		= $01
DARK_BLUE	= $02
MAGENTA		= $03
GREEN		= $04
GREY1		= $05
MEDIUM_BLUE	= $06
LIGHT_BLUE	= $07
BROWN		= $08
ORANGE		= $09
GREY2		= $0A
PINK		= $0B
LIGHT_GREEN	= $0C
YELLOW		= $0D
AQUA		= $0E
WHITE		= $0f



draw_scene:

	ldy	#0

	lda	(INL),Y
	bmi	set_color
	beq	done_scene

	; use jump table for rest
	and	#$7f
	tax
	dex				; types start at 1
	lda	draw_table_h,X
	pha
	lda     draw_table_l,X
	pha
	rts				; jump to it

done_scene:
	inc	INL
	bne	really_done_scene
	inc	INH
really_done_scene:
	rts

set_color:
	; make top and bottom byte the same

	and	#$f
	sta	COLOR
	asl
	asl
	asl
	asl
	adc	COLOR
	sta	COLOR

	lda	#1		; we were one byte long
	bne	update_pointer


	; adds A to input pointer and continues
update_pointer:
	clc
	adc	INL
	sta	INL
	lda	#0
	adc	INH
	sta	INH
	jmp	draw_scene



draw_table_l:
	.byte	<(clear_screen-1),<(draw_box-1),<(draw_hlin-1),<(draw_vlin-1)
	.byte	<(draw_plot-1)
draw_table_h:
	.byte	>(clear_screen-1),>(draw_box-1),>(draw_hlin-1),>(draw_vlin-1)
	.byte	>(draw_plot-1)

	;=================================
	;=================================
	; clear screen
	;=================================
	;=================================
clear_screen:
	jsr	clear_fullgr
	lda	#1
	jmp	update_pointer

	;=================================
	;=================================
	; draw box
	;=================================
	;=================================
draw_box:
	iny
	lda	(INL),Y
	sta	X1
	iny
	lda	(INL),Y
	sta	Y1
	iny
	lda	(INL),Y
	sta	X2
	iny
	lda	(INL),Y
	sta	Y2

	lda	Y2
	lsr
	; if even, go to one less
	; else, fine
	bcs	odd_bottom_draw_box
even_bottom_draw_box:
	sec
	sbc	#1

odd_bottom_draw_box:

	sta	draw_box_yend_smc+1

	; see if we start at multiple of two

	lda	Y1
	lsr
	tay
	bcc	even_draw_box_start

	; we're odd, need to call HLIN

	jsr	hlin_mask_odd
	iny


even_draw_box_start:

draw_box_yloop:
	lda	gr_offsets_l,Y
	sta	draw_box_xloop_smc+1

	lda	gr_offsets_h,Y
	clc
	adc	DRAW_PAGE
	sta	draw_box_xloop_smc+2

	lda	COLOR
	ldx	X2
draw_box_xloop:
draw_box_xloop_smc:
	sta	$400,X
	dex
	cpx	X1
	bcs	draw_box_xloop	; bge

	iny
draw_box_yend_smc:
	cpy	#0
	bcc	draw_box_yloop		; less than
	beq	draw_box_yloop		; equal

	; done

	; if Y2 was even we need to fixup and draw one more line

	lda	Y2
	lsr
	bcs	definitely_odd_bottom

	jsr	hlin_mask_even

definitely_odd_bottom:
	; done

	lda	#5
	jmp	update_pointer


	;=================================
	;=================================
	; draw hlin
	;=================================
	;=================================
draw_hlin:

	iny			; FIXME: move to common code
	lda	(INL),Y
	sta	X1
	iny
	lda	(INL),Y
	sta	X2
	iny
	lda	(INL),Y

;	sta	Y1
;	lda	Y1

	lsr
	tay
	bcs	do_hlin_mask_odd
	jsr	hlin_mask_even
	jmp	hlin_done
do_hlin_mask_odd:
	jsr	hlin_mask_odd

	; done
hlin_done:
	lda	#4
	jmp	update_pointer

	;=================================
	;=================================
	; draw vlin
	;=================================
	;=================================
draw_vlin:
	iny
	lda	(INL),Y
	sta	Y1
	iny
	lda	(INL),Y
	sta	Y2
	iny
	lda	(INL),Y
	sta	X1


	lda	Y2
	lsr
	; if even, go to one less
	; else, fine
	bcs	odd_bottom_vlin
even_bottom_vlin:
	sec
	sbc	#1

odd_bottom_vlin:

	sta	vlin_yend_smc+1

	; see if we start at multiple of two

	lda	Y1
	lsr
	tay
	bcc	even_vlin_start

	; we're odd, need to call PLOT

	jsr	plot_mask_odd
	iny


even_vlin_start:

vlin_yloop:
	lda	gr_offsets_l,Y
	sta	vlin_xloop_smc+1

	lda	gr_offsets_h,Y
	clc
	adc	DRAW_PAGE
	sta	vlin_xloop_smc+2

	lda	COLOR
	ldx	X1

vlin_xloop_smc:
	sta	$400,X

	iny
vlin_yend_smc:
	cpy	#0
	bcc	vlin_yloop		; less than
	beq	vlin_yloop		; equal

	; done

	; if Y2 was even we need to fixup and draw one more line

	lda	Y2
	lsr
	bcs	definitely_odd_vlin

	jsr	plot_mask_even

definitely_odd_vlin:
	; done

	lda	#4
	jmp	update_pointer


	;=================================
	;=================================
	; draw plot
	;=================================
	;=================================
draw_plot:
	iny
	lda	(INL),Y
	sta	X1

	iny
	lda	(INL),Y

;	sta	Y1
;	lda	Y1


	lsr
	tay
	bcs	do_plot_mask_odd
	jsr	plot_mask_even
	jmp	plot_done
do_plot_mask_odd:
	jsr	plot_mask_odd

plot_done:

	; done

	lda	#3
	jmp	update_pointer


	;===================================
	;===================================
	; hlin common code
	;===================================
	;===================================
	; X1, X2 set up
	; Y/2 is in Y
	; call the proper entry point
	; Y untouched

hlin_mask_odd:
	lda	#$0F
	.byte	$2C		; bit trick
hlin_mask_even:
	lda	#$F0
	sta	MASK
	eor	#$FF
	and	COLOR
	sta	COLOR2

	lda	gr_offsets_l,Y
	sta	draw_hlin_l_xloop_smc+1
	sta	draw_hlin_s_xloop_smc+1

	lda	gr_offsets_h,Y
	clc
	adc	DRAW_PAGE
	sta	draw_hlin_l_xloop_smc+2
	sta	draw_hlin_s_xloop_smc+2

	ldx	X2
draw_hlin_xloop:
draw_hlin_l_xloop_smc:
	lda	$400,X
	and	MASK
	ora	COLOR2
draw_hlin_s_xloop_smc:
	sta	$400,X
	dex
	cpx	X1
	bpl	draw_hlin_xloop	; bge

	rts

	;===================================
	;===================================
	; plot common code
	;===================================
	;===================================
	; X1, set up
	; Y/2 is in Y
	; call the proper entry point
	; Y untouched

plot_mask_odd:
	lda	#$0F
	.byte	$2C		; bit trick
plot_mask_even:
	lda	#$F0
	sta	MASK
	eor	#$FF
	and	COLOR
	sta	COLOR2

	lda	gr_offsets_l,Y
	sta	plot_l_smc+1
	sta	plot_s_smc+1

	lda	gr_offsets_h,Y
	clc
	adc	DRAW_PAGE
	sta	plot_l_smc+2
	sta	plot_s_smc+2

	ldx	X1
plot_l_smc:
	lda	$400,X
	and	MASK
	ora	COLOR2
plot_s_smc:
	sta	$400,X

	rts


.include "gr_fast_clear.s"

gr_offsets_l:
	.byte	<$400,<$480,<$500,<$580,<$600,<$680,<$700,<$780
	.byte	<$428,<$4a8,<$528,<$5a8,<$628,<$6a8,<$728,<$7a8
	.byte	<$450,<$4d0,<$550,<$5d0,<$650,<$6d0,<$750,<$7d0

gr_offsets_h:
	.byte	>$400,>$480,>$500,>$580,>$600,>$680,>$700,>$780
	.byte	>$428,>$4a8,>$528,>$5a8,>$628,>$6a8,>$728,>$7a8
	.byte	>$450,>$4d0,>$550,>$5d0,>$650,>$6d0,>$750,>$7d0

