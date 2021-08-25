
	;===============================================
	; hgr 7x28 draw sprite, with bg mask in GR $400
	;===============================================
	; SPRITE in INL/INH
	; Location at CURSOR_X CURSOR_Y

	; for now, BG mask is only all or nothing
	; so we just skip drawing if behind

	; left sprite AT INL/INH
	; right sprite at INL/INH + 14
	; left mask at INL/INH + 28
	; right mask at INL/INH + 42

hgr_draw_sprite_7x28:

	lda	#0
	sta	MASK_COUNTDOWN

	; set up pointers
	lda	INL
	sta	h728_smc1+1
	lda	INH
	sta	h728_smc1+2

	clc
	lda	INL
	adc	#28
	sta	h728_smc3+1
	lda	INH
	adc	#0
	sta	h728_smc3+2

	ldx	#0			; X is row counter
hgr_7x28_sprite_yloop:
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


	txa				; X is current row

	clc
	adc	CURSOR_Y		; add in cursor_y

	; calc GBASL/GBASH

	tay				; get output ROW into GBASL/H
	lda	hposn_low,Y
	sta	GBASL
	lda	hposn_high,Y
	sta	GBASH

	ldy	CURSOR_X

	lda	(GBASL),Y	; load background
h728_smc3:
	and	$d000,X		; mask with sprite mask
h728_smc1:
	ora	$d000,X		; or in sprite
	sta	(GBASL),Y	; store out


draw_sprite_skip:

	inc	MASK_COUNTDOWN

	inx
	cpx	#28
	bne	hgr_7x28_sprite_yloop

	rts


	;======================
	; save bg 7x28
	;======================

save_bg_7x28:

	ldx	#0
save_yloop:
	txa
	pha

	clc
	adc	CURSOR_Y


	; calc GBASL/GBASH

	tax
	lda	hposn_low,X
	sta	GBASL
	lda	hposn_high,X
	sta	GBASH

	pla
	tax

	ldy	CURSOR_X

	lda	(GBASL),Y
	sta	save_sprite_7x28,X

	inx
	cpx	#28
	bne	save_yloop

	rts

	;======================
	; restore bg 7x28
	;======================

restore_bg_7x28:

	ldx	#0
restore_yloop:
	txa				; current row
	clc
	adc	CURSOR_Y		; add in y start point

	; calc GBASL/GBASH using lookup table

	tay
	lda	hposn_low,Y
	sta	GBASL
	lda	hposn_high,Y
	sta	GBASH

	ldy	CURSOR_X

	lda	save_sprite_7x28,X
	sta	(GBASL),Y

	inx
	cpx	#28
	bne	restore_yloop

	rts


	;===================
	; update_bg_mask
	;===================
	; newx/7 in Y
	; newy in X
	; updates MASK
update_bg_mask:

	; calculate peasant priority
	; based on head
	; FIXME: only do this once at beginning
	lda	PEASANT_Y
	sec
	sbc	#48			; Y=48
	lsr				; div by 8
	lsr
	lsr
	clc
	adc	#2
	sta	PEASANT_PRIORITY


			; rrrr rtii	top 5 bits row, bit 2 top/bottom

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
; 15    152-159
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;====================
; save area
;====================

save_sprite_7x28:
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
