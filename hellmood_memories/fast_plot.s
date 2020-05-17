; fast plot
; roughly $4D (77) cycles
; note: ROM plot routine takes $5D (93) cycles


; original, with SMC code 	= 77 cycles
; using indirect-Y/GBASL	= 69 cycles
; split gr_offsets table	= 61 cycles


	; color in COLOR
	; horiz=y, vert=A (A trashed, XY Saved)
fast_plot:
	stx	TEMPX						; 3

	lsr		; get low bit in carry			; 2
	tax							; 2
	lda	gr_offsets_l,X					; 4+
	sta	GBASL						; 3
	lda	gr_offsets_h,X					; 4+
	sta	GBASH						; 3
								;===
								; 21

	lda	COLOR						; 3
	bcs	plot_top					; 2/3t
plot_bottom:
	and	#$0f						; 3
	sta	TEMP						; 3
	lda	#$f0						; 2
	and	(GBASL),Y					; 5
	jmp	plot_common					; 3
plot_top:
	and	#$f0						; 3
	sta	TEMP						; 3
	lda	#$0f						; 2
	and	(GBASL),Y					; 5

plot_common:
	ora	TEMP						; 3
	sta	(GBASL),Y					; 6
								;====
								; 31

	ldx	TEMPX						; 3
	rts							; 6
								;====
								; 9
;.align $100

gr_offsets:

gr_offsets_l:
	.byte	$00,$80,$00,$80,$00,$80,$00,$80
	.byte	$28,$a8,$28,$a8,$28,$a8,$28,$a8
	.byte	$50,$d0,$50,$d0,$50,$d0,$50,$d0

gr_offsets_h:
	.byte	$4,$4,$5,$5,$6,$6,$7,$7
	.byte	$4,$4,$5,$5,$6,$6,$7,$7
	.byte	$4,$4,$5,$5,$6,$6,$7,$7

gr_offsets_end:

;.assert >gr_offsets = >gr_offsets_end, error, "gr_offsets crosses page"

