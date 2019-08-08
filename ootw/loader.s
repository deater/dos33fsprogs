; Loader for OOTW

; the BASIC program sets $05 with which thing to load


nibtbl =  $300	; nothing uses the bottom 128 bytes of $300, do they?
bit2tbl = $380 	; bit2tbl:	.res 86			;	= nibtbl+128
filbuf  = $3D6  ; filbuf:	.res 4			;	= bit2tbl+86

; read any file slot 6 version
; based on FASTLD6 and RTS copyright (c) Peter Ferrie 2011-2013,2018

; modified to assembled with ca64 -- vmw
; added code to patch it to run from current disk slot -- vmw


	WHICH_LOAD =	$05	; thing to load
	adrlo	=	$26	; constant from boot prom
	adrhi	=	$27	; constant from boot prom
	tmpsec	=	$3c	; constant from boot prom
	reqsec	=	$3d	; constant from boot prom
	sizelo	=	$44
	sizehi	=	$45
	secsize	=	$46
	TEMPY	=	$fa
	namlo	=	$fb
	namhi	=	$fc
	step	=	$fd	; state for stepper motor
	tmptrk	=	$fe	; temporary copy of current track
	phase	=	$ff	; current phase for /seek
	OUTL	=	$fe	; for picking filename
	OUTH	=	$ff

	dirbuf	=	$c00
				; note, don't put this immediately below
				;   the value being read as destaddr-4
				;   is temporarily overwritten during read
				;   process


	; note also, can't load file bigger than $8000 (32k) in size?
	; seems to break things?

start:
	jsr	init	; unhook DOS, init nibble table

;======================

which_load_loop:
	ldy	WHICH_LOAD
	lda	filenames_low,Y
	sta	OUTL
	lda	filenames_high,Y
	sta	OUTH

opendir_filename:

	; clear out the filename with $A0 (space)

	lda	#<filename
	sta	namlo
	lda	#>filename
	sta	namhi

	ldy	#29
wipe_filename_loop:
	lda	#$A0
	sta	(namlo),Y
	dey
	bpl	wipe_filename_loop

	ldy	#0
copy_filename_loop:
	lda	(OUTL),Y
	beq	copy_filename_done
	ora	#$80
	sta	(namlo),Y
	iny
	bne	copy_filename_loop

copy_filename_done:
	jsr	opendir		; open and read entire file into memory

	jsr	$1700		; jump to common entry point

	; hope they updated the WHICH_LOAD value

	jmp	which_load_loop

; filename to open is 30-character Apple text, must be padded with space ($A0)
filename:
	.byte $A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0
	.byte $A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0
	.byte $A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0

filenames_low:
	.byte	<intro_filename
	.byte	<ootw_c1_filename
	.byte	<ootw_c2_filename
	.byte	<ootw_c3_filename
	.byte	<ootw_c4_filename
	.byte	<ootw_c5_filename

filenames_high:
	.byte	>intro_filename
	.byte	>ootw_c1_filename
	.byte	>ootw_c2_filename
	.byte	>ootw_c3_filename
	.byte	>ootw_c4_filename
	.byte	>ootw_c5_filename

intro_filename:
	.byte "INTRO",0

ootw_c1_filename:
	.byte "OOTW_C1",0

ootw_c2_filename:
	.byte "OOTW_C2",0

ootw_c3_filename:
	.byte "OOTW_C3",0

ootw_c4_filename:
	.byte "OOTW_C4",0

ootw_c5_filename:
	.byte "OOTW_C5",0



                ;unhook DOS and build nibble table

init:
	; patch to use current drive

	; locate input paramater list
	jsr	$3E3
	; result is in A:Y
	sta	$FF
	sty	$FE
	ldy	#1
	lda	($FE),y

	; list+1 should have slot<<8


	ora	#$80		; add in $80

	; c0e0
	sta	mlsmc06+1

	; c0e8
	clc
	adc	#8
	sta	mlsmc02+1

	; c0e9
	clc
	adc	#1
	sta	mlsmc01+1

	; c0ec
	clc
	adc	#3
	sta	mlsmc03+1
	sta	mlsmc04+1
	sta	mlsmc05+1

	jsr	$fe93					; clear COUT
	jsr	$fe89					; clear KEYIN

	;========================
	; Create nibble table
	; Note: the table starts 16 bytes in, and is sparse
	;	so it doesn't entirely look like the DOS33 table at

	ldy	#0
	ldx	#3
