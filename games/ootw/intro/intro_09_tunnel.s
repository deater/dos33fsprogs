;=========================================
; OOTW -- Intro -- Down in the Accelerator
;=========================================

intro_09_tunnel:

;===============================
;===============================
; Tunnel 1
;===============================
;===============================

tunnel1:

	lda	#<(tunnel1_lzsa)
        sta     getsrc_smc+1    ; LZSA_SRC_LO
	lda	#>(tunnel1_lzsa)
	sta     getsrc_smc+2    ; LZSA_SRC_HI

	lda	#$c			; load to off-screen $c00
	jsr	decompress_lzsa2_fast

	jsr	gr_copy_to_current
	jsr	page_flip

	lda	#<tunnel1_sequence
	sta	INTRO_LOOPL
	lda	#>tunnel1_sequence
	sta	INTRO_LOOPH

	jsr	run_sequence


;tunnel1_loop:
;	lda	KEYPRESS
;	bpl	tunnel1_loop
;	bit	KEYRESET



;===============================
;===============================
; Tunnel 2
;===============================
;===============================


	;=============================
	; Load background to $c00

	lda	#<(tunnel2_lzsa)
        sta     getsrc_smc+1    ; LZSA_SRC_LO
	lda	#>(tunnel2_lzsa)
	sta     getsrc_smc+2    ; LZSA_SRC_HI

	lda	#$c			; load to off-screen $c00
	jsr	decompress_lzsa2_fast

	jsr	gr_copy_to_current
	jsr	page_flip

	lda	#<tunnel2_sequence
	sta	INTRO_LOOPL
	lda	#>tunnel2_sequence
	sta	INTRO_LOOPH

	jsr	run_sequence


;tunnel2_loop:
;	lda	KEYPRESS
;	bpl	tunnel2_loop
;	bit	KEYRESET

	rts



;=================================
;=================================
; Intro Segment 09 Data (Tunnel)
;=================================
;=================================



; background graphics

.include "graphics/09_tunnel/intro_tunnel1.inc"
.include "graphics/09_tunnel/intro_tunnel2.inc"
;.include "graphics/08_lightning/nothing.inc"
;.include "graphics/08_lightning/whiteblack.inc"

	;=======================
	; Tunnel1 Sequence
	;=======================
tunnel1_sequence:
	.byte 10
	.word nothing_lzsa
	.byte 50
	; red blob
	.word tunnel1_01_lzsa
	.byte 128+2	;	.word tunnel1_02_lzsa
	.byte 128+2	;	.word tunnel1_03_lzsa
	.byte 128+2	;	.word tunnel1_04_lzsa
	.byte 128+2	;	.word tunnel1_05_lzsa
	.byte 2

	; lightning blob
	.word nothing_lzsa
	.byte 50
	.word tunnel1_06_lzsa
	.byte 128+2	;	.word tunnel1_07_lzsa
	.byte 2
	.word white_lzsa
	.byte 2
	.word tunnel1_08_lzsa
	.byte 128+2	;	.word tunnel1_09_lzsa
	.byte 128+2	;	.word tunnel1_10_lzsa
	.byte 128+2	;	.word tunnel1_11_lzsa
	.byte 128+2	;	.word tunnel1_12_lzsa
	.byte 128+2	;	.word tunnel1_13_lzsa
	.byte 128+2	;	.word tunnel1_14_lzsa
	.byte 128+2	;	.word tunnel1_15_lzsa
	.byte 128+2	;	.word tunnel1_16_lzsa
	.byte 128+2	;	.word tunnel1_17_lzsa
	.byte 128+2	;	.word tunnel1_18_lzsa
	.byte 128+2	;	.word tunnel1_19_lzsa
	.byte 2
	.word nothing_lzsa
	.byte 0


	;=======================
	; Tunnel2 Sequence
	;=======================
tunnel2_sequence:
	.byte 10
	.word nothing_lzsa
	.byte 50
	; red blob
	.word tunnel2_01_lzsa
	.byte 128+2	;	.word tunnel2_02_lzsa
	.byte 128+2	;	.word tunnel2_03_lzsa
	.byte 128+2	;	.word tunnel2_04_lzsa
	.byte 128+2	;	.word tunnel2_05_lzsa
	.byte 128+2	;	.word tunnel2_06_lzsa
	.byte 128+2	;	.word tunnel2_07_lzsa
	.byte 128+2	;	.word tunnel2_08_lzsa
	.byte 128+2	;	.word tunnel2_09_lzsa
	.byte 2
	.word nothing_lzsa
	.byte 50

	; lightning blob
	.word tunnel2_10_lzsa
	.byte 128+2	;	.word tunnel2_11_lzsa
	.byte 128+2	;	.word tunnel2_12_lzsa
	.byte 128+2	;	.word tunnel2_13_lzsa
	.byte 128+2	;	.word tunnel2_14_lzsa
	.byte 128+2	;	.word tunnel2_15_lzsa
	.byte 128+2	;	.word tunnel2_16_lzsa
	.byte 128+2	;	.word tunnel2_17_lzsa
	.byte 2
	.word nothing_lzsa
	.byte 0

