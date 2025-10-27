
;==============================
; copy_main_main
;==============================
; A = MAIN page start (src)
; Y = MAIN page start (dest)
; X = num pages

copy_main_main:

	; self modify
	sta	cmm_src_smc+2
	sty	cmm_dest_smc+2

copy_main_main_outer_loop:

	ldy	#$00
copy_main_main_inner_loop:

cmm_src_smc:
	lda	$AA00,Y
cmm_dest_smc:
	sta	$BB00,Y

	dey
	bne	copy_main_main_inner_loop

	inc	cmm_src_smc+2
	inc	cmm_dest_smc+2
	dex
	bne	copy_main_main_outer_loop

	rts


