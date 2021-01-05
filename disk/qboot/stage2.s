; the following lives on sectors $0E and $0D
; why?
; request sector 2 and 4, and the interleave is

; beneath apple dos (3-23)
; Physical (firmware) : 0  1   2  3   4  5   6  7   8  9  10 11 12 13 14  15
; DOS33 mapping       : 0, 7, 14, 6, 13, 5, 12, 4, 11, 3, 10, 2, 9, 1, 8, 15


; Beneath Apple DOS
; p86 (dos reference)
;

.org $be00

code_begin:

	.byte	version

readnib:
slotpatch1:			; smc
	lda	$c0d1		; gets set to C08C (Q6L) read
	bpl	readnib
	rts

        ;fill address array for one track
seekread:
	sty	startsec+1
	sta	tmpadr+1
	stx	total+1

inittrk:
	sec
	lda	#$10
	sbc	startsec+1
	cmp	total+1
	bcs     it_skip

	tax

it_skip:
	stx	partial1
	stx	partial2
	jsr	seek

startsec:
	ldy	#$d1

tmpadr:
tmpadr_loop:
	lda	#$d1
	sta	addrtbl, y
	inc	tmpadr+1
	iny
	dec	partial1
	bne	tmpadr_loop

read:

outer_read:
	jsr	readnib
inner_read:
	cmp	#$d5
	bne	outer_read
	jsr	readnib
	cmp	#$aa
	bne	inner_read
	tay			; we need Y=#$AA later
	jsr	readnib
	eor	#$ad		; zero A if match
	beq	check_mode

        ;if not #$AD, then #$96 is assumed

	ldy	#2		; volume, track, sector
another:
	jsr	readnib
	rol			; set carry
	sta	sector+1
	jsr	readnib
	and	sector+1
	dey
	bpl	another
	tay
	ldx	addrtbl, Y	; fetch corresponding address
	beq	read
	sta	sector+1	; store index for later

	stx	adrpatch1+2
	stx	adrpatch8+2
	stx	adrpatch2+2
	stx	adrpatch3+2
	stx	adrpatch5+2
	stx	adrpatch7+2

	inx
	stx	adrpatch9+2
	dex

	dex
	stx	adrpatch4+2
	stx	adrpatch6+2

	ldy	#$fe
adrpatch1:
loop2:
	lda	$d102, Y
	pha
	iny
	bne	loop2

branch_read:
        bcs	read		; branch always
check_mode:
	cpx	#0
	beq	read		; loop if not expecting #$AD

loop33:
	sta	tmpval+1	; zero rolling checksum
slotpatch2:
loop4:
	ldx	$c0d1
	bpl	loop4
	lda	preshift-$96, X
adrpatch2:
	sta	$d102, Y	; store 2-bit array

tmpval:
	eor	#$d1
	iny
	bne	loop33
	ldy	#$aa
slotpatch3:
loop5:
	ldx	$c0d1
	bpl	loop5
	eor	preshift-$96, X
adrpatch3:
	ldx	$d102, Y	; bit2tbl
	eor	grouped+2, X	; first 86 nibbles use group bits 0-1
adrpatch4:
	sta	$d156, y
	iny
        bne	loop5
	and	#$fc
	ldy	#$aa
slotpatch4:
loop6:
	ldx	$c0d1
	bpl	loop6
	eor	preshift-$96, X
adrpatch5:
	ldx	$d102, Y	; bit2tbl
	eor	grouped+1, X	; second 86 nibbles use group bits 2-3
adrpatch6:
	sta	$d1ac, Y
	iny
	bne	loop6
	and	#$fc
	ldx	#$ac
slotpatch5:
loop7:
	ldy	$c0d1
	bpl	loop7
	eor	preshift-$96, Y
adrpatch7:
	ldy	$d100, X	; bit2tbl
	eor	grouped, Y	; last 84 nibbles use group bits 4-5
adrpatch8:
	sta	$d100, x
	inx
	bne	loop7
	and	#$fc
slotpatch6:
loop8:
	ldy	$c0d1
	bpl	loop8
	eor	preshift-$96, Y
	cmp	#1		; carry = !zero
	ldy	#1
loop9:
	pla
adrpatch9:
	sta	$d100, Y
	dey
	bpl	loop9
branch_read2:
	bcs	branch_read	; branch if checksum failure
sector:
	ldy	#$d1
	txa
	sta	addrtbl, Y	; zero corresponding address
	dec	total+1
	dec	partial2	; adjust remaining count (faster than looping over array)
	sec
	bne	branch_read2	; read all requested sectors in one track
total:
	ldx	#$d1
	beq	driveoff
	inc	phase+1
	inc	phase+1		; update current track
	jmp	inittrk

driveoff:
slotpatch7:
	lda	$c0d1

seekret:
	rts

seek:
	lda	#0
	sta	step+1
copy_cur:
curtrk:
	lda	#0
	sta	tmpval+1
	sec
phase:
	sbc	#$d1
	beq	seekret

	eor	#$ff
	inc	curtrk+1

	cmp	step+1
	bcc	loop10
step:
	lda	#$d1
loop10:
	cmp	#8
	bcs	loop11
	tay
	sec
loop11:
	lda	curtrk+1
	ldx	step1, Y
	bne	loop12
loopmmm:
	clc
	lda	tmpval+1
	ldx	step2, Y
loop12:
	stx	sector+1
	and	#3
	rol
	tax
slotpatch8:
	sta	$c0d1, X
loopmm:
	ldx	#$13
loopm:
	dex
	bne	loopm
	dec	sector+1
	bne	loopmm
	lsr
	bcs	loopmmm
	inc	step+1
	bne	copy_cur

step1:		.byte 1, $30, $28, $24, $20, $1e, $1d, $1c
step2:		.byte $70, $2c, $26, $22, $1f, $1e, $1d, $1c
addrtbl:	.res 16
partial1 = *
partial2 = partial1+1
code_end=partial2+1

