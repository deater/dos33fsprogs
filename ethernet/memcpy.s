.define EQU =

PTR	EQU	$06
PTRH	EQU	$07

WRAPL	EQU	$08
WRAPH	EQU	$09

SIZEL	EQU	$0A
SIZEH	EQU	$0B

tx_copy:

	lda	#0		; always copying from 0x4000
	sta	PTR
	lda	#$40
	sta	PTR+1

	ldx	#SIZEH		; number of 256-byte blocks
	beq	copy_remainder	; if none, skip ahead

	ldy	#0
copy256:
	lda	(PTR),y
	sta	$C0B7		; change based on uthernet slot

	cmp	WRAPH,x
	bne	nowrap256

	cmp	WRAPL,y
	bne	nowrap256

	lda	#$40
	sta	$C0B5
	lda	#$00
	sta	$C0B6		; wrap tx buffer address to 0x4000

nowrap256:
	iny
	bne	copy256

	inc	PTR+1		; update 16-bit pointer
	dex			; finish a 256 byte block
	bne	copy256

	ldx	#SIZEL
copy_remainder:
	lda	(PTR),y
	sta	$C0B7		; change based on uthernet slot

	cmp	WRAPL,y
	bne	nowrap_r

	lda	#$40
	sta	$C0B5
	lda	#$00
	sta	$C0B6		; wrap tx buffer address to 0x4000

nowrap_r:
	iny
	dex
	bne	copy_remainder

	rts


