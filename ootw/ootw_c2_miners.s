; Ootw Checkpoint2 -- the background miners
;			I suspect they are working against their will

ootw_draw_miners:

	; move miners
miner1:
	lda	#10
	sta	XPOS
	lda	#32
	sta	YPOS

	lda	#0

	inc	miner1_smc+1
	bpl	miner1_nomove

miner1_smc:
	lda	#0		; smc
	lsr
	lsr
	lsr
	lsr
miner1_nomove:
	and	#$6
	tay

	lda     miner_sprites,Y
        sta     INL
        lda     miner_sprites+1,Y
        sta     INH

        jsr     put_sprite_crop

miner2:



	lda	#14
	sta	XPOS
	lda	#28
	sta	YPOS

	lda	#0

	inc	miner2_smc+1
	bpl	miner2_nomove

miner2_smc:
	lda	#67		; smc
	lsr
	lsr
	lsr
	lsr
miner2_nomove:
	and	#$6
	tay

	lda     miner_sprites,Y
        sta     INL
        lda     miner_sprites+1,Y
        sta     INH

	jmp     put_sprite_crop		; tail call


miner_sprites:
	.word	miner_sprite0
	.word	miner_sprite1
	.word	miner_sprite2
	.word	miner_sprite3

miner_sprite0:
	.byte	3,4
	.byte	$87,$7A,$AA
	.byte	$55,$AA,$AA
	.byte	$00,$AA,$AA
	.byte	$55,$AA,$AA

miner_sprite1:
	.byte	3,4
	.byte	$AA,$87,$AA
	.byte	$55,$AA,$A7
	.byte	$00,$AA,$AA
	.byte	$55,$AA,$AA

miner_sprite2:
	.byte	3,4
	.byte	$AA,$AA,$AA
	.byte	$55,$8A,$77
	.byte	$00,$AA,$A7
	.byte	$55,$AA,$AA

miner_sprite3:
	.byte	3,4
	.byte	$AA,$AA,$AA
	.byte	$55,$AA,$7A
	.byte	$00,$A8,$77
	.byte	$55,$AA,$AA
