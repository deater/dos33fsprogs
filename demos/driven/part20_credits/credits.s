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

	ldx	#8
	stx	FRAME

	; print message

	lda	#160			; bottom of scroll area
	sta	CV

	lda	#<final_credits		; store location of string
	sta	BACKUP_OUTL
	lda	#>final_credits
	sta	BACKUP_OUTH

scroll_loop:

	inc	FRAME			; next frame

	lda	FRAME			; wrap frame after 9 lines
	cmp	#9
	bne	no_update_message

	lda	#0
	sta	FRAME

no_update_message:

	;============================================
	; clear lines to get rid of stray old chars

	ldx	#160
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
;	dex
;	cpx	#183
;	bne	cl_outer_loop

urgh:
	lda	BACKUP_OUTL	; get saved text location
;	sta	OUTL		; FIXME: can call w/o again
	ldy	BACKUP_OUTH	; and load direct in A/Y
;	sta	OUTH

	ldx	FRAME		; load which line of text to draw

;	jsr	draw_condensed_1x8_again

	jsr	draw_condensed_1x8

	; FIXME: only do below if on next string

	lda	FRAME
	cmp	#8
	bne	skip_next_text

			; point to location after
	sec		; always add 1
;	inx
	txa		; afterward X points to end of string
	adc	OUTL
	sta	BACKUP_OUTL
	lda	#0
	adc	OUTH
	sta	BACKUP_OUTH
skip_next_text:

	jsr	hgr_vertical_scroll

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
