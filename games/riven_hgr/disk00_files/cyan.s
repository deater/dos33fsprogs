; Cyan opener

; by deater (Vince Weaver) <vince@deater.net>

.include "../zp.inc"
.include "../hardware.inc"
.include "../qload.inc"

NUM_SCENES	=	18

	;===================
	; notes for cyan opening


cyan_opener:

	;===================
	; Setup graphics
	;===================

	bit	SET_GR
	bit	HIRES
	bit	FULLGR
	bit	PAGE1

	lda	#0
	sta	SCENE_COUNT

	bit	KEYRESET

	;===============================
	;===============================
	; main loop
	;===============================
	;===============================

cyan_loop:
	; clear bottom text

;	jsr	clear_bottom

	; show full screen for last image (book)

;	lda	SCENE_COUNT
;	cmp	#10
;	bne	not_at_end
;	bit	FULLGR
;not_at_end:

	; decompress graphics

	ldx	SCENE_COUNT
	lda	frames_l,X
	sta	ZX0_src
	lda	frames_h,X
	sta	ZX0_src+1

	lda	#$20		; hgr page1
	jsr	full_decomp


wait_for_key:
	lda	KEYPRESS
	bpl	wait_for_key
	bit	KEYRESET


	inc	SCENE_COUNT
	lda	SCENE_COUNT
	cmp	#NUM_SCENES

	bne	cyan_loop


	rts

frames_l:
	.byte	<cyan01_zx02	; 9s		1
	.byte	<cyan02_zx02	; 10.5s		2
	.byte	<cyan03_zx02	; 12s		3
	.byte	<cyan04_zx02	; 13		4
	.byte	<cyan05_zx02	; 14.2		5
	.byte	<cyan06_zx02	; 15		6
	.byte	<cyan07_zx02	; 16		7
	.byte	<cyan08_zx02	; 17		8
	.byte	<cyan09_zx02	; 18.5		9
	.byte	<cyan10_zx02	; 20.5		10
				; 21.5?		11
	.byte	<cyan11_zx02	; 22.5		12
	.byte	<cyan12_zx02	; 24.5		13
	.byte	<cyan13_zx02	; 26		14
	.byte	<cyan14_zx02	; 28		15
				; 28.5?		16
				; 29?		17
	.byte	<cyan15_zx02	; 29.5		18
	.byte	<cyan16_zx02	; 30		19
	.byte	<cyan17_zx02	; 30.5		20
	.byte	<cyan18_zx02	; 32		21

frames_h:
	.byte	>cyan01_zx02
	.byte	>cyan02_zx02
	.byte	>cyan03_zx02
	.byte	>cyan04_zx02
	.byte	>cyan05_zx02
	.byte	>cyan06_zx02
	.byte	>cyan07_zx02
	.byte	>cyan08_zx02
	.byte	>cyan09_zx02
	.byte	>cyan10_zx02
	.byte	>cyan11_zx02
	.byte	>cyan12_zx02
	.byte	>cyan13_zx02
	.byte	>cyan14_zx02
	.byte	>cyan15_zx02
	.byte	>cyan16_zx02
	.byte	>cyan17_zx02
	.byte	>cyan18_zx02


cyan_graphics:
	.include	"graphics_cyan/cyan_graphics.inc"