L1:	stx	$3c		; store tempx    (3?)
	txa			; a=x	     (a=3)
	asl			; a*=2       (a=6)
	bit	$3c		; a&tempx, set N/V (a=6)
	beq	L3		; if 0, skip to L3
	ora	$3c		; a|=tempx	(a=7)
	eor	#$ff		; a=~a		(a=f8)
	and	#$7e		; a&=0x7e 0111 1110 (a=78)
L2:	bcs	L3		; this set way back at asl??
	lsr			; a>>1		a=3c c=0
				;		a=1e c=0
				;		a=0f c=0
				;		a=07 c=1
	bne	L2		; if a!=0 goto l2
	tya			; if a==0, a=y
	sta	nibtbl, x	; write out to table
	iny			; increment y
L3:	inx			; increment x	x=4, a=0f
	bpl	L1		; loop while high bit not set

	rts

	;===========================
	; opendir
	;===========================

	; turn on drive and read volume table of contents
opendir:
mlsmc01:lda	$c0e9		; turn slot#6 drive on
	ldx	#0
	stx	adrlo		; zero out adrlo
	stx	secsize		; zero out secsize
	lda	#$11		; a=$11 (VTOC)
	jsr	readdirsec
firstent:

	lda	dirbuf+1

	; lock if entry not found
entry_not_found:
	beq	entry_not_found

	; read directory sector

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
	lda	#0		; was **stz secsize**
	sta	secsize

readfirst:
	ldy	#$0c

	; read a file sector

readnext:
	tya
	pha
	lda	dirbuf, y		; A = track
	ldx	dirbuf+1, y		; x = sector
	jsr	seekread1
	pla
	tay

	; if low count is non-zero then we are done
	; (can happen only for partial last block)

	lda	secsize
	bne	readdone

	; continue if more than $100 bytes left

	dec	sizehi
        bne	L6

	; set read size to min(length, $100)

	lda	sizelo
	beq	readdone
	sta	secsize
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
;	sta	adrhi
;	pla
	sta	adrlo			; code originally had this backwards
	pla
	sta	adrhi
	bcc	readfirst

mlsmc02:lda	$c0e8

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


	;======================
	; readdirsec
	;======================
	; a = track?
	; x = sector?
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

	cpx	phase
	beq	checksec
	jsr	seek


	;=========================================
	; re merge in with qkumba's recent changes
	; to fix seek problem?
	;=========================================

	; [re-]read sector

re_read_addr:
	jsr	readadr
checksec:
	cmp	reqsec
	bne	re_read_addr

	;=========================
	; read sector data
	;=========================

readdata:
	jsr	readd5aa
	eor	#$ad		; zero A if match
	bne	re_read_addr

L12:
mlsmc03:ldx	$c0ec		; read until valid data (high bit set)
	bpl	L12
	eor	nibtbl-$80, x
	sta	bit2tbl-$aa, y
	iny
	bne	L12
L13:
mlsmc04:ldx	$c0ec		; read until valid data (high bit set)
	bpl	L13
	eor	nibtbl-$80, x
	sta	(adrlo), y	; the real address
	iny
	cpy	secsize
	bne	L13
	ldy	#0
L14:
	ldx	#$a9
L15:
	inx
	beq	L14
	lda	(adrlo), y
	lsr	bit2tbl-$aa, x
	rol
	lsr	bit2tbl-$aa, x
	rol
	sta	(adrlo), y
	iny
	cpy	secsize
	bne	L15
	rts

	; no tricks here, just the regular stuff

	;=======================
	; readaddr -- read the address field
	;=======================
	; Find address field, put track in cutrk, sector in tmpsec

readadr:
	jsr	readd5aa
	cmp	#$96
	bne	readadr
	ldy	#3		; three?
				; first read volume/volume
				; then track/track
				; then sector/sector?
adr_read_two_bytes:
	tax
	jsr	readnib
	rol
	sta	tmpsec
	jsr	readnib
	and	tmpsec
	dey
	bne	adr_read_two_bytes
	rts

	;========================
	; make sure we see the $D5 $AA pattern

readd5aa:
L16:
	jsr	readnib
L17:
	cmp	#$d5
	bne	L16
	jsr	readnib
	cmp	#$aa
	bne	L17
	tay		; we need Y=#$AA later

readnib:
mlsmc05:lda	$c0ec		; read until valid (high bit set)
	bpl	readnib

seekret:
	rts

	;=====================
	; SEEK
	;=====================
	; current track in X?
	; desired track in phase

seek:
	ldy	#0
	sty	step
	asl	phase		; multiply by two
	txa			; current track?
	asl			; mul by two
copy_cur:
	tax
	sta	tmptrk
	sec
	sbc	phase
	beq	L22
	bcs	L18
	eor	#$ff
	inx
	bcc	L19
L18:
	sbc	#1
	dex
L19:
	cmp	step
	bcc	L20
	lda	step
L20:
	cmp	#8
	bcs	L21
	tay
	sec
L21:
	txa
	pha
	ldx	step1, y
L22:
	php
	bne	L24
L23:
	clc
	lda	tmptrk
	ldx	step2, y
L24:
	stx	tmpsec
	and	#3
	rol
	tax
	lsr
mlsmc06:lda	$c0e0, x
L25:
	ldx	#$12
L26:
	dex
	bpl	L26
	dec	tmpsec
	bne	L25
	bcs	L23
	plp
	beq	seekret
	pla
	inc	step
	bne	copy_cur


.if 0
	;==============================
	; old code


	; [re-]read sector

re_read_addr:
	jsr	readadr

repeat_until_right_sector:
	cmp	reqsec
	bne	re_read_addr

	;==========================
	; read sector data
	;==========================
	;

readdata:
mlsmc07:
	ldy	$c0ec		; read data until valid
	bpl	readdata
find_D5:
	cpy	#$d5		; if not D5, repeat
	bne	readdata
find_AA:
mlsmc08:
	ldy	$c0ec		; read data until valid, should be AA
	bpl	find_AA
	cpy	#$aa		; we need Y=#$AA later
	bne	find_D5
find_AD:
mlsmc09:lda	$c0ec		; read data until high bit set (valid)
	bpl	find_AD
	eor	#$ad		; should match $ad
	bne	*		; lock if didn't find $ad (failure)
L12:
mlsmc0A:ldx	$c0ec		; read data until high bit set (valid)
	bpl	L12
	eor	nibtbl-$80, x
	sta	bit2tbl-$aa, y
	iny
	bne	L12
L13:
mlsmc0B:ldx	$c0ec		; read data until high bit set (valid)
	bpl	L13
	eor	nibtbl-$80, x
	sta	(adrlo), y	; the real address
	iny
	cpy	secsize
	bne 	L13
	ldy	#0
L14:
	ldx	#$a9
L15:
	inx
	beq	L14
	lda	(adrlo), y
	lsr	bit2tbl-$aa, x
	rol
	lsr	bit2tbl-$aa, x
	rol
	sta	(adrlo), y
	iny
	cpy	secsize
	bne	L15
	rts

	; no tricks here, just the regular stuff

	;=================
	; readadr -- read address field
	;=================
	; Find address field, put track in cutrk, sector in tmpsec
readadr:
mlsmc0C:lda	$c0ec		; read data until we find a $D5
	bpl	readadr
adr_d5:
	cmp	#$d5
	bne	readadr

adr_aa:
mlsmc0D:lda	$c0ec		; read data until we find a $AA
	bpl	adr_aa
	cmp	#$aa
	bne	adr_d5

adr_96:
mlsmc0E:lda	$c0ec		; read data until we find a $96
	bpl	adr_96
	cmp	#$96
	bne	adr_d5

	ldy	#3		; three?
				; first read volume/volume
				; then track/track
				; then sector/sector?
