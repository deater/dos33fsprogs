; peasant sprites from last disk

; 0 = robe+shield
; 1 = robe  (with on fire variant)
; 2 = robe+shield+helm
; 3 = robe+shield+helm+sword


peasant_location0:
	.word peasannt_robe_shield_zx02

peasant_location1:
	.word peasant_robe_zx02

peasant_location2:
	.word peasant_robe_shield_zx02

peasant_location3:
	.word peasant_robe_shield_zx02

;==========================

peasant_robe_shield_zx02:
	.incbin "robe_shield_sprites.zx02"

peasant_robe_zx02:
	.incbin "robe_sprites.zx02"

