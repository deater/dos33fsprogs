; wait for VBLANK

; no way to do this on II/II+ short of vapor lock / floating bus
; IIe you can read $C019 (in VBLANK when top bit 0)
; IIc you can also read $C019 (also can setup interrupt)
; IIgs you can read $C019 but reverse of IIe (in VBLANK when top bit 1)


VBLANK	= $C019		;

	; wait for vblank on IIe
	; positive? during vblank

; TODO: patch this to a RTS on non-IIe systems

wait_vblank:
;	Assume Apple IIe
;	lda	APPLEII_MODEL
;	cmp	#'e'
;	bne	no_vblank

; 4cade does this, the opposite of the way were doing it originally


; $C019 on IIe high bit is VBL' or "negative if not in VBLANK"
;	see page 66 in Sather's IIe

wait_vblank_iie:
	lda	VBLANK
	bpl	wait_vblank_iie		; repeat until negative
					; not in vblank
wait_vblank_done_iie:
	lda	VBLANK
	bmi	wait_vblank_done_iie	; repeat until positive (start vblank)
					; in vblank
no_vblank:

.if 0
wait_vblank_iie:
	lda	VBLANK
	bmi	wait_vblank_iie		; wait for positive (in vblank)
wait_vblank_done_iie:
	lda	VBLANK			; wait for negative (vlank done)
	bpl	wait_vblank_done_iie
no_vblank:
.endif

	rts
