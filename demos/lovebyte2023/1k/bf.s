; Compressed ZX02 wrapper
;
; by deater (Vince Weaver) <vince@deater.net>

.include "zp.inc"
.include "hardware.inc"

ad_start:

	; size in ldsizeh:ldsizel (f1/f0)

;	lda	#<src
;	sta	zx_src_l+1
;	lda	#>src
;	sta	zx_src_h+1

;	lda	#$80

	.include	"zx02_small.s"

;	jsr	zx02_full_decomp

	jmp	$8000


;	.include	"zx02_optim.s"



comp_data:
	.incbin		"BLUE_FLAME.ZX02"

zx0_ini_block:
           .byte $00, $00, <comp_data, >comp_data, <out_addr, >out_addr, $80
