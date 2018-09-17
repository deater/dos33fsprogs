; C64 Opener
; all good demos start with the C64 boot screen, right?

; Apple II has a lot of trouble making clear text with bluish background
; would be a lot clearer if I used black and white

	;===================
	; set graphics mode
	;===================
	jsr	HOME

	bit	PAGE0                   ; first graphics page
	bit	FULLGR			; full screen graphics
	bit	HIRES			; hires mode !!!
	bit	SET_GR			; graphics mode

	lda	#<c64
	sta	LZ4_SRC
	lda	#>c64
	sta	LZ4_SRC+1

	lda	#<c64_end
	sta	LZ4_END
	lda	#>c64_end
	sta	LZ4_END+1


	lda	#<$2000
	sta	LZ4_DST
	lda	#>$2000
	sta	LZ4_DST+1

	jsr	lz4_decode


	rts

	;===================
	; graphics
	;===================
c64:
.incbin "c64.img.lz4",11
c64_end:
