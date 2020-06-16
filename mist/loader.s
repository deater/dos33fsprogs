; Loader for MIST


.include "zp.inc"
.include "hardware.inc"

.include "common_defines.inc"

; the TITLE program sets $05 with which thing to load
; this part of the program stays resident, so when a level ends
; it changes $05 (WHICH_LOAD) and this code loads the proper executable

nibtbl =  $300	; nothing uses the bottom 128 bytes of $300, do they?
bit2tbl = $380 	; bit2tbl:	.res 86			;	= nibtbl+128
filbuf  = $3D6  ; filbuf:	.res 4			;	= bit2tbl+86

; read any file slot 6 version
; based on FASTLD6 and RTS copyright (c) Peter Ferrie 2011-2013,2018

; modified to assembled with ca65 -- vmw
; added code to patch it to run from current disk slot -- vmw


;	WHICH_LOAD =	$05	; thing to load
;	adrlo	=	$26	; constant from boot prom
;	adrhi	=	$27	; constant from boot prom
;	tmpsec	=	$3c	; constant from boot prom
;	reqsec	=	$3d	; constant from boot prom
;	sizelo	=	$44
;	sizehi	=	$45
;	secsize	=	$46
;	namlo	=	$f8
;	namhi	=	$f9
;	TEMPY	=	$fa
;	step	=	$fd	; state for stepper motor
;	tmptrk	=	$fe	; temporary copy of current track
;	phase	=	$ff	; current phase for /seek
;	OUTL	=	$fe	; for picking filename
;	OUTH	=	$ff

	dirbuf	=	$c00
				; note, don't put this immediately below
				;   the value being read as destaddr-4
				;   is temporarily overwritten during read
				;   process


	FILENAME = $280

	;===================================================
	;===================================================
	; START / INIT
	;===================================================
	;===================================================

.if 0
LOAD_TITLE      = $0
LOAD_MIST       = $1
LOAD_MECHE      = $2
LOAD_SELENA     = $3
LOAD_OCTAGON    = $4
LOAD_VIEWER	= $5
LOAD_STONEDSHIP = $6
LOAD_CHANNEL    = $7
LOAD_ENDING     = $8
.endif

loader_start:
	lda	#LOAD_TITLE
	sta	WHICH_LOAD

	jsr	init	; unhook DOS, init nibble table


	;===================================================
	;===================================================
	; SETUP THE FILENAME
	;===================================================
	;===================================================

which_load_loop:
	lda	WHICH_LOAD
	asl

	tay
	lda	filenames,Y
	sta	OUTL
	lda	filenames+1,Y
	sta	OUTH

	lda	WHICH_LOAD
	bne	load_other

load_intro:
	lda	#<$4000
	sta	entry_smc+1
	lda	#>$4000
	sta	entry_smc+2
	jmp	actual_load

load_other:
	lda	#<$2000
	sta	entry_smc+1
	lda	#>$2000
	sta	entry_smc+2

actual_load:

	;===================================================
	;===================================================
	; SET UP DOS3.3 FILENAME
	;===================================================
	;===================================================

load_file_and_execute:

	jsr	opendir_filename

entry_smc:
	jsr	$1000		; jump to common entry point

	; hope they updated the WHICH_LOAD value

	jmp	which_load_loop


	;==============================
	; setup filename then open/load

opendir_filename:

	; clear out the filename with $A0 (space)

	lda	#<FILENAME
	sta	namlo
	lda	#>FILENAME
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

	rts

filenames:
	.word intro_filename
	.word mist_filename,meche_filename,selena_filename,octagon_filename
	.word viewer_filename,stoney_filename,channel_filename,ending_filename

intro_filename:
	.byte "MIST_TITLE",0
mist_filename:
	.byte "MIST",0
meche_filename:
	.byte "MECHE",0
selena_filename:
	.byte "SELENA",0
octagon_filename:
	.byte "OCTAGON",0
viewer_filename:
	.byte "VIEWER",0
stoney_filename:
	.byte "STONEY",0
channel_filename:
	.byte "CHANNEL",0
ending_filename:
	.byte "ENDING",0


	;===================================================
	;===================================================
	; INIT (build nibble table)
	;===================================================
	;===================================================

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
	sta	mlsmc07+1

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


	;===================================================
	;===================================================
	; file not found
	;===================================================
	;===================================================

file_not_found:

mlsmc07:lda	$c0e8		; turn off drive motor?

	jsr	TEXT
	jsr	HOME

	ldy	#0

	lda	#<disk_string
	sta	OUTL
	lda	#>disk_string
	sta	OUTH

quick_print:
	lda	(OUTL),Y
	beq	quick_print_done
	jsr	COUT1
	iny
	jmp	quick_print

quick_print_done:
;	rts

;	jsr	quick_print

fnf_keypress:
	lda	KEYPRESS
	bpl	fnf_keypress
	bit	KEYRESET

	jmp	which_load_loop

disk_string:
.byte "INSERT OTHER DISK, PRESS RETURN",0





	;===================================================
	;===================================================
	; OPENDIR: actually load the file
	;===================================================
	;===================================================

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
	beq	file_not_found

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




        .include        "audio.s"
        .include        "decompress_fast_v2.s"
        .include        "draw_pointer.s"
        .include        "end_level.s"
	.include        "gr_copy.s"
        .include        "gr_fast_clear.s"
        .include        "gr_offsets.s"
        .include        "gr_pageflip.s"
        .include        "gr_putsprite_crop.s"
        .include        "keyboard.s"
        .include        "text_print.s"

	.include        "common_sprites.inc"
        .include        "page_sprites.inc"

loader_end:

.assert (<loader_end - <loader_start)>16, error, "loader too big"
