; Apple II Megademo

; by deater (Vince Weaver) <vince@deater.net>

.include "zp.inc"
.include "hardware.inc"


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


	;===================
	; do nothing
	;===================
do_nothing:
	jmp	do_nothing


	.include	"lz4_decode.s"


	;===================
	; graphics
	;===================
c64:
.incbin "c64.img.lz4",11
c64_end:
