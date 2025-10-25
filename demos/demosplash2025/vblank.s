; wait for VBLANK

; no way to do this on II/II+ short of vapor lock / floating bus
; IIe you can read $C019 (in VBLANK when top bit 0)
; IIc you can also read $C019 (also can setup interrupt)
; IIgs you can read $C019 but reverse of IIe (in VBLANK when top bit 1)


VBLANK	= $C019		;

	; wait for vblank on IIe
	; positive? during vblank

; TODO: patch this to a RTS on non-IIe systems

; can't check on fly as zero page might be gone

wait_vblank:

;	lda	APPLEII_MODEL

;	cmp	#'e'
;	beq	wait_vblank_iie

;	cmp	#'g'
;	beq	wait_vblank_iigs

;	cmp	#'c'
;	beq	wait_vblank_iic

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

	rts

wait_vblank_iigs:
	lda	VBLANK
	bpl	wait_vblank_iigs	; repeat until negative
					; not in vblank
wait_vblank_done_iigs:
	lda	VBLANK
	bmi	wait_vblank_done_iigs	; repeat until positive (start vblank)
					; in vblank

	rts

.if 0
; NOTE: we don't support this as we have to handle interrupts
;	for music and we'd have to hack up the irq handler
;	to differentiate VBLANK from others

; alternate implementation by Oliver Schmidt
; from https://github.com/cc65/cc65/blob/master/libsrc/apple2/waitvsync.s

wait_vblank_iic:
;	sei			; disables interrupts
	sta	IOUDISOFF
	lda	RDVBLMSK
	bit	ENVBL
	bit	PTRIG		; Reset VBL interrupt flag

wviim:
	bit	RDVBLBAR
	bpl	wviim

	asl
	bcs	wviip		; VBL interrupts were already enabled
	bit	DISVBL
wviip:
	sta	IOUDISON        ; IIc Tech Ref Man: The firmware normally leaves IOUDIS on.
;       cli                     ; re-enable interrupts

	rts
.endif

no_vblank:
	; pause a bit?

;	lda	#50
;	jsr	wait

	rts


