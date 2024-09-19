; Peasant's Quest

; o/~ It's The Map o/~

; by Vince `deater` Weaver	vince@deater.net

.include "../hardware.inc"
.include "../zp.inc"

.include "../qload.inc"
.include "../inventory/inventory.inc"
.include "../parse_input.inc"

LOCATION_BASE	= LOCATION_MAP

the_map:
	lda	#0
	sta	LEVEL_OVER
	sta	FRAME

	jsr	hgr_make_tables
	jsr	hgr2

	;=============================
	;=============================
	; new screen location
	;=============================
	;=============================

	lda	#0
	sta	LEVEL_OVER

	;=====================
	; load bg

	lda     MAP_LOCATION
	sec
	sbc     #LOCATION_BASE
	tax

	lda	#<map_zx02
	sta	zx_src_l+1
	lda	#>map_zx02
	sta	zx_src_h+1

	lda	#$40

	jsr	zx02_full_decomp

game_loop:

	bit	KEYRESET

	jsr	wait_until_keypress

	lda	PREVIOUS_LOCATION

	jmp	update_map_location


.include "../new_map_location.s"

.include "graphics_map/map_graphics.inc"


