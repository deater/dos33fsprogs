; Credits

; o/~ It's the credits, yeah, that's the best part
;     When the movie ends and the reading starts o/~

;
; by deater (Vince Weaver) <vince@deater.net>

.include "../zp.inc"
.include "../hardware.inc"
.include "../qload.inc"
.include "../music.inc"

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
	jsr	hgr_page1_clearscreen	; unrolled
	jsr	hgr_page2_clearscreen	; unrolled

;	jsr	hgr_make_tables


	;=======================
	;=======================
	; scroll job
	;=======================
	;=======================
	; so the way this works is that it only displays PAGE1
	;	and it prints new credits just off the bottom of it which
	;	is essentially the top of PAGE2
	; then it scrolls things up

	ldx	#0
	stx	FRAME

	; print message


	lda	#<final_credits		; store location of string
	sta	BACKUP_OUTL
	lda	#>final_credits
	sta	BACKUP_OUTH

scroll_loop:


	;============================================
	; clear lines to get rid of stray old chars
	;============================================
	; just erase line 158 and 159

	;	$39D0, $3DD0

	clc
	lda	#$39
	adc	DRAW_PAGE
	sta	cl_smc+2

	clc
	lda	#$3d
	adc	DRAW_PAGE
	sta	cl_smc+5

	ldy	#39
	lda	#$00
cl_inner_loop:

cl_smc:
	sta	$39D0,Y
	sta	$3DD0,Y
	dey
	bpl	cl_inner_loop

	;=============================
	;=============================
	; draw text
	;=============================
	;=============================

	;=======================
	; draw one line at 158
	;=======================

	lda	#158		;
	sta	CV
	lda	BACKUP_OUTL	; get saved text location
	ldy	BACKUP_OUTH	; and load direct in A/Y
	ldx	FRAME		; load which line of text to draw
	jsr	draw_condensed_1x8

	; X points to last char printed?

	;=========================================
	; check if increment to next line of text
	;=========================================
	; flip over if frame==9

	lda	FRAME
	cmp	#9
	bcc	skip_next_text

			; point to location after
	sec		; always add 1
	txa		; afterward X points to end of string
	adc	OUTL		; (OUTL is already+1)
	sta	BACKUP_OUTL
	lda	#$0
	adc	OUTH
	sta	BACKUP_OUTH
	lda	#$ff
	sta	FRAME
skip_next_text:

	;===========================
	; draw second line at 159
	;===========================

	lda	#159		;
	sta	CV
	lda	BACKUP_OUTL	; get saved text location
	ldy	BACKUP_OUTH	; and load direct in A/Y
	ldx	FRAME
	inx
	jsr	draw_condensed_1x8

	;=================================
	; increment the frame
	;=================================

	inc	FRAME			; next frame

;	lda	FRAME			; wrap frame after 10 lines
;	cmp	#10
;	bne	no_update_message

;	lda	#0
;	sta	FRAME



	;=============================
	; do the scroll
	;=============================

	jsr	hgr_vertical_scroll

	jsr	hgr_page_flip

	jmp	scroll_loop

.align $100
	.include	"../wait_keypress.s"
;	.include	"../zx02_optim.s"
	.include	"../hgr_clear_screen.s"
	.include	"vertical_scroll.s"

	.include	"font_4am_1x8_oneline.s"
	.include	"fonts/font_4am_1x8_data.s"

;	.include	"font_4am_1x10.s"
;	.include	"fonts/font_4am_1x10_data.s"

	.include	"../irq_wait.s"
	.include	"../hgr_page_flip.s"


final_credits:
	.byte 16,"DRI\/EN",0
	.byte 20," ",0
	.byte 15,"by Desire",0
	.byte 20," ",0
	.byte 7,"This demo was first shown",0
	.byte 10,"at Demosplash 2024",0
	.byte 8,"held in Pittsburgh, PA,",0
	.byte 12,"in November 2024.",0
	.byte 20," ",0
	.byte 13,"Apologies to:",0
	.byte 18,"Cyan",0


; TODO: Cyan disclaimer

;	.byte 14,"Future Crew",0
	.byte 20," ",0
	.byte 15,"Code used:",0
; Deater
	.byte  9,"French Touch -- Plasma",0
	.byte  7,"DMSC -- ZX02 decompression",0
	.byte  7,"qkumba -- fast disk loader",0
	.byte 15,"4am - font",0
	.byte  2,"K. Kennaway -- iipix image converter",0
;	.byte  3,"O. Schmidt -- sampled audio player",0
;	.byte  6,"Hellmood -- circles/sierzoom",0
	.byte 20," ",0

; Graphics

; Music

;	.byte 11,"Special Thanks to:",0
;	.byte 5,"mA2E for providing intro music",0
;	.byte 7,"at the extreme-last minute",0
;	.byte 20," ",0

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
