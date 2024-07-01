; Opening with Atrus

; by deater (Vince Weaver) <vince@deater.net>

.include "../zp.inc"
.include "../hardware.inc"
.include "../qload.inc"

NUM_SCENES	=	11

	;===================
	; notes for atrus opening


atrus_start:

	;===================
	; Setup graphics
	;===================

	bit	SET_GR
	bit	HIRES
	bit	TEXTGR
	bit	PAGE1

	lda	#0
	sta	SCENE_COUNT

	lda	#4
	sta	DRAW_PAGE

	bit	KEYRESET

	;===============================
	;===============================
	; main loop
	;===============================
	;===============================

atrus_loop:

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

	bne	atrus_loop


	rts

frames_l:
	.byte	<atrus1_zx02
	.byte	<atrus2_zx02
	.byte	<atrus3_zx02
	.byte	<atrus4_zx02
	.byte	<atrus5_zx02
	.byte	<atrus6_zx02
	.byte	<atrus7_zx02
	.byte	<atrus8_zx02
	.byte	<atrus9_zx02
	.byte	<atrus10_zx02
	.byte	<atrus11_zx02


frames_h:
	.byte	>atrus1_zx02
	.byte	>atrus2_zx02
	.byte	>atrus3_zx02
	.byte	>atrus4_zx02
	.byte	>atrus5_zx02
	.byte	>atrus6_zx02
	.byte	>atrus7_zx02
	.byte	>atrus8_zx02
	.byte	>atrus9_zx02
	.byte	>atrus10_zx02
	.byte	>atrus11_zx02


atrus_graphics:
	.include	"graphics_atrus/atrus_graphics.inc"


; [welcoming player back]
.byte "Thank God you've returned.",0
.byte "I need your help.",0

.byte "There's a great deal of history that",0
.byte "you should know, but I'm afraid that...",0
.byte "I must continue my writing. Here.",0

;[hands player his journal]
.byte "Most of what you'll need to know is in",0
.byte "there.",0
.byte "Keep it well hidden.",0

;[picks up the book]
.byte "For reasons you'll discover, I can't",0
.byte "send you to Riven with a way out, but",0
.byte "I can give you this.",0

.byte "It appears to be a Linking Book, back",0
.byte "here to D'ni, but it's actually a",0
.byte "one-man prison. You'll need it,",0
.byte "I'm afraid, to capture Gehn.",0
;[hands player the Prison book]

.byte "Once you've found Catherine, signal me,",0
.byte "and I'll come with a Linking Book",0
.byte "to bring us back.",0

;[writes in the Riven book, then closes it",0
; re-opens to the first page, holds it up,",0
; showing glitchy panel]

.byte "There's also a chance, if all goes",0
.byte "well, that I might be able to get you",0
.byte "back to the place that you came from.",0

