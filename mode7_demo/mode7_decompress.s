; Note: needs some extra work
; Set up initial pointer
; Skip/strip the LZ4 header

.include "zp.inc"

UNPACK_BUFFER	EQU	$2000

start:
	jsr	lz4_decode

	jmp	$2000

;===============================================
; External modules
;===============================================

.include "../asm_routines/lz4_decode.s"

data:
.incbin	"MODE7_DEMO.lz4"

