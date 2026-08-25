; Peasant's Quest

; Kerrek Fall Loader

; by Vince `deater` Weaver	vince@deater.net


.include "../location_common/include_common.s"

kerrek_fall_loader:

CORE_LOCATION=kerrek_fall_core_zx02
BACKGROUND_DESTINATION = $6000
CORE_DESTINATION = $8000

	lda	#0
	sta	LEVEL_OVER
	sta	FRAME
	sta	FLAME_COUNT

	;========================
	; Load Sprites
	;========================

	jsr	load_shooting_sprites

	jsr	load_kerrek_walking_sprites

	jsr	load_kerrek_hit_sprites

	;========================
	; Load Core
	;========================
	; do this before background
	; as we might be located above $6000 if the loader is >8k

	lda	#<CORE_LOCATION
	sta	zx_src_l+1
	lda	#>CORE_LOCATION
	sta	zx_src_h+1

	lda	#>CORE_DESTINATION

	jsr	zx02_full_decomp


        jmp     $8000

kerrek_fall_core_zx02:
.incbin "KERREK_FALL_CORE.zx02"

.include "load_shooting_sprites.s"
