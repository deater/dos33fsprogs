;license:MIT
;(c) 2020 by 4am
;
;!cpu 6502
;!to "build/FX.INDEXED/DHGR.REDLINES",plain
;*=$6000

; for red line:
; mainmem alternate #$11/#$44
; auxmem  alternate #$08/#$22

;hgrlo    =     $0201                 ; [$C0 bytes, main memory only] defined in constants.a
;hgr1hi   =     $0301                 ; [$C0 bytes, main memory only] defined in constants.a

 ;        !source "src/fx/macros.a"

	.include "../macros.s"

do_wipe_redlines:


	COPY_TO_0 start, end
;	jsr	iBuildHGRTables
	jmp	loop

start:
.org $00
;!pseudopc 0 {
loop:
	jsr	wait_vblank
row1=*+1
	ldx	#$00			; SMC
	jsr	DrawRedLine
row2=*+1
	ldx	#$BF			; SMC
	jsr	DrawRedLine
	ldx	row1
	beq	drl_p1
	dex
	jsr	DrawBlackLine
drl_p1:
	ldx	row2
	inx
	cpx	#$C0
	beq	drl_p2
	jsr	DrawBlackLine
drl_p2:
	lda	KBD
	bmi	drl_exit
	inc	row1
	dec	row2
	lda	row1
	cmp	#$60
	bne	loop

loop2:
	jsr	wait_vblank
	ldx	row1
	cpx	#$C0
	beq	drl_p3
	jsr	DrawRedLine
drl_p3:
	ldx	row2
	bmi	drl_p4
	jsr	DrawRedLine
drl_p4:
	ldx	row1
	dex
	jsr	CopyLine
	ldx	row2
	inx
	jsr	CopyLine
	lda	KBD
	bmi	drl_exit
	inc	row1
	dec	row2
	lda	row1
	cmp	#$C1
	bne	loop2
drl_exit:
	jmp	unwait_for_vblank

DrawRedLine:
	lda	hgrlo, X
	sta	<reddst1+1
	sta	<reddst2+1
	lda	hgr1hi, X
	sta	<reddst1+2
	sta	<reddst2+2
	ldy	#$27
	lda	#$11
drl_m1:
	eor	#$55
reddst1:
	sta	$FDFD, Y		; SMC
	dey
	bpl	drl_m1
	sta	WRITEAUXMEM
	ldy	#$27
	lda	#$08
drl_m2:
	eor	#$2A
reddst2:
	sta	$FDFD, Y		; SMC
	dey
	bpl	drl_m2
	sta	WRITEMAINMEM
	rts

DrawBlackLine:
	lda	hgrlo, X
	sta	<blackdst+1
	lda	hgr1hi, X
	sta	<blackdst+2
	lda	#$00
	clc
	.byte	$24			; bit
;	HIDE_NEXT_BYTE
dbl_mm:
	sec
	ldy	#$27
blackdst:
	sta	$FDFD, Y		; SMC
	dey
	bpl	blackdst
	sta	WRITEAUXMEM
	bcc	dbl_mm
	sta	WRITEMAINMEM
	rts

CopyLine:
	lda	hgrlo, X
	sta	<copysrc+1
	sta	<copydst+1
	lda	hgr1hi, X
	sta	<copydst+2
	eor	#$60
	sta	<copysrc+2
	clc
	.byte	$24			; bit
	; HIDE_NEXT_BYTE
cl_m1:
	sec
	ldy	#$27
copysrc:
	lda	$FDFD, Y		; SMC
copydst:
	sta	$FDFD, Y		; SMC
	dey
	bpl	copysrc
	sta	READAUXMEM
	sta	WRITEAUXMEM
	bcc	cl_m1
	sta	READMAINMEM
	sta	WRITEMAINMEM
	rts
;}
.reloc
end:
