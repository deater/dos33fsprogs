;license:MIT
;(c) 2017-2020 by qkumba/4am/John Brooks
;

addrs=$70 		; $40 bytes from $70..$AF  (original code used  $BF)
			; Code is $70 bytes

.macro OVERCOPY_TO_0 start, end
; over-copy region to $00
; clobbers $FF

.local oczm

; out:   X=0
;        Y=last byte before start (e.g. 0 if the last instruction is JMP $0000)
	ldx	#(end-start+1)
oczm:
	ldy	start-2, X
	sty	$FE, X
	dex
	bne	oczm
.endmacro




do_wipe_fizzle:

	ldx	#$1F			; build address lookup table
dwf1:
	txa
	eor   #$20			;
	sta   addrs, X			; builds the dest table starting at $20
	eor   #$80			; (was originally $A0 to build at $80)
	sta   addrs+$20, X		; builds aux table starting at $A0
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
	sta	READAUXMEM		; copy $4000/aux to $A000/main
	ldx	#$20
aa:
	lda	$4000, Y
bb:
	sta	$A000, Y		; was $8000
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
	sta	<mdst+2
	eor	#$60
	sta	<msrc+2
msrc:
	lda	$FD00, Y
mdst:
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
	lda	(msrc+1), Y	; last lousy byte (because LFSR never hits 0)
	sta	(mdst+1), Y
zexit:
	sta	$C000		; 80STORE mode off
	rts

aux:
	sta	$C055	; switch $2000 access to aux memory (read/write!)
	sta	<auxsrc+2
	eor	#$80		; (was originally $A0 when it loaded from $8000)
	sta	<auxdst+2
auxsrc:
	lda	$FD00, Y	; gets modified to $A000
auxdst:
	sta	$FD00, Y	; gets modified to $2000
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
