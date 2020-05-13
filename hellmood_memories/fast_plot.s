; fast plot
; roughly $4D (77) cycles
; note: ROM plot routine takes $5D (93) cycles

	; color in COLOR
	; horiz=y, vert=A (A trashed, XY Saved)


fast_plot:
	stx	TEMPX						; 3

	ror		; get low bit in carry			; 2
	php		; store for later			; 3
	asl							; 2
	tax							; 2
	lda	gr_offsets,X					; 4+
	sta	plot_smc+1					; 4
	sta	load_old_smc+1					; 4
	lda	gr_offsets+1,X					; 4+
	sta	plot_smc+2					; 4
	sta	load_old_smc+2					; 4
								;===
								; 36

;4->3,4->3,4->0,4->0, 4->5, 5->6

load_old_smc:
	lda	$400,Y						; 4+
	plp							; 4
	bcs	plot_bottom					; 2/3t
								;=====
								; 11
plot_top:
	and	#$f0						; 2
	sta	TEMP						; 3
	lda	COLOR						; 3
	and	#$0f						; 2
	ora	TEMP						; 3
	jmp	plot_smc					; 3
								;====
								; 16
plot_bottom:
	and	#$0f						; 2
	sta	TEMP						; 3
	lda	COLOR						; 3
	and	#$f0						; 2
	ora	TEMP						; 3
plot_smc:
	sta	$400,Y						; 5

	ldx	TEMPX						; 3
	rts							; 6
								;====
								; 14
;.align $100

gr_offsets:
	.word	$400,$480,$500,$580,$600,$680,$700,$780
	.word	$428,$4a8,$528,$5a8,$628,$6a8,$728,$7a8
	.word	$450,$4d0,$550,$5d0,$650,$6d0,$750,$7d0
gr_offsets_end:

;.assert >gr_offsets = >gr_offsets_end, error, "gr_offsets crosses page"

