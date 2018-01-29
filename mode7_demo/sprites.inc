;================
; Ship Sprites
;================

splash_forward:
	.byte $7,$2
	.byte $00,$ee,$00,$00,$00,$ee,$00
	.byte $ee,$00,$00,$00,$00,$00,$ee

splash_right:
	.byte $7,$2
	.byte $00,$00,$00,$00,$00,$ee,$00
	.byte $00,$00,$00,$00,$00,$00,$ee


splash_left:
	.byte $7,$2
	.byte $00,$ee,$00,$00,$00,$00,$00
	.byte $ee,$00,$00,$00,$00,$00,$00

shadow_forward:
	.byte $3,$2
	.byte $00,$aa,$00
	.byte $a0,$aa,$a0

shadow_right:
	.byte $3,$2
	.byte $a0,$00,$aa
	.byte $00,$0a,$a0

shadow_left:
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

ship_right:
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

sphere_offset:
	.byte	0,27,54,81, 108,135,162,189

.if 0

sphere0:
	.byte $5,$5
	.byte $00,$b0,$b3,$b0,$00
	.byte $b0,$bb,$bb,$bb,$30
	.byte $bb,$bb,$bb,$bb,$33
	.byte $bb,$bb,$bb,$bb,$33
	.byte $00,$3b,$3b,$3b,$00

sphere1:
	.byte $5,$5
	.byte $00,$30,$bb,$b0,$00
	.byte $30,$bb,$bb,$bb,$b0
	.byte $bb,$bb,$bb,$bb,$bb
	.byte $bb,$bb,$bb,$bb,$bb
	.byte $00,$bb,$bb,$bb,$00

sphere2:
	.byte $5,$5
	.byte $00,$30,$b3,$b0,$00
	.byte $30,$b3,$bb,$bb,$b0
	.byte $33,$bb,$bb,$bb,$bb
	.byte $33,$bb,$bb,$bb,$bb
	.byte $00,$33,$3b,$3b,$00

sphere3:
	.byte $5,$5
	.byte $00,$30,$bb,$b0,$00
	.byte $30,$bb,$bb,$bb,$b0
	.byte $33,$3b,$bb,$bb,$bb
	.byte $33,$33,$3b,$bb,$bb
	.byte $00,$33,$33,$3b,$00

sphere4:
	.byte $5,$5
	.byte $00,$b0,$bb,$b0,$00
	.byte $30,$bb,$bb,$bb,$b0
	.byte $33,$33,$3b,$bb,$bb
	.byte $33,$33,$33,$33,$3b
	.byte $00,$33,$33,$33,$00

sphere5:
	.byte $5,$5
	.byte $00,$b0,$bb,$b0,$00
	.byte $30,$bb,$bb,$bb,$30
	.byte $33,$3b,$3b,$3b,$33
	.byte $33,$33,$33,$33,$33
	.byte $00,$33,$33,$33,$00

sphere6:
	.byte $5,$5
	.byte $00,$30,$bb,$b0,$00
	.byte $30,$bb,$bb,$bb,$30
	.byte $bb,$bb,$bb,$3b,$33
	.byte $33,$3b,$33,$33,$33
	.byte $00,$33,$33,$33,$00

sphere7:
	.byte $5,$5
	.byte $00,$30,$bb,$b0,$00
	.byte $b0,$bb,$bb,$bb,$30
	.byte $bb,$bb,$bb,$bb,$33
	.byte $bb,$bb,$bb,$3b,$33
	.byte $00,$33,$33,$33,$00
.endif

sphere0:
	.byte $5,$5
	.byte $00,$30,$bb,$b0,$00
	.byte $b0,$bb,$bb,$bb,$30
	.byte $bb,$bb,$bb,$bb,$33
	.byte $bb,$bb,$bb,$3b,$33
	.byte $00,$33,$33,$33,$00

sphere1:
	.byte $5,$5
	.byte $00,$30,$bb,$b0,$00
	.byte $30,$bb,$bb,$bb,$30
	.byte $bb,$bb,$bb,$3b,$33
	.byte $33,$3b,$33,$33,$33
	.byte $00,$33,$33,$33,$00

sphere2:
	.byte $5,$5
	.byte $00,$b0,$bb,$b0,$00
	.byte $30,$bb,$bb,$bb,$30
	.byte $33,$3b,$3b,$3b,$33
	.byte $33,$33,$33,$33,$33
	.byte $00,$33,$33,$33,$00

sphere3:
	.byte $5,$5
	.byte $00,$b0,$bb,$b0,$00
	.byte $30,$bb,$bb,$bb,$b0
	.byte $33,$33,$3b,$bb,$bb
	.byte $33,$33,$33,$33,$3b
	.byte $00,$33,$33,$33,$00

sphere4:
	.byte $5,$5
	.byte $00,$30,$bb,$b0,$00
	.byte $30,$bb,$bb,$bb,$b0
	.byte $33,$3b,$bb,$bb,$bb
	.byte $33,$33,$3b,$bb,$bb
	.byte $00,$33,$33,$3b,$00

sphere5:
	.byte $5,$5
	.byte $00,$30,$b3,$b0,$00
	.byte $30,$b3,$bb,$bb,$b0
	.byte $33,$bb,$bb,$bb,$bb
	.byte $33,$bb,$bb,$bb,$bb
	.byte $00,$33,$3b,$3b,$00

sphere6:
	.byte $5,$5
	.byte $00,$30,$bb,$b0,$00
	.byte $30,$bb,$bb,$bb,$b0
	.byte $bb,$bb,$bb,$bb,$bb
	.byte $bb,$bb,$bb,$bb,$bb
	.byte $00,$bb,$bb,$bb,$00

sphere7:
	.byte $5,$5
	.byte $00,$b0,$b3,$b0,$00
	.byte $b0,$bb,$bb,$bb,$30
	.byte $bb,$bb,$bb,$bb,$33
	.byte $bb,$bb,$bb,$bb,$33
	.byte $00,$3b,$3b,$3b,$00




sphere_shadow1:
	.byte $5,$1
	.byte $00,$a0,$a0,$a0,$00

sphere_shadow2:
	.byte $5,$1
	.byte $00,$00,$a0,$00,$00

