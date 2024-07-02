;open/read/write binary file in ProDOS filesystem
;copyright (c) Peter Ferrie 2013-16

; modified to assemble with ca65 (vmw) 2024


;!cpu 6502
;!to "prorwts",plain
;*=$800

	;constants
	cmdread   = 1           ;requires enable_write=1
	cmdwrite  = 2           ;requires enable_write=1
	SETKBD    = $fe89
	SETVID    = $fe93
	DEVNUM    = $bf30
	PHASEOFF  = $c080
	MOTOROFF  = $c088
	MOTORON   = $c089
	Q6L       = $c08c
	Q6H       = $c08d
	Q7L       = $c08e
	Q7H       = $c08f
	MLI       = $bf00
	KEY_POINTER = $11       ;ProDOS constant
	EOF       = $15         ;ProDOS constant
	AUX_TYPE  = $1f         ;ProDOS constant
	ROMIN     = $c081
	LCBANK2   = $c089
	CLRAUXRD  = $c002
	CLRAUXWR  = $c004

	;options
	enable_floppy = 0       ;set to 1 to enable floppy drive support
	poll_drive   = 0        ;set to 1 to check if disk is in drive
	override_adr = 0        ;set to 1 to require an explicit load address
	aligned_read = 0        ;set to 1 if all reads can be a multiple of block size
	enable_write = 0        ;set to 1 to enable write support
		        ;file must exist already and its size cannot be altered
		        ;writes occur in multiples of block size (256 bytes for floppy, 512 bytes for HDD)
	allow_multi  = 0        ;set to 1 to allow multiple floppies
	check_checksum=0        ;set to 1 to enforce checksum verification for floppies
	allow_subdir = 0        ;set to 1 to allow opening subdirectories to access files
	might_exist  = 0        ;set to 1 if file is not known to always exist already
		        ;makes use of status to indicate success or failure
	allow_aux    = 0        ;set to 1 to allow read/write directly to/from aux memory
		        ;requires load_high to be set for arbitrary memory access
		        ;else driver must be running from same memory target
		        ;i.e. running from main if accessing main, running from aux if accessing aux
	load_high    = 0        ;load into banked RAM instead of main RAM
	lc_bank      = 1        ;load into specified bank (1 or 2) if load_high=1

	;zpage usage
.if enable_floppy=1
	tmpsec    = $3c
	reqsec    = $3d
.endif	; enable_floppy

.if enable_floppy=1
	curtrk    = $40
.endif ;enable_floppy

	command   = $42         ;ProDOS constant
	unit      = $43         ;ProDOS constant
	adrlo     = $44         ;ProDOS constant
	adrhi     = $45         ;ProDOS constant
	bloklo    = $46         ;ProDOS constant
	blokhi    = $47         ;ProDOS constant

.if aligned_read=0
	secsize   = $46
	secsize1  = $47
	secsize2  = $48
.endif ;aligned_read

.if might_exist=1
	status    = $f3         ;returns non-zero on error
.endif ;might_exist

.if allow_aux=1
	auxreq    = $f4         ;set to 1 to read/write aux memory, else main memory is used
.endif ;allow_aux
	sizelo    = $f5         ;set if enable_write=1 and writing
	sizehi    = $f6         ;set if enable_write=1 and writing
	entries   = $f7         ;(internal) total number of entries
	reqcmd    = $f8         ;set (read/write) if enable_write=1
		        ;if allow_multi=1, bit 7 selects floppy drive in current slot (clear=drive 1, set=drive 2)
	ldrlo     = $f9         ;set to load address if override_adr=1
	ldrhi     = $fa         ;set to load address if override_adr=1
	namlo     = $fb         ;name of file to access
	namhi     = $fc         ;name of file to access
.if enable_floppy=1
	step      = $fd         ;(internal) state for stepper motor
	tmptrk    = $fe         ;(internal) temporary copy of current track
	phase     = $ff         ;(internal) current phase for seek
  .if enable_write=1
    .if load_high=1
	reloc     = $d000       ;$300 bytes code, $100 bytes data
	dirbuf    = reloc+$400
	encbuf    = dirbuf+$200
    .else  ;load_high
	reloc     = $bc00       ;$300 bytes code, $100 bytes data
	dirbuf    = reloc-$200
	encbuf    = dirbuf-$100
    .endif ;load_high
  .else  ;enable_write
    .if load_high=1
	reloc     = $d000       ;$200 bytes code, $100 bytes data
	dirbuf    = reloc+$300
    .else  ;load_high
	reloc     = $bd00       ;$200 bytes code, $100 bytes data
	dirbuf    = reloc-$200
    .endif ;load_high
  .endif ;enable_write
