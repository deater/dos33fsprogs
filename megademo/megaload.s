;read any file slot 6 version
;copyright (c) Peter Ferrie 2013
;!cpu 65c02
;!to "trk",plain
;*=$800

                adrlo     = $26         ;constant from boot prom
                adrhi     = $27         ;constant from boot prom
                tmpsec    = $3c         ;constant from boot prom
                reqsec    = $3d         ;constant from boot prom
                A1L       = $3c         ;constant from ROM
                A1H       = $3d         ;constant from ROM
                A2L       = $3e         ;constant from ROM
                A2H       = $3f         ;constant from ROM
                curtrk    = $40
                niblo     = $41
                nibhi     = $42
                A4L       = $42         ;constant from ROM
                A4H       = $43         ;constant from ROM
                sizelo    = $44
                sizehi    = $45
                secsize   = $46
		TEMPX	= $f9
		TEMPY	  = $fa
                namlo     = $fb
                namhi     = $fc
                step      = $fd         ;state for stepper motor
                tmptrk    = $fe         ;temporary copy of current track
                phase     = $ff         ;current phase for seek
                reloc     = $bc00
                dirbuf    = $bf00
                MOVE      = $fe2c

start:
		jsr init ;one-time call to unhook DOS
		;open and read a file
		lda #<file_to_read
		sta namlo
		lda #>file_to_read
		sta namhi
		jsr opendir ;open and read entire file into memory at its load address

blah:		jmp blah

; format of request name is 30-character Apple text:
;e.g. !scrxor $80, "MYFILE                        "
file_to_read:	;.byte "MYFILE                        "
	.byte 'M'|$80,'E'|$80,'G'|$80,'A'|$80,'D'|$80,'E'|$80,'M'|$80,'O'|$80
	.byte $A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0
	.byte $A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0
	.byte $A0,$A0,$A0,$A0,$A0,$A0


                ;unhook DOS and build nibble table

init:
	jsr	$fe93					; clear COUT
	jsr	$fe89					; clear KEYIN
;	lda	#<unreloc
;	sta	A1L
;	lda	#>unreloc
;	sta	A1H
;	lda	#<(unreloc+(codeend-opendir)-1)
;	sta	A2L
;	lda	#>(unreloc+(codeend-opendir)-1)
;	sta	A2H
;	ldy	#0
;	sty	A4L
;	lda	#>reloc
;	sta	A4H
;	jsr	MOVE	; move mem from A1-A2 to location A4

	ldx	#3
L1:	stx	$3c
	txa
	asl
	bit	$3c
	beq	L3
	ora	$3c
	eor	#$ff
	and	#$7e
L2:	bcs	L3
	lsr
	bne	L2
	tya
	sta	nibtbl, x
	iny
L3:	inx
	bpl	L1

	rts

