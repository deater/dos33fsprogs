; Note there are various we have to handle

; note, depending what order you do some tasks the outfit might be
;	temporarily wrong.  From what I gather the real game has this problem
;	too

; 0 = initial short pants peasant
; 1 = robe  (with on fire variant)
; 2 = mud
; 3 = pot on head
; 4 = haystack

; ones only on last disk
; robe+on fire
; ? = robe + helm
; ? = robe + shield
; ? = robe + sword

peasant_location0:				; original
	.word peasant_original_zx02

peasant_location1:				; robe
	.word peasant_robe_zx02

peasant_location2:				; mud
	.word peasant_mud_zx02

peasant_location3:				; pot
	.word peasant_pot_zx02

peasant_location4:				; haystack
	.word peasant_original_zx02

;==========================

peasant_original_zx02:
	.incbin "walking_sprites.zx02"

peasant_mud_zx02:
	.incbin "mud_sprites.zx02"

peasant_robe_zx02:
	.incbin "robe_sprites.zx02"

peasant_pot_zx02:
	.incbin "robe_pot_sprites.zx02"

