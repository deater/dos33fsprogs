; Credits

; o/~ It's the credits, yeah, that's the best part
;     When the movie ends and the reading starts o/~

;
; by deater (Vince Weaver) <vince@deater.net>

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

;	bit	SET_GR
;	bit	HIRES
;	bit	FULLGR
;	bit	PAGE1


	; disable 80column mode
	sta	SETAN3
	sta	CLR80COL
	sta	EIGHTYCOLOFF
	bit	PAGE1


	lda	#0
	sta	DRAW_PAGE

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

	lda	#18
	sta	CURSOR_X

	lda	#160
	sta	CURSOR_Y

	inc	GUITAR_FRAME


not_at_end:

	;===========================
	; keeper1

	lda	GUITAR_FRAME
	and	#$1f
	tax
	lda	keeper1_pattern,X
	tax


	lda	#14
	sta	CURSOR_X

	lda	#160
	sta	CURSOR_Y

	lda	keeper_l,X
	sta	INL
	lda	keeper_h,X
	sta	INH

	jsr	hgr_draw_sprite

	;====================
	; keeper2

	lda	GUITAR_FRAME
	and	#$1f
	tax
	lda	keeper2_pattern,X
	tax


	lda	#22
	sta	CURSOR_X

	lda	#160
	sta	CURSOR_Y

	lda	keeper_l,X
	sta	INL
	lda	keeper_h,X
	sta	INH

	jsr	hgr_draw_sprite



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
	; draw objects
	;=============================
	;=============================
draw_objects:

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

done_draw_objects:
	rts




.align $100
	.include	"vertical_scroll.s"

	.include	"font_4am_1x8_oneline.s"
	.include	"fonts/font_4am_1x8_data.s"


;	.include	"hgr_sprite.s"



;	.include	"graphics/guitar_sprites.inc"

.if 0
guitar_pattern:
.byte 0,0,1,1,2,2,1,1

guitar_l:
	.byte <guitar0,<guitar1,<guitar2
guitar_h:
	.byte >guitar0,>guitar1,>guitar2
.endif

	.include	"graphics/keeper1_sprites.inc"
	.include	"graphics/keeper2_sprites.inc"

keeper_l:
	.byte <keeper_r0,<keeper_r1,<keeper_r2
	.byte <keeper_r3,<keeper_r4,<keeper_r5
	.byte <keeper_r6,<keeper_r7
	.byte <keeper_l0,<keeper_l1,<keeper_l2
	.byte <keeper_l3,<keeper_l4,<keeper_l5
	.byte <keeper_l6,<keeper_l7

keeper_h:
	.byte >keeper_r0,>keeper_r1,>keeper_r2
	.byte >keeper_r3,>keeper_r4,>keeper_r5
	.byte >keeper_r6,>keeper_r7
	.byte >keeper_l0,>keeper_l1,>keeper_l2
	.byte >keeper_l3,>keeper_l4,>keeper_l5
	.byte >keeper_l6,>keeper_l7

keeper1_pattern:
.byte 1,1,2,2,1,1,2,2
.byte 1,2,3,4,5,4,3,4
.byte 5,4,3,4,5,6,7,5
.byte 7,6,5,4,3,2,1,2

keeper2_pattern:
.byte 1+8,1+8,2+8,2+8,1+8,1+8,2+8,2+8
.byte 1+8,2+8,3+8,4+8,5+8,4+8,3+8,4+8
.byte 5+8,4+8,3+8,4+8,5+8,6+8,7+8,5+8
.byte 7+8,6+8,5+8,4+8,3+8,2+8,1+8,2+8


	.include	"graphics/other_sprites.inc"

.if 0
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
	.byte  8,"--== Monster Splash ==--",0			; 24 (8)
	.byte 20," ",0
	.byte 15,"by Desire",0					; 9 (15.5)
	.byte 20," ",0
	.byte  7,"This demo was first shown",0			; 25 (7.5)
	.byte 11,"at Demosplash 2025",0				; 18 (11)
	.byte  8,"held in Pittsburgh, PA,",0			; 23 (8.5)
	.byte 10,"on Hallowe'en 2025.",0			; 19 (10.5)
	.byte 20," ",0

; Code
	.byte 20," ",0
	.byte 20," ",0
	.byte 17,"Code:",0					;  5 (17.5)
	.byte 20," ",0
	.byte  8,"4am -- font, transitions",0			; 24 (8)
	.byte  7,"DMSC -- ZX02 decompression",0			; 26 (7)
	.byte  9,"French Touch -- Plasma",0			; 22 (9)
	.byte  7,"Martin Kahn -- martimation",0			; 26 (7)
	.byte  7,"qkumba -- fast disk loader",0			; 26 (7)
	.byte  8,"Deater - everything else",0			; 24 (8)

