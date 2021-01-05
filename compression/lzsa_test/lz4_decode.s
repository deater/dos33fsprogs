; LZ4 data decompressor for Apple II

; Code by Peter Ferrie (qkumba) (peter.ferrie@gmail.com)
; "LZ4 unpacker in 143 bytes (6502 version) (2013)"
;    http://pferrie.host22.com/misc/appleii.htm
; This is that code, but with comments and labels added for clarity.
; I also found a bug when decoding with runs of multiples of 256
;   which has since been fixed upstream.

; For LZ4 reference see
; https://github.com/lz4/lz4/wiki/lz4_Frame_format.md

; LZ4 summary:
;
; HEADER:
;       Should: check for magic number 04 22 4d 18
;	FLG: 64 in our case (01=version, block.index=1, block.checksum=0
;		size=0, checksum=1, reserved
;	MAX Blocksize: 40 (64kB)
;	HEADER CHECKSUM: a7
;	BLOCK HEADER: 4 bytes (le)  length If highest bit set, uncompressed!
;			data (see below), followed by checksum?
; BLOCKS:
;	Token byte.  High 4-bits literal length, low 4-bits copy length
;	+ If literal length==15, then following byte gets added to length
;	  If that byte was 255, then keep adding bytes until not 255
;       + The literal bytes follow.  There may be zero of them
;	+ Next is block copy info.  little-endian 2-byte offset to
;	  be subtracted from current read position indicating source
;	+ The low 4-bits of the token are the copy length, which needs
;         4 added to it.  As with the literal length, if it is 15 then
;	  you read a byte and add (and if that byte is 255, keep adding)

; At end you have 4 byte end-of-block marker (all zeros?) then
;                 4 bytes of checksum (if marked in flags)
;                 our code does that, so be sure to set end -8


;LZ4_SRC	EQU $00
;LZ4_DST	EQU $02
;LZ4_END	EQU $04
;COUNT		EQU $06
;DELTA		EQU $08


	;======================
	; LZ4 decode
	;======================
	; input buffer in LZ4_SRC
	; end of input in LZ4_END
        ; output buffer in LZ4_DST


lz4_decode:


unpmain:
	ldy	#0			; used to index, always zero

parsetoken:
	jsr	getsrc			; get next token
	pha				; save for later (need bottom 4 bits)

	lsr				; number of literals in top 4 bits
	lsr				; so shift into place
	lsr
	lsr
	beq	copymatches		; if zero, then no literals
					; jump ahead and copy

	jsr	buildcount		; add up all the literal sizes
					; result is in ram[count+1]-1:A
	tax				; now in ram[count+1]-1:X
	jsr	docopy			; copy the literals

	lda	LZ4_SRC			; 16-bit compare
	cmp	LZ4_END			; to see if we have reached the end
	lda	LZ4_SRC+1
	sbc	LZ4_END+1
	bcs	done

copymatches:
	jsr	getsrc			; get 16-bit delta value
	sta	DELTA
	jsr	getsrc
	sta	DELTA+1

	pla				; restore token
	and	#$0f			; get bottom 4 bits
					; match count.  0 means 4
					; 15 means 19+, must be calculated

	jsr	buildcount		; add up count bits, in ram[count+1]-:A

	clc
	adc	#4			; adjust count by 4 (minmatch)

	tax				; now in ramp[count+1]-1:X

	beq	copy_no_adjust		; BUGFIX, don't increment if
					;	exactly a multiple of 0x100
	bcc	copy_no_adjust

	inc	COUNT+1			; increment if we overflowed
copy_no_adjust:

	lda	LZ4_SRC+1			; save src on stack
	pha
	lda	LZ4_SRC
	pha

	sec				; subtract delta
	lda	LZ4_DST			; from destination, make new src
	sbc	DELTA
	sta	LZ4_SRC
	lda	LZ4_DST+1
	sbc	DELTA+1
	sta	LZ4_SRC+1

	jsr	docopy			; do the copy

	pla				; restore the src
	sta	LZ4_SRC
	pla
	sta	LZ4_SRC+1

	jmp	parsetoken		; back to parsing tokens

done:
	pla
	rts

	;=========
	; getsrc
	;=========
	; gets byte from src into A, increments pointer
getsrc:
	lda	(LZ4_SRC), Y		; get a byte from src
	inc	LZ4_SRC			; increment pointer
	bne	done_getsrc		; update 16-bit pointer
	inc	LZ4_SRC+1			; on 8-bit overflow
done_getsrc:
	rts

	;============
	; buildcount
	;============
buildcount:
	ldx	#1			; high count starts at 1
	stx	COUNT+1			; (loops at zero?)
	cmp	#$0f			; if LITERAL_COUNT < 15, we are done
	bne	done_buildcount
buildcount_loop:
	sta	COUNT			; save LITERAL_COUNT (15)
	jsr	getsrc			; get the next byte
	tax				; put in X
	clc
	adc	COUNT			; add new byte to old value
	bcc	bc_8bit_oflow		; if overflow, increment high byte
	inc	COUNT+1
bc_8bit_oflow:
	inx				; check if read value was 255
	beq	buildcount_loop		; if it was, keep looping and adding
done_buildcount:
	rts

	;============
	; getput
	;============
	; gets a byte, then puts the byte
getput:
	jsr	getsrc
	; fallthrough to putdst

	;=============
	; putdst
	;=============
	; store A into destination
putdst:
	sta 	(LZ4_DST), Y		; store A into destination
	inc	LZ4_DST			; increment 16-bit pointer
	bne	putdst_end		; if overflow, increment top byte
	inc	LZ4_DST+1
putdst_end:
	rts

	;=============================
	; docopy
	;=============================
	; copies ram[count+1]-1:X bytes
	; from src to dst
docopy:

docopy_loop:
	jsr	getput			; get/put byte
	dex				; decrement count
	bne	docopy_loop		; if not zero, loop
	dec	COUNT+1			; if zero, decrement high byte
	bne	docopy_loop		; if not zero, loop

	rts
