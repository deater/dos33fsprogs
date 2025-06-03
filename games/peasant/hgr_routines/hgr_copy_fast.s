	;=========================================================
	; hgr copy from $2000 to $4000
	;=========================================================
	; copy $2000 to $4000

	; would be faster if we unroll it, but much bigger

	; 14+ ((14*256)+20)*32 + 5 = 115347 = 8.6fps

	; theoretical unrolled, 30*6 bytes bigger (180 bytes?)
	; 2 + ((9*32)+5)*256 + 5 = 75015 = 13.3 fps

hgr_copy:

	ldx	#0				; 2
	lda	#$20				; 2
	sta	hgr_copy_smc+2			; 4
	lda	#$40				; 2
	sta	hgr_copy_smc+5			; 4

hgr_copy_column:

hgr_copy_smc:
	lda	$2000,X				; 4
	sta	$4000,X				; 5

	dex					; 2
	bne	hgr_copy_column			; 2nt/3t



	inc	hgr_copy_smc+2			; 6
	inc	hgr_copy_smc+5			; 6

	lda	hgr_copy_smc+2			; 4
	cmp	#$40				; 2
	bne	hgr_copy_column			; 2/3

	rts					; 6

