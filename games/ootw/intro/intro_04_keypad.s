;==========================
; OOTW -- Intro -- Keypad
;==========================

intro_04_keypad:

;===============================
;===============================
; Keycode
;===============================
;===============================

keypad:

	;=============================
	; Load background to $c00

	lda	#<(intro_scanner_door_lzsa)
        sta     getsrc_smc+1    ; LZSA_SRC_LO
	lda	#>(intro_scanner_door_lzsa)
	sta     getsrc_smc+2    ; LZSA_SRC_HI

	lda	#$c			; load to off-screen $c00
	jsr	decompress_lzsa2_fast

	lda	#<approach_sequence
	sta	INTRO_LOOPL
	lda	#>approach_sequence
	sta	INTRO_LOOPH

	jsr	run_sequence


	;=============================
	; Load background to $c00

	lda	#<(intro_keypad_bg_lzsa)
        sta     getsrc_smc+1    ; LZSA_SRC_LO
	lda	#>(intro_keypad_bg_lzsa)
	sta     getsrc_smc+2    ; LZSA_SRC_HI

	lda	#$c			; load to off-screen $c00
	jsr	decompress_lzsa2_fast

	;==================================
	; draw keypad sequence

	lda	#<keypad_sequence
	sta	INTRO_LOOPL
	lda	#>keypad_sequence
	sta	INTRO_LOOPH

	jsr	run_sequence


	;==================================
	; door opening sequence

	lda	#<(intro_scanner_door_lzsa)
        sta     getsrc_smc+1    ; LZSA_SRC_LO
	lda	#>(intro_scanner_door_lzsa)
	sta     getsrc_smc+2    ; LZSA_SRC_HI

	lda	#$c			; load to off-screen $c00
	jsr	decompress_lzsa2_fast


	lda	#<opening_sequence
	sta	INTRO_LOOPL
	lda	#>opening_sequence
	sta	INTRO_LOOPH

	jmp	run_sequence		; exit for us




;=================================
;=================================
; Intro Segment 04 Data (Keypad)
;=================================
;=================================

.include "graphics/04_keypad/intro_scanner_door.inc"
.include "graphics/04_keypad/intro_approach.inc"
.include "graphics/04_keypad/intro_keypad_bg.inc"
.include "graphics/04_keypad/intro_hands.inc"
.include "graphics/04_keypad/intro_opening.inc"


; Approaching keypad sequence

approach_sequence:
	.byte	20
	.word	approach01_lzsa
	.byte	128+20	;	.word	approach02_lzsa
	.byte	128+20	;	.word	approach03_lzsa
	.byte	128+20	;	.word	approach04_lzsa
	.byte	128+20	;	.word	approach05_lzsa
	.byte	128+20	;	.word	approach06_lzsa
	.byte	128+20	;	.word	approach07_lzsa
	.byte	80
	.word	approach07_lzsa
	.byte	0

; Using keypad sequence

keypad_sequence:
	.byte	9
	.word	hand04_01_lzsa
	.byte	9
	.word	hand04_02_lzsa
	.byte	9
	.word	hand04_03_lzsa
	.byte	9
	.word	hand04_02_lzsa
	.byte	9
	.word	hand05_01_lzsa
	.byte	9
	.word	hand05_02_lzsa
	.byte	9
	.word	hand05_03_lzsa
	.byte	9
	.word	hand05_04_lzsa
	.byte	9
	.word	hand01_01_lzsa
	.byte	9
	.word	hand01_02_lzsa
	.byte	9
	.word	hand01_03_lzsa
	.byte	9
	.word	hand04_02_lzsa
	.byte	9
	.word	hand01_02_lzsa
	.byte	9
	.word	hand01_03_lzsa
	.byte	9
	.word	hand04_02_lzsa
	.byte	9
	.word	hand09_01_lzsa
	.byte	9
	.word	hand09_02_lzsa
	.byte	9
	.word	hand09_03_lzsa
	.byte	9
	.word	hand09_04_lzsa
	.byte	9
	.word	hand09_05_lzsa
	.byte	9
	.word	hand03_01_lzsa
	.byte	9
	.word	hand03_02_lzsa
	.byte	9
	.word	hand03_03_lzsa
	.byte	9
	.word	hand03_04_lzsa
	.byte	9
	.word	hand02_01_lzsa
	.byte	9
	.word	hand02_02_lzsa
	.byte	9
	.word	hand02_03_lzsa
	.byte	9
	.word	hand02_04_lzsa
	.byte	9
	.word	hand02_05_lzsa
	.byte	12
	.word	hand02_05_lzsa
	.byte	0


; Door opening sequence

opening_sequence:
	.byte	15
	.word	opening01_lzsa
	.byte	128+15	;	.word	opening02_lzsa
	.byte	128+15	;	.word	opening03_lzsa
	.byte	128+15	;	.word	opening04_lzsa
	.byte	128+15	;	.word	opening05_lzsa
	.byte	128+15	;	.word	opening06_lzsa
	.byte	128+15	;	.word	opening07_lzsa
	.byte	128+15	;	.word	opening08_lzsa
	.byte	128+15	;	.word	opening09_lzsa
	.byte	128+15	;	.word	opening10_lzsa
	.byte	128+15	;	.word	opening11_lzsa
	.byte	128+15	;	.word	opening12_lzsa
	.byte	15
	.word	nothing_lzsa
	.byte	100
	.word	nothing_lzsa
	.byte	0


