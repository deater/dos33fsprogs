; wait for VBLANK

; no way to do this on II/II+ short of vapor lock / floating bus
; IIe you can read $C019 (in VBLANK when top bit 0)
; IIc you can also read $C019 (also can setup interrupt)
; IIgs you can read $C019 but reverse of IIe (in VBLANK when top bit 1)


VBLANK	= $C019		;

	; wait for vblank on IIe
	; positive? during vblank

wait_vblank_iie:
	lda	VBLANK
	bmi	wait_vblank_iie		; wait for positive (in vblank)
wait_vblank_done_iie:
	lda	VBLANK			; wait for negative (vlank done)
	bpl	wait_vblank_done_iie

	rts
