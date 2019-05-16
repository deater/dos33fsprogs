; Lo-res fire animation, size-optimized

; by deater (Vince Weaver) <vince@deater.net>

; based on code described here http://fabiensanglard.net/doom_fire_psx/

FIRE_YSIZE=20

fire_init:
	lda	#<fire_framebuffer
	sta	FIRE_FB_L

	lda	#>fire_framebuffer
	sta	FIRE_FB_H

	ldx	#FIRE_YSIZE
clear_fire_loop:

	lda	#0
	ldy	#39
clear_fire_line_loop:
	sta	(FIRE_FB_L),Y
	dey
	bpl	clear_fire_line_loop
done_fire_line_loop:

	clc
	lda	FIRE_FB_L
	adc	#40
	sta	FIRE_FB_L
	lda	FIRE_FB_H
	adc	#0
	sta	FIRE_FB_H

	dex
	bne	clear_fire_loop

	lda	#7
	jsr	fire_setline

	rts



	;======================================
	; set bottom line to color in A
	;======================================
	;
fire_setline:

	ldx	#<(fire_framebuffer+(FIRE_YSIZE-1)*40)
	stx	FIRE_FB_L

	ldx	#>(fire_framebuffer+(FIRE_YSIZE-1)*40)
	stx	FIRE_FB_H

	ldy	#39
set_fire_line:
	sta	(FIRE_FB_L),Y
	dey
	bpl	set_fire_line
done_set_fire_line:

	rts


	;===============================
	;===============================
	; Draw fire frame
	;===============================
	;===============================

draw_fire_frame:

	;===============================
	; Update fire frame
	;===============================

	lda	#<fire_framebuffer
	sta	FIRE_FB_L

	lda	#>fire_framebuffer
	sta	FIRE_FB_H

	lda	#<(fire_framebuffer+40)
	sta	FIRE_FB2_L

	lda	#>(fire_framebuffer+40)
	sta	FIRE_FB2_H

	ldx	#0

fire_fb_update:

	ldy	#39
fire_fb_update_loop:

	jsr	random16

	lda	SEEDL
	and	#$1
	sta	FIRE_Q

	; get next line color
	lda	(FIRE_FB2_L),Y

	; adjust it
	sec
	sbc	FIRE_Q

	; saturate to 0
	bpl	fb_positive
	lda	#0
fb_positive:

	; store out
	sta	(FIRE_FB_L),Y		; store out

	dey
	bpl	fire_fb_update_loop

done_fire_fb_update_loop:

	; complicated adjustment
	clc
	lda	FIRE_FB_L
	adc	#40
	sta	FIRE_FB_L
	lda	FIRE_FB_H
	adc	#0
	sta	FIRE_FB_H

	clc
	lda	FIRE_FB2_L
	adc	#40
	sta	FIRE_FB2_L
	lda	FIRE_FB2_H
	adc	#0
	sta	FIRE_FB2_H

	inx
	cpx	#(FIRE_YSIZE-1)
	bne	fire_fb_update



	;===============================
	; copy framebuffer to low-res screen
	;===============================

	lda	#<fire_framebuffer
	sta	FIRE_FB_L

	lda	#>fire_framebuffer
	sta	FIRE_FB_H

	lda	#<(fire_framebuffer+40)
	sta	FIRE_FB2_L

	lda	#>(fire_framebuffer+40)
	sta	FIRE_FB2_H

	lda	#16
	sta	FIRE_FB_LINE

	ldx	#(FIRE_YSIZE/2)

fire_fb_copy:
	lda	FIRE_FB_LINE
	clc
	adc	#$2
	sta	FIRE_FB_LINE
	tay

	lda	gr_offsets,Y
	sta	OUTL
	lda	gr_offsets+1,Y
	clc
	adc	DRAW_PAGE
	sta	OUTH

	; FIXME: below, can we do this better?  self-modifying code?

	ldy	#39
fire_fb_copy_loop:
	txa
	pha

	; get top byte
	lda	(FIRE_FB_L),Y
	tax
	lda	fire_colors_low,X
	pha

	; get bottom byte
	lda	(FIRE_FB2_L),Y
	tax
	pla
	ora	fire_colors_high,X
	sta	(OUTL),Y		; store out
	pla
	tax

	dey
	bpl	fire_fb_copy_loop
done_fire_fb_copy_loop:

	; complicated adjustment
	clc
	lda	FIRE_FB_L
	adc	#80
	sta	FIRE_FB_L
	lda	FIRE_FB_H
	adc	#0
	sta	FIRE_FB_H

	clc
	lda	FIRE_FB2_L
	adc	#80
	sta	FIRE_FB2_L
	lda	FIRE_FB2_H
	adc	#0
	sta	FIRE_FB2_H


	dex
	bne	fire_fb_copy


	rts

fire_colors_low:	.byte	$00,$00,$03,$02,$06,$07,$0E,$0F
fire_colors_high:	.byte	$00,$00,$30,$20,$60,$70,$E0,$F0



	; FIXME: just reserve space in our memory map
fire_framebuffer:
	.res    40*FIRE_YSIZE, $00

