;==============================
; copy_main_aux
;==============================
; A = AUX page start (dest)
; Y = MAIN page start (src)
; X = num pages

copy_main_aux:

	; self modify
	sta	cma_aux_smc+2
	sty	cma_main_smc+2

	; switch to read MAIN/WRITE AUX
	sta	$C002	; read MAIN
	sta	$C005	; write AUX

copy_main_aux_outer_loop:

	ldy	#$00
copy_main_aux_inner_loop:

cma_main_smc:
	lda	$BB00,Y
cma_aux_smc:
	sta	$AA00,Y
	dey
	bne	copy_main_aux_inner_loop

	inc	cma_main_smc+2
	inc	cma_aux_smc+2
	dex
	bne	copy_main_aux_outer_loop

	; switch to read MAIN/WRITE MAIN
	sta	$C002	; read MAIN
	sta	$C004	; write MAIN

	rts



;==============================
; copy_aux_main
;==============================
; A = AUX page start (src)
; Y = MAIN page start (dest)
; X = num pages

copy_aux_main:

	; self modify
	sta	cam_aux_smc+2
	sty	cam_main_smc+2

	; switch to read AUX/WRITE MAIN
	sta	$C003	; read AUX
	sta	$C004	; write MAIN

copy_aux_main_outer_loop:

	ldy	#$00
copy_aux_main_inner_loop:

cam_aux_smc:
	lda	$AA00,Y
cam_main_smc:
	sta	$BB00,Y

	dey
	bne	copy_aux_main_inner_loop

	inc	cam_main_smc+2
	inc	cam_aux_smc+2
	dex
	bne	copy_aux_main_outer_loop

	; switch to read MAIN/WRITE MAIN
	sta	$C002	; read MAIN
	sta	$C004	; write MAIN

	rts



