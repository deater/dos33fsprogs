
	;======================
	;======================
	; draw charger
	;======================
	;======================
draw_charger:

	lda	#6
	sta	XPOS
	lda	#24
	sta	YPOS

	lda	CHARGER_COUNT
	tay

	lda	charger_sequence_lo,Y
	sta	INL

	lda	charger_sequence_hi,Y
	sta	INH

	jsr	put_sprite

	lda	FRAMEL				; slow it down
	and	#$7
	bne	done_drawing_charger

	inc	CHARGER_COUNT
	lda	CHARGER_COUNT
	cmp	#11
	bne	done_drawing_charger

	lda	#200				; actually charge
	sta	GUN_CHARGE

	lda	#0
	sta	CHARGER_COUNT

done_charging:

done_drawing_charger:


	rts

charger_sequence_hi:
	.byte >zapper1_sprite
	.byte >zapper2_sprite
	.byte >zapper3_sprite
	.byte >zapper4_sprite
	.byte >zapper5_sprite
	.byte >zapper6_sprite
	.byte >zapper7_sprite
	.byte >zapper8_sprite
	.byte >zapper9_sprite
	.byte >zapper10_sprite
	.byte >zapper11_sprite

charger_sequence_lo:
	.byte <zapper1_sprite
	.byte <zapper2_sprite
	.byte <zapper3_sprite
	.byte <zapper4_sprite
	.byte <zapper5_sprite
	.byte <zapper6_sprite
	.byte <zapper7_sprite
	.byte <zapper8_sprite
	.byte <zapper9_sprite
	.byte <zapper10_sprite
	.byte <zapper11_sprite


zapper1_sprite:
	.byte 10,10
	.byte $AA,$00,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA
	.byte $AA,$00,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA
	.byte $AA,$00,$AA,$AA,$AA,$9A,$9A,$AA,$AA,$AA
	.byte $AA,$00,$AA,$AA,$AA,$bb,$99,$AA,$AA,$AA
	.byte $AA,$00,$AA,$0a,$0a,$AA,$0b,$AA,$AA,$AA
	.byte $AA,$00,$AA,$AA,$A0,$Ab,$b0,$AA,$AA,$AA
	.byte $AA,$00,$AA,$AA,$AA,$AA,$00,$AA,$AA,$AA
	.byte $AA,$00,$AA,$AA,$AA,$AA,$44,$AA,$AA,$AA
	.byte $AA,$00,$AA,$AA,$AA,$44,$c4,$AA,$AA,$AA
	.byte $AA,$00,$AA,$AA,$fA,$f4,$7A,$AA,$AA,$AA

zapper2_sprite:
	.byte 10,10
	.byte $AA,$00,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA
	.byte $AA,$A0,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA
	.byte $AA,$AA,$AA,$AA,$AA,$9A,$9A,$AA,$AA,$AA
	.byte $AA,$AA,$AA,$AA,$AA,$bb,$99,$AA,$AA,$AA
	.byte $AA,$AA,$AA,$0a,$0a,$AA,$0b,$AA,$AA,$AA
	.byte $AA,$AA,$AA,$AA,$A0,$Ab,$b0,$AA,$AA,$AA
	.byte $AA,$AA,$AA,$AA,$AA,$AA,$00,$AA,$AA,$AA
	.byte $AA,$AA,$AA,$AA,$AA,$AA,$44,$AA,$AA,$AA
	.byte $AA,$AA,$AA,$AA,$AA,$44,$c4,$AA,$AA,$AA
	.byte $AA,$00,$AA,$AA,$fA,$f4,$7A,$AA,$AA,$AA

zapper3_sprite:
	.byte 10,10
	.byte $AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA
	.byte $6a,$fe,$fe,$AA,$AA,$AA,$AA,$AA,$AA,$AA
	.byte $ee,$ff,$ff,$ee,$AA,$9A,$9A,$AA,$AA,$AA
	.byte $Ae,$ef,$ef,$6A,$AA,$bb,$99,$AA,$AA,$AA
	.byte $AA,$AA,$66,$0a,$0a,$AA,$0b,$AA,$AA,$AA
	.byte $6A,$66,$AA,$AA,$A0,$Ab,$b0,$AA,$AA,$AA
	.byte $AA,$66,$AA,$AA,$AA,$AA,$00,$AA,$AA,$AA
	.byte $AA,$66,$AA,$AA,$AA,$AA,$44,$AA,$AA,$AA
	.byte $AA,$66,$AA,$AA,$AA,$44,$c4,$AA,$AA,$AA
	.byte $AA,$A6,$AA,$AA,$fA,$af,$7A,$A7,$AA,$AA

