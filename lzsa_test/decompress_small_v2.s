; -----------------------------------------------------------------------------
; Decompress raw LZSA2 block.
; Create one with lzsa -r -f2 <original_file> <compressed_file>
;
; in:
; * LZSA_SRC_LO and LZSA_SRC_HI contain the compressed raw block address
; * LZSA_DST_LO and LZSA_DST_HI contain the destination buffer address
;
; out:
; * LZSA_DST_LO and LZSA_DST_HI contain the last decompressed byte address, +1
;
; -----------------------------------------------------------------------------
; Backward decompression is also supported, use lzsa -r -b -f2 <original_file> <compressed_file>
; To use it, also define BACKWARD_DECOMPRESS=1 before including this code!
;
; in:
; * LZSA_SRC_LO/LZSA_SRC_HI must contain the address of the last byte of compressed data
; * LZSA_DST_LO/LZSA_DST_HI must contain the address of the last byte of the destination buffer
;
; out:
; * LZSA_DST_LO/LZSA_DST_HI contain the last decompressed byte address, -1
;
; -----------------------------------------------------------------------------
;
;  Copyright (C) 2019 Emmanuel Marty
;
;  This software is provided 'as-is', without any express or implied
;  warranty.  In no event will the authors be held liable for any damages
;  arising from the use of this software.
;
;  Permission is granted to anyone to use this software for any purpose,
;  including commercial applications, and to alter it and redistribute it
;  freely, subject to the following restrictions:
;
;  1. The origin of this software must not be misrepresented; you must not
;     claim that you wrote the original software. If you use this software
;     in a product, an acknowledgment in the product documentation would be
;     appreciated but is not required.
;  2. Altered source versions must be plainly marked as such, and must not be
;     misrepresented as being the original software.
;  3. This notice may not be removed or altered from any source distribution.
; -----------------------------------------------------------------------------

;NIBCOUNT = $FC                          ; zero-page location for temp offset

decompress_lzsa2:
	ldy	#$00
	sty	NIBCOUNT

decode_token:
	jsr	getsrc			; read token byte: XYZ|LL|MMM
	pha				; preserve token on stack

	and	#$18			; isolate literals count (LL)
	beq	no_literals		; skip if no literals to copy
	lsr				; shift literals count into place
	lsr
	lsr
	cmp	#$03			; LITERALS_RUN_LEN_V2?
	bcc	prepare_copy_literals	; if less, count is directly embedded in token

	jsr	getnibble		; get extra literals length nibble
					; add nibble to len from token
	adc	#$02			; (LITERALS_RUN_LEN_V2) minus carry
	cmp	#$12			; LITERALS_RUN_LEN_V2 + 15 ?
	bcc	prepare_copy_literals	; if less, literals count is complete

	jsr	getsrc			; get extra byte of variable literals count
					; the carry is always set by the CMP above
					; GETSRC doesn't change it
	sbc	#$EE			; overflow?

prepare_copy_literals:
	tax
	bcc prepare_copy_literals_high	; if not, literals count is complete

					; handle 16 bits literals count
					; literals count = directly these 16 bits
	jsr	getlargesrc		; grab low 8 bits in X, high 8 bits in A
	tay				; put high 8 bits in Y

prepare_copy_literals_high:
	txa
	beq	copy_literals
	iny

copy_literals:
	jsr	getput			; copy one byte of literals
	dex
	bne	copy_literals
	dey
	bne	copy_literals

no_literals:
	pla				; retrieve token from stack
	pha				; preserve token again
	asl
	bcs	repmatch_or_large_offset	; 1YZ: rep-match or 13/16 bit offset

	asl				; 0YZ: 5 or 9 bit offset
	bcs	offset_9_bit

					; 00Z: 5 bit offset

	ldx	#$FF			; set offset bits 15-8 to 1

	jsr	getcombinedbits		; rotate Z bit into bit 0, read nibble for bits 4-1
	ora	#$E0			; set bits 7-5 to 1
	bne	got_offset_lo		; go store low byte of match offset and prepare match

offset_9_bit:				; 01Z: 9 bit offset
	;;asl				; shift Z (offset bit 8) in place
	rol
	rol
	and	#$01
	eor	#$FF			; set offset bits 15-9 to 1
	bne	got_offset_hi		; go store high byte, read low byte of match offset and prepare match
					; (*same as JMP GOT_OFFSET_HI but shorter)

repmatch_or_large_offset:
	asl				; 13 bit offset?
	bcs	repmatch_or_16_bit	; handle rep-match or 16-bit offset if not

					; 10Z: 13 bit offset

	jsr	getcombinedbits		; rotate Z bit into bit 8, read nibble for bits 12-9
	adc	#$DE			; set bits 15-13 to 1 and substract 2 (to substract 512)
	bne	got_offset_hi		; go store high byte, read low byte of match offset and prepare match
					; (*same as JMP GOT_OFFSET_HI but shorter)

repmatch_or_16_bit:			; rep-match or 16 bit offset
	;;asl				; XYZ=111?
	bmi	rep_match		; reuse previous offset if so (rep-match)

					; 110: handle 16 bit offset
	jsr	getsrc			; grab high 8 bits
