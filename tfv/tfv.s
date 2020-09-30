.include "tfv_zp.inc"
.include "hardware.inc"

	;================================
	; Clear screen and setup graphics
	;================================

	jsr	HOME
	jsr	set_gr_page0

	lda	#0
	sta	DISP_PAGE	; Forgot to set initially
				; real hardware and AppleWin default
				; to different values

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
.include "tfv_title.s"
.include "tfv_textentry.s"
.include "tfv_flying.s"
.include "tfv_worldmap.s"
.include "tfv_info.s"

.include "gr_fast_clear.s"
.include "../asm_routines/gr_hlin.s"
.include "../asm_routines/pageflip.s"
.include "../asm_routines/gr_setpage.s"
.include "../asm_routines/keypress.s"
.include "../asm_routines/gr_putsprite.s"
.include "../asm_routines/text_print.s"
.include "../asm_routines/memset.s"
.include "../asm_routines/gr_vlin.s"
.include "../asm_routines/gr_copy.s"
;.include "../asm_routines/gr_unrle.s"
.include "decompress_fast_v2.s"
.include "../asm_routines/gr_offsets.s"

;===============================================
; Variables
;===============================================

enter_name_string:
	.asciiz	"PLEASE ENTER A NAME:"

name:
	.byte $0,$0,$0,$0,$0,$0,$0,$0


.include "tfv_sprites.inc"
.include "graphics_map/tfv_backgrounds.inc"
