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

	lda	#<fire_framebuffer					; 2
	sta	FIRE_FB_L						; 3

	lda	#>fire_framebuffer					; 2
	sta	FIRE_FB_H						; 3

	lda	#<(fire_framebuffer+40)					; 2
	sta	FIRE_FB2_L						; 3

	lda	#>(fire_framebuffer+40)					; 2
	sta	FIRE_FB2_H						; 3

	ldx	#0							; 2

fire_fb_update:

	ldy	#39							; 2
fire_fb_update_loop:

	; Get random 16-bit number

	jsr	random16						; 40

	cpy	#13							; 2
	bcs	fire_b		; bge					; 2/3
fire_a:
	lda	A_VOLUME						; 3
	jmp	fire_vol						; 3

fire_b:
	cpy	#26							; 2
	bcs	fire_c		; bge					; 2/3
	lda	B_VOLUME						; 3
	jmp	fire_vol						; 3
fire_c:
	lda	C_VOLUME						; 3
fire_vol:
	and	#$f							; 2
	sta	FIRE_VOLUME						; 3

	; get random number

	lda	SEEDL							; 3
	and	#$3							; 2
	sta	FIRE_Q							; 3

	; adjust fire height with volume

	lda	FIRE_VOLUME
	cmp	#$8
	bcs	fire_medium	; bge
fire_low:
	; Q=1 3/4 of time
	lda	FIRE_Q
	beq	fire_height_done
fire_low_br:
	lda	#1
	jmp	fire_height_done

fire_medium:
	cmp	#$d
	bcs	fire_high	; blt

	; Q=1 1/2 of time
	lda	FIRE_Q
	and	#$1

	jmp	fire_height_done
fire_high:
	; Q=1 1/4 of time
	lda	FIRE_Q
	cmp	#1
	beq	fire_height_done
fire_high_br:
	lda	#0

fire_height_done:
	sta	FIRE_Q

	sty	FIRE_Y

	;
	cpy	#0
	beq	fire_r_same
	cpy	#39
	beq	fire_r_same



	lda	#$2
	bit	SEEDH
	bne	fire_r_same
	lda	SEEDH
	and	#$1
	beq	r_up
r_down:
	dey
	jmp	fire_r_same
r_up:
	iny
fire_r_same:

	; get next line color
	lda	(FIRE_FB2_L),Y

	ldy	FIRE_Y

	;

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
	beq	fire_update_done
	jmp	fire_fb_update

fire_update_done:


	;===============================
	; copy framebuffer to low-res screen
	;===============================

	lda	#<fire_framebuffer					; 2
	sta	FIRE_FB_L						; 3

	lda	#>fire_framebuffer					; 2
	sta	FIRE_FB_H						; 3

	lda	#<(fire_framebuffer+40)					; 2
	sta	FIRE_FB2_L						; 3

	lda	#>(fire_framebuffer+40)					; 2
	sta	FIRE_FB2_H						; 3

	lda	#16							; 2
	sta	FIRE_FB_LINE						; 3

	ldx	#(FIRE_YSIZE/2)						; 2

fire_fb_copy:

	ldy	FIRE_FB_LINE						; 3
	iny								; 2
	iny								; 2
	sty	FIRE_FB_LINE						; 3

	lda	gr_offsets,Y						; 4+
	sta	OUTL							; 3
	lda	gr_offsets+1,Y						; 4+
	clc								; 2
	adc	DRAW_PAGE						; 3
	sta	OUTH							; 3

	; FIXME: below, can we do this better?  self-modifying code?

	ldy	#39							; 2
fire_fb_copy_loop:
	txa								; 2
	pha								; 3

	; get top byte
	lda	(FIRE_FB_L),Y						; 5+
	tax								; 2
	lda	fire_colors_low,X					; 4+
	pha								; 3

	; get bottom byte
	lda	(FIRE_FB2_L),Y						; 5+
	tax								; 2
	pla								; 4
	ora	fire_colors_high,X					; 4+
	sta	(OUTL),Y		; store out			; 6
	pla								; 4
	tax								; 2

	dey								; 2
	bpl	fire_fb_copy_loop					; 2/3
done_fire_fb_copy_loop:

	; complicated adjustment
	clc								; 2
	lda	FIRE_FB_L						; 3
	adc	#80							; 2
	sta	FIRE_FB_L						; 3
	lda	FIRE_FB_H						; 3
	adc	#0							; 2
	sta	FIRE_FB_H						; 3

	clc								; 2
	lda	FIRE_FB2_L						; 3
	adc	#80							; 2
	sta	FIRE_FB2_L						; 3
	lda	FIRE_FB2_H						; 3
	adc	#0							; 2
	sta	FIRE_FB2_H						; 3

	dex								; 2
	bne	fire_fb_copy						; 2/3


	rts								; 6

fire_colors_low:	.byte	$00,$00,$03,$02,$06,$07,$0E,$0F
fire_colors_high:	.byte	$00,$00,$30,$20,$60,$70,$E0,$F0



	; FIXME: just reserve space in our memory map
fire_framebuffer:
	.res    40*FIRE_YSIZE, $00