.else  ;enable_floppy
  .if load_high=1
	reloc     = $d000       ;$200 bytes code
    .if aligned_read=0
	dirbuf    = reloc+$200
    .else  ;aligned_read
	dirbuf    = reloc+$100
    .endif ;aligned_read
  .else  ;load_high
	reloc     = $be00       ;$200 bytes code
    .if aligned_read=0
	dirbuf    = reloc-$200
    .else  ;aligned_read
	dirbuf    = reloc-$100
    .endif ;aligned_read
  .endif ;load_high
.endif ;enable_floppy

init:
	jsr	SETVID		; intialize text output pointers?
	jsr	SETKBD		; initalize keyboard?
	lda	DEVNUM
	sta	x80_parms+1
	sta	unrunit+1
	and	#$70
.if (enable_floppy+enable_write)=2
	sta	unrslot1+1
	sta	unrslot2+1
	sta	unrslot3+1
	sta	unrslot4+1
.endif ;enable_floppy and enable_write
	pha
.if enable_floppy=1
	ora	#<PHASEOFF
	sta	unrseek+1
	ora	#<MOTOROFF
  .if might_exist=1
	sta	unrdrvoff1+1
  .endif ;might_exist
	sta	unrdrvoff2+1
	tax
	inx	;MOTORON
   .if poll_drive=1
	stx	unrdrvon1+1
   .endif ;poll_drive
	stx	unrdrvon2+1
	inx	;DRV0EN
  .if allow_multi=1
	stx	unrdrvsel+1
  .endif ;allow_multi
	inx
	inx ;Q6L
	stx	unrread1+1
  .if poll_drive=1
	stx	unrread2+1
	stx	unrread3+1
  .endif ;poll_drive
	stx	unrread4+1
	stx	unrread5+1
  .if check_checksum=1
	stx	unrread6+1
  .endif ;check_checksum
.endif ;enable_floppy
	ldx	#1
	stx	namlo
	inx
	stx	namhi

	jsr	MLI
	.byte	$c7
	.word c7_parms
	ldx	$200
	dex
	stx	sizelo

	bmi	readblock_plus_three	; +++

readblock:
	jsr	MLI
	.byte $80
	.word x80_parms

	lda	#<(readbuff+4)
	sta	bloklo
	lda	#>(readbuff+4)
	sta	blokhi
inextent:
	ldy	#0
	lda (bloklo), Y
	pha
	and 	#$d0

	; watch for subdirectory entries

	cmp	#$d0
	bne	readblock_plus_one	; +

	lda	(bloklo), Y
	and	#$0f
	tax
	iny
readblock_minus_two:			; --
	lda	(bloklo), Y
	cmp	(namlo), Y
	beq	ifoundname

	; match failed, move to next directory in this block, if possible

readblock_minus_one:			; -
readblock_plus_one:			; +
	pla
	clc
	lda	bloklo
	adc	#$27
	sta	bloklo
	bcc	readblock_plus_two	; +

	; there can be only one page crossed, so we can increment instead of adc

	inc	blokhi
readblock_plus_two:			; +
	cmp	#<(readbuff+$1ff) ;4+($27*$0d)
	lda	blokhi
	sbc	#>(readbuff+$1ff)
	bcc	inextent

	; read next directory block when we reach the end of this block

	lda	readbuff+2
	ldx	readbuff+3
	bcs	readblock_plus_four	; +

ifoundname:
	iny
	dex
	bne	readblock_minus_two	; --
	lda	(namlo), Y
	cmp	#'/'
	bne	readblock_minus_one	; -
	tya
	eor	#$ff
	adc	sizelo
	sta	sizelo
	clc
	tya
	adc	namlo
	sta	namlo
	pla
	and	#$20
	bne	readblock_plus_five	; ++
	ldy	#KEY_POINTER+1
	lda	(bloklo), Y
	tax
	dey
	lda	(bloklo), Y
.if enable_floppy=1
	sta	unrblocklo+1
	stx	unrblockhi+1
.endif ;enable_floppy
	sta	unrhddblocklo+1
	stx	unrhddblockhi+1
readblock_plus_four:		; +
	sta	x80_parms+4
	stx	x80_parms+5
readblock_plus_five:		; ++
	lda	sizelo
	bne	readblock

readblock_plus_three:		; +++
	pla
	lsr
	lsr
	lsr
	tax
	lsr
	ora	#$c0
	ldy	$bf11, x
	cpy	#$c8		; max slot+1
	bcs	set_slot
	tya
set_slot:
	sta	slot+2
	sta	unrentry+2
.if enable_floppy=1
	ldx	#>unrelocdsk
	ldy	#<unrelocdsk
slot:
	lda	$cfff
	sta	unrentry+1
	php
	beq	copydrv
	ldx	#>unrelochdd
	ldy	#<unrelochdd

