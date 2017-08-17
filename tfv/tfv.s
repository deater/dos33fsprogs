.include "zp.inc"

	;================================
	; Clear screen and setup graphics
	;================================

	jsr	HOME
	jsr	set_gr_page0

	;===================================
	; zero out the zero page that we use
	;===================================

	; memset()

	;===================================
	; Clear top/bottom of page 0
	;===================================

	lda	#$0
	sta	DRAW_PAGE
	jsr	clear_top
	jsr	clear_bottom

	;===================================
	; Clear top/bottom of page 1
	;===================================

	lda	#$4
	sta	DRAW_PAGE
	jsr	clear_top
	jsr	clear_bottom

	;==========================
	; Do Opening
	;==========================

	jsr	opening

	;======================
	; show the title screen
	;======================

	jsr	title_screen

	;======================
	; get name
	;======================

	jsr	enter_name

	;=====================
	; Flying
	;=====================

	jsr	flying_start


	;=====================
	; All finished
	;=====================
exit:

	lda	#$4
	sta	BASH
	lda	#$0
	sta	BASL			; restore to 0x400 (page 0)
					; copy to 0x400 (page 0)

	; call home
	jsr	HOME


	; Return to BASIC?
	rts


;===============================================
; External modules
;===============================================

.include "opener.s"
.include "utils.s"
.include "title.s"
.include "textentry.s"
.include "flying.s"

;===============================================
; Variables
;===============================================

vmwsw_string:
	.asciiz "A VMW SOFTWARE PRODUCTION"

enter_name_string:
	.asciiz	"PLEASE ENTER A NAME:"

name:
	.byte $0,$0,$0,$0,$0,$0,$0,$0


	; waste memory with a lookup table
	; maybe faster than using GBASCALC?

gr_offsets:
	.word	$400,$480,$500,$580,$600,$680,$700,$780
	.word 	$428,$4a8,$528,$5a8,$628,$6a8,$728,$7a8
	.word	$450,$4d0,$550,$5d0,$650,$6d0,$750,$7d0

tb1_sprite:
	.byte $8,$4
	.byte $55,$50,$00,$00,$00,$00,$00,$00
	.byte $55,$55,$55,$00,$00,$00,$00,$00
	.byte $ff,$1f,$4f,$2f,$ff,$22,$20,$00
	.byte $5f,$5f,$5f,$5f,$ff,$f2,$f2,$f2

.include "backgrounds.inc"
