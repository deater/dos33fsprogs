BACKGROUND_DESTINATION = $6000
CORE_DESTINATION = $8000

	lda	#0
	sta	LEVEL_OVER
	sta	FRAME
	sta	FLAME_COUNT

	jsr	hgr_make_tables		; necessary?


	;========================
	; Load Peasant Sprites
	;========================
	; NOTE: moved to qload (and done once at load/intro)


	;===============================
	; decompress dialog to $D000

	lda	#<DIALOG_LOCATION
        sta     zx_src_l+1
        lda     #>DIALOG_LOCATION
        sta     zx_src_h+1

        lda     #>dialog_location

        jsr     zx02_full_decomp


	;============================
	; load priority to $400
	; indirectly as we can't trash screen holes

	lda	#<PRIORITY_LOCATION
	sta	zx_src_l+1
	lda	#>PRIORITY_LOCATION
	sta	zx_src_h+1

	lda	#>priority_temp		; temporarily load to $6000

	jsr	zx02_full_decomp

	jsr	priority_copy		; copy to $400

	; copy collision detection info

	ldx     #0
col_copy_loop:
	lda	collision_temp,X
	sta	collision_location,X
	inx
	bne	col_copy_loop


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


	;=====================
	; load bg
	;=====================

.ifdef LOAD_NIGHT
	lda	GAME_STATE_1
	and	#NIGHT
	beq	load_bg_normal

load_bg_night:
	lda	#<BG_NIGHT_LOCATION
	sta	zx_src_l+1
	lda	#>BG_NIGHT_LOCATION
	jmp	load_bg_common

.endif

load_bg_normal:
	lda	#<BG_LOCATION
	sta	zx_src_l+1
	lda	#>BG_LOCATION
load_bg_common:
	sta	zx_src_h+1
	lda	#>BACKGROUND_DESTINATION	; load to $6000

	jsr	zx02_full_decomp

