.include "tfv_zp.inc"

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
	; Clear top/bottom of page 0 and 1
	;===================================

	jsr	clear_screens

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
	; World Map
	;=====================

	jsr	world_map

	;=====================
	; Game Over
	;=====================

	jsr	game_over

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

.include "tfv_opener.s"
.include "tfv_utils.s"
.include "tfv_title.s"
.include "tfv_textentry.s"
.include "tfv_info.s"
.include "tfv_flying.s"
.include "tfv_worldmap.s"

;===============================================
; Variables
;===============================================

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

.include "tfv_sprites.inc"
.include "tfv_backgrounds.inc"
