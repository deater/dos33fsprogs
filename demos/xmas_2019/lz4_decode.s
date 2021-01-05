; LZ4 data decompressor for Apple II


; NOTE: this version is optimized for loading LORES graphics
;	on even page boundaries (usually $C00)
; Don't use it for generic purposes!

; Code originally by Peter Ferrie (qkumba) (peter.ferrie@gmail.com)
; "LZ4 unpacker in 143 bytes (6502 version) (2013)"
;    http://pferrie.host22.com/misc/appleii.htm

; For LZ4 reference see
; https://github.com/lz4/lz4/wiki/lz4_Frame_format.md


; We expect src in LZ4_SRC
; Incoming Accumulator is page to write to
; Size is in first 2 bytes pointed to by LZ4_SRC
; LZ4 data should have 11 byte header stripped off beginning
;	and 8 byte checksum stripped off the end

;LZ4_SRC	EQU $00	; 25:10   (size=7c)
;LZ4_DST	EQU $02 ; 0c:00
;LZ4_END	EQU $04 ; 25:8c
;COUNT		EQU $06
;DELTA		EQU $08


	;======================
	; LZ4 decode
	;======================
	; input buffer in LZ4_SRC
        ; A is destination page
	; size in first two bytes
lz4_decode:
	sta	LZ4_DST+1	; set to page we want
	lda	#0
	sta	LZ4_DST

	ldy	#0

	; calculate LZ4_END based on start and total size in
	; first two bytes
;	clc
;	lda	(LZ4_SRC),Y	; size (low)
;	adc	LZ4_SRC
;	sta	LZ4_END
;	iny
;	lda	(LZ4_SRC),Y	; size (high)
;	adc	LZ4_SRC+1
;	sta	LZ4_END+1

	; skip past size
;	clc
;	lda	LZ4_SRC
;	adc	#2
;	sta	LZ4_SRC
;	lda	LZ4_SRC+1
;	adc	#0
;	sta	LZ4_SRC+1


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
