; NOTE!  DOES NOT WORK

; alogithm uses the result as a lookup table so if you try to modify
; before writing then everything gets corrupt


; note -- modified by Vince Weaver to assemble with ca65
;		in this case, A = page to decompress to
;		getsrc_smc+1, getsrc_smc+2 is src location

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
;  Copyright (C) 2019 Emmanuel Marty, Peter Ferrie
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

decompress_lzsa2_overlay:

	sta	LZSA_DST_HI_OVERLAY

	ldy	#$00
	sty	LZSA_DST_LO_OVERLAY
	sty	NIBCOUNT

decode_token_overlay:
	jsr	getsrc_overlay		; read token byte: XYZ|LL|MMM
	pha				; preserve token on stack

	and	#$18			; isolate literals count (LL)
	beq	no_literals_overlay	; skip if no literals to copy
	cmp	#$18			; LITERALS_RUN_LEN_V2?
	bcc	prepare_copy_literals_overlay	; if less, count is directly embedded in token

	jsr	getnibble_overlay		; get extra literals length nibble
					; add nibble to len from token
	adc	#$02			; (LITERALS_RUN_LEN_V2) minus carry
	cmp	#$12			; LITERALS_RUN_LEN_V2 + 15 ?
	bcc	prepare_copy_literals_direct_overlay	; if less, literals count is complete

	jsr	getsrc_overlay			; get extra byte of variable literals count
					; the carry is always set by the CMP above
					; GETSRC doesn't change it
	sbc	#$EE			; overflow?
	jmp	prepare_copy_literals_direct_overlay

prepare_copy_literals_large_overlay:
					; handle 16 bits literals count
					; literals count = directly these 16 bits
	jsr	getlargesrc_overlay		; grab low 8 bits in X, high 8 bits in A
	tay				; put high 8 bits in Y
	bcs	prepare_copy_literals_high_overlay	; (*same as JMP PREPARE_COPY_LITERALS_HIGH but shorter)

prepare_copy_literals_overlay:
	lsr				; shift literals count into place
	lsr
	lsr

prepare_copy_literals_direct_overlay:
	tax
	bcs	prepare_copy_literals_large_overlay	; if so, literals count is large

prepare_copy_literals_high_overlay:
	txa
	beq	copy_literals_overlay
	iny

copy_literals_overlay:
	jsr	getput_overlay			; copy one byte of literals
	dex
	bne	copy_literals_overlay
	dey
	bne	copy_literals_overlay

no_literals_overlay:
	pla				; retrieve token from stack
	pha				; preserve token again
	asl
	bcs	repmatch_or_large_offset_overlay	; 1YZ: rep-match or 13/16 bit offset

	asl					; 0YZ: 5 or 9 bit offset
	bcs	offset_9_bit_overlay

					; 00Z: 5 bit offset

	ldx	#$FF			; set offset bits 15-8 to 1

	jsr	getcombinedbits_overlay		; rotate Z bit into bit 0, read nibble for bits 4-1
	ora	#$E0			; set bits 7-5 to 1
	bne	got_offset_lo_overlay		; go store low byte of match offset and prepare match

offset_9_bit_overlay:				; 01Z: 9 bit offset
	;;asl				; shift Z (offset bit 8) in place
	rol
	rol
	and	#$01
	eor	#$FF			; set offset bits 15-9 to 1
	bne	got_offset_hi_overlay		; go store high byte, read low byte of match offset and prepare match
					; (*same as JMP GOT_OFFSET_HI but shorter)

repmatch_or_large_offset_overlay:
	asl				; 13 bit offset?
	bcs	repmatch_or_16bit_overlay	; handle rep-match or 16-bit offset if not

					; 10Z: 13 bit offset

	jsr	getcombinedbits_overlay		; rotate Z bit into bit 8, read nibble for bits 12-9
	adc	#$DE			; set bits 15-13 to 1 and substract 2 (to substract 512)
	bne	got_offset_hi_overlay		; go store high byte, read low byte of match offset and prepare match
					; (*same as JMP GOT_OFFSET_HI but shorter)

repmatch_or_16bit_overlay:			; rep-match or 16 bit offset
	;;ASL				; XYZ=111?
	bmi	rep_match_overlay		; reuse previous offset if so (rep-match)

					; 110: handle 16 bit offset
	jsr	getsrc_overlay			; grab high 8 bits
got_offset_hi_overlay:
	tax
	jsr	getsrc_overlay			; grab low 8 bits
got_offset_lo_overlay:
	sta	OFFSLO_OVERLAY			; store low byte of match offset
	stx	OFFSHI_OVERLAY			; store high byte of match offset

