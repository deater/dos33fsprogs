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

SET_COLOR = $C0
END	=	$80
CLEAR	=	$81
BOX	=	$82
HLIN	=	$83
VLIN	=	$84
PLOT	=	$85
HLIN_ADD=	$86
HLIN_ADD_LSAME=	$87
HLIN_ADD_RSAME=	$88
BOX_ADD=	$89
BOX_ADD_LSAME=	$8A
BOX_ADD_RSAME=	$8B

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

; top bit not set, command
; top bit set, repeat last command


; 11xx xxxx

; 00 = co-ord
; 10 = new command
; 11 = new-color

draw_scene:

	lda	#0	; always clear to black
	sta	COLOR
	jsr	clear_fullgr

draw_scene_loop:
	ldy	#0
	lda	(INL),Y				; load next byte

	bpl	repeat_last			; if top bit 0, repeat last
						; command

	asl					; clear top bit
	beq	done_scene			; if 0, END
	bmi	set_color			; if negative, color
	lsr					; shift back down

	sta	LAST_TYPE			; store last type

	jsr	inc_inl

repeat_last:
	lda	LAST_TYPE

;	iny					; point to next byte

	; use jump table for rest
	and	#$3f
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

	lsr					; shift back down
	and	#$f
	sta	COLOR
	asl
	asl
	asl
	asl
	adc	COLOR
	sta	COLOR

	lda	#1		; we were one byte long
;	bne	update_pointer


	; adds A to input pointer and continues
update_pointer:
	clc
	adc	INL
	sta	INL
	lda	#0
	adc	INH
	sta	INH
	jmp	draw_scene_loop



draw_table_l:
	.byte	<(clear_screen-1),<(draw_box-1),<(draw_hlin-1),<(draw_vlin-1)
	.byte	<(draw_plot-1)
	.byte	<(draw_hlin_add-1),<(draw_hlin_add_lsame-1),<(draw_hlin_add_rsame-1)
	.byte	<(draw_box_add-1),<(draw_box_add_lsame-1),<(draw_box_add_rsame-1)
draw_table_h:
	.byte	>(clear_screen-1),>(draw_box-1),>(draw_hlin-1),>(draw_vlin-1)
	.byte	>(draw_plot-1)
	.byte	>(draw_hlin_add-1),>(draw_hlin_add_lsame-1),>(draw_hlin_add_rsame-1)
	.byte	>(draw_box_add-1),>(draw_box_add_lsame-1),>(draw_box_add_rsame-1)

	;=================================
	;=================================
	; clear screen
	;=================================
	;=================================
clear_screen:
	jsr	clear_fullgr
	lda	#0
	jmp	update_pointer

	;=================================
	;=================================
	; draw box
	;=================================
	;=================================

	; blurgh.  Cases
	;	Y1=EVEN, Y2=ODD ->       loop Y1/2 to Y2/2, inclusive
	;	Y1=ODD,  Y2=ODD -> HLIN, loop (Y1/2)+1 to Y2/2 inclusive
	;	Y1=EVEN, Y2=EVEN->       loop Y1/2 to (Y2/2)-1, HLIN
	;	Y1=ODD, Y2=EVEN -> HLIN, loop (Y1/2)+1 to (Y2/2)-1, HLIN
	; 2/3 case, 1 to 1
	; 3/5 case, (>1) 2 to 2
	; 2/4 case, 1 to 1 (<2)
	; 3/4 case, 2 to 1 (!)
	; 3/6 case, 2 to 2
draw_box:
;	iny
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

	jsr	draw_box_common

done_draw_box:
	lda	#4
	jmp	update_pointer


	;==================================
	; draw box common
	;==================================
draw_box_common:
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

draw_box_yend_smc:
	cpy	#0
	bcc	bbbb
	beq	bbbb
	jmp	done_draw_box_yloop		; bge

bbbb:
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
;draw_box_yend_smc:
;	cpy	#0
;	bcc	draw_box_yloop		; less than
;	beq	draw_box_yloop		; equal

	jmp	draw_box_yloop

done_draw_box_yloop:
	; done

	; if Y2 was even we need to fixup and draw one more line

	lda	Y2
	lsr
	bcs	definitely_odd_bottom

	jsr	hlin_mask_even

definitely_odd_bottom:
	; done

	rts



	;=================================
	;=================================
	; draw hlin
	;=================================
	;=================================