copydrv:
	stx	blokhi
	sty	bloklo
  .if load_high=1
    .if lc_bank=1
	lda	LCBANK2
	lda	LCBANK2
    .else	; lc_bank
	lda	ROMIN
	lda	ROMIN
    .endif ;lc_bank
  .endif  ;load_high
	ldx	#>((bit2tbl-opendir)+$ff)
	ldy	#0
copydrv_minus_one:				; -
	lda	(bloklo), Y
reladr:
	sta	reloc, Y
	iny
	bne	copydrv_minus_one		; -
	inc	blokhi
	inc	reladr+2
	dex
	bne	copydrv_minus_one		; -
	plp
	bne	++
	ldx	#$16
copydrv_minus_two:				; --
	stx	bloklo
	txa
	asl
	bit	bloklo
	beq +
	ora bloklo
	eor #$ff
	and #$7e
-               bcs +
	lsr
	bne -
	tya
	sta nibtbl-$16, x
  .if enable_write=1
	txa
	ora #$80
	sta xlattbl, y
  .endif ;enable_write
	iny
+               inx
	bpl	copydriv_minus_two	; --
++              rts
.else ; enable_floppy
slot:
	lda	$cfff
	sta	unrentry+1
  .if load_high=1
    .if lc_bank=1
	lda	LCBANK2
	lda	LCBANK2
    .else ; { ;lc_bank
	lda	ROMIN
	lda	ROMIN
    .endif ;lc_bank
  .endif ;load_high
	ldy	#0
slot_minus_one:				; -
	lda	unrelochdd, Y
	sta	reloc, y
	lda	unrelochdd+$100, Y
	sta	reloc+$100, Y
	iny
	bne	slot_minus_one
	rts
.endif ;enable_floppy


c7_parms:
	.byte 1
	.word $200

x80_parms:
	.byte 3, $d1
	.word readbuff, 2

.if enable_floppy=1
unrelocdsk:

;!pseudopc reloc {
reloc	= $D000

opendir         ;read volume directory key block
unrblocklo=unrelocdsk+(*-reloc)
	ldx #2
unrblockhi=unrelocdsk+(*-reloc)
	lda #0
	jsr readdirsel

	;include volume directory header in count

readdir
  !if might_exist=1 {
	ldx dirbuf+37
	inx
	stx entries
  } ;might_exist
firstent        lda #<(dirbuf+4)
	sta bloklo
	lda #>(dirbuf+4)
	sta blokhi
nextent         ldy #0
  !if might_exist=1 {
	sty status
  } ;might_exist
	lda (bloklo), y
  !if (might_exist+allow_subdir)>0 {
	and #$f0

    !if might_exist=1 {
	;skip deleted entries without counting

	beq ++
    } ;might_exist
  } ;might_exist or allow_subdir

  !if allow_subdir=1 {
	;subdirectory entries are seedlings
	;but we need to distinguish between them later

	cmp #$d0
	beq savetype
  } ;allow_subdir

	;watch for seedling and saplings only

	cmp #$30
	bcs +

	;remember type

savetype
  !if allow_subdir=1 {
	asl
	asl
  } else { ;allow_subdir
	cmp #$20
  } ;allow_subdir
	php

	;match name lengths before attempting to match names

	lda (bloklo), y
	and #$0f
	tax
	inx
	!byte $2c
-               lda (bloklo), y
	cmp (namlo), y
	beq foundname

	;match failed, check if any directory entries remain

	plp
+
  !if might_exist=1 {
	dec entries
	bne ++
nodisk
unrdrvoff1=unrelocdsk+(*-reloc)
	lda MOTOROFF
	inc status
	rts
  } ;might_exist

	;move to next directory in this block, if possible

++              clc
	lda bloklo
	adc #$27
	sta bloklo
	bcc +

	;there can be only one page crossed, so we can increment instead of adc

	inc blokhi
+               cmp #<(dirbuf+$1ff) ;4+($27*$0d)
	lda blokhi
	sbc #>(dirbuf+$1ff)
	bcc nextent

	;read next directory block when we reach the end of this block

	ldx dirbuf+2
	lda dirbuf+3
	jsr readdirsec
	bne firstent

foundname       iny
	dex
	bne -
	stx entries

  !if enable_write=1 {
	ldy reqcmd
	cpy #cmdwrite           ;control carry instead of zero
	bne +

	;round requested size up to nearest sector if writing
	;or nearest block if using aligned reads

	lda sizelo
    !if aligned_read=0 {
	beq +
	inc sizehi
    } else { ;aligned_read
	ldx sizehi
	jsr round
	sta sizehi
    } ;aligned_read
+
  } ;enable_write

	;cache EOF (file size, loaded backwards)

	ldy #EOF+1
	lda (bloklo), y
  !if (enable_write+aligned_read)>0 {
	tax
  } else { ;enable_write or aligned_read
	sta sizehi
  } ;enable_write or aligned_read
	dey
	lda (bloklo), y
  !if (enable_write+aligned_read)>0 {

	;round file size up to nearest sector if writing without aligned reads
	;or nearest block if using aligned reads

    !if aligned_read=0 {
	bcc ++
	beq +
	inx
	lda #0
    } else { ;aligned_read
      !if enable_write=1 {
	jsr round
	tax
      } else { ;enable_write
	adc #$fe
	txa
	adc #1
	and #$fe
      } ;enable_write
    } ;aligned_read

	;set requested size to min(length, requested size)

    !if enable_write=1 {
+               cpx sizehi
	bcs +
++              stx sizehi
+
    } else { ;enable_write
	sta sizehi
    } ;enable_write
  } ;enable_write or aligned_read
  !if aligned_read=0 {
	sta sizelo
  } ;aligned_read

	;cache AUX_TYPE (load offset for binary files)

  !if override_adr=0 {
    !if allow_subdir=1 {
	pla
	tax
    } else { ;allow_subdir
	plp
    } ;allow_subdir
	ldy #AUX_TYPE
	lda (bloklo), y
	pha
	iny
	lda (bloklo), y
	pha
    !if allow_subdir=1 {
	txa
	pha
    } ;allow_subdir
  } ;override_adr

	;cache KEY_POINTER

	ldy #KEY_POINTER
	lda (bloklo), y
	tax
	sta dirbuf
	iny
	lda (bloklo), y
	sta dirbuf+256

	;read index block in case of sapling

  !if allow_subdir=1 {
	plp
	bpl rdwrfile
	php
	jsr readdirsec
	plp
  } else { ;allow_subdir
    !if override_adr=1 {
	plp
    } ;override_adr
	bcc rdwrfile
	jsr readdirsec
  } ;allow_subdir

	;restore load offset

rdwrfile
  !if override_adr=1 {
	ldx ldrhi
	lda ldrlo
  } else { ;override_adr
	pla
	tax
	pla
  } ;override_adr

  !if allow_subdir=1 {
	;check file type and fake size and load address for subdirectories

	bcc +
	ldy #2
	sty sizehi
	ldx #>dirbuf
	lda #<dirbuf
+
  } ;allow_subdir
	sta adrlo
	stx adrhi

  !if allow_aux=1 {
	ldx auxreq
	jsr setaux
  } ;allow_aux

  !if enable_write=1 {
	ldy reqcmd
	sty command
  } ;enable_write

rdwrloop
  !if aligned_read=0 {
	;set read/write size to min(length, $200)

	lda sizelo
	ldx sizehi
	cpx #2
	bcc +
	lda #0
	ldx #2
+               sta secsize1
	stx secsize2
  } ;aligned_read

	;fetch data block and read/write it

	ldy entries
	inc entries
	ldx dirbuf, y
	lda dirbuf+256, y
	jsr seekrdwr

  !if aligned_read=0 {
	;if low count is non-zero then we are done
	;(can happen only for partial last block)

	lda secsize1
	bne rdwrdone

	;if count is $1xx then we are done
	;(can happen only for partial last block)

	dec sizehi
	beq rdwrdone

	;loop while size-$200 is non-zero

	dec sizehi
	lda sizehi
	ora sizelo
  } else { ;aligned_read
	;loop while size-$200 is non-zero

	dec sizehi
	dec sizehi
  } ;aligned_read
	bne rdwrloop

unrdrvoff2=unrelocdsk+(*-reloc)
rdwrdone        lda MOTOROFF
  !if allow_aux=1 {
	ldx #0
setaux          sta CLRAUXRD, x
	sta CLRAUXWR, x
  } ;allow_aux
seekret         rts

	;no tricks here, just the regular stuff

seek            sty step
	asl phase
	txa
	asl
copy_cur        tax
	sta tmptrk
	sec
	sbc phase
	beq +++
	bcs +
	eor #$ff
	inx
	bcc ++
+               sbc #1
	dex
++              cmp step
	bcc +
	lda step
+               cmp #8
	bcs +
	tay
	sec
+               txa
	pha
	ldx step1, y
+++             php
	bne +
---             clc
	lda tmptrk
	ldx step2, y
+               stx tmpsec
	and #3
	rol
	tax
	lsr
unrseek=unrelocdsk+(*-reloc)
	lda PHASEOFF, x
--              ldx #$13
-               dex
	bne -
	dec tmpsec
	bne --
	bcs ---
	plp
	beq seekret
	pla
	inc step
	bne copy_cur

step1           !byte 1, $30, $28, $24, $20, $1e, $1d, $1c
step2           !byte $70, $2c, $26, $22, $1f, $1e, $1d, $1c

readadr
-               jsr readd5aa
	cmp #$96
	bne -
	ldy #3
-               sta curtrk
	jsr readnib
	rol
	sta tmpsec
	jsr readnib
	and tmpsec
	dey
	bne -
	rts

readd5aa
--              jsr readnib
-               cmp #$d5
	bne --
	jsr readnib
	cmp #$aa
	bne -
	tay	    ;we need Y=#$AA later

readnib
unrread1=unrelocdsk+(*-reloc)
-               lda Q6L
	bpl -
	rts

  !if (enable_write+aligned_read)=2 {
round           clc
	adc #$ff
	txa
	adc #1
	and #$fe
	rts
  } ;enable_write and aligned_read

readdirsel      ldy #0
	sty adrlo
  !if aligned_read=0 {
	sty secsize1
  } ;aligned_read

  !if allow_multi=1 {
	asl reqcmd
	bcc seldrive
	iny
seldrive        lsr reqcmd
unrdrvsel=unrelocdsk+(*-reloc)
	cmp DRV0EN, y
  } ;allow_multi
  !if poll_drive=1 {
	sty status
unrdrvon1=unrelocdsk+(*-reloc)
	ldy MOTORON
unrread2=unrelocdsk+(*-reloc)
-               ldy Q6L
	bpl -
unrread3=unrelocdsk+(*-reloc)
-               cpy Q6L
	bne readdirsec
	inc status
	bne -
	pla
	pla
	jmp nodisk
  } ;poll_drive

readdirsec      ldy #>dirbuf
	sty adrhi
  !if aligned_read=0 {
	ldy #2
	sty secsize2
  } ;aligned_read
	ldy #cmdread
	sty command

	;convert block number to track/sector

seekrdwr
unrdrvon2=unrelocdsk+(*-reloc)
	ldy MOTORON
	lsr
	txa
	ror
	lsr
	lsr
	sta phase
	txa
	and #3
	php
	asl
	plp
	rol
	sta reqsec

  !if aligned_read=0 {
	;set read size to min(first size, $100) and then read address

	ldy #0
	lda secsize2
	bne +
	ldy secsize1
+               sty secsize
	dec secsize2
  } ;aligned_read
	jsr readadr

	;if track does not match, then seek

	ldx curtrk
	cpx phase
	beq checksec
	jsr seek

	;force sector mismatch

	lda #$ff

	;match or read/write sector

checksec        jsr cmpsec

  !if aligned_read=0 {
	;return if less than one sector requested

	tya
	bne readret

	;return if only one sector requested

	lda secsize1
	cmp secsize2
	beq readret
	sta secsize
  } ;aligned_read
	inc reqsec
	inc reqsec

	;force sector mismatch

cmpsecrd:
	lda	#$ff

cmpsec:
  .if enable_write=1
	ldy	command
	cpy	#cmdwrite           ;we need Y=2 below
	beq	encsec
  .endif ; enable_write
cmpsec2:
	cmp	reqsec
	beq	readdata
	jsr	readadr
	beq	cmpsec2

	; read sector data

readdata:
	jsr	readd5aa
	eor	#$ad	;zero A if match
;;	bne *	   ;lock if read failure
unrread4=unrelocdsk+(*-reloc)

readdata_minus_one:			; -
	ldx	Q6L
	bpl	readdata_minus_one	; -
	eor	nibtbl-$96, X
	sta	bit2tbl-$aa, Y
	iny
	bne	readdata_minus_one	; -
unrread5=unrelocdsk+(*-reloc)

readdata_minus_two:			; --
	ldx	Q6L
	bpl	readdata_minus_two	; --
	eor	nibtbl-$96, X
	sta	(adrlo), Y		; the real address
	iny
  .if check_checksum=1
    .if aligned_read=0
	bne	check_end
    .else  ;aligned_read
	bne readdata_minus_two		; --
    .endif  ;aligned_read

unrread6=unrelocdsk+(*-reloc)

readdata_minus_three:			; -
	ldx	Q6L
	bpl	readdata_minus_three	; -
	eor	nibtbl-$96, X
	bne	cmpsecrd
  .endif ;check_checksum

  .if aligned_read=0
check_end:
	cpy	secsize
	bne	readdata_minus_two	; --
	ldy	#0
  .endif ;aligned_read
--              ldx #$a9
-               inx
	beq --
	lda (adrlo), y
	lsr bit2tbl-$aa, x
	rol
	lsr bit2tbl-$aa, x
	rol
	sta (adrlo), y
	iny
  .if aligned_read=0
	cpy secsize
  .endif ;aligned_read
	bne -
readret         inc adrhi
	rts

  .if enable_write=1
encsec:
--              ldx #$aa
-               dey
	lda (adrlo), y
	lsr
	rol bit2tbl-$aa, x
	lsr
	rol bit2tbl-$aa, x
	sta encbuf, y
	lda bit2tbl-$aa, x
	and #$3f
	sta bit2tbl-$aa, x
	inx
	bne -
	tya
	bne --

cmpsecwr:
	        jsr readadr
	cmp reqsec
	bne cmpsecwr

	;skip tail #$DE #$AA #$EB some #$FFs ...

	ldy #$24
-               dey
	bpl -

	;write sector data

unrslot1=unrelocdsk+(*-reloc)
	ldx #$d1
	lda Q6H, x             ;prime drive
	lda Q7L, x             ;required by Unidisk
	tya
	sta Q7H, x
	ora Q6L, x

	;40 cycles

	ldy #4	 ;2 cycles
	cmp $ea	;3 cycles
	cmp ($ea,x)            ;6 cycles
-               jsr writenib1          ;(29 cycles)

		       ;+6 cycles
	dey	    ;2 cycles
	bne -	  ;3 cycles if taken, 2 if not

	;36 cycles
		       ;+10 cycles
	ldy #(prolog_e-prolog) ;2 cycles
	cmp $ea	;3 cycles
-               lda prolog-1, y        ;4 cycles
	jsr writenib3          ;(17 cycles)

	;32 cycles if branch taken
		       ;+6 cycles
	dey	    ;2 cycles
	bne -	  ;3 cycles if taken, 2 if not

	;36 cycles on first pass
		       ;+10 cycles
	tya	    ;2 cycles
	ldy #$56               ;2 cycles
-               eor bit2tbl-1, y       ;5 cycles
	tax	    ;2 cycles
	lda xlattbl, x         ;4 cycles
unrslot2=unrelocdsk+(*-reloc)
	ldx #$d1               ;2 cycles
	sta Q6H, x             ;5 cycles
	lda Q6L, x             ;4 cycles

	;32 cycles if branch taken

	lda bit2tbl-1, y       ;5 cycles
	dey	    ;2 cycles
	bne -	  ;3 cycles if taken, 2 if not

	;32 cycles
		       ;+9 cycles
	clc	    ;2 cycles
--              eor encbuf, y          ;4 cycles
-               tax	    ;2 cycles
	lda xlattbl, x         ;4 cycles
unrslot3=unrelocdsk+(*-reloc)
	ldx #$d1               ;2 cycles
	sta Q6H, x             ;5 cycles
	lda Q6L, x             ;4 cycles
	bcs +	  ;3 cycles if taken, 2 if not

	;32 cycles if branch taken

	lda encbuf, y          ;4 cycles
	iny	    ;2 cycles
	bne --	 ;3 cycles if taken, 2 if not

	;32 cycles
		       ;+10 cycles
	sec	    ;2 cycles
	bcs -	  ;3 cycles

	;32 cycles
		       ;+3 cycles
+               ldy #(epilog_e-epilog) ;2 cycles
	cmp ($ea,x)            ;6 cycles
-               lda epilog-1, y        ;4 cycles
	jsr writenib3          ;(17 cycles)

	;32 cycles if branch taken
		       ;+6 cycles
	dey	    ;2 cycles
	bne -	  ;3 cycles if branch taken, 2 if not

	lda Q7L, x
	lda Q6L, x             ;flush final value
	inc adrhi
	rts

writenib1:
	cmp	($ea,X)			; 6 cycles
writenib2:
	cmp	($ea,X)			; 6 cycles
writenib3:
unrslot4=unrelocdsk+(*-reloc)
	ldx	#$d1			; 2 cycles
writenib4:
	sta	Q6H, X			; 5 cycles
	ora	Q6L, X			; 4 cycles
	rts				; 6 cycles

prolog:
	.byte $ad, $aa, $d5
prolog_e:
epilog:
	.byte $ff, $eb, $aa, $de
epilog_e:
.endif ;enable_write
bit2tbl         = (*+255) & -256
nibtbl          = bit2tbl+86
  !if enable_write=1 {
xlattbl         = nibtbl+106
dataend         = xlattbl+64
  } else { ;enable_write
dataend         = nibtbl+106
  } ;enable_write
;hack to error out when code is too large for current address
  .if reloc<$c000
    .if dataend>$c000
      .error "code is too large"
    .endif
  .else
    .if reloc<dirbuf
      .if dataend>dirbuf
        .error "code is too large"
      .endif
    .endif
  .endif
.endif ;enable_floppy
;.endif ;reloc


unrelochdd:
	.org reloc	; !pseudopc reloc {

hddopendir:      ;read volume directory key block

unrhddblocklo=unrelochdd+(*-reloc)
	ldx	#2
unrhddblockhi=unrelochdd+(*-reloc)
	lda	#0
	jsr	hddreaddirsel

.if enable_floppy=1
  .if (*-hddopendir) < (readdir-opendir)
	;essential padding to match offset with floppy version
    .res (readdir-opendir)-(*-hddopendir), $ea	; .fill
  .endif
.endif ;enable_floppy

	;include volume directory header in count

hddreaddir:
  .if might_exist=1
	ldx	dirbuf+37
	inx
	stx	entries
  .endif ;might_exist
hddfirstent:
	lda	#<(dirbuf+4)
	sta	bloklo
	lda	#>(dirbuf+4)
	sta	blokhi
hddnextent:
	ldy	#0
  .if might_exist=1
	sty	status
  .endif ;might_exist
	lda	(bloklo), Y
  .if (might_exist+allow_subdir)>0
	and	#$f0

    .if might_exist=1
	;skip deleted entries without counting

	beq	hddst_plus_two	; ++
    .endif ;might_exist
  .endif ;might_exist or allow_subdir

  .if allow_subdir=1
		;subdirectory entries are seedlings
		;but we need to distinguish between them later

	cmp	#$d0
	beq	hddsavetype
  .endif ;allow_subdir

		;watch for seedling and saplings only

	cmp	#$30
	bcs	hddst_plus_one	; +

		;remember type

hddsavetype:
  .if allow_subdir=1
	asl
	asl
  .else ;allow_subdir
	cmp	#$20
  .endif ;allow_subdir
	php

		;match name lengths before attempting to match names

	lda	(bloklo), Y
	and	#$0f
	tax
	inx
	.byte $2c
hddst_minus_one:				; -
	lda	(bloklo), Y
	cmp	(namlo), y
	beq	hddfoundname

		;match failed, check if any directory entries remain

	plp
hddst_plus_one:					; +
  .if might_exist=1
	dec	entries
	bne	hddst_plus_two			; ++
	inc	status
	rts
  .endif ;might_exist

		;move to next directory in this block, if possible

hddst_plus_two:					; __ ++
	clc
	lda	bloklo
	adc	#$27
	sta	bloklo
	bcc	hddst_plus_three		; +

	;there can be only one page crossed, so we can increment instead of adc

	inc	blokhi
hddst_plus_three:				; +
	cmp	#<(dirbuf+$1ff) ;4+($27*$0d)
	lda	blokhi
	sbc	#>(dirbuf+$1ff)
	bcc	hddnextent

		;read next directory block when we reach the end of this block

	ldx	dirbuf+2
	lda	dirbuf+3
	jsr	hddreaddirsec
	bcc	hddfirstent

hddfoundname:
	iny
	dex
	bne	hddst_minus_one		; -
	stx	entries

  .if enable_write=1
	ldy	reqcmd
	cpy	#cmdwrite           ;control carry instead of zero
	bne	hddst_plus_four

	;round requested size up to nearest block if writing

	lda	sizelo
	ldx	sizehi
	jsr	hddround
	sta	sizehi
    .if aligned_read=0
	sec
    .endif ;aligned_read
hddst_plus_four:			; +
  .endif ;enable_write

	;cache EOF (file size, loaded backwards)

	ldy	#EOF+1
	lda	(bloklo), Y
  .if (enable_write+aligned_read)>0
	tax
  .else ;enable_write or aligned_read
	sta	sizehi
  .endif ;enable_write or aligned_read
	dey
	lda	(bloklo), Y
  .if (enable_write+aligned_read)>0
    .if aligned_read=0
	bcc	hddst_plus_five	; ++
    .endif	;aligned_read

	;round file size up to nearest block if writing or using aligned reads

    .if enable_write=1
	jsr	hddround
	tax
      .if aligned_read=0 {
	lda	#0
      .endif ;aligned_read

		;set requested size to min(length, requested size)

	cpx	sizehi
	bcs	hddst_plus_six
hddst_plus_five:		; ++
	stx	sizehi
hddst_plus_six:			; +
    .else ;enable_write
	adc	#$fe
	txa
	adc	#1
	and	#$fe
	sta	sizehi
    .endif ;enable_write
  .endif ;enable_write or aligned_read
  .if aligned_read=0
	sta	sizelo
  .endif ;aligned_read

	;cache AUX_TYPE (load offset for binary files)

  .if override_adr=0
    .if allow_subdir=1
	pla
	tax
    .else  ;allow_subdir
	plp
    .endif ;allow_subdir
	ldy	#AUX_TYPE
	lda	(bloklo), Y
	pha
	iny
	lda	(bloklo), Y
	pha
    .if allow_subdir=1
	txa
	pha
    .endif ;allow_subdir
  .endif ;override_adr

	;cache KEY_POINTER

	ldy	#KEY_POINTER
	lda	(bloklo), Y
	tax
	sta	dirbuf
	iny
	lda	(bloklo), Y
	sta	dirbuf+256

	; read index block in case of sapling

  .if allow_subdir=1
	plp
	bpl	hddrdwrfile
	php
	jsr	hddreaddirsec
	plp
  .else  ;allow_subdir
    .if override_adr=1
	plp
    .endif ;override_adr
	bcc	hddrdwrfile
	jsr	hddreaddirsec
  .endif ;allow_subdir

	;restore load offset

hddrdwrfile:
  .if override_adr=1
	ldx	ldrhi
	lda	ldrlo
  .else  ;override_adr
	pla
	tax
	pla
  .endif ;override_adr

  .if allow_subdir=1
	;check file type and fake size and load address for subdirectories

	bcc	hdd_rdwr_plus_one	; +
	ldy	#2
	sty	sizehi
	ldx	#>dirbuf
	lda	#<dirbuf
hdd_rdwr_plus_one:		; +
  .endif ;allow_subdir
	sta	adrlo
	stx	adrhi

  .if allow_aux=1
	ldx	auxreq
	jsr	hddsetaux
  .endif ;allow_aux

hddrdwrloop:
  .if aligned_read=0
	;set read/write size to min(length, $200)

	lda	sizehi
	cmp	#2
	bcs	hdd_rdwr_plus_two	; +
	pha
	lda	#2
	sta	sizehi
	lda	adrhi
	pha
	lda	adrlo
	pha
	lda	#>dirbuf
	sta	adrhi
	lda	#0
	sta	adrlo
hdd_rdwr_plus_two:			; +
	php
  .endif ;aligned_read

	;fetch data block and read/write it

	ldy	entries
	inc	entries
	ldx	dirbuf, Y
	lda	dirbuf+256, Y
  .if enable_write=1
	ldy	reqcmd
  .endif ;enable_write
	jsr hddseekrdwr

  .if aligned_read=0
	plp
	bcc	hdd_rdwr_plus_three	; +
  .endif ;aligned_read
	inc	adrhi
	inc	adrhi
	dec	sizehi
	dec	sizehi
	bne	hddrdwrloop
  .if aligned_read=0
	lda	sizelo
	bne	hddrdwrloop
  .endif ;aligned_read
  .if allow_aux=1
hddrdwrdone:
	ldx	#0
hddsetaux:
	sta	CLRAUXRD, x
	sta	CLRAUXWR, x
  .endif ;allow_aux
	rts

  .if aligned_read=0
hdd_rdwr_plus_three:		; +
	pla
	sta	bloklo
	pla
	sta	blokhi
	pla
	tay
	beq	hdd_rdwr_plus_four	; +
	dey
hdd_rdwr_minus_one:		; -
	lda	(adrlo), Y
	sta	(bloklo), Y
	iny
	bne	hdd_rdwr_minus_one
	inc	blokhi
	inc	adrhi
	bne	hdd_rdwr_plus_four	; +
hdd_rdwr_minus_two:			; -
	lda	(adrlo), Y
	sta	(bloklo), Y
	iny
hdd_rdwr_plus_four:			; +
	cpy	sizelo
	bne	hdd_rdwr_minus_two	; -
    .if allow_aux=1
	beq	hddrdwrdone
    .else ;allow_aux
	rts
    .endif ;allow_aux
  .endif ;aligned_read

  .if enable_write=1
hddround:
	clc
	adc	#$ff
	txa
	adc	#1
	and	#$fe
	rts
  .endif ;enable_write

hddreaddirsel:
	ldy	#0
	sty	adrlo
  .if might_exist=1
	sty	status
  .endif ;might_exist

  .if allow_multi=1
	asl	reqcmd
	lsr	reqcmd
  .endif ;allow_multi

hddreaddirsec:
	ldy	#>dirbuf
	sty	adrhi
	ldy	#cmdread
  .if enable_write=1
hddseekrdwr:
  .endif ;enable_write
	sty	command
  .if enable_write=0
hddseekrdwr:
  .endif ;enable_write
	stx	bloklo
	sta	blokhi

unrunit=unrelochdd+(*-reloc)
	lda	#$d1
	sta	unit

unrentry=unrelochdd+(*-reloc)
	jmp	$d1d1

;} end reloc

readbuff:
.byte $D3,$C1,$CE,$A0,$C9,$CE,$C3,$AE
