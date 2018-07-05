bird_stand_right:
	.byte $6,$7
	.byte $00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$dd,$90
	.byte $00,$00,$00,$00,$dd,$00
	.byte $0d,$dd,$dd,$dd,$dd,$00
	.byte $00,$00,$0d,$dd,$0d,$00
	.byte $00,$00,$00,$99,$00,$00
	.byte $00,$00,$00,$99,$90,$00

bird_walk_right:
	.byte $6,$7
	.byte $00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$dd,$90
	.byte $00,$00,$00,$00,$dd,$00
	.byte $0d,$dd,$dd,$dd,$dd,$00
	.byte $00,$00,$0d,$dd,$0d,$00
	.byte $00,$00,$00,$99,$00,$00
	.byte $00,$00,$99,$00,$99,$00

small_tree:
	.byte $3,$3
	.byte $00,$CC,$00
	.byte $CC,$CC,$CC
	.byte $00,$88,$00

big_tree:
	.byte $5,$5
	.byte $00,$00,$CC,$00,$00
	.byte $00,$C0,$CC,$C0,$00
	.byte $00,$CC,$CC,$CC,$00
	.byte $c0,$CC,$CC,$CC,$c0
	.byte $00,$00,$88,$00,$00
	

blob:
	.byte $3,$3
	.byte $01,$02,$03
	.byte $04,$05,$06
	.byte $07,$08,$09
