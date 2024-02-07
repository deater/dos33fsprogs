; blurgh

.include "zp.inc"

	; TODO: inline

        lda     #<compressed_data
        sta     zx_src_l+1
        lda     #>compressed_data
        sta     zx_src_h+1
	lda	#$40
	jsr	zx02_full_decomp

	jmp	$4000

.include "zx02_optim.s"

compressed_data:
.incbin	"PLASMA_COMPRESS.zx02"
