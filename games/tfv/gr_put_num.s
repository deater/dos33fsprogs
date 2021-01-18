
;******    **    ****    ****    **  **  ******    ****  ******  ******  ******
;**  **  ****        **      **  **  **  **      **          **  **  **  **  **
;**  **    **      ****  ****    ******  ****    ******    **    ******  ******
;**  **    **    **          **      **      **  **  **    **    **  **      **
;******  ******  ******  ****        **  ****    ******    **    ******      **

	;===========================
	; gr put num
	;===========================
	; damage in DAMAGE_VAL_LO/HI (BCD)
	; location in XPOS,YPOS

gr_put_num:
	lda	#$ff

	; color should be in A when we get here
gr_put_num_color:
	sta	COLOR

	lda	#1
	sta	gr_put_num_leading_zero

	; put high digit first
	lda	DAMAGE_VAL_HI
	beq	gr_put_num_bottom_byte
	jsr	gr_put_num_byte
gr_put_num_bottom_byte:
	lda	DAMAGE_VAL_LO
	; fallthrough

	;=================================
	; print two-digit BCD number in A
gr_put_num_byte:
	pha				; store on stack

gr_put_num_tens:

	and	#$f0
	bne	gr_put_num_print_tens

	; was zero, check if we should print

	lda	gr_put_num_leading_zero	; if 1, we skip
	bne	gr_put_num_ones

	pla	; restore value
	pha

gr_put_num_print_tens:

	; we were non-zero, notify leading zero
	ldy	#0
	sty	gr_put_num_leading_zero


	; print tens digit
	lsr
	lsr
	lsr
	lsr


	asl
	tay
	lda	number_sprites,Y
	sta	INL
	lda	number_sprites+1,Y
	sta	INH

	jsr	put_sprite_mask

	; point to next
	lda	XPOS
	clc
	adc	#4
	sta	XPOS

gr_put_num_ones:

	; we were non-zero, notify leading zero
	ldy	#0
	sty	gr_put_num_leading_zero

	; print ones digit
	pla
	and	#$f

	asl
	tay
	lda	number_sprites,Y
	sta	INL
	lda	number_sprites+1,Y
	sta	INH

	jsr	put_sprite_mask

	rts



gr_put_num_leading_zero:	.byte	$01


; Numbers


; ******    **    ****    ****    **  **  ******    ****  ******  ******  ******
; **  **  ****        **      **  **  **  **      **          **  **  **  **  **
; **  **    **      ****  ****    ******  ****    ******    **    ******  ******
; **  **    **    **          **      **      **  **  **    **    **  **      **
; ******  ******  ******  ****        **  ****    ******    **    ******      **


number_sprites:
	.word number0_sprite
	.word number1_sprite
	.word number2_sprite
	.word number3_sprite
	.word number4_sprite
	.word number5_sprite
	.word number6_sprite
	.word number7_sprite
	.word number8_sprite
	.word number9_sprite
	.word numberX_sprite
	.word numberX_sprite
	.word numberX_sprite
	.word numberX_sprite
	.word numberX_sprite
	.word numberX_sprite


number0_sprite:
	.byte $3,$3
	.byte $55,$A5,$55
	.byte $55,$AA,$55
	.byte $A5,$A5,$A5

number1_sprite:
	.byte $3,$3
	.byte $5A,$55,$AA
	.byte $AA,$55,$AA
	.byte $A5,$A5,$A5

number2_sprite:
	.byte $3,$3
	.byte $A5,$A5,$5A
	.byte $5A,$A5,$A5
	.byte $A5,$A5,$A5

number3_sprite:
	.byte $3,$3
	.byte $A5,$A5,$5A
	.byte $A5,$A5,$5A
	.byte $A5,$A5,$AA

number4_sprite:
	.byte $3,$3
	.byte $55,$AA,$55
	.byte $A5,$A5,$55
	.byte $AA,$AA,$A5

number5_sprite:
	.byte $3,$3
	.byte $55,$A5,$A5
	.byte $A5,$A5,$5A
	.byte $A5,$A5,$AA

number6_sprite:
	.byte $3,$3
	.byte $5A,$A5,$A5
	.byte $55,$A5,$55
	.byte $A5,$A5,$A5

number7_sprite:
	.byte $3,$3
	.byte $A5,$A5,$55
	.byte $AA,$55,$AA
	.byte $AA,$A5,$AA

number8_sprite:
	.byte $3,$3
	.byte $55,$A5,$55
	.byte $55,$A5,$55
	.byte $A5,$A5,$A5

number9_sprite:
	.byte $3,$3
	.byte $55,$A5,$55
	.byte $A5,$A5,$55
	.byte $AA,$AA,$A5

numberX_sprite:
	.byte $3,$3
	.byte $55,$55,$55
	.byte $55,$55,$55
	.byte $55,$55,$55
