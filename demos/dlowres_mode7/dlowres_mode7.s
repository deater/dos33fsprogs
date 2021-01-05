.include "dlowres_zp.inc"

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

.include "dlowres_utils.s"
.include "dlowres_flying.s"

.include "dlowres_sprites.inc"

;===============================================
; Variables
;===============================================

	; waste memory with a lookup table
	; maybe faster than using GBASCALC?

gr_offsets:
	.word	$400,$480,$500,$580,$600,$680,$700,$780
	.word 	$428,$4a8,$528,$5a8,$628,$6a8,$728,$7a8
	.word	$450,$4d0,$550,$5d0,$650,$6d0,$750,$7d0


