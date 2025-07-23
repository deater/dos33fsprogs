	;========================
	; animate brothers
	;=========================
animate_brothers:

	;==========================
	; always animate mendelev
animate_mendelev:
	lda     FRAME
	and     #4
	bne	mendelev_arm_moved

mendelev_normal:

	lda	#<mendelev0_sprite
	sta	INL
	lda	#>mendelev0_sprite
	jmp	mendelev_common

mendelev_arm_moved:

	lda	#<mendelev1_sprite
	sta	INL
	inx
	lda	#>mendelev1_sprite

mendelev_common:

	sta	INH

	lda	#29		; 203/7 = 29
	sta     CURSOR_X
	lda	#96
	sta	CURSOR_Y

	jsr	hgr_draw_sprite		;

	;==========================
	; only animate dongolev if there

	lda	GAME_STATE_0
	and	#HALDO_TO_DONGOLEV
	beq	done_animate_brothers

animate_dongolev:
	lda     FRAME
	adc	#2			; offset from mendelev
	and     #4
	bne	dongolev_mouth_open

dongolevlev_normal:

	lda	#<dongolev0_sprite
	sta	INL
	lda	#>dongolev0_sprite
	jmp	dongolev_common

dongolev_mouth_open:

	lda	#<dongolev1_sprite
	sta	INL
	inx
	lda	#>dongolev1_sprite

dongolev_common:

	sta	INH

	lda	#34		; 238/7 = 34
	sta     CURSOR_X
	lda	#94
	sta	CURSOR_Y

	jsr	hgr_draw_sprite		;

done_animate_brothers:
	rts


	;==============================
	; add dongolev to priority map
	; so we can walk behind him
	;==============================

priority_add_dongolev:

	lda	GAME_STATE_0
	and	#HALDO_TO_DONGOLEV
	beq	done_brothers_priority

	; 64A 11->81
	; 64B 11->88

	lda	#$81
	sta	$64A
	lda	#$88
	sta	$64B

done_brothers_priority:
	rts
