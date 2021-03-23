;==================================
; OOTW -- Intro -- Walking to door
;==================================

;===============================
;===============================
; Walk into door
;===============================
;===============================

intro_02_outer_door:

	;==================================
	; draw feet going into door

	lda	#<feet_sequence
	sta	INTRO_LOOPL
	lda	#>feet_sequence
	sta	INTRO_LOOPH

	jmp	run_sequence	; returns for us



;=================================
;=================================
; Intro Segment 02 Data (Door)
;=================================
;=================================

; background graphics

.include "graphics/02_outer_door/outer_door.inc"
.include "graphics/02_outer_door/feet.inc"


;=============================
; Feet going in door sequence

feet_sequence:
	.byte	255
	.word	outer_door_lzsa
	.byte	1
	.word	outer_door_lzsa
	.byte	128+100	;	.word	feet01_lzsa
	.byte	128+10	;	.word	feet02_lzsa
	.byte	128+10	;	.word	feet03_lzsa
	.byte	128+10	;	.word	feet04_lzsa
	.byte	128+10	;	.word	feet05_lzsa
	.byte	128+10	;	.word	feet06_lzsa
	.byte	128+10	;	.word	feet07_lzsa
	.byte	128+10	;	.word	feet08_lzsa
	.byte	128+30	;	.word	feet09_lzsa
	.byte	128+10	;	.word	feet10_lzsa
	.byte	128+10	;	.word	feet11_lzsa
	.byte	128+10	;	.word	feet12_lzsa
	.byte	128+10	;	.word	feet13_lzsa
	.byte	128+10	;	.word	feet14_lzsa
	.byte	128+10	;	.word	feet15_lzsa
	.byte	10
	.word	nothing_lzsa
	.byte	100
	.word	nothing_lzsa
	.byte	0

