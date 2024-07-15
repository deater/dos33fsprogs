;license:BSD-3-Clause

; based on minimal open/read binary file in ProDOS filesystem
; from 4cade
;
;copyright (c) Peter Ferrie 2016-2019

.include "hardware.inc"

PROBOOTENTRY	=	$2000

; zpage usage, arbitrary selection except for the "ProDOS constant" ones
	command	= $42		; ProDOS constant
	UNIT	= $43		; ProDOS constant
	ADRLO	= $44		; ProDOS constant
	ADRHI	= $45		; ProDOS constant
	BLOKLO	= $46		; ProDOS constant
	BLOKHI	= $47		; ProDOS constant

	A2L       = $3e
	A2H       = $3f
	sizehi    = $53


	SCRN2P2   = $f87b	; shifts top nibble to bottom

	dirbuf    = $1e00       ;for size-optimisation

; start of boot sector, presumably how many sectors to load
;	512 bytes on prodos/hard-disk(???)

.byte 1

proboot_start:
	txa
	pha			; save slot for later

	; init.  is all this necessary?
	; originally "4cade.init.machine.a"

	cld			; clear direction flag
	sta	$C082		; read rom / no write (language card)
	sta	PRIMARYCHARSET	; turn off mouse text
	sta	EIGHTYCOLOFF	; disable 80-col mode
	sta	CLR80COL
	sta	READMAINMEM	; make sure not using aux mem
	sta	WRITEMAINMEM
	sta	SETSTDZP

	; more init
	; originally "4cade.init.screen.a"

	; initializes and clears screen using ROM routines

	jsr	INIT_TEXT	; setup text mode
	jsr	HOME		; clear screen
	jsr	SETNORM		; normal text
	jsr	SETKBD		; keyboard input
	jsr	SETVID		; video output

	; set up disk stuff?

	pla			; restore slot
	sta	UNIT		; save for later

	tax
	; X = boot slot x16

	; Y = 0
	; 4cade calls a print-title routine here that exits with Y=0

	ldy	#0

	; set up ProDOS shim

	; from IIgs smartport firmware manual

	; prodos entry point is $CX00+($CXFF)
	;	so if slot 7, $C700 + value in $C7ff (say, A) so $C70A
	; smartport entry point is $CX00+(CXFF)+3


setup_loop:
	txa
	jsr	SCRN2P2		; shift top nibble of A to bottom
	and	#7
	ora	#$c0
	sta	$be30, Y	; ????
	sta	slot_smc+2
	sta	entry_smc+2	; set up smartport/prodos entry point

slot_smc:
	lda	$cfff
	sta	entry_smc+1	; set up rest of smartport/prodos entry

	lda	fakeMLI_e-$100, Y
	sta	$be00+fakeMLI_e-fakeMLI, Y
	iny
	bne	setup_loop	; ?????

	; Y is 0 here
;	ldy	#0
	sty	ADRLO
	stx	$bf30		; ?????
	sty	$200		; ?????

opendir:
	; read volume directory key block
	ldx	#2

	; include volume directory header in count

firstent:
	lda	#>dirbuf	; load volume block to ADDRH/L (dirbuf/$1e00)
	sta	ADRHI
	sta	A2H
	jsr	seekread


	lda	#4		; start at filename offset
	sta	A2L
nextent:
	ldy	#0

	; match name lengths before attempting to match names
	; first byte, bottom nibble is length

	lda	(A2L), Y
	and	#$0f
	tax
	inx

try_again:
	cmp	filename, Y
	beq	filename_char_match

         ; move to next directory in this block
not_found:
	clc
	lda	A2L
	adc	#$27
	sta	A2L
	bcc	no_cross_page

	; there can be only one page crossed,
	; so we can increment instead of adc

	inc	A2H
no_cross_page:
	cmp	#$ff			; 4+($27*$0d)
	bne	nextent

	; read next directory block when we reach the end of this block

	ldx	dirbuf+2
	ldy	dirbuf+3
	bcs	firstent

filename_char_match:
	iny			; point to next char
	lda	(A2L), Y	; grab value
	dex			; countdown filename length
	bne	try_again	; if not full match, keep going


	stx	$ff		; set address $FF in zero page to zero?

	; bytes $11 and $12 in the file entry are the "key pointer"

	ldy	#$11
	lda	(A2L), Y
	tax
	iny
	lda	(A2L), Y
	tay


	; seedling files = less than 512 bytes, contents are simply key block
	;	storage type is $1
	; sapling files = 512B - 128k
	;	key block has low bytes of addrss in 0..255 and high in 256..512
	;	storage type is $2
	; tree files = 128k - 16M


	; read the 512-byte block at key pointer into memory
	; will only work for a "sapling" file?

readfile:
	jsr	seekread

	inc	ADRHI	; point destination past it (so at $2000)
	inc	ADRHI

	; fetch contents of file?
	; just keep reading 512-byte blocks until done?
	; this means file will be at $2000?

blockind:
	ldy	$ff			; use $ff as block index?
	inc	$ff			;

	ldx	dirbuf, Y		; low byte of block#
	lda	dirbuf+256, Y		; high byte of block#
	tay

	bne	readfile		; if high byte!=0, read another block

	txa				; if high byte=0 and low_byte=0, done
	bne	readfile

readdone:
	jmp	PROBOOTENTRY		; would be $2000 if sapling

	;================================
	; seek read
	;================================
	; Y:X = block number to load (???)
	; A = page to load to?

seekread:
	stx   BLOKLO
	sty   BLOKHI
	lda   #1
	sta   command
	lda   ADRHI
	pha
entry_smc:
	jsr	$d1d1
	pla
	sta	ADRHI
	rts

fakeMLI:
	bne	retcall
readblk:
	dey
	dey
	sty	ADRHI
	tay
	jsr	$bf00+seekread-fakeMLI
retcall:
	pla
	tax
	inx
	inx
	inx
	txa
	pha
;-:
	rts
fakeMLI_e:


filename:
	; expects PASCAL-string filename
	; first byte size (max 15)
	.byte	7,"SEASONS"

;.if (* > $9f7)
;	.error "Bootloader is too large"
;.endif

;*=$9f8
;!byte $D3,$C1,$CE,$A0,$C9,$CE,$C3,$AE
;       S   A   N       I   N   C   .
;