; Graphics
	.byte 20," ",0
	.byte 20," ",0
	.byte 20," ",0
	.byte 20," ",0
	.byte 15,"Graphics:",0					; 9 (15.5)
	.byte 20," ",0
	.byte  7,"grimnir -- logos/monsters",0			; 25 (7.5)
	.byte  8,"Videlectrix -- peasantry",0			; 24 (8)
	.byte  2,"The Pixel Apothecary -- spooky house",0	; 36 (2)
	.byte  6,"Chad Savage -- fiendish font",0		; 28 (6)

; Music
	.byte 20," ",0
	.byte 20," ",0
	.byte 17,"Music:",0					; 6 (17)
	.byte 20," ",0
	.byte 18,"mA2E",0					; 4 (18)

; Greetz

	.byte 20," ",0
	.byte 20," ",0
	.byte 15,"Greets to:",0				; 10 (15)
	.byte 20," ",0
	.byte 14,"French Touch",0			; 12 (14)
	.byte 18,"4am",0				; 3 (18.5)
	.byte 17,"qkumba",0				; 6 (17)
	.byte 17,"Grouik",0				; 6 (17)
	.byte 16,"Lethargy",0				; 8 (16)
	.byte 14,"Otomata Labs",0			; 12 (14)
	.byte 14,"Fenarinarsa",0			; 11 (14.5)
	.byte 15,"Ninjaforce",0				; 10 (15)
	.byte 15,"T. Greene",0				; 9 (15.5)
	.byte 15,"K. Savetz",0				; 9 (15.5)
	.byte 15,"Boo Atari",0				; 9 (15.5)
	.byte 14,"Talbot 0101",0			; 11 (14.5)
	.byte 15,"textfiles",0				; 9 (15.5)
	.byte 13,"Stealth Susie",0			; 13 (13.5)
	.byte 17,"wiz21b",0				; 6 (17)
	.byte 16,"Trixter",0				; 7 (16.5)
	.byte 18,"LGR",0				; 3 (18.5)
	.byte 16,"Hellmood",0				; 8 (16)
	.byte 17,"Foone",0				; 5 (17.5)
	.byte 11,"The Brothers Chaps",0			; 18 (11)
	.byte 20," ",0
	.byte 20," ",0

	.byte 13,"No greets to:",0			; 13 (13.5)
	.byte 20," ",0
	.byte 11,"UM Faculty Senate",0			; 17 (11.5)
	.byte 20," ",0
	.byte 20," ",0

	.byte 12,"Obsolete boards:",0			; 16 (12)
	.byte 20," ",0
	.byte 12,"Utopia BBS (410)",0			; 16 (12)
	.byte 10,"Weave's World Talker",0		; 20 (10)
	.byte 8,"Tell 'em Deater sent ya",0		; 23 (8.5)
	.byte 20," ",0
	.byte 20," ",0

; No Greetz



; ?

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
peasant_smc:			; hack hack hack
	.byte $FE," ",0
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
	.byte 20," ",0
	.byte $FF


	; high:low is FRAMEH:L to match on when ready to draw
	; why doubled?  I guess because odd/even frames?

sprite_triggers_l:
	.byte	$48,$49		; demosplash logo
	.byte	$E0,$E1		; vmw logo
	.byte	$90,$91		; m
	.byte	$A0,$A1		; s
	.byte	$B0,$B1		; o
	.byte	$C0,$C1		; p
	.byte	$D0,$D1		; n
	.byte	$E0,$E1		; l
	.byte	$F0,$F1		; s
	.byte	$00,$01		; a
	.byte	$10,$11		; t
	.byte	$20,$21		; s
	.byte	$30,$31		; e
	.byte	$40,$41		; h
	.byte	$50,$51		; r


sprite_triggers_h:
	.byte $00,$00		; demosplash logo
	.byte $00,$00		; vmw logo
	.byte $01,$01		; m
	.byte $01,$01		; s
	.byte $01,$01		; o
	.byte $01,$01		; p
	.byte $01,$01		; n
	.byte $01,$01		; l
	.byte $01,$01		; s
	.byte $02,$02		; a
	.byte $02,$02		; t
	.byte $02,$02		; s
	.byte $02,$02		; e
	.byte $02,$02		; h
	.byte $02,$02		; r
	.byte $ff

