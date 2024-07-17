;license:BSD-3-Clause

; based on minimal open/read binary file in ProDOS filesystem
; from 4cade
;
;copyright (c) Peter Ferrie 2016-2019

.include "hardware.inc"



; zpage usage, arbitrary selection except for the "ProDOS constant" ones

	; this is the structure for a smartport command, at least
	; for a read (command=1)


	COMMAND	= $42		; ProDOS constant
	UNIT	= $43		; ProDOS constant
	ADRLO	= $44		; ProDOS constant
	ADRHI	= $45		; ProDOS constant
	BLOKLO	= $46		; ProDOS constant
	BLOKHI	= $47		; ProDOS constant

;	A2L       = $3e
;	A2H       = $3f
;	sizehi    = $53

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
	lsr
	lsr
	lsr
	lsr
	and	#7
	ora	#$c0
;	sta	$be30, Y	; ????
	sta	slot_smc+2
	sta	entry_smc+2	; set up smartport/prodos entry point

slot_smc:
	lda	$cfff
	sta	entry_smc+1	; set up rest of smartport/prodos entry

;	lda	fakeMLI_e-$100, Y
;	sta	$be00+fakeMLI_e-fakeMLI, Y
;	iny
;	bne	setup_loop	; ?????

	; Y is 0 here
;	ldy	#0
;	sty	ADRLO
;	stx	$bf30		; ?????
;	sty	$200		; ?????

opendir:



	; we want to load 5 blocks from 1024 to $1600


QLOAD_BLOCK	=	1024
QLOAD_ADDR	=	$1600


	ldy	#>QLOAD_BLOCK		; high
	ldx	#<QLOAD_BLOCK		; low

	lda	#>QLOAD_ADDR		; high
	sta	ADRHI
	lda	#0
	sta	ADRLO

	jsr	seekread


done:
	jmp	done


	;================================
	; seek read
	;================================
	; this calls the smartport PRODOS entrypoint
	;	command=1 READBLOCK
	;	I can't find this documented anywhere
	;	but the paramaters are stored in the zero page
	;================================
	; Y:X = block number to load (???)
	; ADRHI preserved
seekread:
	stx   BLOKLO
	sty   BLOKHI
	lda   #1		; READBLOCK
	sta   COMMAND
	lda   ADRHI
	pha
entry_smc:
	jsr	$d1d1
	pla
	sta	ADRHI
	rts
