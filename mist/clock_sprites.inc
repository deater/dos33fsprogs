
clock_hour_sprites:
	.word hour12_sprite, hour1_sprite, hour2_sprite
	.word  hour3_sprite, hour4_sprite, hour5_sprite
	.word  hour6_sprite, hour7_sprite, hour8_sprite
	.word  hour9_sprite,hour10_sprite,hour11_sprite
clock_minute_sprites:
	.word minute12_sprite, minute1_sprite, minute2_sprite
	.word  minute3_sprite, minute4_sprite, minute5_sprite
	.word  minute6_sprite, minute7_sprite, minute8_sprite
	.word  minute9_sprite,minute10_sprite,minute11_sprite
	
minute12_sprite:
	.byte 3,5
	.byte $aa,$0a,$aa
	.byte $aa,$00,$aa
	.byte $aa,$00,$aa
	.byte $aa,$aa,$aa
	.byte $aa,$aa,$aa

minute1_sprite:
	.byte 3,5
	.byte $aa,$aa,$0a
	.byte $aa,$0a,$a0
	.byte $aa,$00,$aa
	.byte $aa,$aa,$aa
	.byte $aa,$aa,$aa

minute2_sprite:
	.byte 3,5
	.byte $aa,$aa,$aa
	.byte $aa,$aa,$0a
	.byte $aa,$00,$aa
	.byte $aa,$aa,$aa
	.byte $aa,$aa,$aa

minute3_sprite:
	.byte 3,5
	.byte $aa,$aa,$aa
	.byte $aa,$aa,$aa
	.byte $aa,$0a,$0a
	.byte $aa,$aa,$aa
	.byte $aa,$aa,$aa

minute4_sprite:
	.byte 3,5
	.byte $aa,$aa,$aa
	.byte $aa,$aa,$aa
	.byte $aa,$0a,$aa
	.byte $aa,$aa,$00
	.byte $aa,$aa,$aa

minute5_sprite:
	.byte 3,5
	.byte $aa,$aa,$aa
	.byte $aa,$aa,$aa
	.byte $aa,$0a,$aa
	.byte $aa,$00,$aa
	.byte $aa,$aa,$00

minute6_sprite:
	.byte 3,5
	.byte $aa,$aa,$aa
	.byte $aa,$aa,$aa
	.byte $aa,$0a,$aa
	.byte $aa,$00,$aa
	.byte $aa,$00,$aa

minute7_sprite:
	.byte 3,5
	.byte $aa,$aa,$aa
	.byte $aa,$aa,$aa
	.byte $aa,$0a,$aa
	.byte $aa,$00,$aa
	.byte $00,$aa,$aa

minute8_sprite:
	.byte 3,5
	.byte $aa,$aa,$aa
	.byte $aa,$aa,$aa
	.byte $aa,$0a,$aa
	.byte $00,$aa,$aa
	.byte $aa,$aa,$aa

minute9_sprite:
	.byte 3,5
	.byte $aa,$aa,$aa
	.byte $aa,$aa,$aa
	.byte $0a,$0a,$aa
	.byte $aa,$aa,$aa
	.byte $aa,$aa,$aa

minute10_sprite:
	.byte 3,5
	.byte $aa,$aa,$aa
	.byte $0a,$aa,$aa
	.byte $aa,$00,$aa
	.byte $aa,$aa,$aa
	.byte $aa,$aa,$aa

minute11_sprite:
	.byte 3,5
	.byte $00,$aa,$aa
	.byte $aa,$0a,$aa
	.byte $aa,$00,$aa
	.byte $aa,$aa,$aa
	.byte $aa,$aa,$aa



hour12_sprite:
	.byte 3,5
	.byte $fd,$fd,$fd
	.byte $ff,$55,$ff
	.byte $ff,$55,$ff
	.byte $ff,$ff,$ff
	.byte $ff,$ff,$ff

hour1_sprite:
	.byte 3,5
	.byte $fd,$fd,$fd
	.byte $ff,$5f,$f5
	.byte $ff,$55,$ff
	.byte $ff,$ff,$ff
	.byte $ff,$ff,$ff

hour2_sprite:
	.byte 3,5
	.byte $fd,$fd,$fd
	.byte $ff,$ff,$5f
	.byte $ff,$55,$ff
	.byte $ff,$ff,$ff
	.byte $ff,$ff,$ff

hour3_sprite:
	.byte 3,5
	.byte $fd,$fd,$fd
	.byte $ff,$ff,$ff
	.byte $ff,$5f,$5f
	.byte $ff,$ff,$ff
	.byte $ff,$ff,$ff

hour4_sprite:
	.byte 3,5
	.byte $fd,$fd,$fd
	.byte $ff,$ff,$ff
	.byte $ff,$5f,$ff
	.byte $ff,$ff,$55
	.byte $ff,$ff,$ff

hour5_sprite:
	.byte 3,5
	.byte $fd,$fd,$fd
	.byte $ff,$ff,$ff
	.byte $ff,$5f,$ff
	.byte $ff,$55,$ff
	.byte $ff,$ff,$f5

hour6_sprite:
	.byte 3,5
	.byte $fd,$fd,$fd
	.byte $ff,$ff,$ff
	.byte $ff,$5f,$ff
	.byte $ff,$55,$ff
	.byte $ff,$f5,$ff


hour7_sprite:
	.byte 3,5
	.byte $fd,$fd,$fd
	.byte $ff,$ff,$ff
	.byte $ff,$5f,$ff
	.byte $ff,$55,$ff
	.byte $f5,$ff,$ff

hour8_sprite:
	.byte 3,5
	.byte $fd,$fd,$fd
	.byte $ff,$ff,$ff
	.byte $ff,$5f,$ff
	.byte $55,$ff,$ff
	.byte $ff,$ff,$ff

hour9_sprite:
	.byte 3,5
	.byte $fd,$fd,$fd
	.byte $ff,$ff,$ff
	.byte $5f,$5f,$ff
	.byte $ff,$ff,$ff
	.byte $ff,$ff,$ff

hour10_sprite:
	.byte 3,5
	.byte $fd,$fd,$fd
	.byte $5f,$ff,$ff
	.byte $ff,$55,$ff
	.byte $ff,$ff,$ff
	.byte $ff,$ff,$ff

hour11_sprite:
	.byte 3,5
	.byte $5d,$fd,$fd
	.byte $ff,$5f,$ff
	.byte $ff,$55,$ff
	.byte $ff,$ff,$ff
	.byte $ff,$ff,$ff