got_offset_hi:
	tax
	jsr	getsrc			; grab low 8 bits
got_offset_lo:
	sta	offslo			; store low byte of match offset
	stx	offshi			; store high byte of match offset

rep_match:

.ifdef BACKWARD_DECOMPRESS

	; Backward decompression - substract match offset

	sec				; add dest + match offset
	lda	putdst+1		; low 8 bits
offslo = *+1
	sbc	#$AA
	sta	copy_match_loop+1	; store back reference address
	lda	putdst+2
offshi = *+1
	sbc	#$AA			; high 8 bits
	sta	copy_match_loop+2	; store high 8 bits of address
	sec

.else

	; Forward decompression - add match offset

	clc				; add dest + match offset
	lda	putdst+1		; low 8 bits
offslo = *+1
	adc	#$AA
	sta	copy_match_loop+1	; store back reference address
offshi = *+1
	lda	#$AA			; high 8 bits
	adc	putdst+2
	sta	copy_match_loop+2	; store high 8 bits of address
.endif

	pla				; retrieve token from stack again
	and	#$07			; isolate match len (MMM)
	adc	#$01			; add MIN_MATCH_SIZE_V2 and carry
	cmp	#$09			; MIN_MATCH_SIZE_V2 + MATCH_RUN_LEN_V2?
	bcc	prepare_copy_match	; if less, length is directly embedded in token

	jsr	getnibble		; get extra match length nibble
					; add nibble to len from token
	adc	#$08			; (MIN_MATCH_SIZE_V2 + MATCH_RUN_LEN_V2) minus carry
	cmp	#$18			; MIN_MATCH_SIZE_V2 + MATCH_RUN_LEN_V2 + 15?
	bcc	prepare_copy_match	; if less, match length is complete

	jsr	getsrc			; get extra byte of variable match length
					; the carry is always set by the CMP above
					; GETSRC doesn't change it
	sbc	#$E8			; overflow?

prepare_copy_match:
	tax
	bcc	prepare_copy_match_y	; if not, the match length is complete
	beq	decompression_done	; if EOD code, bail

					; Handle 16 bits match length
	jsr	getlargesrc		; grab low 8 bits in X, high 8 bits in A
	tay				; put high 8 bits in Y

prepare_copy_match_y:
	txa
	beq	copy_match_loop
	iny

copy_match_loop:
	lda	$AAAA			; get one byte of backreference
	jsr	putdst			; copy to destination

.ifdef BACKWARD_DECOMPRESS

   ; Backward decompression -- put backreference bytes backward

	lda	copy_match_loop+1
	bne	getmatch_done
	dec	copy_match_loop+2
getmatch_done:
	dec	copy_match_loop+1

.else

	; Forward decompression -- put backreference bytes forward

	inc	copy_match_loop+1
	bne	getmatch_done
	inc	copy_match_loop+2

getmatch_done:

.endif

	dex
	bne	copy_match_loop
	dey
	bne	copy_match_loop
	jmp	decode_token

getcombinedbits:
	eor	#$80
	asl
	php

	jsr	getnibble		; get nibble into bits 0-3 (for offset bits 1-4)
	plp				; merge Z bit as the carry bit (for offset bit 0)
combinedbitz:
	rol				; nibble -> bits 1-4; carry(!Z bit) -> bit 0 ; carry cleared
decompression_done:
	rts

getnibble:
nibbles = *+1
	lda	#$AA
	lsr	NIBCOUNT
	bcs	has_nibbles

	inc	NIBCOUNT
	jsr	getsrc			; get 2 nibbles
	sta	nibbles
	lsr
	lsr
	lsr
	lsr
	sec

has_nibbles:
	and	#$0F			; isolate low 4 bits of nibble
	rts

.ifdef BACKWARD_DECOMPRESS

   ; Backward decompression -- get and put bytes backward

getput:
	jsr	getsrc
putdst:
LZSA_DST_LO = *+1
LZSA_DST_HI = *+2
	sta	$AAAA
	lda	putdst+1
	bne	putdst_done
	dec	putdst+2
putdst_done:
	dec	putdst+1
	rts

getlargesrc:
	jsr	getsrc			; grab low 8 bits
	tax				; move to X
					; fall through grab high 8 bits

getsrc:
LZSA_SRC_LO = *+1
LZSA_SRC_HI = *+2
	lda	$AAAA
	pha
	lda	getsrc+1
	bne	getsrc_done
	dec	getsrc+2
getsrc_done:
	dec	getsrc+1
	pla
	rts

.else

   ; Forward decompression -- get and put bytes forward

getput:
	jsr	getsrc

putdst:
LZSA_DST_LO = *+1
LZSA_DST_HI = *+2
	sta	$AAAA
	inc	putdst+1
	bne	putdst_done
	inc	putdst+2
putdst_done:
	rts

getlargesrc:
	jsr	getsrc			; grab low 8 bits
	tax				; move to X
					; fall through grab high 8 bits

getsrc:
LZSA_SRC_LO = *+1
LZSA_SRC_HI = *+2
	lda	$AAAA
	inc	getsrc+1
	bne	getsrc_done
	inc	getsrc+2
getsrc_done:
	rts

.endif