zapper4_sprite:
	.byte 10,10
	.byte $AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA
	.byte $AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA
	.byte $a6,$6a,$AA,$AA,$AA,$B9,$99,$AA,$AA,$AA
	.byte $6a,$A6,$66,$AA,$AA,$AB,$b9,$AA,$AA,$AA
	.byte $A6,$AA,$66,$A0,$00,$BA,$00,$AA,$AA,$AA
	.byte $AA,$AA,$66,$AA,$AA,$AA,$0b,$AA,$AA,$AA
	.byte $AA,$66,$A6,$AA,$AA,$AA,$40,$AA,$AA,$AA
	.byte $AA,$66,$6a,$AA,$AA,$4A,$44,$AA,$AA,$AA
	.byte $66,$AA,$66,$AA,$AA,$F4,$AC,$7A,$AA,$AA
	.byte $A6,$AA,$A6,$AA,$AF,$AA,$A7,$AA,$AA,$AA

zapper5_sprite:
	.byte 10,10
	.byte $6A,$6A,$AA,$6a,$AA,$AA,$AA,$AA,$AA,$AA
	.byte $A6,$AA,$AA,$66,$AA,$9A,$9A,$AA,$AA,$AA
	.byte $AA,$AA,$6A,$A6,$AA,$BB,$99,$AA,$AA,$AA
	.byte $AA,$AA,$66,$0A,$0A,$AA,$0b,$AA,$AA,$AA
	.byte $A6,$66,$AA,$66,$A0,$AB,$b0,$AA,$AA,$AA
	.byte $AA,$66,$AA,$66,$AA,$AA,$00,$AA,$EA,$f6
	.byte $66,$AA,$AA,$66,$AA,$AA,$44,$AA,$EE,$FF
	.byte $66,$AA,$AA,$66,$AA,$44,$C4,$AA,$A6,$A6
	.byte $AA,$66,$66,$AA,$FA,$AF,$7A,$A7,$AA,$AA
	.byte $AA,$A6,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA

zapper6_sprite:
	.byte 10,10
	.byte $6A,$6A,$AA,$AA,$6A,$AA,$AA,$AA,$AA,$AA
	.byte $A6,$AA,$AA,$66,$AA,$99,$99,$99,$AA,$AA
	.byte $AA,$AA,$6A,$A6,$AA,$BB,$99,$A9,$AA,$AA
	.byte $AA,$AA,$66,$0A,$0A,$AA,$0b,$AA,$AA,$AA
	.byte $AA,$66,$66,$AA,$A0,$AB,$b0,$AA,$AA,$AA
	.byte $AA,$66,$AA,$66,$AA,$AA,$00,$AA,$AA,$AA
	.byte $66,$66,$AA,$A6,$6A,$AA,$44,$AA,$AA,$AA
	.byte $66,$AA,$AA,$6A,$66,$44,$C4,$AA,$AA,$AA
	.byte $AA,$AA,$6A,$A6,$FA,$AF,$7A,$A7,$AA,$6A
	.byte $A6,$A6,$A6,$AA,$AA,$AA,$AA,$AA,$A6,$A6

zapper7_sprite:
	.byte 10,10
	.byte $6A,$6A,$6A,$6A,$6A,$AA,$AA,$AA,$AA,$AA
	.byte $A6,$AA,$66,$AA,$AA,$99,$99,$99,$AA,$AA
	.byte $AA,$AA,$66,$AA,$AA,$BB,$99,$A9,$AA,$AA
	.byte $AA,$AA,$66,$0A,$0A,$AA,$0b,$AA,$AA,$AA
	.byte $AA,$AA,$66,$AA,$A0,$AB,$b0,$AA,$AA,$AA
	.byte $AA,$66,$AA,$66,$AA,$AA,$00,$AA,$AA,$AA
	.byte $AA,$66,$AA,$A6,$6A,$AA,$44,$AA,$AA,$AA
	.byte $66,$AA,$AA,$6A,$66,$AA,$44,$AA,$AA,$6A
	.byte $66,$AA,$6A,$A6,$AA,$FA,$7F,$67,$6A,$66
	.byte $A6,$AA,$A6,$AA,$AA,$AA,$AA,$6A,$A6,$A6

