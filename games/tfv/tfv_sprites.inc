; Hand generated as I'm too lazy to automate this

;tb1_sprite:
;	.byte $8,$4
;	.byte $55,$5A,$AA,$AA,$AA,$AA,$AA,$AA
;	.byte $55,$55,$55,$AA,$AA,$AA,$AA,$AA
;	.byte $ff,$1f,$4f,$2f,$ff,$22,$2A,$AA
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

;====================
; TFV Battle Sprites
;====================

tfv_battle1_sprite:
	.byte $4,$6
	.byte $AA,$BD,$DD,$AA
	.byte $AB,$DB,$DD,$AA
	.byte $AA,$AA,$22,$AA
	.byte $AB,$A2,$22,$AA
	.byte $AA,$22,$22,$2A
	.byte $8A,$82,$AA,$82

tfv_battle2_sprite:
	.byte $4,$6
	.byte $AA,$DA,$DA,$AA
	.byte $BA,$BB,$DD,$AA
	.byte $AA,$AD,$2D,$AA
	.byte $BA,$2A,$22,$AA
	.byte $AA,$2A,$22,$22
	.byte $8A,$82,$AA,$82


tfv_led_sword_sprite:
	.byte $5,$3
	.byte $1A,$AA,$1A,$AA,$AA
	.byte $1A,$A1,$1A,$1A,$1A
	.byte $AA,$AA,$11,$A1,$1A

tfv_led_sword2_sprite:
	.byte $5,$3
	.byte $A1,$1A,$A1,$AA,$AA
	.byte $A1,$AA,$11,$11,$A1
	.byte $AA,$AA,$A1,$AA,$A1


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
	.byte 8,7
	.byte $AA,$AA,$AA,$AA,$AA,$4A,$A4,$4A
	.byte $AA,$4A,$A4,$44,$84,$4A,$AA,$AA
	.byte $A4,$AA,$4A,$A5,$88,$AA,$A4,$4A
	.byte $AA,$44,$AA,$AA,$A8,$8A,$AA,$AA
	.byte $AA,$AA,$AA,$AA,$AA,$88,$AA,$AA
	.byte $AA,$AA,$AA,$AA,$8A,$A8,$AA,$AA
	.byte $AA,$AA,$AA,$AA,$88,$AA,$AA,$AA

; Pine Tree

pine_tree:
	.byte 7,6
	.byte $AA,$AA,$AA,$44,$AA,$AA,$AA
	.byte $AA,$AA,$AA,$44,$AA,$AA,$AA
	.byte $AA,$AA,$44,$44,$44,$AA,$AA
	.byte $AA,$A4,$44,$44,$44,$A4,$AA
	.byte $A4,$A4,$A4,$84,$A4,$A4,$A4
	.byte $AA,$AA,$AA,$88,$AA,$AA,$AA

; Snowy Tree

snowy_tree:
	.byte 7,6
	.byte $AA,$AA,$AA,$77,$AA,$AA,$AA
	.byte $AA,$AA,$AA,$77,$AA,$AA,$AA
	.byte $AA,$AA,$77,$44,$44,$AA,$AA
	.byte $AA,$A7,$44,$44,$44,$A4,$AA
	.byte $A7,$A4,$A4,$84,$A4,$A4,$A4
	.byte $AA,$AA,$AA,$88,$AA,$AA,$AA

; Cactus
cactus:
	.byte 5,6
	.byte $AA,$AA,$44,$AA,$AA
	.byte $44,$AA,$44,$AA,$4A
	.byte $44,$AA,$44,$AA,$44
	.byte $A4,$A4,$44,$A4,$A4
	.byte $AA,$AA,$44,$AA,$AA
	.byte $AA,$AA,$44,$AA,$AA

; Mountain

mountain:
	.byte 13,7
	.byte $AA,$AA,$AA,$AA,$AA,$7A,$f7,$7A,$AA,$AA,$AA,$AA,$AA
	.byte $AA,$AA,$AA,$AA,$77,$ff,$ff,$77,$AA,$AA,$AA,$AA,$AA
	.byte $AA,$AA,$AA,$9A,$8D,$88,$48,$58,$85,$5A,$AA,$AA,$AA
	.byte $AA,$AA,$DA,$9D,$88,$88,$88,$48,$88,$55,$5A,$AA,$AA
	.byte $AA,$DA,$89,$88,$88,$89,$88,$88,$88,$88,$85,$75,$AA
	.byte $DA,$89,$98,$88,$98,$88,$84,$88,$88,$88,$85,$88,$55
	.byte $AA,$AA,$A8,$A8,$A8,$A8,$A8,$88,$88,$88,$A8,$AA,$AA

;Lightning, @25,4 */

lightning:
	.byte 6,5
	.byte $AA,$AA,$dd,$AA,$AA,$AA
	.byte $AA,$AA,$AA,$dd,$AA,$AA
	.byte $AA,$AA,$dd,$AA,$dd,$AA
	.byte $AA,$dd,$AA,$AA,$dd,$AA
	.byte $dd,$AA,$AA,$Ad,$AA,$dd