draw_hlin:

	lda	(INL),Y
	sta	X1
	iny
	lda	(INL),Y
	sta	X2
	iny
	lda	(INL),Y

	sta	Y1		; needed for HLIN_ADD
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
	lda	#3
	jmp	update_pointer



	;=================================
	;=================================
	; draw hlin add
	;=================================
	;=================================
	; increment Y1
draw_hlin_add:

	lda	(INL),Y
	sta	X1
	iny
	lda	(INL),Y
	sta	X2

	inc	Y1
	lda	Y1

;	sta	Y1
;	lda	Y1

	lsr
	tay
	bcs	do_hlin_add_mask_odd
	jsr	hlin_mask_even
	jmp	hlin_add_done
do_hlin_add_mask_odd:
	jsr	hlin_mask_odd

	; done
hlin_add_done:
	lda	#2
	jmp	update_pointer


	;=================================
	;=================================
	; draw hlin add_lsame
	;=================================
	;=================================
	; increment Y1
	; use old left value
draw_hlin_add_lsame:

	lda	(INL),Y
	sta	X2

	inc	Y1
	lda	Y1

;	sta	Y1
;	lda	Y1

	lsr
	tay
	bcs	do_hlin_add_lsame_mask_odd
	jsr	hlin_mask_even
	jmp	hlin_add_lsame_done
do_hlin_add_lsame_mask_odd:
	jsr	hlin_mask_odd

	; done
hlin_add_lsame_done:
	lda	#1
	jmp	update_pointer


	;=================================
	;=================================
	; draw hlin add_rsame
	;=================================
	;=================================
	; increment Y1
	; use old right value
draw_hlin_add_rsame:

	lda	(INL),Y
	sta	X1

	inc	Y1
	lda	Y1

;	sta	Y1
;	lda	Y1

	lsr
	tay
	bcs	do_hlin_add_rsame_mask_odd
	jsr	hlin_mask_even
	jmp	hlin_add_rsame_done
do_hlin_add_rsame_mask_odd:
	jsr	hlin_mask_odd

	; done
hlin_add_rsame_done:
	lda	#1
	jmp	update_pointer


	;=================================
	;=================================
	; draw box add
	;=================================
	;=================================
	; increment Y2, put into Y1
draw_box_add:
	lda	Y2
	sta	Y1
	inc	Y1

	lda	(INL),Y
	sta	X1
	iny
	lda	(INL),Y
	sta	X2
	iny
	lda	(INL),Y
	sta	Y2

	jsr	draw_box_common

	lda	#3
	jmp	update_pointer


	;=================================
	;=================================
	; draw box add_lsame
	;=================================
	;=================================
	; increment Y2, store in Y1
	; use old X1 value
draw_box_add_lsame:

	lda	Y2
	sta	Y1
	inc	Y1

	lda	(INL),Y
	sta	X2
	iny
	lda	(INL),Y
	sta	Y2

	jsr	draw_box_common

	lda	#2
	jmp	update_pointer


	;=================================
	;=================================
	; draw box add_rsame
	;=================================
	;=================================
	; increment Y2, put in Y1
	; use old right value X2
draw_box_add_rsame:

	lda	Y2
	sta	Y1
	inc	Y1

	lda	(INL),Y
	sta	X1
	iny
	lda	(INL),Y
	sta	Y2

	jsr	draw_box_common

	lda	#2
	jmp	update_pointer





	;=================================
	;=================================
	; draw vlin
	;=================================
	;=================================
draw_vlin:
;	iny
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
vlin_yend_smc:
	cpy	#0
	bcc	cccc
	beq	cccc
	jmp	done_vlin_yloop		;

cccc:

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
;vlin_yend_smc:
;	cpy	#0
;	bcc	vlin_yloop		; less than
;	beq	vlin_yloop		; equal

	jmp	vlin_yloop

	; done
done_vlin_yloop:

	; if Y2 was even we need to fixup and draw one more line

	lda	Y2
	lsr
	bcs	definitely_odd_vlin

	jsr	plot_mask_even

definitely_odd_vlin:
	; done

	lda	#3
	jmp	update_pointer


	;=================================
	;=================================
	; draw plot
	;=================================
	;=================================
draw_plot:
;	iny
	lda	(INL),Y
	sta	X1

	iny
	lda	(INL),Y

	sta	Y1		; needed for HLIN_ADD
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

	lda	#2
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


	; inline this?
inc_inl:
	inc	INL
	bne	done_inc_inl
	inc	INH
done_inc_inl:
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

