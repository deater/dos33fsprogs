; Credits

; o/~ It's the credits, yeah, that's the best part
;     When the movie ends and the reading starts o/~

;
; by deater (Vince Weaver) <vince@deater.net>

.include "../zp.inc"
.include "../hardware.inc"
.include "../qload2.inc"
.include "../music2.inc"

mod7_table	= $1c00
div7_table	= $1d00
hposn_low	= $1e00
hposn_high	= $1f00

intro_start:
	;=====================
	; initializations
	;=====================

	bit	KEYRESET		; clear just in case

	;===================
	; Load graphics
	;===================
load_loop:

	bit	SET_GR
	bit	HIRES
	bit	FULLGR
	bit	PAGE1

	lda	#0
	jsr	hgr_page1_clearscreen

;	jsr	hgr_make_tables

	;=====================
	;=====================
	; do thumbnail credits
	;=====================
	;=====================

	jsr	thumbnail_credits

	;=======================
	;=======================
	; scroll job
	;=======================
	;=======================

	ldx	#8
	stx	FRAME

	; print message

	lda	#192			; top of $4000 PAGE2
	sta	CV

	lda	#<final_credits
	sta	BACKUP_OUTL
	lda	#>final_credits
	sta	BACKUP_OUTH

do_scroll:

	inc	FRAME

	lda	FRAME
	cmp	#9
	bne	no_update_message

;	and	#$7
;	bne	no_update_message

	lda	#0
	sta	FRAME




	; clear lines on Page2

	; we cheat and setup 192-200 to map to top of page2

	ldx	#200
cl_outer_loop:
	lda	hposn_low,X
	sta	INL
	lda	hposn_high,X
	sta	INH
	ldy	#39
	lda	#0
cl_inner_loop:
	sta	(INL),Y
	dey
	bpl	cl_inner_loop
	dex
	cpx	#191
	bne	cl_outer_loop

urgh:
	lda	BACKUP_OUTL
	sta	OUTL
	lda	BACKUP_OUTH
	sta	OUTH

	jsr	draw_condensed_1x8_again

			; point to location after
	sec		; always add 1
;	inx
	txa
	adc	OUTL
	sta	BACKUP_OUTL
	lda	#0
	adc	OUTH
	sta	BACKUP_OUTH


no_update_message:

	jsr	hgr_vertical_scroll

	jmp	do_scroll

.align $100
	.include	"../wait_keypress.s"
	.include	"../zx02_optim.s"
;	.include	"../hgr_table.s"
	.include	"../hgr_clear_screen.s"
	.include	"vertical_scroll.s"

	.include	"font_4am_1x8.s"
	.include	"fonts/font_4am_1x8_data.s"

	.include	"font_4am_1x10.s"
	.include	"fonts/font_4am_1x10_data.s"

	.include	"thumbnail_credits.s"

	.include	"../irq_wait.s"


summary1_data:
	.incbin "graphics/summary1_invert.hgr.zx02"
summary2_data:
	.incbin "graphics/summary2_invert.hgr.zx02"


final_credits:
	.byte 12,"Apple ][ Reality",0
	.byte 20," ",0
	.byte 11,"by Deater / Desire",0
	.byte 20," ",0
	.byte 1 ,"This demo was shown at Demosplash 2023",0
	.byte 8,"held in Pittsburgh, PA,",0
	.byte 12,"in November 2023.",0
	.byte 20," ",0
	.byte 13,"Apologies to:",0
	.byte 14,"Future Crew",0
	.byte 20," ",0

	.byte 15,"Code used:",0
	.byte  9,"French Touch -- Plasma",0
	.byte  7,"DMSC -- ZX02 decompression",0
	.byte  7,"qkumba -- fast disk loader",0
	.byte 15,"4am - font",0
	.byte  2,"K. Kennaway -- iipix image converter",0
	.byte  3,"O. Schmidt -- sampled audio player",0
	.byte 11,"Hellmood - circles",0
	.byte 20," ",0

	.byte 15,"Greets to:",0
	.byte 14,"French Touch",0
	.byte 18,"4am",0
	.byte 17,"qkumba",0
	.byte 17,"Grouik",0
	.byte 14,"Fenarinarsa",0
	.byte 14,"Ninjaforce",0
	.byte 15,"T. Greene",0
	.byte 15,"K. Savetz",0
	.byte 15,"Boo Atari",0
	.byte 15,"textfiles",0
	.byte 13,"Stealth Susie",0
	.byte 17,"wiz21b",0
	.byte 17,"Trixter",0
	.byte 18,"LGR",0
	.byte 16,"Hellmood",0
	.byte 17,"Foone",0
	.byte 20," ",0
	.byte 14,"Talbot 0101",0
	.byte 12,"Utopia BBS (410)",0
	.byte 10,"Weave's World Talker",0
	.byte 8,"Tell 'em Deater sent ya",0
	; end
	.byte 20," ",0
	.byte 20," ",0
	.byte 20," ",0
	.byte 20," ",0
	.byte 20," ",0
	.byte 20," ",0
	.byte 20," ",0
	.byte 20," ",0
	.byte 20," ",0
	.byte 20," ",0
	.byte 20," ",0
	.byte 12,"Apple II Forever",0
	.byte 20," ",0
	.byte 20," ",0
	.byte 20," ",0
	.byte 20," ",0
	.byte 20," ",0
	.byte 20," ",0
	.byte 20," ",0
	.byte 20," ",0
	.byte 20," ",0
	.byte 20," ",0
	.byte 20," ",0
	.byte 20," ",0
	.byte $FF
