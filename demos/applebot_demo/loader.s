; Loader for botdemo

NIBCOUNT = $00

.include "zp.inc"
.include "hardware.inc"

loader_start:

	; decompress

	; we do this as it's faster
	; but also we can over-write DOS with impunity

	; we have to load upat $6000 to preserve both
	; lores and hires graphics areas

	lda	#<botdemo_lzsa
	sta	LZSA_SRC_LO
	lda	#>botdemo_lzsa
	sta	LZSA_SRC_HI
	lda	#$60			; load to page $6000
	jsr	decompress_lzsa2_fast
	jmp	$6000


.include "decompress_fast_v2.s"

botdemo_lzsa:
.incbin "BOTDEMO.LZ4"
