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
	; TODO: move this elsewhere


;	lda	#<robe_sprite_data
;	sta	zx_src_l+1
;	lda	#>robe_sprite_data
;	sta	zx_src_h+1

;	lda	#$a0

;	jsr	zx02_full_decomp

;	lda	#0
;	jsr	load_peasant_sprites



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


	;=====================
	; load bg

	lda	#<BG_LOCATION
	sta	zx_src_l+1
	lda	#>BG_LOCATION
	sta	zx_src_h+1

	lda	#>BACKGROUND_DESTINATION	; load to $6000

	jsr	zx02_full_decomp



	;========================
	; Load Core
	;========================

	lda	#<CORE_LOCATION
	sta	zx_src_l+1
	lda	#>CORE_LOCATION
	sta	zx_src_h+1

	lda	#>CORE_DESTINATION

	jsr	zx02_full_decomp


