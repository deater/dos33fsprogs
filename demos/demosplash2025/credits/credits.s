; Credits

; o/~ It's the credits, yeah, that's the best part
;     When the movie ends and the reading starts o/~

;
; by deater (Vince Weaver) <vince@deater.net>

.include "zp.inc"
.include "../zp.inc"
.include "../hardware.inc"
.include "../qload.inc"
.include "../music.inc"
.include "../common_defines.inc"


	;=======================
	; so the way this works is that it only displays PAGE1
	;	and it prints new credits just off the bottom of it which
	;	is essentially the top of PAGE2
	; then it scrolls things up
	;========================

credits_start:
	;=====================
	; initializations
	;=====================

	bit	KEYRESET		; clear just in case

	bit	SET_GR
	bit	HIRES
	bit	FULLGR
	bit	PAGE1

	lda	#0
	jsr	hgr_page1_clearscreen	; unrolled
	jsr	hgr_page2_clearscreen	; unrolled

;	jsr	hgr_make_tables

	ldx	#0
	stx	SCROLL_LINE
	sta	SCROLL_DONE
	sta	FRAMEL
	sta	FRAMEH
	sta	SPRITE_LIST

	; print message


	lda	#<final_credits		; store location of string
	sta	BACKUP_OUTL
	lda	#>final_credits
	sta	BACKUP_OUTH

scroll_loop:

	; if done scrolling, keepy playing music

	lda	SCROLL_DONE
	bne	draw_sprites


	;================================
	; scroll up current page


	jsr	hgr_vertical_scroll


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
	; draw stars
	;=============================
	;=============================

	jsr	draw_stars

	;=============================
	;=============================
	; draw falling objects
	;=============================
	;=============================

	jsr	draw_objects

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
	ldx	SCROLL_LINE		; load which line of text to draw
	jsr	draw_condensed_1x8

	; X points to last char printed?

	;=========================================
	; check if increment to next line of text
	;=========================================
	; flip over if frame==9

	lda	SCROLL_LINE
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
	sta	SCROLL_LINE
skip_next_text:

	;===========================
	; draw second line at 159
	;===========================

	lda	#159		;
	sta	CV
	lda	BACKUP_OUTL	; get saved text location
	ldy	BACKUP_OUTH	; and load direct in A/Y
	ldx	SCROLL_LINE
	inx
	jsr	draw_condensed_1x8

	;=================================
	; increment the frame
	;=================================

	inc	SCROLL_LINE		; increment starting text subline

	inc	FRAMEL
	bne	frame_noflo
	inc	FRAMEH
frame_noflo:

	;=============================
	; draw sprites
	;=============================
draw_sprites:
.if 0
	lda	#18
	sta	CURSOR_X

	lda	#160
	sta	CURSOR_Y

	inc	GUITAR_FRAME

	lda	GUITAR_FRAME
	and	#7
	tax
	lda	guitar_pattern,X
	tax

	lda	guitar_l,X
	sta	INL
	lda	guitar_h,X
	sta	INH

	jsr	hgr_draw_sprite


	;===========================
	; catherine

	lda	GUITAR_FRAME
	and	#$1f
	tax
	lda	catherine_pattern,X
	tax


	lda	#14
	sta	CURSOR_X

	lda	#160
	sta	CURSOR_Y

	lda	moiety_l,X
	sta	INL
	lda	moiety_h,X
	sta	INH

	jsr	hgr_draw_sprite

	;====================
	; moiety2

	lda	GUITAR_FRAME
	and	#$1f
	tax
	lda	moiety2_pattern,X
	tax


	lda	#22
	sta	CURSOR_X

	lda	#160
	sta	CURSOR_Y

	lda	moiety_l,X
	sta	INL
	lda	moiety_h,X
	sta	INH

	jsr	hgr_draw_sprite
.endif


	;=============================
	; do the scroll
	;=============================

	jsr	wait_vblank

	lda	SCROLL_DONE
	beq	do_page_flip

	; this is a hack?

	bit	PAGE1
	lda	#0
	sta	DRAW_PAGE

	lda	#150		; eyeballed
	jsr	wait

	jmp	scroll_loop

do_page_flip:
	jsr	hgr_page_flip
skip_page_flip:

	jmp	scroll_loop




	;=============================
	;=============================
	; draw stars
	;=============================
	;=============================
draw_stars:
.if 0
	lda	FRAME
	and	#1
	bne	stars_odd

