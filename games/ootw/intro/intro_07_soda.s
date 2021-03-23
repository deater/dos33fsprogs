;===================================
; OOTW -- Intro -- Refreshing Pause
;===================================

intro_07_soda:

;===============================
;===============================
; Opening Soda
;===============================
;===============================
soda:
	lda	#<(soda_bg_lzsa)
        sta     getsrc_smc+1    ; LZSA_SRC_LO
	lda	#>(soda_bg_lzsa)
	sta     getsrc_smc+2    ; LZSA_SRC_HI

	lda	#$c			; load to off-screen $c00
	jsr	decompress_lzsa2_fast

	bit	FULLGR

	lda	#<soda_sequence
	sta	INTRO_LOOPL
	lda	#>soda_sequence
	sta	INTRO_LOOPH

	jsr	run_sequence


;	ldx	#30
;	jsr	long_wait

;open_soda_loop:
;	lda	KEYPRESS
;	bpl	open_soda_loop
;	bit	KEYRESET

;===============================
;===============================
; Drinking Soda
;===============================
;===============================

	lda	#<(drinking02_lzsa)
        sta     getsrc_smc+1    ; LZSA_SRC_LO
	lda	#>(drinking02_lzsa)
	sta     getsrc_smc+2    ; LZSA_SRC_HI

	lda	#$c			; load to off-screen $c00
	jsr	decompress_lzsa2_fast

	lda	#<drinking_sequence
	sta	INTRO_LOOPL
	lda	#>drinking_sequence
	sta	INTRO_LOOPH

	jsr	run_sequence

	ldx	#200
	jsr	long_wait

;drinking_loop:
;	lda	KEYPRESS
;	bpl	drinking_loop
;	bit	KEYRESET


	rts



;=================================
;=================================
; Intro Segment 07 Data (Soda)
;=================================
;=================================

.include "graphics/07_soda/intro_open_soda.inc"
.include "graphics/07_soda/intro_drinking.inc"

; Soda sequence

soda_sequence:
	.byte	1
	.word	soda01_lzsa
	.byte	128+30	;	.word	soda02_lzsa
	.byte	128+15	;	.word	soda03_lzsa
	.byte	128+15	;	.word	soda04_lzsa
	.byte	128+15	;	.word	soda05_lzsa
	.byte	128+15	;	.word	soda06_lzsa
	.byte	128+15	;	.word	soda07_lzsa
	.byte	128+15	;	.word	soda08_lzsa
	.byte	128+15	;	.word	soda09_lzsa
	.byte	20
	.word	soda09_lzsa
	.byte	0


drinking_sequence:
	.byte 30
	.word drinking02_lzsa
	.byte 128+30	;	.word drinking03_lzsa
	.byte 128+30	;	.word drinking04_lzsa
	.byte 128+30	;	.word drinking05_lzsa
	.byte 0
