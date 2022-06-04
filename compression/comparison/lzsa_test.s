.include "zp.inc"
.include "hardware.inc"

lzsa_test:

	bit	SET_GR
	bit	PAGE0
	bit	HIRES
	bit	FULLGR

	lda     #<level5_lzsa
	sta     getsrc_smc+1	; LZSA_SRC_LO
	lda     #>level5_lzsa
	sta     getsrc_smc+2	; LZSA_SRC_HI

	lda	#$20

	jsr	decompress_lzsa2_fast

end:
	jmp	end


.include "graphics_level5.inc"

.include "decompress_fast_v2.s"
