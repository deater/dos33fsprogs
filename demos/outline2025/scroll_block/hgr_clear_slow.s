; inefficient

; thought compressing 8k of zeros might be smaller but it takes 99 bytes?

; in any case if you want to call more than once you'll need to reset
; the address

hgr_clear_slow:

	lda	#0
	ldy	#0
hcs_inner:
	sta	$2000,Y
	iny
	bne	hcs_inner

	inc	hcs_inner+2
	ldx	hcs_inner+2
	cpx	#$40
	bne	hcs_inner

	rts
