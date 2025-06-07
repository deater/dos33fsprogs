
	lda	#0
	sta	LEVEL_OVER
	sta	FRAME
	sta	FLAME_COUNT

	jsr	hgr_make_tables		; necessary?

	;===============================
	; decompress dialog to $D000

	lda	#<DIALOG_LOCATION
        sta     zx_src_l+1
        lda     #>DIALOG_LOCATION
        sta     zx_src_h+1

        lda     #$D0

        jsr     zx02_full_decomp

	;================================
	; update score

;	jsr	update_score


	;=============================
	;=============================
	; new screen location
	;=============================
	;=============================

new_location:
	lda	#0
	sta	LEVEL_OVER

	;============================
	; load priority to $400
	; indirectly as we can't trash screen holes

	lda	#<PRIORITY_LOCATION
	sta	zx_src_l+1
	lda	#>PRIORITY_LOCATION
	sta	zx_src_h+1

	lda	#$20			; temporarily load to $2000

	jsr	zx02_full_decomp

	jsr	gr_copy_to_page1	; copy to $400

	; copy collision detection info

	ldx     #0
col_copy_loop:
	lda	$2400,X
	sta	collision_location,X
	inx
	bne	col_copy_loop


	;=====================
	; load bg

	lda	#<BG_LOCATION
	sta	zx_src_l+1
	lda	#>BG_LOCATION
	sta	zx_src_h+1

	lda	#$80			; load to $8000 (FIXME)

	jsr	zx02_full_decomp


	;====================================
        ; check if allowed to be in haystack

;	jsr	check_haystack_exit


	;=======================
	; put peasant text

;	lda	#<peasant_text
;	sta	OUTL
;	lda	#>peasant_text
;	sta	OUTH

;	jsr	hgr_put_string

	;=======================
	; put score

;	jsr	print_score

	;=======================
	; always activate text

;	jsr	setup_prompt

	;========================
	; Load Peasant Sprites
	;========================

	lda	#<robe_sprite_data
	sta	zx_src_l+1
	lda	#>robe_sprite_data
	sta	zx_src_h+1

	lda	#$a0

	jsr	zx02_full_decomp


	;========================
	; Load Core
	;========================

	lda	#<CORE_LOCATION
	sta	zx_src_l+1
	lda	#>CORE_LOCATION
	sta	zx_src_h+1

	lda	#$60

	jsr	zx02_full_decomp


