	;=========================
	; draw sleeping trogdor
	;=========================
	; actual frames:
	; 	 0..16: do nothing
	; 	17..59: draw sleep sprite
	; 	60..63: puff1
	; 	64..67: puff2
	;	68..71: puff3
	;	72..75: puff4
	;	76..79: puff5
	;	80..83: puff6


draw_sleeping_trogdor:
	inc	SLEEP_COUNT
	lda	SLEEP_COUNT
	cmp	#84
	bne	sleep_good
	lda	#0
	sta	SLEEP_COUNT
sleep_good:

	; draw breath sprite if 17..59

	lda	SLEEP_COUNT
	cmp	#17
	bcc	done_breathing		; blt
	cmp	#60
	bcs	done_breathing

	; trogdor sleep top

	lda	#20			; 140/7=20
	sta	CURSOR_X
	lda	#144
	sta	CURSOR_Y
	lda	#<sleep_sprite0
	sta	INL
	lda	#>sleep_sprite0
	sta	INH

	jsr	hgr_draw_sprite

	; trogdor sleep bottom

	lda	#20			; 140/7=20
	sta	CURSOR_X
	lda	#163
	sta	CURSOR_Y
	lda	#<sleep_sprite1
	sta	INL
	lda	#>sleep_sprite1
	sta	INH

	jsr	hgr_draw_sprite

done_breathing:

	; draw smoke

	lda	SLEEP_COUNT
	cmp	#60
	bcc	done_smoke		; blt

	sec
	sbc	#60
	lsr
	lsr
	tax

	lda	#17			; 119/7=17
	sta	CURSOR_X
	lda	smoke_y,X
	sta	CURSOR_Y
	lda	smoke_sprite_l,X
	sta	INL
	lda	smoke_sprite_h,X
	sta	INH

	jsr	hgr_draw_sprite


done_smoke:

	rts

smoke_y:
	.byte	130,118,111,103,96,87

smoke_sprite_l:
	.byte <smoke0_sprite,<smoke1_sprite,<smoke2_sprite,<smoke3_sprite
	.byte <smoke4_sprite,<smoke5_sprite
smoke_sprite_h:
	.byte >smoke0_sprite,>smoke1_sprite,>smoke2_sprite,>smoke3_sprite
	.byte >smoke4_sprite,>smoke5_sprite


;draw_sprite_x:
;.byte  22, 22, 18, 18,18,18
;draw_sprite_y:
;.byte 146,146,130,108,95,80
;draw_sprite_l:
;.byte <sleep1_sprite		; do nothing
;.byte <sleep2_sprite		; draw open mouth
;.byte <smoke2_sprite		; draw smoke2
;.byte <smoke3_sprite		; draw smoke3
;.byte <smoke4_sprite		; draw smoke4
;.byte <smoke5_sprite		; draw smoke5
;draw_sprite_h:
;.byte >sleep1_sprite
;.byte >sleep2_sprite
;.byte >smoke2_sprite
;.byte >smoke3_sprite
;.byte >smoke4_sprite
;.byte >smoke5_sprite