adr_read_two_bytes:
	sta	curtrk		; store out current track
	tax
L20:
mlsmc0F:lda	$c0ec		; read until full value
	bpl	L20
	rol
	sta	tmpsec
L21:
mlsmc10:lda	$c0ec		; read until full value
	bpl	L21		; sector value is (v1<<1)&v2????
	and	tmpsec
	dey			; loop 3 times
	bne	adr_read_two_bytes

seekret:
	rts			; return

	;================
	; SEEK
	;================
	; current track in curtrk
	; desired track in phase

seek:
	asl	curtrk		; multiply by 2
	asl	phase		; multiply by 2
	lda	#0
	sta	step
copy_cur:
	lda	curtrk		; load current track
	sta	tmptrk		; store as temptrk
	sec			; calc current-desired
	sbc	phase
	beq	seekret		; if they match, we are done!

	bcs	seek_neg	; if negative, skip ahead
	eor	#$ff		; ones-complement the distance
	inc	curtrk		; increment current (make it 2s comp?)
	bcc	L114		; skip ahead
seek_neg:
	adc	#$fe
	dec	curtrk
L114:
	cmp	step
	bcc	L115
	lda	step
L115:
	cmp	#8
	bcs	L116
	tay
	sec
L116:
	lda	curtrk
	ldx	step1, y
	bne	L118
L117:
	clc
	lda	tmptrk
	ldx	step2, y
L118:
	stx	tmpsec
	and	#3
	rol
	tax
mlsmc11:sta	$c0e0, x
L119:
	ldx	#$13
L120:
	dex
	bne	L120
	dec	tmpsec
	bne	L119
	lsr
	bcs	L117
	inc	step
	bne	copy_cur
.endif


step1:	.byte $01, $30, $28, $24, $20, $1e, $1d, $1c
step2:	.byte $70, $2c, $26, $22, $1f, $1e, $1d, $1c

sectbl:	.byte $00,$0d,$0b,$09,$07,$05,$03,$01,$0e,$0c,$0a,$08,$06,$04,$02,$0f


; From $BA96 of DOS33
;nibtbl:	.res 128			;		= *
;	.byte	$00,$01,$98,$99,$02,$03,$9C,$04	; $BA96	; 00
;	.byte	$05,$06,$A0,$A1,$A2,$A4,$A4,$A5 ; $BA9E	; 08
;	.byte	$07,$08,$A8,$A9,$AA,$09,$0A,$0B ; $BAA6	; 10
;	.byte	$0C,$0D,$B0,$B1,$0E,$0F,$10,$11 ; $BAAE	; 18
;	.byte	$12,$13,$B8,$14,$15,$16,$17,$18 ; $BAB6	; 20
;	.byte	$19,$1A,$C0,$C1,$C2,$C3,$C4,$C5	; $BABE	; 28
;	.byte	$C6,$C7,$C8,$C9,$CA,$1B,$CC,$1C ; $BAC6	; 30
;	.byte	$1D,$1E,$D0,$D1,$D2,$1E,$D4,$D5 ; $BACE	; 38
;	.byte	$20,$21,$D8,$22,$23,$24,$25,$26	; $BAD6	; 40
;	.byte	$27,$28,$E0,$E1,$E2,$E3,$E4,$29	; $BADE ; 48
;	.byte	$2A,$2B,$E8,$2C,$2D,$2E,$2F,$30	; $BAE6 ; 50
;	.byte	$31,$32,$F0,$F1,$33,$34,$35,$36 ; $BAEE ; 58
;	.byte	$37,$38,$F8,$39,$3A,$3B,$3C,$3D	; $BAF6	; 60
;	.byte	$3E,$3F,$13,$00,$01,$02,$01,$00 ; $BAFE ; 68
;	.byte	$00,$00,$00,$00,$00,$00,$00,$00
;	.byte	$00,$00,$00,$00,$00,$00,$00,$00


;bit2tbl:	.res 86			;	= nibtbl+128
;filbuf:		.res 4			;	= bit2tbl+86
					;dataend         = filbuf+4

