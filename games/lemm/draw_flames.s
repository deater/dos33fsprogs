	;=======================
	; draw exit flames
	;=======================

draw_flames:

	; draw left_flame
	lda	FRAMEL
	and	#$3
	tay

	lda	lflame_l,Y
	sta	INL
	lda	lflame_h,Y
	sta	INH

l_flame_x_smc:
	ldx	#31		; 217
        stx     XPOS
l_flame_y_smc:
	lda	#108
	sta	YPOS

	jsr	hgr_draw_sprite


	; draw right_flame
	lda	FRAMEL
	and	#$3
	tay

	lda	rflame_l,Y
	sta	INL
	lda	rflame_h,Y
	sta	INH

r_flame_x_smc:
	ldx	#35		; 245
        stx     XPOS
r_flame_y_smc:
	lda	#108
	sta	YPOS

	jmp	hgr_draw_sprite

;	rts


lflame_l:
.byte	<lflame1_sprite,<lflame2_sprite,<lflame3_sprite,<lflame4_sprite

lflame_h:
.byte	>lflame1_sprite,>lflame2_sprite,>lflame3_sprite,>lflame4_sprite

rflame_l:
.byte	<rflame1_sprite,<rflame2_sprite,<rflame3_sprite,<rflame4_sprite

rflame_h:
.byte	>rflame1_sprite,>rflame2_sprite,>rflame3_sprite,>rflame4_sprite




	;=======================
	; draw exit flames (green)
	;=======================

draw_flames_green:

	; draw left_flame
	lda	FRAMEL
	and	#$3
	tay

	lda	lflame_g_l,Y
	sta	INL
	lda	lflame_g_h,Y
	sta	INH

l_flame_g_x_smc:
	ldx	#31		; 217
        stx     XPOS
l_flame_g_y_smc:
	lda	#108
	sta	YPOS

	jsr	hgr_draw_sprite


	; draw right_flame
	lda	FRAMEL
	and	#$3
	tay

	lda	rflame_g_l,Y
	sta	INL
	lda	rflame_g_h,Y
	sta	INH

r_flame_g_x_smc:
	ldx	#35		; 245
        stx     XPOS
r_flame_g_y_smc:
	lda	#108
	sta	YPOS

	jmp	hgr_draw_sprite

;	rts


lflame_g_l:
.byte	<lflameg1_sprite,<lflameg2_sprite,<lflameg3_sprite,<lflameg4_sprite

lflame_g_h:
.byte	>lflameg1_sprite,>lflameg2_sprite,>lflameg3_sprite,>lflameg4_sprite

rflame_g_l:
.byte	<rflameg1_sprite,<rflameg2_sprite,<rflameg3_sprite,<rflameg4_sprite

rflame_g_h:
.byte	>rflameg1_sprite,>rflameg2_sprite,>rflameg3_sprite,>rflameg4_sprite

