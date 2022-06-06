.include "zp.inc"
.include "hardware.inc"

lzsa_test:

	bit	SET_GR
	bit	PAGE0
	bit	HIRES
	bit	FULLGR

;	lda     #<level5_lzsa
;	sta     getsrc_smc+1	; LZSA_SRC_LO
;	lda     #>level5_lzsa
;	sta     getsrc_smc+2	; LZSA_SRC_HI
;
;	lda	#$20

	jsr	full_decomp

;	jsr	decompress_lzsa2_fast

end:
	jmp	end


out_addr	=	$2000

.include "zx02_optim.s"

comp_data:
level5_zx02:
.incbin "level5.zx02"