unreloc:
;!pseudopc reloc {

                ;turn on drive and read volume table of contents

opendir:
	lda	$c0e9
	ldx	#0
	stx	adrlo
	stx	secsize
	lda	#$11
	jsr	readdirsec
firstent:
	lda	dirbuf+1

	;lock if entry not found

	beq	*

	;read directory sector

	ldx	dirbuf+2
	jsr	seekread1
	ldy	#7              ;number of directory entries in a sector
	ldx	#$2b            ;offset of filename in directory entry
nextent:
	tya
	pha			; was **phy**
	txa
	pha			; was **phx**
	ldy	#$1d

	; match name backwards (slower but smaller)

L4:
	lda	(namlo), y
	cmp	dirbuf, x
	beq	foundname
	pla

	; move to next directory in this block, if possible

	clc
	adc	#$23
	tax
	pla
	tay			; was **ply**
	dey
	bne	nextent
	beq	firstent	; was **bra**

foundname:
	dex
	dey
	bpl	L4
	pla
	tay			; was **ply**
	pla

	; read track/sector list

	lda	dirbuf-32, y
	ldx	dirbuf-31, y
	jsr	seekread1

	; read load offset and length info only, initially

	lda	#<filbuf
	sta	adrlo
	lda	#4
	sta	secsize
	lda	dirbuf+12
	ldx	dirbuf+13
	ldy	#>filbuf
	jsr	seekread

	; reduce load offset by 4, to account for offset and length

	sec
	lda	filbuf
	sbc	#4
	sta	adrlo
	lda	filbuf+1
	sbc	#0
	sta	adrhi

	; save on stack bytes that will be overwritten by extra read

	ldy	#3
L5:
	lda	(adrlo), y
	pha
	dey
	bpl	L5

	lda	adrhi
	pha
	lda	adrlo
	pha

	; increase load size by 4, to account for offst and length

	lda	filbuf+2
	adc	#3
	sta	sizelo
	sta	secsize
	lda	filbuf+3
	adc	#0
	sta	sizehi
	beq	readfirst
	ldy	#0		; was **stz secsize**
	sty	secsize

readfirst:
	ldy #$0c

	; read a file sector

readnext:
	lda dirbuf, y
	ldx dirbuf+1, y
	sty TEMPY			; ** was phy **
	jsr seekread1
	ldy TEMPY			; ** was ply **

	; if low count is non-zero then we are done
	; (can happen only for partial last block)

	lda secsize
	bne readdone

	; continue if more than $100 bytes left

                dec sizehi
                bne L6

                ;set read size to min(length, $100)

                lda sizelo
                beq readdone
                sta secsize
L6:
	inc	adrhi
	iny
	iny
	bne 	readnext

	; save current address for after t/s read

	lda	adrhi
	pha
	lda	adrlo
	pha
	lda	#0
	sta	adrlo			; was **stz adrlo**

	; read next track/sector sector

	lda	dirbuf+1
	ldx	dirbuf+2
	jsr	readdirsec
	clc

	; restore current address
readdone:
	pla
	sta	adrhi
	pla
	sta	adrlo
	bcc	readfirst

	lda	$c0e8

	; restore from stack bytes that were overwritten by extra read

	ldx	#3
	ldy	#0
L7:
	pla
	sta	(adrlo), y
	iny
	dex
	bpl	L7
	rts

readdirsec:
	ldy	#>dirbuf
seekread:
	sty	adrhi
seekread1:
	sta	phase
	lda	sectbl, x
	sta	reqsec
	jsr	readadr

	; if track does not match, then seek

	lda	curtrk
	cmp	phase
	beq	checksec
	jsr	seek

	; [re-]read sector

L8:
	jsr	readadr
checksec:
	cmp	reqsec
	bne	L8

	; read sector data

readdata:
	ldy	$c0ec
	bpl	readdata
L9:
	cpy	#$d5
	bne	readdata
L10:
	ldy	$c0ec
	bpl	L10
	cpy	#$aa                ;we need Y=#$AA later
	bne	L9
L11:
	lda	$c0ec
	bpl	L11
	eor	#$ad                ;zero A if match
	bne	*                   ;lock if read failure
L12:
	ldx	$c0ec
	bpl	L12
	eor	nibtbl-$80, x
	sta	bit2tbl-$aa, y
	iny
	bne	L12
L13:
	ldx	$c0ec
	bpl	L13
	eor	nibtbl-$80, x
	sta	(adrlo), y          ;the real address
	iny
	cpy	secsize
	bne 	L13
	ldy	#0
L14:
	ldx	#$a9
L15:
	inx
	beq	L14
                lda (adrlo), y
                lsr bit2tbl-$aa, x
                rol
                lsr bit2tbl-$aa, x
                rol
                sta (adrlo), y
                iny
                cpy secsize
                bne L15
                rts

                ;no tricks here, just the regular stuff

readadr:
	lda	$c0ec
	bpl	readadr
L16:
	cmp	#$d5
	bne	readadr
L17:
	lda	$c0ec
	bpl	L17
	cmp	#$aa
	bne	L16
L18:
	lda	$c0ec
	bpl	L18
	cmp	#$96
	bne	L16
	ldy	#3
L19:
	sta	curtrk
L20:
               lda $c0ec
                bpl L20
                rol
                sta tmpsec
L21:
	lda	$c0ec
	bpl	L21
	and	tmpsec
	dey
                bne L19
                rts

	;=====================
	; Stepper motor delay
	;=====================
stepdelay:
	stx	TEMPX			; was **phx**
	and	#3
	rol
	tax
	lda	$c0e0, x
	lda	TEMPX			; was **pla**
L22:
	ldx	#$13
L23:
	dex
	bne	L23
	sec
	sbc	#1			; was **dec**
	bne	L22
seekret:
	rts

	;================
	; SEEK
	;================
seek:
	asl	curtrk
	lda	#0
	sta	step			; *** WAS *** stz step
	asl	phase
copy_cur:
	lda	curtrk
	sta	tmptrk
	sec
	sbc	phase
	beq	seekret
	bcs	L24
	eor	#$ff
	inc	curtrk
	bcc	L25
L24:
	sec
	sbc	#1			; *** WAS *** dec
	dec	curtrk
L25:
	cmp	step
	bcc	L26
	lda	step
L26:
	cmp	#8
	bcs	L27
	tay
	sec
L27:
	lda	curtrk
	ldx	step1, y
	jsr	stepdelay
	lda	tmptrk
	ldx	step2, y
	jsr	stepdelay
	inc	step
	bne	copy_cur

step1:	.byte $01, $30, $28, $24, $20, $1e, $1d, $1c
step2:	.byte $70, $2c, $26, $22, $1f, $1e, $1d, $1c

sectbl:	.byte 0, $0d, $0b, 9, 7, 5, 3, 1, $0e, $0c, $0a, 8, 6, 4, 2, $0f

codeend         = *

nibtbl          = *
bit2tbl         = nibtbl+128
filbuf          = bit2tbl+86
dataend         = filbuf+4
;hack to error out when code is too large for current address
;!if ((dirbuf-(dataend-opendir))&$ff00)<reloc {
;1=1
;}
;}
