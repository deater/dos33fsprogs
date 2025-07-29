

	;==============================
	;==============================
	; remove pot
	;==============================
	;==============================

; 0 (wide arms up)
; 1 (touch pot)
; 2 (push pot up)
; 1 (touch pot)
; 2 (push potup)
; 1 (touch pot)
; 3 (pop off head) (2 frames?)
; 4 to side
; 5 lower
; 6 last
; message




remove_pot_from_head:

	lda	#0
	sta	POT_COUNT
	sta	FRAME

	lda	#SUPPRESS_PEASANT
	sta	SUPPRESS_DRAWING

remove_loop:

	jsr	update_screen

	; draw peasant bottom

	lda	#<peasant_bottom
	sta	INL
	lda	#>peasant_bottom
	sta	INH

	lda	#8				; 56/7=8
	sta	CURSOR_X
	lda	#125
	sta	CURSOR_Y

	jsr	hgr_draw_sprite

	; draw peasant top
	ldy	POT_COUNT
	ldx	peasant_sequence,Y

	lda	peasant_remove_l,X
	sta	INL
	lda	peasant_remove_h,X
	sta	INH

	lda	#7				; 49/7 = 7
	sta	CURSOR_X
	lda	peasant_remove_y,X
	sta	CURSOR_Y

	jsr	hgr_draw_sprite


	; flip page

	jsr	hgr_page_flip

	inc	FRAME			; slow down animation
	lda	FRAME
	and	#$3
	bne	remove_loop

	inc	POT_COUNT
	lda	POT_COUNT
	cmp	#12
	bne	remove_loop

done_remove:
	lda	SUPPRESS_DRAWING
	and	#<(~SUPPRESS_PEASANT)
	sta	SUPPRESS_DRAWING

	rts

peasant_sequence:
	.byte 0,1,2,1, 2,1,3,3
	.byte 4,5,6,6

peasant_remove_y:
	.byte 107,108,108,99, 100,105,108


peasant_remove_l:
	.byte <peasant_top0,<peasant_top1,<peasant_top2
	.byte <peasant_top3,<peasant_top4,<peasant_top5
	.byte <peasant_top6


peasant_remove_h:
	.byte >peasant_top0,>peasant_top1,>peasant_top2
	.byte >peasant_top3,>peasant_top4,>peasant_top5
	.byte >peasant_top6