rep_match_overlay:

	; Forward decompression - add match offset

	clc				; add dest + match offset
	lda	putdst_smc_overlay+1		; low 8 bits
OFFSLO_OVERLAY = *+1
	adc	#$AA
	sta	copy_match_loop_overlay+1	; store back reference address
OFFSHI_OVERLAY = *+1
	lda	#$AA			; high 8 bits
	adc	putdst_smc_overlay+2
	sta	copy_match_loop_overlay+2	; store high 8 bits of address

	pla				; retrieve token from stack again
	and	#$07			; isolate match len (MMM)
	adc	#$01			; add MIN_MATCH_SIZE_V2 and carry
	cmp	#$09			; MIN_MATCH_SIZE_V2 + MATCH_RUN_LEN_V2?
	bcc	prepare_copy_match_overlay	; if less, length is directly embedded in token

	jsr	getnibble_overlay		; get extra match length nibble
					; add nibble to len from token
	adc	#$08			; (MIN_MATCH_SIZE_V2 + MATCH_RUN_LEN_V2) minus carry
	cmp	#$18			; MIN_MATCH_SIZE_V2 + MATCH_RUN_LEN_V2 + 15?
	bcc	prepare_copy_match_overlay	; if less, match length is complete

	jsr	getsrc_overlay			; get extra byte of variable match length
					; the carry is always set by the CMP above
					; GETSRC doesn't change it
	sbc	#$E8			; overflow?

prepare_copy_match_overlay:
	tax
	bcc	prepare_copy_match_y_overlay	; if not, the match length is complete
	beq	decompression_done_overlay	; if EOD code, bail

					; Handle 16 bits match length
	jsr	getlargesrc_overlay		; grab low 8 bits in X, high 8 bits in A
	tay				; put high 8 bits in Y

prepare_copy_match_y_overlay:
	txa
	beq	copy_match_loop_overlay
	iny

copy_match_loop_overlay:
	lda	$AAAA			; get one byte of backreference
	jsr	putdst_overlay			; copy to destination

	; Forward decompression -- put backreference bytes forward

	inc	copy_match_loop_overlay+1
	beq	getmatch_adj_hi_overlay
getmatch_done_overlay:

	dex
	bne	copy_match_loop_overlay
	dey
	bne	copy_match_loop_overlay
	jmp	decode_token_overlay

getmatch_adj_hi_overlay:
	inc	copy_match_loop_overlay+2
	jmp	getmatch_done_overlay

getcombinedbits_overlay:
	eor	#$80
	asl
	php

	jsr	getnibble_overlay		; get nibble into bits 0-3 (for offset bits 1-4)
	plp				; merge Z bit as the carry bit (for offset bit 0)
combinedbitz_overlay:
	rol				; nibble -> bits 1-4; carry(!Z bit) -> bit 0 ; carry cleared
decompression_done_overlay:
	rts

getnibble_overlay:
NIBBLES_OVERLAY = *+1
	lda	#$AA
	lsr	NIBCOUNT
	bcc	need_nibbles_overlay
	and	#$0F			; isolate low 4 bits of nibble
	rts

need_nibbles_overlay:
	inc	NIBCOUNT
	jsr	getsrc_overlay		; get 2 nibbles
	sta	NIBBLES_OVERLAY
	lsr
	lsr
	lsr
	lsr
	sec
	rts

	; Forward decompression -- get and put bytes forward


	; Note: must preserve A here


getput_overlay:
	jsr	getsrc_overlay


putdst_overlay:

	pha
output_overlay:
	lda	$9000

putdst_smc_overlay:
LZSA_DST_LO_OVERLAY = *+1
LZSA_DST_HI_OVERLAY = *+2
	sta	$AAAA
	inc	putdst_smc_overlay+1
;	beq	putdst_adj_hi_overlay
	bne	adjust_input_overlay

putdst_adj_hi_overlay:
	inc	putdst_smc_overlay+2

adjust_input_overlay:
	inc	output_overlay+1
	beq	output_adj_hi_overlay
	bne	done_overlay
output_adj_hi_overlay:
	inc	output_overlay+2

done_overlay:
	pla
	rts

getlargesrc_overlay:
	jsr	getsrc_overlay			; grab low 8 bits
	tax				; move to X
					; fall through grab high 8 bits

getsrc_overlay:
getsrc_smc_overlay:
LZSA_SRC_LO_OVERLAY = *+1
LZSA_SRC_HI_OVERLAY = *+2
	lda	$AAAA
	inc	getsrc_overlay+1
	beq	getsrc_adj_hi_overlay
	rts

getsrc_adj_hi_overlay:
	inc	getsrc_overlay+2
	rts


