;license:BSD-3-Clause

; vaguely based on the minimal open/read binary file in ProDOS filesystem
; from 4cade
;
;copyright (c) Peter Ferrie 2016-2019

.include "hardware.inc"
.include "zp.inc"

	; we want to load 10 blocks from 1024 to $0b00

	; blurgh we want to load 10.5 (512-byte) blocks
	; I guess we can load 11 and hope over-writing a bit at $2000
	;	doesn't matter?

QLOAD_BLOCK	=	((0+1)*512)+(1*8)+(0)	; D0 T1 S0
QLOAD_ADDR	=	$0b00
QLOAD_SIZE	=	11


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
	sta	UNIT		; save for later (also has meaning)

	tax

	; 4cade calls a print-title routine here that exits with Y=0


	ldy	#0

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
	sta	slot_smc+2
	sta	entry_smc+2	; set up smartport/prodos entry point

slot_smc:
	lda	$cfff
	sta	entry_smc+1	; set up rest of smartport/prodos entry


;opendir:


	ldy	#>QLOAD_BLOCK		; high
	ldx	#<QLOAD_BLOCK		; low

	lda	#>QLOAD_ADDR		; high
	sta	ADRHI
	lda	#0
	sta	ADRLO

	lda	#QLOAD_SIZE

	jsr	seekread


done:
	jmp	QLOAD_ADDR


	;================================
	; seek + read blocks
	;================================
	; this calls the smartport PRODOS entrypoint
	;	command=1 READBLOCK
	;	I can't find this documented anywhere
	;	but the paramaters are stored in the zero page
	;================================
	; Y:X = block number to load (???)
	; A = num blocks
seekread:
	sta	COUNT

	stx   BLOKLO
	sty   BLOKHI

seekread_loop:
	lda   #1		; READBLOCK
	sta   COMMAND
	lda   ADRHI
	pha
entry_smc:
	jsr	$d1d1
	pla
	sta	ADRHI

	inc	ADRHI		; twice, as 512 byte chunks
	inc	ADRHI

	inc	BLOKLO		; increment block pointer
	bne	no_blokloflo
	inc	BLOKHI
no_blokloflo:


	dec	COUNT
	bne	seekread_loop

	rts