stars_even:

	; generate star data

	; get x-coord

	jsr	random8
	and	#$1f		; 1..32
	tax
	lda	star_x,X
	sta	STAR_X

	; get type

	jsr	random8
	and	#7
	sta	STAR_WHICH

	lda	#159
	bne	stars_common	; bra

stars_odd:
	lda	#158
stars_common:
	sta	CURSOR_Y

	lda	STAR_X
	bmi	no_stars
	sta	CURSOR_X

	lda	STAR_WHICH
	tax
	lda	star_sprites_l,X
	sta	INL
	lda	star_sprites_h,X
	sta	INH

	jmp	hgr_draw_sprite	; tail call
no_stars:
.endif
	rts



	;=============================
	;=============================
	; draw objects
	;=============================
	;=============================
draw_objects:
.if 0
	ldx	SPRITE_LIST
	lda	sprite_triggers_h,X
	bmi	done_draw_objects

	cmp	FRAMEH
	bne	done_draw_objects

	lda	sprite_triggers_l,X
	cmp	FRAMEL
	bne	done_draw_objects

	; we matched!

	inc	SPRITE_LIST			; point to next in advance

	lda	sprite_triggers_y,X
	sta	CURSOR_Y

	lda	sprite_triggers_x,X
	sta	CURSOR_X

	lda	sprite_triggers_sprite_l,X
	sta	INL
	lda	sprite_triggers_sprite_h,X
	sta	INH

	jmp	hgr_draw_sprite	; tail call
.endif
done_draw_objects:
	rts




.align $100
;	.include	"../hgr_clear_screen.s"
	.include	"vertical_scroll.s"

	.include	"font_4am_1x8_oneline.s"
	.include	"fonts/font_4am_1x8_data.s"

;	.include	"../irq_wait.s"
;	.include	"../hgr_page_flip.s"

;	.include	"../vblank.s"

	.include	"hgr_sprite.s"
	.include	"random8.s"

.if 0

	.include	"graphics/guitar_sprites.inc"

guitar_pattern:
.byte 0,0,1,1,2,2,1,1

guitar_l:
	.byte <guitar0,<guitar1,<guitar2
guitar_h:
	.byte >guitar0,>guitar1,>guitar2


	.include	"graphics/catherine_sprites.inc"
	.include	"graphics/moiety2_sprites.inc"

moiety_l:
	.byte <moiety_r0,<moiety_r1,<moiety_r2
	.byte <moiety_r3,<moiety_r4,<moiety_r5
	.byte <moiety_r6,<moiety_r7
	.byte <moiety_l0,<moiety_l1,<moiety_l2
	.byte <moiety_l3,<moiety_l4,<moiety_l5
	.byte <moiety_l6,<moiety_l7

moiety_h:
	.byte >moiety_r0,>moiety_r1,>moiety_r2
	.byte >moiety_r3,>moiety_r4,>moiety_r5
	.byte >moiety_r6,>moiety_r7
	.byte >moiety_l0,>moiety_l1,>moiety_l2
	.byte >moiety_l3,>moiety_l4,>moiety_l5
	.byte >moiety_l6,>moiety_l7

catherine_pattern:
.byte 1,1,2,2,1,1,2,2
.byte 1,2,3,4,5,4,3,4
.byte 5,4,3,4,5,6,7,5
.byte 7,6,5,4,3,2,1,2

moiety2_pattern:
.byte 1+8,1+8,2+8,2+8,1+8,1+8,2+8,2+8
.byte 1+8,2+8,3+8,4+8,5+8,4+8,3+8,4+8
.byte 5+8,4+8,3+8,4+8,5+8,6+8,7+8,5+8
.byte 7+8,6+8,5+8,4+8,3+8,2+8,1+8,2+8


	.include	"graphics/other_sprites.inc"

star_sprites_l:
	.byte <star0_sprite,<star1_sprite,<star2_sprite,<star3_sprite
	.byte <star4_sprite,<star5_sprite,<star6_sprite,<star7_sprite
star_sprites_h:
	.byte >star0_sprite,>star1_sprite,>star2_sprite,>star3_sprite
	.byte >star4_sprite,>star5_sprite,>star6_sprite,>star7_sprite

star_x:
	.byte 0,2,4,6, 8,10,12,14, 16,18,20,22, 24,26,28,30
	.byte 32,34,36,38, $FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF
.endif