zapper8_sprite:
	.byte 10,10
	.byte $6A,$0A,$6A,$6A,$6A,$AA,$AA,$AA,$AA,$AA
	.byte $AA,$00,$EA,$EA,$AA,$9A,$9A,$9A,$AA,$AA
	.byte $AA,$EE,$FF,$DD,$AA,$B9,$99,$99,$AA,$AA
	.byte $AA,$AA,$6E,$EE,$EA,$AB,$b9,$AA,$AA,$AA
	.byte $AA,$AA,$66,$EE,$FF,$EE,$00,$AA,$AA,$AA
	.byte $AA,$AA,$AA,$A6,$AE,$AE,$0b,$AA,$AA,$66
	.byte $AA,$AA,$AA,$AA,$AA,$AA,$40,$AA,$AA,$66
	.byte $AA,$A6,$6A,$6A,$6A,$AA,$44,$6A,$AA,$66
	.byte $AA,$00,$66,$A6,$AA,$AA,$F4,$7A,$A6,$A6
	.byte $AA,$00,$A6,$AA,$AA,$AF,$A7,$AA,$AA,$AA

zapper9_sprite:
	.byte 10,10
	.byte $AA,$00,$AA,$6A,$AA,$AA,$AA,$AA,$AA,$6A
	.byte $AA,$00,$AA,$66,$AA,$9A,$9A,$9A,$AA,$66
	.byte $AA,$00,$AA,$A6,$6A,$B9,$99,$99,$A6,$AA
	.byte $AA,$00,$AA,$EA,$AA,$AB,$b9,$AA,$AA,$AA
	.byte $AA,$00,$EE,$FF,$EE,$BA,$00,$AA,$AA,$AA
	.byte $AA,$00,$AA,$AE,$AA,$AA,$0b,$AA,$AA,$AA
	.byte $AA,$00,$6A,$AA,$AA,$AA,$40,$AA,$AA,$AA
	.byte $AA,$00,$66,$AA,$AA,$AA,$44,$6A,$AA,$AA
	.byte $AA,$00,$A6,$6A,$AA,$AA,$F4,$7A,$A6,$66
	.byte $AA,$00,$AA,$AA,$A6,$AF,$A7,$AA,$AA,$AA

zapper10_sprite:
	.byte 10,10
	.byte $6A,$00,$AA,$6A,$AA,$AA,$AA,$AA,$AA,$AA
	.byte $AA,$00,$AA,$A6,$6A,$9A,$9A,$9A,$6A,$6A
	.byte $AA,$00,$AA,$AA,$AA,$B9,$99,$99,$AA,$66
	.byte $AA,$00,$AA,$AA,$AA,$AB,$b9,$AA,$AA,$AA
	.byte $AA,$00,$AA,$A0,$00,$BA,$00,$AA,$AA,$AA
	.byte $AA,$00,$AA,$AA,$AA,$AA,$0b,$AA,$A6,$A6
	.byte $AA,$00,$AA,$6A,$AA,$AA,$40,$AA,$AA,$AA
	.byte $6A,$00,$66,$AA,$AA,$AA,$44,$6A,$AA,$AA
	.byte $AA,$00,$66,$AA,$AA,$AA,$F4,$7A,$A6,$6A
	.byte $AA,$00,$A6,$AA,$AA,$AF,$A7,$AA,$AA,$A6

zapper11_sprite:
	.byte 10,10
	.byte $6A,$00,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA
	.byte $AA,$A0,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA
	.byte $AA,$AA,$AA,$AA,$AA,$9A,$9A,$AA,$AA,$AA
	.byte $AA,$AA,$AA,$AA,$AA,$BB,$99,$AA,$AA,$AA
	.byte $AA,$AA,$AA,$0A,$0A,$AA,$0b,$AA,$AA,$AA
	.byte $AA,$AA,$AA,$AA,$A0,$AB,$b0,$AA,$AA,$AA
	.byte $AA,$AA,$AA,$AA,$AA,$AA,$00,$AA,$AA,$AA
	.byte $AA,$AA,$AA,$AA,$AA,$AA,$40,$AA,$AA,$AA
	.byte $AA,$AA,$AA,$AA,$AA,$AA,$44,$AA,$AA,$AA
	.byte $AA,$00,$AA,$AA,$AA,$FA,$7F,$A7,$AA,$AA


