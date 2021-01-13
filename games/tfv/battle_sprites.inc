;=========
; Enemies
;==========

killer_crab_sprite:
	.byte $9,$6
	.byte $99,$AA,$99,$AA,$AA,$AA,$99,$AA,$99
	.byte $A6,$6A,$A6,$AA,$AA,$AA,$A6,$6A,$A6
	.byte $AA,$A6,$4A,$49,$44,$49,$4A,$A6,$AA
	.byte $A6,$A4,$44,$44,$44,$44,$44,$A4,$A6
	.byte $AA,$6A,$A4,$64,$A4,$64,$A4,$6A,$AA
	.byte $44,$AA,$4A,$A4,$AA,$A4,$4A,$AA,$44

plain_fish_sprite:
	.byte $9,$6
	.byte $6A,$AA,$A9,$69,$6A,$6A,$AA,$AA,$AA
	.byte $64,$6A,$66,$66,$66,$66,$66,$6A,$AA
	.byte $64,$66,$66,$66,$46,$66,$64,$66,$AA
	.byte $64,$66,$66,$44,$66,$66,$66,$66,$ee
	.byte $64,$66,$66,$66,$64,$66,$66,$6e,$A5
	.byte $64,$AA,$A6,$66,$66,$66,$A6,$AA,$AA

evil_tree_sprite:
	.byte $9,$6
	.byte $8A,$44,$88,$44,$44,$44,$88,$44,$8A
	.byte $48,$84,$84,$44,$44,$44,$84,$84,$48
	.byte $A4,$A4,$44,$98,$88,$98,$44,$A4,$A4
	.byte $AA,$A8,$A8,$88,$88,$88,$A8,$A8,$AA
	.byte $AA,$AA,$AA,$88,$89,$88,$AA,$AA,$AA
	.byte $AA,$AA,$AA,$88,$88,$88,$AA,$AA,$AA

wood_elf_sprite:
	.byte $9,$6
	.byte $AA,$AA,$AA,$AA,$dd,$bd,$AA,$AA,$AA
	.byte $AA,$AA,$AA,$AA,$dd,$bb,$Ab,$AA,$AA
	.byte $AA,$AA,$AA,$AA,$dd,$4b,$44,$AA,$AA
	.byte $AA,$AA,$dA,$dd,$4d,$44,$AA,$AA,$AA
	.byte $AA,$4A,$4d,$4d,$44,$b4,$AA,$AA,$AA
	.byte $A4,$A4,$AA,$AA,$AA,$bb,$3A,$AA,$AA

giant_bee_sprite:
	.byte $9,$6
	.byte $AA,$6A,$eA,$AA,$AA,$AA,$AA,$AA,$8A
	.byte $AA,$86,$66,$6e,$eA,$dA,$8A,$55,$AA
	.byte $dd,$88,$88,$d6,$86,$d6,$88,$85,$AA
	.byte $dd,$88,$88,$dd,$88,$dd,$d8,$55,$A6
	.byte $Ad,$88,$88,$dd,$88,$dd,$Ad,$AA,$AA
	.byte $5A,$A5,$AA,$5A,$A5,$AA,$A5,$5A,$AA

procrastinon_sprite:
	.byte $9,$6
	.byte $AA,$AA,$AA,$5A,$85,$88,$8A,$AA,$AA
	.byte $AA,$AA,$55,$88,$88,$88,$88,$dd,$AA
	.byte $AA,$AA,$55,$88,$88,$88,$88,$dd,$AA
	.byte $AA,$AA,$A5,$88,$88,$88,$d8,$Ad,$AA
	.byte $AA,$AA,$AA,$AA,$A8,$Ad,$AA,$AA,$AA
	.byte $AA,$AA,$AA,$5A,$5A,$5A,$5A,$AA,$AA

ice_fish_sprite:
	.byte $9,$6
	.byte $1A,$AA,$A1,$71,$7A,$7A,$AA,$AA,$AA
	.byte $17,$7A,$77,$77,$77,$77,$77,$7A,$AA
	.byte $17,$77,$77,$77,$f7,$77,$71,$77,$AA
	.byte $17,$77,$77,$ff,$77,$77,$77,$77,$55
	.byte $17,$77,$77,$77,$7f,$77,$77,$75,$A1
	.byte $17,$AA,$A7,$77,$77,$77,$A7,$AA,$AA

evil_penguin_sprite:
	.byte $9,$6
	.byte $AA,$AA,$AA,$AA,$AA,$5A,$5A,$AA,$AA
	.byte $AA,$AA,$AA,$AA,$5A,$55,$7c,$cA,$AA
	.byte $AA,$AA,$AA,$5A,$55,$77,$AA,$AA,$AA
	.byte $AA,$AA,$AA,$77,$55,$77,$AA,$AA,$AA
	.byte $AA,$AA,$55,$55,$77,$A7,$AA,$AA,$AA
	.byte $AA,$AA,$AA,$cc,$cA,$AA,$AA,$AA,$AA

;===========
; Boss
;===========

