; zx02 compression test

.include "zp.inc"
.include "hardware.inc"

zx02_saturn_start:


	bit	HIRES
	bit	FULLGR
	bit	SET_GR
	bit	PAGE1


	; size in ldsizeh:ldsizel (f1/f0)

	lda	#<graphic
	sta	zx_src_l+1

	lda	#>graphic
	sta	zx_src_h+1

	lda	#$20			; destination

	jsr	zx02_full_decomp

forever:
	jmp	forever

	.include	"zx02_optim.s"



graphic:
	.incbin "graphics/a2_saturn_warrior.hgr.zx02"
