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
draw_table_h:
	.byte	>(clear_screen-1),>(draw_box-1),>(draw_hlin-1),>(draw_vlin-1)


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
	sta	draw_box_yend_smc+1

	lda	Y1
	lsr
	tay

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
	bne	draw_box_yloop

	; done

	lda	#5
	jmp	update_pointer


	;=================================
	;=================================
	; draw hlin
	;=================================
	;=================================
draw_hlin:
	; done

	lda	#4
	jmp	update_pointer

	;=================================
	;=================================
	; draw vlin
	;=================================
	;=================================
draw_vlin:
	; done

	lda	#4
	jmp	update_pointer



.include "gr_fast_clear.s"

gr_offsets_l:
	.byte	<$400,<$480,<$500,<$580,<$600,<$680,<$700,<$780
	.byte	<$428,<$4a8,<$528,<$5a8,<$628,<$6a8,<$728,<$7a8
	.byte	<$450,<$4d0,<$550,<$5d0,<$650,<$6d0,<$750,<$7d0

gr_offsets_h:
	.byte	>$400,>$480,>$500,>$580,>$600,>$680,>$700,>$780
	.byte	>$428,>$4a8,>$528,>$5a8,>$628,>$6a8,>$728,>$7a8
	.byte	>$450,>$4d0,>$550,>$5d0,>$650,>$6d0,>$750,>$7d0