roboknee1_sprite:
	.byte $9,$b
	.byte $55,$55,$b5,$AA,$AA,$AA,$AA,$AA,$AA
	.byte $55,$bb,$bb,$Ab,$AA,$5A,$d5,$A5,$5A
	.byte $A5,$b5,$Ab,$AA,$AA,$55,$dA,$Ad,$55
	.byte $88,$88,$88,$AA,$AA,$5A,$A5,$A5,$AA
	.byte $88,$88,$88,$A8,$Ab,$A5,$AA,$AA,$AA
	.byte $88,$88,$88,$8A,$bA,$AA,$AA,$AA,$AA
	.byte $58,$78,$78,$AA,$AA,$AA,$AA,$AA,$AA
	.byte $55,$e1,$e7,$AA,$AA,$AA,$AA,$AA,$AA
	.byte $55,$7e,$4e,$AA,$AA,$AA,$AA,$AA,$AA
	.byte $f5,$A7,$f7,$AA,$AA,$AA,$AA,$AA,$AA
	.byte $88,$88,$88,$88,$AA,$AA,$AA,$AA,$AA

roboknee2_sprite:
	.byte $9,$b
	.byte $55,$55,$b5,$AA,$AA,$5A,$d5,$A5,$5A
	.byte $55,$bb,$bb,$Ab,$AA,$55,$dA,$Ad,$55
	.byte $A5,$b5,$Ab,$AA,$AA,$5A,$A5,$A5,$AA
	.byte $88,$88,$88,$8A,$bA,$A5,$AA,$AA,$AA
	.byte $88,$88,$88,$A8,$Ab,$AA,$AA,$AA,$AA
	.byte $88,$88,$88,$AA,$AA,$AA,$AA,$AA,$AA
	.byte $58,$78,$78,$AA,$AA,$AA,$AA,$AA,$AA
	.byte $55,$e1,$17,$eA,$AA,$AA,$AA,$AA,$AA
	.byte $55,$7e,$Ae,$7e,$2e,$AA,$AA,$AA,$AA
	.byte $f5,$A7,$AA,$87,$87,$AA,$AA,$AA,$AA
	.byte $88,$88,$AA,$A8,$A8,$AA,$AA,$AA,$AA

;===========
; Summons
;===========

metrocat_sprite:
	.byte $b,$9
	.byte $88,$8A,$AA,$AA,$AA,$5A,$AA,$AA,$AA,$8A,$88
	.byte $88,$58,$55,$88,$55,$55,$55,$88,$55,$58,$88
	.byte $58,$55,$55,$55,$88,$55,$88,$55,$55,$55,$58
	.byte $58,$55,$55,$55,$55,$55,$55,$55,$55,$55,$58
	.byte $88,$dd,$00,$dd,$55,$75,$55,$dd,$00,$dd,$88
	.byte $85,$55,$55,$55,$55,$77,$55,$55,$55,$55,$85
	.byte $88,$55,$85,$55,$b5,$b7,$b5,$55,$85,$55,$88
	.byte $AA,$55,$55,$f5,$ff,$8b,$ff,$f5,$55,$55,$AA
	.byte $AA,$AA,$A5,$57,$f8,$f7,$f8,$57,$A5,$AA,$AA

vortex_cannon_sprite:
	.byte $5,$7
	.byte $88,$98,$98,$8A,$AA
	.byte $dd,$d8,$89,$99,$88
	.byte $dd,$dd,$d8,$98,$88
	.byte $dd,$55,$dd,$99,$88
	.byte $dd,$55,$dd,$99,$88
	.byte $Ad,$dd,$dd,$99,$88
	.byte $AA,$Ad,$dd,$89,$88

vortex_sprite:
	.byte $3,$3
	.byte $1A,$A1,$1A
	.byte $11,$AA,$11
	.byte $A1,$1A,$A1

magic_health_sprite:
	.byte $5,$6
	.byte $AA,$AA,$AE,$AA,$AC
	.byte $AA,$Ae,$AA,$Ac,$AA
	.byte $Ae,$AA,$Ac,$AA,$Ae
	.byte $AA,$Ac,$AA,$Ae,$AA
	.byte $Ac,$AA,$Ae,$AA,$Ac
	.byte $AA,$Ae,$AA,$Ac,$AA

magic_fire_sprite:
	.byte $5,$6
	.byte $AA,$AA,$fA,$AA,$AA
	.byte $fA,$AA,$ff,$AA,$fA
	.byte $Af,$fA,$ff,$fA,$Af
	.byte $AA,$ff,$fe,$ff,$AA
	.byte $ff,$AA,$ff,$AA,$ff
	.byte $AA,$AA,$ff,$AA,$AA


magic_ice_sprite:
	.byte $5,$6
	.byte $AA,$Ad,$dA,$AA,$AA
	.byte $AA,$dd,$dd,$dd,$dA
	.byte $dA,$dd,$9d,$dd,$dd
	.byte $dd,$dd,$99,$99,$dd
	.byte $AA,$99,$99,$99,$dd
	.byte $AA,$Ad,$99,$99,$Ad


magic_bolt_sprite:
	.byte $5,$6
	.byte $55,$55,$55,$55,$55
	.byte $A5,$A5,$d5,$A5,$A5
	.byte $AA,$AA,$Ad,$dA,$AA
	.byte $AA,$dA,$Ad,$dA,$AA
	.byte $dA,$Ad,$AA,$Ad,$dA
	.byte $Ad,$AA,$AA,$AA,$Ad


magic_malaise_sprite:
	.byte $5,$6
	.byte $AA,$5A,$5A,$5A,$AA
	.byte $55,$52,$55,$52,$55
	.byte $55,$55,$52,$55,$55
	.byte $A5,$22,$52,$22,$A5
	.byte $AA,$A5,$A5,$A5,$AA
	.byte $AA,$AA,$AA,$AA,$AA





