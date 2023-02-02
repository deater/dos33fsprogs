; Compressed ZX02 wrapper
;
; by deater (Vince Weaver) <vince@deater.net>

.include "zp.inc"
.include "hardware.inc"

ad_start:

	; size in ldsizeh:ldsizel (f1/f0)

	lda	#<src
	sta	zx_src_l+1
	lda	#>src
	sta	zx_src_h+1

	lda	#$80

	jsr	zx02_full_decomp

	jmp	$8000


	.include	"zx02_optim.s"

src:
	.incbin		"BLUE_FLAME.ZX02"
