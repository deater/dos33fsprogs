; Hand generated as I'm too lazy to automate this

;tb1_sprite:
;	.byte $8,$4
;	.byte $55,$50,$00,$00,$00,$00,$00,$00
;	.byte $55,$55,$55,$00,$00,$00,$00,$00
;	.byte $ff,$1f,$4f,$2f,$ff,$22,$20,$00
;	.byte $5f,$5f,$5f,$5f,$ff,$f2,$f2,$f2


;===============
; TFV Sprites
;===============

tfv_stand_right_sprite:
	.byte $4,$6
	.byte $AA,$DD,$BD,$AA
	.byte $AA,$DD,$DB,$AB
	.byte $AA,$22,$AA,$AA
	.byte $AA,$22,$A2,$AB
	.byte $AA,$22,$AA,$AA
	.byte $AA,$82,$8A,$AA


tfv_walk_right_sprite:
	.byte $4,$6
	.byte $AA,$DD,$BD,$AA
	.byte $AA,$DD,$DB,$AB
	.byte $AA,$22,$AA,$AA
	.byte $AA,$22,$A2,$BA
	.byte $22,$A2,$2A,$AA
	.byte $82,$AA,$82,$AA

tfv_stand_left_sprite:
	.byte $4,$6
	.byte $AA,$BD,$DD,$AA
	.byte $AB,$DB,$DD,$AA
	.byte $AA,$AA,$22,$AA
	.byte $AB,$A2,$22,$AA
	.byte $AA,$AA,$22,$AA
	.byte $AA,$8A,$82,$AA

tfv_walk_left_sprite:
	.byte $4,$6
	.byte $AA,$BD,$DD,$AA
	.byte $AB,$DB,$DD,$AA
	.byte $AA,$AA,$22,$AA
	.byte $BA,$A2,$22,$AA
	.byte $AA,$2A,$A2,$22
	.byte $AA,$82,$AA,$82

tfv_led_sword_sprite:
	.byte $5,$3
	.byte $1A,$AA,$1A,$AA,$AA
	.byte $1A,$A1,$1A,$1A,$1A
	.byte $AA,$AA,$11,$A1,$1A

tfv_defeat_sprite:
	.byte $7,$3
	.byte $AA,$AA,$AA,$2b,$AA,$AA,$AA
	.byte $88,$AA,$AA,$22,$bA,$bA,$dA
	.byte $88,$22,$22,$22,$dd,$db,$dd

tfv_victory_sprite:
	.byte $4,$6
	.byte $AA,$BD,$2b,$AA
	.byte $AB,$DB,$22,$AA
	.byte $AA,$AA,$22,$AA
	.byte $AA,$AA,$22,$AA
	.byte $AA,$2A,$A2,$22
	.byte $AA,$82,$AA,$82




;================
; Bird Sprites
;================




;=======================
; Background Features
;=======================


; Palm Tree

palm_tree:
	.byte $08,$07
	.byte $00,$00,$00,$00,$00,$40,$04,$40
	.byte $00,$40,$04,$44,$84,$40,$00,$00
	.byte $04,$00,$40,$05,$88,$00,$04,$40
	.byte $00,$44,$00,$00,$08,$80,$00,$00
	.byte $00,$00,$00,$00,$00,$88,$00,$00
	.byte $00,$00,$00,$00,$80,$08,$00,$00
	.byte $00,$00,$00,$00,$88,$00,$00,$00

; Pine Tree

pine_tree:
	.byte $07,$06
	.byte $00,$00,$00,$44,$00,$00,$00
	.byte $00,$00,$00,$44,$00,$00,$00
	.byte $00,$00,$44,$44,$44,$00,$00
	.byte $00,$04,$44,$44,$44,$04,$00
	.byte $04,$04,$04,$84,$04,$04,$04
	.byte $00,$00,$00,$88,$00,$00,$00

; Snowy Tree

snowy_tree:
	.byte $07,$06
	.byte $00,$00,$00,$77,$00,$00,$00
	.byte $00,$00,$00,$77,$00,$00,$00
	.byte $00,$00,$77,$44,$44,$00,$00
	.byte $00,$07,$44,$44,$44,$04,$00
	.byte $07,$04,$04,$84,$04,$04,$04
	.byte $00,$00,$00,$88,$00,$00,$00

; Cactus
cactus:
	.byte $05,$06
	.byte $00,$00,$44,$00,$00
	.byte $44,$00,$44,$00,$40
	.byte $44,$00,$44,$00,$44
	.byte $04,$04,$44,$04,$04
	.byte $00,$00,$44,$00,$00
	.byte $00,$00,$44,$00,$00

; Mountain

mountain:
	.byte $0d,$07
	.byte $00,$00,$00,$00,$00,$70,$f7,$70,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$77,$ff,$ff,$77,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$90,$8D,$88,$48,$58,$85,$50,$00,$00,$00
	.byte $00,$00,$D0,$9D,$88,$88,$88,$48,$88,$55,$50,$00,$00
	.byte $00,$D0,$89,$88,$88,$89,$88,$88,$88,$88,$85,$75,$00
	.byte $D0,$89,$98,$88,$98,$88,$84,$88,$88,$88,$85,$88,$55
	.byte $00,$00,$08,$08,$08,$08,$08,$88,$88,$88,$08,$00,$00

;Lightning, @25,4 */

lightning:
	.byte $06,$05
	.byte $00,$00,$dd,$00,$00,$00
	.byte $00,$00,$00,$dd,$00,$00
	.byte $00,$00,$dd,$00,$dd,$00
	.byte $00,$dd,$00,$00,$dd,$00
	.byte $dd,$00,$00,$0d,$00,$dd