sprite_triggers_x:
	.byte	2,2		; demosplash logo
	.byte	16,16		; vmw logo
	.byte	2,2		; m
	.byte	34,34		; s
	.byte	2,2		; o
	.byte	34,34		; p
	.byte	2,2		; n
	.byte	34,34		; l
	.byte	2,2		; s
	.byte	34,34		; a
	.byte	2,2		; t
	.byte	34,34		; s
	.byte	2,2		; e
	.byte	34,34		; h
	.byte	2,2		; r


sprite_triggers_y:
	.byte	143,142		; demosplash logo
	.byte	146,145		; vmw logo
	.byte	145,144		; m
	.byte	145,144		; s
	.byte	145,144		; o
	.byte	145,144		; p
	.byte	145,144		; n
	.byte	145,144		; l
	.byte	145,144		; s
	.byte	145,144		; a
	.byte	145,144		; t
	.byte	145,144		; s
	.byte	145,144		; e
	.byte	145,144		; h
	.byte	145,144		; r


sprite_triggers_sprite_l:
	.byte	<demosplash_sprite,<demosplash_sprite
	.byte	<vmw_sprite,<vmw_sprite
	.byte	<m_sprite,<m_sprite
	.byte	<s_sprite,<s_sprite
	.byte	<o_sprite,<o_sprite
	.byte	<p_sprite,<p_sprite
	.byte	<n_sprite,<n_sprite
	.byte	<l_sprite,<l_sprite
	.byte	<s_sprite,<s_sprite
	.byte	<a_sprite,<a_sprite
	.byte	<t_sprite,<t_sprite
	.byte	<s_sprite,<s_sprite
	.byte	<e_sprite,<e_sprite
	.byte	<h_sprite,<h_sprite
	.byte	<r_sprite,<r_sprite



sprite_triggers_sprite_h:
	.byte	>demosplash_sprite,>demosplash_sprite
	.byte	>vmw_sprite,>vmw_sprite
	.byte	>m_sprite,>m_sprite
	.byte	>s_sprite,>s_sprite
	.byte	>o_sprite,>o_sprite
	.byte	>p_sprite,>p_sprite
	.byte	>n_sprite,>n_sprite
	.byte	>l_sprite,>l_sprite
	.byte	>s_sprite,>s_sprite
	.byte	>a_sprite,>a_sprite
	.byte	>t_sprite,>t_sprite
	.byte	>s_sprite,>s_sprite
	.byte	>e_sprite,>e_sprite
	.byte	>h_sprite,>h_sprite
	.byte	>r_sprite,>r_sprite


	;=========================
	; draw peasant at end
	;=========================
peasant_interlude:

	lda	OUTL
	pha
	lda	OUTH
	pha

	;====================
	; draw on current page

	lda	#20
	sta	CURSOR_X
	lda	#110
	sta	CURSOR_Y

	lda	#<peasant
	sta	INL
	lda	#>peasant
	sta	INH

	jsr	hgr_draw_sprite

	lda	#<question1
	ldy	#>question1
	jsr	DrawCondensedString
	lda	#<question2
	ldy	#>question2
	jsr	DrawCondensedString

	;=============================
	; draw on other page one lower

	lda	DRAW_PAGE
	eor	#$20
	sta	DRAW_PAGE

	lda	#20
	sta	CURSOR_X
	lda	#111
	sta	CURSOR_Y

	lda	#<peasant
	sta	INL
	lda	#>peasant
	sta	INH

	jsr	hgr_draw_sprite

	inc	question1+1
	inc	question2+1

	lda	#<question1
	ldy	#>question1
	jsr	DrawCondensedString
	lda	#<question2
	ldy	#>question2
	jsr	DrawCondensedString

	lda	DRAW_PAGE
	eor	#$20
	sta	DRAW_PAGE

	lda	#4
	jsr	wait_seconds


	lda	#<question3
	ldy	#>question3
	jsr	DrawCondensedString


	lda	DRAW_PAGE
	eor	#$20
	sta	DRAW_PAGE

	inc	question3+1
	lda	#<question3
	ldy	#>question3
	jsr	DrawCondensedString

	lda	DRAW_PAGE
	eor	#$20
	sta	DRAW_PAGE


	pla
	sta	OUTH
	pla
	sta	OUTL

	rts



question1:;          012345  6   7890123456789012345678901234567  8   9
	.byte 0,85,"Wait, ",34,"All monsters have been splashed",34,"?",0
question2:
	.byte 7,95,"What does that even mean?",0
question3:
	.byte 9,140,"Wait! Don't scroll me!",0
