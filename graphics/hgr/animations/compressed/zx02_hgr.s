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

; modified by deater to be Apple II hi-res specific

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
lowTen = $D3
highTen = $D4
CURRENT_Y = $D5
HGR_OUTL = $D6
HGR_OUTH = $D7
CURRENT_X = $D8
PNTR_ROW	= $D9
temp = $CF
counterLow = $CD
counterHigh = $CE


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
	sbc	offset			; C=0 from get_elias
	sta	pntr
	lda	ZX0_dst+1
	sbc	offset+1
	sta	pntr+1

	jsr	div_by_40_pntr

cop1:

;	lda	(FAKEL),Y

	lda	(pntr), Y
	inc	pntr		; can never overflow


	pha

	lda	pntr
	and	#$7f		; oflo if $28, $50, $78
				;	  $A8, $D0, $F8

	cmp	#$28
	beq	pntr_oflo
	cmp	#$50
	beq	pntr_oflo
	cmp	#$78
	bne	pntr_oflo_done

pntr_oflo:
	inc	PNTR_ROW

	ldy	PNTR_ROW
	lda	hposn_low,Y
	sta	pntr
	lda	hposn_high,Y
	sta	pntr+1

	ldy	#0
pntr_oflo_done:

	pla

;	bne	plus3
;	inc	pntr+1
;plus3:

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

	inc	CURRENT_Y
	ldy	CURRENT_Y
	lda	hposn_low,Y
	sta	HGR_OUTL
	lda	hposn_high,Y
	sta	HGR_OUTH
	ldy	#0
	sty	CURRENT_X

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


; 0..192*40 = 7680 bytes
; 960 / 5 would also work



	;==============================
	; 16-bit div by 40
	;==============================
	; in ZX0_dst/ZX0_dst-1
	; mask off top 3 bits? 0x2000 0x4000
	;	to 0x000

	; put remapped address in FAKEL/FAKEH

div_by_40_pntr:
	pha

	lda	pntr
	sta	counterLow
	lda	pntr+1
	and	#$1f
	sta	counterHigh

	jsr	startDivideBy10

	; 7680 / 10 = 768

	lsr	highTen
	ror	lowTen

	lsr	highTen
	ror	lowTen

	; lowTen is now address / 40

	ldy	lowTen

	lda	hposn_low,Y
	sta	pntr
	lda	hposn_high,Y
	sta	pntr+1

	sty	PNTR_ROW


	;==========================
	; calculate remainder

	; 16-bit multiply by 40
	;	((x*4)+x)*8


	lda	#0
	sta	TEMPH

	lda	PNTR_ROW

	asl				;
	rol	TEMPH			; *2
	asl				;
	rol	TEMPH			; *4

	clc
	adc	PNTR_ROW
	bcc	rnoflo
	inc	TEMPH
rnoflo:
					; now has X*5

	asl				;
	rol	TEMPH			; *10
	asl				;
	rol	TEMPH			; *20
	asl				;
	rol	TEMPH			; *40

	sta	TEMPL

	sec
	lda	counterLow
	sbc	TEMPL
	sta	TEMPL			; know this is < 255?
	lda	counterHigh
	sbc	TEMPH
	sta	TEMPH

	lda	pntr
	clc
	adc	TEMPL
	sta	pntr
	lda	TEMPH
	adc	pntr+1
	sta	pntr+1


	ldy	#0		; Y always 0 in this code

	pla

	rts

.include "div10.s"
