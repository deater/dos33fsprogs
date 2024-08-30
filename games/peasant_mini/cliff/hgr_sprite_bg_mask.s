	;===============================================
	; hgr draw sprite, with bg mask in GR $400
	;===============================================
	; used primarily to draw Rather Dashing
	;===============================================
	; attempts to shift for odd/even column
	; cannot handle sprites bigger than 256 bytes

	;
	; Location at CURSOR_X CURSOR_Y

	; for now, BG mask is only all or nothing
	; so we just skip drawing if behind

	; X is sprite to draw

	; Y is save slot

hgr_draw_sprite_bg_mask:

	ldy	#4	; FIXME

	lda	CURSOR_X
	sta	save_xstart,Y
	lda	CURSOR_Y
	sta	save_ystart,Y

	lda	walk_sprites_xsize,X
	clc
	adc	CURSOR_X
	sta	hdsb_width_smc+1
	sta	save_xend,Y

	lda	walk_sprites_ysize,X
	sta	hdsb_ysize_smc+1
	sta	save_yend,Y


	lda	#0
	sta	MASK_COUNTDOWN

	; calculate peasant priority
	; based on head

	lda	PEASANT_Y
	sec
	sbc	#48			; Y=48
	lsr				; div by 8
	lsr
	lsr
	clc
	adc	#2
	sta	PEASANT_PRIORITY

	; set up sprite pointers
	lda	walk_sprites_data_l,X
	sta	h728_smc1+1
	lda	walk_sprites_data_h,X
	sta	h728_smc1+2

	; set up mask pointers
	lda	walk_mask_data_l,X
	sta	h728_smc3+1
	lda	walk_mask_data_h,X
	sta	h728_smc3+2

	ldx	#0			; X is row counter
	stx	CURRENT_ROW
hgr_sprite_bm_yloop:
	lda	MASK_COUNTDOWN
	and	#$3			; only update every 4th
	bne	mask_good

	txa
	pha				; save X

	; recalculate mask
	txa
	clc
	adc	CURSOR_Y
	tax
	ldy	CURSOR_X
	jsr	update_bg_mask


        pla				; restore X
	tax

mask_good:
	lda	MASK
	bne	draw_sprite_skip


	lda	CURRENT_ROW

	clc
	adc	CURSOR_Y		; add in cursor_y

	; calc GBASL/GBASH

	tay				; get output ROW into GBASL/H
	lda	hposn_low,Y
	sta	GBASL
	lda	hposn_high,Y
	sta	GBASH

	ldy	CURSOR_X
	lda	#0
	sta	SPRITE_TEMP
	sta	MASK_TEMP

hsbm_inner_loop:


h728_smc1:
	lda	$d000,X		; or in sprite
	sta	TEMP_SPRITE
h728_smc3:
	lda	$d000,X		; mask with sprite mask
	sta	TEMP_MASK


hsbm_draw_sprite_both:
	lda	(GBASL),Y	; load background
	eor	TEMP_SPRITE
	and	TEMP_MASK

	eor	(GBASL),Y	; store out
	sta	(GBASL),Y	; store out

draw_sprite_skip:



	inx
	iny

hdsb_width_smc:
	cpy	#6
	bne	hsbm_inner_loop

	inc	MASK_COUNTDOWN

	inc	CURRENT_ROW
	lda	CURRENT_ROW

hdsb_ysize_smc:
	cmp	#28
	bne	hgr_sprite_bm_yloop

	rts



	;======================
	; restore bg 1x28
	;======================

restore_bg_1x28:

	; restore bg behind peasant

	; is this actually faster than using the generic version?

	ldy	CURSOR_Y		; y start point

	ldx	#27			; height

restore_yloop:
	; calc GBASL/GBASH using lookup table

	clc
	lda	hposn_low,Y
	adc	PEASANT_X
	sta	restore_page1_smc+1
	sta	restore_page2_smc+1

	; $40 -> $20   0100 0000 -> 0010 0000
	; $41 -> $21   0100 0001 -> 0010 0001
	; $51 -> $31   0101 0011 -> 0101 0001

	lda	hposn_high,Y
	sta	restore_page2_smc+2
	eor	#$60
	sta	restore_page1_smc+2

restore_page1_smc:
	lda	$DDDD
restore_page2_smc:
	sta	$DDDD

	iny

	dex
	bpl	restore_yloop

	rts


	;===================
	; update_bg_mask
	;===================
	; newx/7 in Y
	; newy in X
	; updates MASK
update_bg_mask:

			; rrrr rtii	top 5 bits row, bit 2 top/bottom

	sty	xsave
mask_try_again:
	stx	ysave

	txa
	and	#$04	; see if odd/even
	beq	bg_mask_even

bg_mask_odd:
	lda	#$f0
	bne	bg_mask_mask		; bra

bg_mask_even:
	lda	#$0f
bg_mask_mask:

	sta	MASK

	txa
	lsr
	lsr		; need to divide by 8 then * 2
	lsr		; can't just div by 4 as we need to mask bottom bit
	asl
	tax

	lda	gr_offsets,X
	sta	BASL
	lda	gr_offsets+1,X
	sta	BASH

	lda	(BASL),Y

	ldy	MASK
	cpy	#$f0
	bne	mask_bottom
mask_top:
	lsr
	lsr
	lsr
	lsr
	jmp	mask_mask_mask
mask_bottom:
	and	#$0f
mask_mask_mask:
	sta	MASK

	cmp	#$0			; 0 means collision, find mask
	bne	mask_not_zero		; by iteratively going down till
	ldx	ysave			; non-zero
	ldy	xsave
	inx
	inx
	inx
	inx
	jmp	mask_try_again

mask_not_zero:
	cmp	#$f			; priority F means always on top
	beq	mask_true

	cmp	PEASANT_PRIORITY
	beq	mask_false		; branch less than equal
	bcc	mask_false		; blt

mask_true:
	lda	#$ff
	sta	MASK
	rts

mask_false:
	lda	#$00
	sta	MASK
	rts


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; priorities
; 0 = collision
; 1 = bg = always draw		; Y-48
; 2 	0-55
; 3 	56-63			; 8/8+2 = 3
; 4 	64-71			; 16/8+2 = 4
; 5 	72-79
; 6 	80-87			; 32/8+2 = 6
; 7 	88-95
; 8 	96-103
; 9 	104-111
; 10 	112-119
; 11 	120-127
; 12 	128-135			; 8
; 13 	136-143
; 14	144-151
; 15 = fg = always hide
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;====================
; save area
;====================

;save_sprite_1x28:
;.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

ysave:
.byte $00
xsave:
.byte $00
