; De-compressor for de-interlaced HGR ZX02 files (vertical, 256)
; --------------------------------------------------------------
;
; Decompress ZX02 data (6502 optimized format), optimized for speed and size
;  138 bytes code, 58.0 cycles/byte in test file.
;
; Compress with:
;    zx02 input.bin output.zx0
;
; (c) 2022 DMSC

; modified by deater to be Apple II hi-res specific

; Code under MIT license, see LICENSE file.


; ZP=$00

;offset          = ZP+0
;ZX0_src         = ZP+2
;ZX0_dst         = ZP+4
;bitr            = ZP+6
;pntr            = ZP+7

;RESULT		= $D0
;TEMPL		= $D1
;TEMPH		= $D2
FAKEL		= $D3
FAKEH		= $D4
CURRENT_Y	= $D5
HGR_OUTL	= $D6
HGR_OUTH	= $D7
CURRENT_X	= $D8


;--------------------------------------------------
; Decompress ZX0 data (6502 optimized format)

zx02_full_decomp:

	sta	ZX0_dst+1	; page to output to in A

	ldy	#$80		; ??
	sty	bitr

;	ldy	#$20		; set OUTH to be $2000
;	sty	HGR_OUTH

	ldy	#0
;	sty	HGR_OUTL

	sty	offset		; ?
	sty	offset+1

	sty	ZX0_dst		; assume dest always on page boundary

	sty	CURRENT_Y	; ?
	sty	CURRENT_X

; Decode literal: Ccopy next N bytes from compressed file
;    Elias(length)  byte[1]  byte[2]  ...  byte[N]

decode_literal:
	jsr	get_elias

cop0:
	lda	(ZX0_src), Y
	inc	ZX0_src		; 16-bit increment
	bne	plus1
	inc	ZX0_src+1
plus1:
	jsr	store_and_inc	; store value and increment

	dex			; X is length of run?
	bne	cop0

	asl	bitr
	bcs	dzx0s_new_offset

; Copy from last offset (repeat N bytes from last offset)
;    Elias(length)

	jsr	get_elias

	; copy from existing decompressed values


dzx0s_copy:


	lda	ZX0_dst
	sbc	offset			; C=0 from get_elias
	sta	pntr
;	sta	counterLow

	lda	ZX0_dst+1
	sbc	offset+1

;	and	#$1f
	sbc	#$20			;get down to 0

	sta	pntr+1
;	sta	counterHigh

cop1:

	;==============================
	; 16-bit div by 256
	;==============================

	; pntr   has Y
	; pntr+1 has X

	ldy	pntr			; if >192 clamp to 191
	cpy	#192
	bcc	pntr_good
	ldy	#191

pntr_good:

	clc
	lda	hposn_low,Y		; lookup location of row X
	sta	FAKEL
	lda	hposn_high,Y
	sta	FAKEH

	ldy	pntr+1

	lda	(FAKEL), Y

	ldy	#0

	inc	pntr
	bne	pntr_noflo
	inc	pntr+1

pntr_noflo:

	jsr	store_and_inc

	dex
	bne	cop1

	asl	bitr
	bcc	decode_literal

; Copy from new offset (repeat N bytes from new offset)
;    Elias(MSB(offset))  LSB(offset)  Elias(length-1)

dzx0s_new_offset:

	; Read elias code for high part of offset

	jsr	get_elias
	beq	exit			; Read a 0, signals the end

	; Decrease and divide by 2

	dex
	txa
	lsr				; @
	sta	offset+1

	; Get low part of offset, a literal 7 bits
	lda	(ZX0_src), Y
	inc	ZX0_src
	bne	plus5
	inc	ZX0_src+1
plus5:
	; Divide by 2
	ror				; @
	sta	offset

	; And get the copy length.
	; Start elias reading with the bit already in carry:

	ldx	#1
	jsr	elias_skip1

	inx
	bcc	dzx0s_copy

; Read an elias-gamma interlaced code.
; ------------------------------------

get_elias:
	; Initialize return value to #1
	ldx	#1
	bne	elias_start

elias_get:
	; Read next data bit to result
	asl	bitr
	rol				; @
	tax

elias_start:
	; Get one bit
	asl	bitr
	bne	elias_skip1

	; Read new bit from stream
	lda	(ZX0_src), Y
	inc	ZX0_src
	bne	plus6
	inc	ZX0_src+1
plus6:
	;sec		; not needed, C=1 guaranteed from last bit
	rol		; @
	sta	bitr

elias_skip1:
	txa
	bcs	elias_get
	; Got ending bit, stop reading
exit:
	rts

	;===============================
	; store and inc
	;===============================
	; store value in A to HGR_OUT
	; increment ZX0_dst
	; also increment HGR_OUT, wrapping to next row if needed

store_and_inc:

	ldy	CURRENT_Y		; lookup in lookup table
	cpy	#192
	bcs	sai_skip_store

	pha

	lda	hposn_low,Y
	sta	HGR_OUTL

	lda	hposn_high,Y
	sta	HGR_OUTH

	ldy	CURRENT_X

	pla

	sta	(HGR_OUTL),Y

sai_skip_store:

	; incrememnt ZX02_dst for bookkeeping purposes

	inc	ZX0_dst
	bne	done_zxadd
	inc	ZX0_dst+1
done_zxadd:

	inc	CURRENT_Y		; go to next row

	ldy	CURRENT_Y
	bne	yadd_nowrap

	; go to next column

	inc	CURRENT_X

yadd_nowrap:


done_store_and_inc:

	ldy	#0			; restore y to 0

	rts
