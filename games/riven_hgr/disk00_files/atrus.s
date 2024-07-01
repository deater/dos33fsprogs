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

	bit	KEYRESET

	;===============================
	;===============================
	; main loop
	;===============================
	;===============================

atrus_loop:
	; clear bottom text

	jsr	clear_bottom

	; show full screen for last image (book)

	lda	SCENE_COUNT
	cmp	#10
	bne	not_at_end
	bit	FULLGR
not_at_end:

	; decompress graphics

	ldx	SCENE_COUNT
	lda	frames_l,X
	sta	ZX0_src
	lda	frames_h,X
	sta	ZX0_src+1

	lda	#$20		; hgr page1
	jsr	full_decomp

	; write dialog

	lda	#0
	sta	DRAW_PAGE

	ldx	SCENE_COUNT

	lda	dialog_l,X
	sta	OUTL
	lda	dialog_h,X
	sta	OUTH

	jsr	move_and_print_list

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


	; could maybe optimize if we can guarantee we don't
	; cross a page boundary
dialog_l:
	.byte <dialog0	; nothing
	.byte <dialog1	; returned
	.byte <dialog2	; history
	.byte <dialog3	; nothing
	.byte <dialog4	; nothing
	.byte <dialog5	; nothing
	.byte <dialog6	; nothing
	.byte <dialog7	; nothing
	.byte <dialog0	; nothing
	.byte <dialog0	; nothing
	.byte <dialog0	; nothing

dialog_h:
	.byte >dialog0	; nothing
	.byte >dialog1	; returned
	.byte >dialog2	; history
	.byte >dialog3	; nothing
	.byte >dialog4	; nothing
	.byte >dialog5	; nothing
	.byte >dialog6	; nothing
	.byte >dialog7	; nothing
	.byte >dialog0	; nothing
	.byte >dialog0	; nothing
	.byte >dialog0	; nothing


; Dialog

; [doesn't see you yet, writing in book]
dialog0:
.byte 0,20," ",0,$ff

dialog1: 	; returned
; [welcoming player back]
.byte 7,20,"Thank God you've returned.",0
.byte 11,22,"I need your help.",0
.byte $FF

dialog2:	; history
.byte 2,20,"There's a great deal of history that",0
.byte 0,21,"you should know, but I'm afraid that...",0
.byte 6,22,"I must continue my writing.",0
.byte $FF

dialog3:
;[hands player his journal]
.byte 3,20,"Here.  Most of what you'll need to",0
.byte 11,21,"know is in there.",0
.byte 10,23,"Keep it well hidden.",0
.byte $FF

dialog4:
;[picks up the book]
.byte 2,20,"For reasons you'll discover, I can't",0
.byte 1,21,"send you to Riven with a way out, but",0
.byte 10,22,"I can give you this.",0
.byte $FF

dialog5:
.byte 1,20,"It appears to be a Linking Book, back",0
.byte 3,21,"here to D'ni, but it's actually a",0
.byte 4,22,"one-man prison.  You'll need it,",0
.byte 6,23,"I'm afraid, to capture Gehn.",0
;[hands player the Prison book]
.byte $FF

dialog6:
.byte 0,20,"Once you've found Catherine, signal me,",0
.byte 3,21,"and I'll come with a Linking Book",0
.byte 11,22,"to bring us back.",0
.byte $FF

dialog7:

;[writes in the Riven book, then closes it",0
; re-opens to the first page, holds it up,",0
; showing glitchy panel]

.byte 3,20,"There's also a chance, if all goes",0
.byte 1,21,"well, that I might be able to get you",0
.byte 1,22,"back to the place that you came from.",0
.byte $FF
