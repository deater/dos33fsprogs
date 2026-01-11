; De-compressor for de-interlaced HGR ZX02 files
; ----------------------------------------------
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

RESULT		= $D0
TEMPL		= $D1
TEMPH		= $D2
FAKEL		= $D3
FAKEH		= $D4

;lowTen		= $D3
;highTen		= $D4
CURRENT_Y	= $D5
HGR_OUTL	= $D6
HGR_OUTH	= $D7
CURRENT_X	= $D8
PNTR_ROW	= $D9
temp		= $CF
;counterLow	= $CD
;counterHigh	= $CE


;--------------------------------------------------
; Decompress ZX0 data (6502 optimized format)

zx02_full_decomp:

	sta	ZX0_dst+1	; page to output to in A

	ldy	#$80		; ??
	sty	bitr

	ldy	#$20		; set OUTH to be $2000
	sty	HGR_OUTH

	ldy	#0
	sty	HGR_OUTL

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


	; convert destination from expected linear to instead be
	; apple II interleave

	; $0000 -> $2000  (x=0,y=0)
	; $0001 ->        (x=0,y=1)
	; ...
	; $00BF ->        (x=0,y=191)
	; $00C0 -> $2001  (x=1,y=0)
	; $00C1 ->        (x=1,y=1)

	; read_addr= y_lookup[(actual_addr)%192]+(actual_addr/192)


dzx0s_copy:


	lda	ZX0_dst
	sbc	offset			; C=0 from get_elias
	sta	pntr
;	sta	counterLow

	lda	ZX0_dst+1
	sbc	offset+1

	and	#$1f
	sta	pntr+1
;	sta	counterHigh

cop1:

	jsr	div_by_192_pntr

	lda	(FAKEL), Y

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

	ldy	CURRENT_X

	sta	(HGR_OUTL),Y

	; incrememnt ZX02_dst for bookkeeping purposes

	inc	ZX0_dst
	bne	done_zxadd
	inc	ZX0_dst+1
done_zxadd:

	inc	CURRENT_Y		; go to next row

	ldy	CURRENT_Y
	cpy	#192
	bne	yadd_nowrap

	; go to next column

	lda	#0
	sta	CURRENT_Y

	inc	CURRENT_X

yadd_nowrap:
	ldy	CURRENT_Y		; lookup in lookup table
	lda	hposn_low,Y
	sta	HGR_OUTL

	lda	hposn_high,Y
	sta	HGR_OUTH

done_store_and_inc:

	ldy	#0			; restore y to 0

	rts



; want to map packed to actual

; any time dest used

; $2000 -> row one
; $2028 -> row two

; divide by 40?  divide by 8 then by 5?
; 8192 = $2000
; $2000/8 = $1000, $800,$400
; 1k lookup table?


; 0..192*40 = 7680 bytes
; 960 / 5 would also work


; max is 8192
; 0x20.00 >> 64 (6)
; 0x02.00 >>4
; 0x0

;/ 192 = /64 = 3

	;==============================
	; 16-bit div by 192
	;==============================
	; in counterLow/counterHigh (counterHigh has top 3 bits masked off)

	; puts divided address in PNTR_ROW

	; pntr/pntr+1 is set up with address


div_by_192_pntr:
	pha				; save values
	txa
	pha

	lda	pntr			; put pntr value into TEMPL/TEMPH
	sta	TEMPL
	lda	pntr+1
;	and	#$1F
	sta	TEMPH

	lda	#0			; set result to 0
	sta	RESULT

div_by_192_loop:
	sec
	lda	TEMPL
	sbc	#192
	sta	TEMPL
	bcc	dbuflo
	inc	RESULT
	jmp	div_by_192_loop
dbuflo:
	lda	TEMPH
	sbc	#0
	sta	TEMPH
	inc	RESULT
	bcs	div_by_192_loop

	; here if less than 0

	dec	RESULT			; adjust for going 1 past

	; add back #192
	clc
	lda	TEMPL
	adc	#192

	; A is remainder

	tax
	lda	hposn_low,X		; lookup location of row X
	sta	FAKEL
	lda	hposn_high,X
	sta	FAKEH

	; FIXME: combine with above?

	clc
	lda	RESULT			; get result

	adc	FAKEL
	sta	FAKEL			; add back in remainder
	lda	FAKEH
	adc	#0
	sta	FAKEH

	pla				; restore
	tax
	pla

	rts
