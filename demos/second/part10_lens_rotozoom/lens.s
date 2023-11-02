; Weird head lens/rotozoom

; by deater (Vince Weaver) <vince@deater.net>

.include "../zp.inc"
.include "../hardware.inc"
.include "../qload.inc"
.include "../music.inc"

lens_start:
	;=====================
	; initializations
	;=====================

        ; debug
        ; force right location in music

        lda     #34
        sta     current_pattern_smc+1
        jsr     pt3_set_pattern

	;================================
	; Clear screen and setup graphics
	;================================

	bit	SET_GR
	bit	FULLGR
	bit	PAGE1			; set page 1
	bit	LORES			; Lo-res graphics

	lda	#0
	sta	DISP_PAGE
	lda	#4
	sta	DRAW_PAGE

	;===================================
	; Clear top/bottom of page 0 and 1
	;===================================

	jsr	clear_screens

	;===================================
	; init the multiply tables
	;===================================

	jsr	init_multiply_tables

	;======================
	; show the title screen
	;======================

	; Title Screen

title_screen:

load_background:

	;===========================
	; Clear both bottoms

;	jsr     clear_bottoms

	;=============================
	; Load title

	lda     #<lens_zx02
        sta     zx_src_l+1
	lda     #>lens_zx02
	sta	zx_src_h+1

	lda	#$40

        jsr     zx02_full_decomp

	;=================================
	; copy to both pages

	jsr	gr_copy_to_current
	jsr	page_flip
	jsr	gr_copy_to_current

	; wait
	; TODO: draw lens

	lda	#15
	jsr	wait_seconds


	;=================================
	;=================================
	; do rotozoom
	;=================================
	;=================================

	jsr	do_rotozoom

lens_end:
	rts


;===============================================
; External modules
;===============================================

.include "roto.s"
.include "rotozoom.s"

.include "../gr_pageflip.s"
;.include "../gr_fast_clear.s"
.include "../gr_copy.s"

.include "../gr_offsets.s"
.include "../c00_scrn_offsets.s"

.include "../multiply_fast.s"

	.include	"../wait_keypress.s"
	.include	"../zx02_optim.s"
	.include	"../irq_wait.s"

;===============================================
; Data
;===============================================

lens_zx02:
	.incbin "graphics/lenspic.gr.zx02"

