;================
; Ship Sprites
;================

splash_forward:
	.byte $7,$2
	.byte $00,$ee,$00,$00,$00,$ee,$00
	.byte $ee,$00,$00,$00,$00,$00,$ee

splash_forward_aux:
	.byte $7,$2
	.byte $00,$ee,$00,$00,$00,$ee,$00
	.byte $ee,$00,$00,$00,$00,$00,$ee

splash_right:
	.byte $7,$2
	.byte $00,$00,$00,$00,$00,$ee,$00
	.byte $00,$00,$00,$00,$00,$00,$ee

splash_right_aux:
	.byte $7,$2
	.byte $00,$00,$00,$00,$00,$ee,$00
	.byte $00,$00,$00,$00,$00,$00,$ee

splash_left:
	.byte $7,$2
	.byte $00,$ee,$00,$00,$00,$00,$00
	.byte $ee,$00,$00,$00,$00,$00,$00

splash_left_aux:
	.byte $7,$2
	.byte $00,$ee,$00,$00,$00,$00,$00
	.byte $ee,$00,$00,$00,$00,$00,$00

shadow_forward:
	.byte $3,$2
	.byte $00,$aa,$00
	.byte $a0,$aa,$a0

shadow_forward_aux:
	.byte $3,$2
	.byte $00,$aa,$00
	.byte $a0,$aa,$a0

shadow_right:
	.byte $3,$2
	.byte $a0,$00,$aa
	.byte $00,$0a,$a0

shadow_right_aux:
	.byte $3,$2
	.byte $a0,$00,$aa
	.byte $00,$0a,$a0

shadow_left:
	.byte $3,$2
	.byte $aa,$00,$a0
	.byte $a0,$0a,$00

shadow_left_aux:
	.byte $3,$2
	.byte $aa,$00,$a0
	.byte $a0,$0a,$00

ship_forward:
	.byte $9,$5
	.byte $00,$00,$00,$00,$ff,$00,$00,$00,$00
	.byte $00,$00,$00,$66,$ff,$66,$00,$00,$00
	.byte $00,$00,$70,$2f,$12,$2f,$70,$00,$00
	.byte $f0,$f7,$f7,$f2,$d9,$f2,$f7,$f7,$f0
	.byte $00,$00,$00,$00,$0d,$00,$00,$00,$00

ship_forward_aux:
	.byte $9,$5
	.byte $00,$00,$00,$00,$ff,$00,$00,$00,$00
	.byte $00,$00,$00,$44,$ff,$44,$00,$00,$00
	.byte $00,$00,$b0,$1f,$81,$1f,$b0,$00,$00
	.byte $f0,$fb,$fb,$f1,$dc,$f1,$fb,$fb,$f0
	.byte $00,$00,$00,$00,$0e,$00,$00,$00,$00


ship_right:
	.byte $9,$5
	.byte $00,$00,$00,$00,$00,$60,$60,$f0,$00
	.byte $00,$f0,$70,$70,$f6,$f6,$6f,$66,$00
	.byte $00,$07,$ff,$2f,$12,$27,$f6,$00,$00
	.byte $00,$00,$00,$dd,$d9,$f2,$77,$00,$00
	.byte $00,$00,$00,$00,$00,$0f,$ff,$70,$00

ship_right_aux:
	.byte $9,$5
	.byte $00,$00,$00,$00,$00,$60,$60,$f0,$00
	.byte $00,$f0,$70,$70,$f6,$f6,$6f,$66,$00
	.byte $00,$07,$ff,$2f,$12,$27,$f6,$00,$00
	.byte $00,$00,$00,$dd,$d9,$f2,$77,$00,$00
	.byte $00,$00,$00,$00,$00,$0f,$ff,$70,$00

ship_left:
	.byte $9,$5
	.byte $00,$f0,$60,$60,$00,$00,$00,$00,$00
	.byte $00,$66,$6f,$f6,$f6,$70,$70,$f0,$00
	.byte $00,$00,$f6,$27,$12,$2f,$ff,$07,$00
	.byte $00,$00,$77,$f2,$d9,$dd,$00,$00,$00
	.byte $00,$70,$ff,$0f,$00,$00,$00,$00,$00

ship_left_aux:
	.byte $9,$5
	.byte $00,$f0,$60,$60,$00,$00,$00,$00,$00
	.byte $00,$66,$6f,$f6,$f6,$70,$70,$f0,$00
	.byte $00,$00,$f6,$27,$12,$2f,$ff,$07,$00
	.byte $00,$00,$77,$f2,$d9,$dd,$00,$00,$00
	.byte $00,$70,$ff,$0f,$00,$00,$00,$00,$00
