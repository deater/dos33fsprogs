adv_walk_left_progression:
	.word	adv_stand_left
	.word	adv_walk_left1
	.word	adv_walk_left2
	.word	adv_walk_left3
	.word	adv_walk_left4
	.word	adv_walk_left5
	.word	adv_walk_left6
	.word	adv_walk_left7

adv_walk_right_progression:
	.word	adv_stand_right
	.word	adv_walk_left1
	.word	adv_walk_left2
	.word	adv_walk_left3
	.word	adv_walk_left4
	.word	adv_walk_left5
	.word	adv_walk_left6
	.word	adv_walk_left7


adv_stand_right:
	.byte $4,$8
	.byte $aa,$9a,$9a,$aa
	.byte $aa,$99,$bb,$aa
	.byte $aa,$0b,$aa,$aa
	.byte $aa,$bb,$aa,$aa
	.byte $aa,$bb,$aa,$aa
	.byte $aa,$44,$aa,$aa
	.byte $aa,$44,$aa,$aa
	.byte $aa,$f4,$fa,$aa

adv_stand_left:
	.byte $4,$8
	.byte $aa,$9a,$9a,$aa
	.byte $aa,$bb,$99,$aa
	.byte $aa,$aa,$0b,$aa
	.byte $aa,$aa,$bb,$aa
	.byte $aa,$aa,$bb,$aa
	.byte $aa,$aa,$44,$aa
	.byte $aa,$aa,$44,$aa
	.byte $aa,$fa,$f4,$aa

adv_walk_left1:
	.byte $4,$8
	.byte $aa,$9a,$9a,$aa
	.byte $aa,$bb,$99,$aa
	.byte $aa,$aa,$0b,$aa
	.byte $aa,$aa,$bb,$aa
	.byte $aa,$ba,$0b,$aa
	.byte $aa,$aa,$44,$aa
	.byte $aa,$cc,$44,$aa
	.byte $aa,$fa,$f4,$a5

adv_walk_left2:
	.byte $4,$8
	.byte $aa,$9a,$9a,$aa
	.byte $aa,$bb,$99,$aa
	.byte $aa,$aa,$0b,$aa
	.byte $aa,$aa,$bb,$aa
	.byte $ba,$ab,$00,$ba
	.byte $aa,$aa,$44,$aa
	.byte $aa,$cc,$44,$4a
	.byte $aa,$a5,$fc,$f4

adv_walk_left3:
	.byte $4,$8
	.byte $aa,$9a,$9a,$aa
	.byte $aa,$bb,$99,$aa
	.byte $aa,$aa,$0b,$aa
	.byte $aa,$aa,$bb,$aa
	.byte $ba,$ab,$00,$ba
	.byte $aa,$aa,$44,$aa
	.byte $aa,$cc,$a4,$4a
	.byte $5a,$5c,$fa,$f4

adv_walk_left4:
	.byte $4,$8
	.byte $aa,$9a,$9a,$aa
	.byte $aa,$bb,$99,$aa
	.byte $aa,$aa,$0b,$aa
	.byte $aa,$aa,$bb,$aa
	.byte $aa,$ba,$0b,$aa
	.byte $aa,$aa,$44,$aa
	.byte $aa,$aa,$c4,$4a
	.byte $aa,$5a,$5f,$af

adv_walk_left5:
	.byte $4,$8
	.byte $aa,$9a,$9a,$aa
	.byte $aa,$bb,$99,$aa
	.byte $aa,$aa,$0b,$aa
	.byte $aa,$aa,$bb,$aa
	.byte $aa,$aa,$bb,$aa
	.byte $aa,$aa,$44,$aa
	.byte $aa,$44,$c4,$aa
	.byte $af,$5f,$5c,$aa

adv_walk_left6:
	.byte $4,$8
	.byte $aa,$9a,$9a,$aa
	.byte $aa,$bb,$99,$aa
	.byte $aa,$aa,$0b,$aa
	.byte $aa,$aa,$bb,$aa
	.byte $aa,$ba,$00,$bb
	.byte $aa,$aa,$44,$aa
	.byte $aa,$aa,$44,$aa
	.byte $fa,$f4,$5c,$5c

adv_walk_left7:
	.byte $4,$8
	.byte $aa,$9a,$9a,$aa
	.byte $aa,$bb,$99,$aa
	.byte $aa,$aa,$0b,$aa
	.byte $aa,$aa,$bb,$aa
	.byte $aa,$aa,$0b,$ba
	.byte $aa,$aa,$44,$aa
	.byte $aa,$aa,$44,$aa
	.byte $aa,$fa,$f4,$5c






foreground_plant:
	.byte	$5,$5
	.byte	$aa,$00,$aa,$aa,$aa
	.byte	$aa,$a0,$0a,$aa,$aa
	.byte	$aa,$aa,$00,$aa,$aa
	.byte	$0a,$0a,$00,$aa,$0a
	.byte	$aa,$aa,$00,$aa,$00

