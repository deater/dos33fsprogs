
clock_hour_sprites:
	.word hour12_sprite,hour1_sprite,hour2_sprite,hour3_sprite
	.word hour12_sprite,hour1_sprite,hour2_sprite,hour3_sprite
	.word hour12_sprite,hour1_sprite,hour2_sprite,hour3_sprite
clock_minute_sprites:
	.word minute12_sprite,minute1_sprite,minute2_sprite,minute3_sprite
	.word minute12_sprite,minute1_sprite,minute2_sprite,minute3_sprite
	.word minute12_sprite,minute1_sprite,minute2_sprite,minute3_sprite
	
hour12_sprite:
	.byte 3,5
	.byte $fd,$0d,$fd
	.byte $ff,$00,$ff
	.byte $ff,$00,$ff
	.byte $ff,$ff,$ff
	.byte $ff,$ff,$ff

hour1_sprite:
	.byte 3,5
	.byte $fd,$fd,$0d
	.byte $ff,$0f,$f0
	.byte $ff,$00,$ff
	.byte $ff,$ff,$ff
	.byte $ff,$ff,$ff

hour2_sprite:
	.byte 3,5
	.byte $fd,$fd,$fd
	.byte $ff,$ff,$0f
	.byte $ff,$00,$ff
	.byte $ff,$ff,$ff
	.byte $ff,$ff,$ff

hour3_sprite:
	.byte 3,5
	.byte $fd,$fd,$fd
	.byte $ff,$ff,$ff
	.byte $ff,$0f,$0f
	.byte $ff,$ff,$ff
	.byte $ff,$ff,$ff

minute12_sprite:
	.byte 3,5
	.byte $aa,$aa,$aa
	.byte $aa,$00,$aa
	.byte $aa,$00,$aa
	.byte $aa,$aa,$aa
	.byte $aa,$aa,$aa

minute1_sprite:
	.byte 3,5
	.byte $aa,$aa,$aa
	.byte $aa,$0a,$a0
	.byte $aa,$00,$aa
	.byte $aa,$aa,$aa
	.byte $aa,$aa,$aa

minute2_sprite:
	.byte 3,5
	.byte $aa,$aa,$aa
	.byte $aa,$aa,$5a
	.byte $aa,$00,$aa
	.byte $aa,$aa,$aa
	.byte $aa,$aa,$aa

minute3_sprite:
	.byte 3,5
	.byte $aa,$aa,$aa
	.byte $aa,$aa,$aa
	.byte $aa,$0a,$5a
	.byte $aa,$aa,$aa
	.byte $aa,$aa,$aa