final_credits:
	.byte 20," ",0
	.byte 16,"DRI\/EN",0					; 7 (16.5)
	.byte 20," ",0
	.byte 15,"by Desire",0					; 9 (15.5)
	.byte 20," ",0
	.byte  7,"This demo was first shown",0			; 25 (7.5)
	.byte 11,"at Demosplash 2024",0				; 18 (11)
	.byte  8,"held in Pittsburgh, PA,",0			; 23 (8.5)
	.byte 11,"in November 2024.",0				; 17 (11.5)
	.byte 20," ",0

; Cyan disclaimer

	.byte 11,"*** DISCLAIMER ***",0				; 18 (11)
	.byte  2,"This demo contains trademarks and/or",0	; 36 (2)
	.byte  7,"copyrighted works of CYAN.",0			; 26 (7)
	.byte  2,"This product is not official and is",0	; 35 (2.5)
	.byte  9,"not endorsed by CYAN.",0			; 21 (9.5)

; Credits

; Code
	.byte 20," ",0
	.byte 20," ",0
	.byte 17,"Code:",0					;  5 (17.5)
	.byte 20," ",0
	.byte  9,"French Touch -- Plasma",0			; 22 (9)
	.byte  7,"DMSC -- ZX02 decompression",0			; 26 (7)
	.byte  7,"qkumba -- fast disk loader",0			; 26 (7)
	.byte  8,"4am -- font, transitions",0			; 24 (8)
	.byte  2,"K. Kennaway -- iipix image converter",0	; 36 (2)
	.byte  8,"Deater - everything else",0			; 24 (8)

; Graphics
	.byte 20," ",0
	.byte 20," ",0
	.byte 20," ",0
	.byte  9,"Falling Graphic, Logo:",0		; 22 (9)
	.byte 20," ",0
	.byte 16,"Steffest",0				; 8 (16)
	.byte 20," ",0


; Music
	.byte 20," ",0
	.byte 20," ",0
	.byte 17,"Music:",0				; 6 (17)
	.byte 20," ",0
	.byte 18,"mA2E",0				; 4 (18)

; Greetz

	.byte 20," ",0
	.byte 20," ",0
	.byte 15,"Greets to:",0				; 10 (15)
	.byte 20," ",0
	.byte 14,"French Touch",0			; 12 (14)
	.byte 18,"4am",0				; 3 (18.5)
	.byte 17,"qkumba",0				; 6 (17)
	.byte 17,"Grouik",0				; 6 (17)
	.byte 14,"Fenarinarsa",0			; 11 (14.5)
	.byte 15,"Ninjaforce",0				; 10 (15)
	.byte 15,"T. Greene",0				; 9 (15.5)
	.byte 15,"K. Savetz",0				; 9 (15.5)
	.byte 15,"Boo Atari",0				; 9 (15.5)
	.byte 15,"textfiles",0				; 9 (15.5)
	.byte 13,"Stealth Susie",0			; 13 (13.5)
	.byte 17,"wiz21b",0				; 6 (17)
	.byte 17,"Trixter",0				; 7 (17.5)
	.byte 18,"LGR",0				; 3 (18.5)
	.byte 16,"Hellmood",0				; 8 (16)
	.byte 17,"Foone",0				; 5 (17.5)
	.byte 14,"Chapman Bros",0			; 12 (14)
	.byte 20," ",0
	.byte 14,"Talbot 0101",0			; 11 (14.5)
	.byte 12,"Utopia BBS (410)",0			; 16 (12)
	.byte 10,"Weave's World Talker",0		; 20 (10)
	.byte 8,"Tell 'em Deater sent ya",0		; 23 (8.5)
	.byte 20," ",0
	.byte 20," ",0
	.byte 20," ",0

; animals
	.byte 8,"No Wharks were harmed in",0		; 24 (8)
	.byte 8,"the making of this demo.",0		; 24 (8)

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
	.byte 12,"Apple II Forever",0			; 16 (12)
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

.if 0
sprite_triggers_l:
	.byte $48,$49		; demosplash logo
	.byte $08,$09		; vmw logo
	.byte $50,$51		; falling book
	.byte $90,$91		; falling guy
	.byte $D0,$D1		; animal10
	.byte $E0,$E1		; animal11
	.byte $F0,$F1		; animal12
	.byte $00,$01		; animal13
	.byte $10,$11		; animal9
	.byte $20,$21		; animal1
	.byte $30,$31		; animal2
	.byte $40,$41		; animal3
	.byte $50,$51		; animal4
	.byte $60,$61		; animal5
	.byte $70,$71		; animal6
	.byte $80,$81		; animal7
	.byte $90,$91		; animal8
	.byte $A0,$A1		; animal0


