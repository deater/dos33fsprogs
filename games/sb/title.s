; Yet Another HR project
;
; by deater (Vince Weaver) <vince@deater.net>


.include "zp.inc"
.include "hardware.inc"

div7_table     = $9C00
mod7_table     = $9D00
hposn_high     = $9E00
hposn_low      = $9F00

hires_start:

	;===================
	; set graphics mode
	;===================
	jsr	HOME

	jsr	HGR
	bit	FULLGR

	lda	#0
	sta	DRAW_PAGE

	;====================
	; set up tables
	;====================

	lda	#$20
	sta	HGR_PAGE
	jsr	hgr_make_tables


	;=========================================
	; detect if we have a language card (64k)
	; and load sound into it if possible
	;===================================

	lda	#0
	sta	SOUND_STATUS		; clear out, sound enabled

	jsr	detect_language_card
	bcs	no_language_card

yes_language_card:

	; update sound status
	lda	SOUND_STATUS
	ora	#SOUND_IN_LC
	sta	SOUND_STATUS

	;==================================
	; load sound into the language card
	;       into $D000 set 1
	;==================================

	; read/write RAM, use $d000 bank1
	bit	$C083
	bit	$C083

	lda     #<purple_data
        sta     ZX0_src
        lda     #>purple_data
        sta     ZX0_src+1

        lda     #$D0    ; decompress to $D000

	jsr	full_decomp

	; read ROM/no-write
	bit	$C082


no_language_card:

	;====================
	; see if skipping
	;====================

	lda	NOT_FIRST_TIME
	bne	load_title_image

	;===================
	;===================
	; scroll the logo
	;===================
	;===================
scroll_logo:

	;===================
	; decomress to $a000

	; size in ldsizeh:ldsizel (f1/f0)

	lda	#<vid_top
	sta	ZX0_src
	lda	#>vid_top
	sta	ZX0_src+1


	lda	#$40

	jsr	full_decomp

	;======================
	; scroll up vertically
	;======================

	jsr	hgr_logo_vscroll


	;===================
	; Do Title Screen
	;===================
load_loop:

	;==========================
	; Load Title Image
	;===========================

load_title_image:

	; size in ldsizeh:ldsizel (f1/f0)

	lda	#<title_data
	sta	ZX0_src
	lda	#>title_data
	sta	ZX0_src+1


	lda	#$20


	jsr	full_decomp

	lda	#0
	sta	MENU_ITEM

	;==========================
	; Play sound
	;===========================

	lda	NOT_FIRST_TIME
	bne	skip_purple

say_purple:
	jsr	play_purple

skip_purple:
	;==========================
	; Update purple sprite
	;===========================

	lda	#<purple_sprite
	sta	INL
	lda	#>purple_sprite
	sta	INH
	lda	#(175/7)
	sta	SPRITE_X
	lda	#83
	sta	SPRITE_Y
	jsr	hgr_draw_sprite

	lda	#1
	sta	NOT_FIRST_TIME
main_loop:
	;==========================
	; Draw arrow
	;===========================
draw_arrow:
	ldx	MENU_ITEM
	stx	OLD_MENU_ITEM

	lda	#<arrow_sprite
	sta	INL
	lda	#>arrow_sprite
	sta	INH
	lda	#(105/7)
	sta	SPRITE_X
	lda	arrow_y,X
	sta	SPRITE_Y
	jsr	hgr_draw_sprite

wait_until_keypress:
	lda	KEYPRESS				; 4
	bpl	wait_until_keypress			; 3
	bit	KEYRESET	; clear the keyboard buffer

	and	#$7f

	;=========================
	; see if number pressed

	cmp	#27
	beq	load_loop

	cmp	#'8'
	beq	draw_edga_jr

	cmp	#'1'
	bcc	done_check_number		; blt
	cmp	#'8'
	bcs	done_check_number		; bge


	; was a number

	and	#$f
	sta	MENU_ITEM
	bne	load_new_program

done_check_number:

	cmp	#' '
	beq	load_from_arrow
	cmp	#13
	beq	load_from_arrow

	cmp	#'P'
	beq	say_purple

	cmp	#8		; left
	beq	arrow_up
	cmp	#$15
	beq	arrow_down	; right
	cmp	#$0B
	beq	arrow_up	; up
	cmp	#$0A
	beq	arrow_down	; down


done_arrow:
	jmp	wait_until_keypress

arrow_up:
	lda	MENU_ITEM
	beq	done_arrow
	dec	MENU_ITEM
	jmp	move_arrow

arrow_down:
	lda	MENU_ITEM
	cmp	#6			; 0 indexed
	bcs	done_arrow
	inc	MENU_ITEM

move_arrow:
	; erase arrow

	ldx	OLD_MENU_ITEM
	lda	#<empty_sprite
	sta	INL
	lda	#>empty_sprite
	sta	INH
	lda	#(105/7)
	sta	SPRITE_X
	lda	arrow_y,X
	sta	SPRITE_Y
	jsr	hgr_draw_sprite

	jmp	draw_arrow

draw_edga_jr:

	lda	#<edga_jr_sprite
	sta	INL
	lda	#>edga_jr_sprite
	sta	INH
	lda	#(105/7)
	sta	SPRITE_X
	lda	#0
	sta	SPRITE_Y
	jsr	hgr_draw_sprite_big

	jmp	draw_arrow



load_from_arrow:
	inc	MENU_ITEM	; it's zero indexed

load_new_program:

	lda     #<loading_data
        sta     ZX0_src
        lda     #>loading_data
        sta     ZX0_src+1

        lda     #$20    ; decompress to hgr page1

	jsr	full_decomp

	lda	MENU_ITEM
	sta	WHICH_LOAD
	rts

	.include	"zx02_optim.s"
	.include	"hgr_tables.s"
	.include	"hgr_logo_scroll.s"
	.include	"audio.s"
	.include	"play_purple.s"
	.include	"lc_detect.s"
	.include	"title_graphics/title_sprites.inc"
	.include	"hgr_sprite.s"
	.include	"hgr_sprite_big.s"

title_data:
	.incbin "title_graphics/czmg4ap_title.hgr.zx02"
vid_top:
	.incbin "title_graphics/videlectrix_top.hgr.zx02"
loading_data:
	.incbin "title_graphics/the_cheat_loading.hgr.zx02"

purple_data:
	.incbin "title_sound/purple.btc.zx02"

	; offsets of arrow
arrow_y:
	.byte 111,121,131,141,151,161,171
