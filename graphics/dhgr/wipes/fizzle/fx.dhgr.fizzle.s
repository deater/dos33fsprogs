;license:MIT
;(c) 2017-2020 by qkumba/4am/John Brooks
;
;cpu 6502
;to "build/FX.INDEXED/DHGR.FIZZLE",plain
;*=$6000

addrs=$BF                            ; [$40 bytes]

         ; source "src/fx/macros.a"

.include "../macros.s"

do_wipe_fizzle:

	ldx	#$1F			; build address lookup table
dwf1:
	txa
	eor   #$20
	sta   addrs, x
	eor   #$A0
	sta   addrs+$20, x
	dex
	bpl	dwf1

	OVERCOPY_TO_0 start, end
	; $FF clobbered
	; X=0
	; Y=0
	jmp	copyaux


start:
.org $00
;!pseudopc 0 {

	;Y=0 on entry to copyaux
copyaux:
	sta	READAUXMEM		; copy $4000/aux to $8000/main
	ldx	#$20
aa:
	lda	$4000, Y
bb:
	sta	$8000, Y
	iny
	bne	aa
	inc	aa+2
	inc	bb+2
	dex
	bne	aa
	sta	READMAINMEM
	sta	$C001			; 80STORE mode
;X,Y=0 on entry to LFSR
loop:
	txa
loop1:
	eor	#$35			; LFSR form 0x3500 with period 16383
	tax
loop2:
	lda	addrs, X
	bmi	aux
	sta	$C054			; switch $2000 access to main memory
	sta	<dst+2
	eor	#$60
	sta	<src+2
src:
	lda	$FD00, Y
dst:
	sta	$FD00, Y
	txa
	lsr
	tax
	tya
	ror
	tay
	bcc	loop2
	bne	loop
	bit	KBD
	bmi	zexit
	txa
	bne	loop1
	lda	(src+1), Y	; last lousy byte (because LFSR never hits 0)
	sta	(dst+1), Y
zexit:
	sta	$C000		; 80STORE mode off
	rts

aux:
	sta	$C055	; switch $2000 access to aux memory (read/write!)
	sta	<auxsrc+2
	eor	#$A0
	sta	<auxdst+2
auxsrc:
	lda	$FD00, Y
auxdst:
	sta	$FD00, Y
	txa
	lsr
	tax
	tya
	ror
	tay
	bcc	loop2
	bne	loop
	lda	KBD
	bmi	zexit
	txa
	bne	loop1
	beq	zexit
.reloc
end:
