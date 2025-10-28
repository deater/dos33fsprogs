; copy hi-res graphics from $A000:$BFFF to $2000 / $4000
;	can copy partial screen

; A : SRC_OFFSET  = src Y-coord offset in $A000
; X : DEST_OFFSET = dest Y-coord offset in $2000/$4000 (based on DRAW_PAGE)
; Y : LENGTH      = number of lines to copy

slow_copy_aux:
	sta	WRAUX
	sta	RDAUX

slow_copy_main:

slow_copy:
	sty	LENGTH			; save length for later
	sta	SRC_OFFSET		; save src offset

	lda	#0
	sta	INDEX

slow_copy_outer_loop:
	stx	DEST_OFFSET		; save dest_offset

	lda	SRC_OFFSET		; src is SRC_OFFSET+INDEX
	clc
	adc	INDEX
	tax

	lda	hposn_low,X		; copy src
	sta	slow_copy_smc1+1
	lda	hposn_high,X
	clc
	adc	#$80			; to $A0
	sta	slow_copy_smc1+2

	; set destination

	ldx	DEST_OFFSET		; restore dest_offset

	lda	hposn_low,X		; copy destination
	sta	slow_copy_smc2+1

	lda	hposn_high,X
	clc
	adc	DRAW_PAGE
	sta	slow_copy_smc2+2

	ldy	#39
slow_copy_loop:

slow_copy_smc1:
	lda	$A000,Y
slow_copy_smc2:
	sta	$2000,Y
	dey
	bpl	slow_copy_loop

	inx
	inc	INDEX
	dec	LENGTH
	bne	slow_copy_outer_loop

	sta	RDMAIN
	sta	WRMAIN

	rts
