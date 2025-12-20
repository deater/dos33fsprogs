; De-compressor for ZX02 files
; ----------------------------
;
; Decompress ZX02 data (6502 optimized format), optimized for speed and size
;  138 bytes code, 58.0 cycles/byte in test file.
;
; Compress with:
;    zx02 input.bin output.zx0
;
; (c) 2022 DMSC
; Code under MIT license, see LICENSE file.


; ZP=$00

;offset          = ZP+0
;ZX0_src         = ZP+2
;ZX0_dst         = ZP+4
;bitr            = ZP+6
;pntr            = ZP+7


RESULT = $D0
TEMPL = $D1
TEMPH = $D2
FAKEL = $D3
FAKEH = $D4
CURRENT_Y = $D5
HGR_OUTL = $D6
HGR_OUTH = $D7
CURRENT_X = $D8

;--------------------------------------------------
; Decompress ZX0 data (6502 optimized format)

zx02_full_decomp:

	sta	ZX0_dst+1	; page to output to in A

	ldy	#$80
	sty	bitr

	ldy	#$20
	sty	HGR_OUTH

	ldy	#0
	sty	HGR_OUTL
	sty	offset
	sty	offset+1
	sty	ZX0_dst		; assume dest always on page boundary
	sty	CURRENT_Y
	sty	CURRENT_X

; Decode literal: Ccopy next N bytes from compressed file
;    Elias(length)  byte[1]  byte[2]  ...  byte[N]

decode_literal:
	jsr	get_elias

cop0:
	lda	(ZX0_src), Y
	inc	ZX0_src
	bne	plus1
	inc	ZX0_src+1
plus1:
	jsr	store_and_inc

	dex
	bne	cop0

	asl	bitr
	bcs	dzx0s_new_offset

; Copy from last offset (repeat N bytes from last offset)
;    Elias(length)

	jsr	get_elias
dzx0s_copy:
	lda	ZX0_dst
	sbc	offset  ; C=0 from get_elias
	sta	pntr
	lda	ZX0_dst+1
	sbc	offset+1
	sta	pntr+1

cop1:
	jsr	div_by_40_pntr
	lda	(FAKEL),Y

;	lda	(pntr), Y
	inc	pntr
	bne	plus3
	inc	pntr+1
plus3:

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


store_and_inc:

	sta	(HGR_OUTL),Y

	inc	ZX0_dst
	bne	done_zxadd
	inc	ZX0_dst+1
done_zxadd:

	inc	HGR_OUTL
	inc	CURRENT_X
	lda	CURRENT_X
	cmp	#40
	bne	done_store_and_inc

	lda	#0
	sta	CURRENT_X
	inc	CURRENT_Y
	ldy	CURRENT_Y
	lda	hposn_low,Y
	sta	HGR_OUTL
	lda	hposn_high,Y
	sta	HGR_OUTH
	ldy	#0

;	inc	ZX0_dst
;	bne	done_store_and_inc
;	inc	ZX0_dst+1
done_store_and_inc:

	rts



; want to map packed to actual

; any time dest used

; $2000 -> row one
; $2028 -> row two

; divide by 40?  divide by 8 then by 5?
; 8192 = $2000
; $2000/8 = $1000, $800,$400
; 1k lookup table?


div_by_40_pntr:
	pha				; save values

	lda	pntr
	sta	TEMPL
	lda	pntr+1
;	jmp	div_by_40_common

	;==============================
	; 16-bit div by 40
	;==============================
	; in ZX0_dst/ZX0_dst-1
	; mask off top 3 bits? 0x2000 0x4000
	;	to 0x000

	; put remapped address in FAKEL/FAKEH
;div_by_40:
;	pha				; save values

;	lda	ZX0_dst
;	sta	TEMPL
;	lda	ZX0_dst+1
;div_by_40_common:
	and	#$1F
	sta	TEMPH
	lda	#0
	sta	RESULT

div_by_40_loop:
	sec
	lda	TEMPL
	sbc	#40
	sta	TEMPL
	bcc	dbuflo
	inc	RESULT
	jmp	div_by_40_loop
dbuflo:
	lda	TEMPH
	sbc	#0
	sta	TEMPH
	inc	RESULT
	bcs	div_by_40_loop
	ldy	RESULT
	dey				; adjust

	lda	hposn_low,Y
	sta	FAKEL
	lda	hposn_high,Y
	sta	FAKEH

	; add back #40
	clc
	lda	TEMPL
	adc	#40

	cmp	#40
	bcs	no_r

	clc
	adc	FAKEL
	sta	FAKEL
no_r:

	ldy	#0		; Y always 0 in this code

	pla

	rts