sprite_triggers_h:
	.byte $00,$00		; demosplash logo
	.byte $01,$01		; vmw logo
	.byte $01,$01		; falling book
	.byte $01,$01		; falling guy
	.byte $01,$01		; animal10
	.byte $01,$01		; animal11
	.byte $01,$01		; animal12
	.byte $02,$02		; animal13
	.byte $02,$02		; animal9
	.byte $02,$02		; animal1
	.byte $02,$02		; animal2
	.byte $02,$02		; animal3
	.byte $02,$02		; animal4
	.byte $02,$02		; animal5
	.byte $02,$02		; animal6
	.byte $02,$02		; animal7
	.byte $02,$02		; animal8
	.byte $02,$02		; animal0
	.byte $ff

sprite_triggers_x:
	.byte	2,2		; demosplash logo
	.byte	16,16		; vmw logo
	.byte	2,2		; falling book
	.byte	34,34		; falling guy
	.byte	2,2		; animal10
	.byte	34,34		; animal11
	.byte	2,2		; animal12
	.byte	34,34		; animal13
	.byte	2,2		; animal9
	.byte	34,34		; animal1
	.byte	2,2		; animal2
	.byte	34,34		; animal3
	.byte	2,2		; animal4
	.byte	34,34		; animal5
	.byte	2,2		; animal6
	.byte	34,34		; animal7
	.byte	2,2		; animal8
	.byte	34,34		; animal0

sprite_triggers_y:
	.byte	143,142		; demosplash logo
	.byte	146,145		; vmw logo
	.byte	117,116		; falling book
	.byte	145,144		; falling guy
	.byte	145,144		; animal10
	.byte	145,144		; animal11
	.byte	145,144		; animal12
	.byte	145,144		; animal13
	.byte	145,144		; animal9
	.byte	145,144		; animal1
	.byte	145,144		; animal2
	.byte	145,144		; animal3
	.byte	145,144		; animal4
	.byte	145,144		; animal5
	.byte	145,144		; animal6
	.byte	145,144		; animal7
	.byte	145,144		; animal8
	.byte	145,144		; animal0


sprite_triggers_sprite_l:
	.byte	<demosplash_sprite,<demosplash_sprite
	.byte	<vmw_sprite,<vmw_sprite
	.byte	<book_sprite,<book_sprite
	.byte	<falling_sprite,<falling_sprite
	.byte	<animal10_sprite,<animal10_sprite
	.byte	<animal11_sprite,<animal11_sprite
	.byte	<animal12_sprite,<animal12_sprite
	.byte	<animal13_sprite,<animal13_sprite
	.byte	<animal9_sprite,<animal9_sprite
	.byte	<animal1_sprite,<animal1_sprite
	.byte	<animal2_sprite,<animal2_sprite
	.byte	<animal3_sprite,<animal3_sprite
	.byte	<animal4_sprite,<animal4_sprite
	.byte	<animal5_sprite,<animal5_sprite
	.byte	<animal6_sprite,<animal6_sprite
	.byte	<animal7_sprite,<animal7_sprite
	.byte	<animal8_sprite,<animal8_sprite
	.byte	<animal0_sprite,<animal0_sprite


sprite_triggers_sprite_h:
	.byte	>demosplash_sprite,>demosplash_sprite
	.byte	>vmw_sprite,>vmw_sprite
	.byte	>book_sprite,>book_sprite
	.byte	>falling_sprite,>falling_sprite
	.byte	>animal10_sprite,>animal10_sprite
	.byte	>animal11_sprite,>animal11_sprite
	.byte	>animal12_sprite,>animal12_sprite
	.byte	>animal13_sprite,>animal13_sprite
	.byte	>animal9_sprite,>animal9_sprite
	.byte	>animal1_sprite,>animal1_sprite
	.byte	>animal2_sprite,>animal2_sprite
	.byte	>animal3_sprite,>animal3_sprite
	.byte	>animal4_sprite,>animal4_sprite
	.byte	>animal5_sprite,>animal5_sprite
	.byte	>animal6_sprite,>animal6_sprite
	.byte	>animal7_sprite,>animal7_sprite
	.byte	>animal8_sprite,>animal8_sprite
	.byte	>animal0_sprite,>animal0_sprite

.endif
