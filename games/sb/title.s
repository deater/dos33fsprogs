; Yet Another HR project
;
; by deater (Vince Weaver) <vince@deater.net>


.include "zp.inc"
.include "hardware.inc"


hires_start:

	;===================
	; set graphics mode
	;===================
	jsr	HOME

	jsr	HGR
;	bit	HIRES
	bit	FULLGR
;	bit	SET_GR
;	bit	PAGE1

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

	;==========================
	; Play sound
	;===========================
say_purple:
	jsr	play_purple

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

	lda	#0
	sta	MENU_ITEM

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

	cmp	#'1'
	bcc	done_check_number		; blt
	cmp	#'7'
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
	cmp	#5			; 0 indexed
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


load_from_arrow:
	inc	MENU_ITEM	; it's zero indexed

load_new_program:
	lda	MENU_ITEM
	sta	WHICH_LOAD
	rts

	.include	"zx02_optim.s"
	.include	"hgr_tables.s"
	.include	"hgr_logo_scroll.s"
	.include	"audio.s"
	.include	"purple.s"
	.include	"lc_detect.s"
	.include	"graphics/title_sprites.inc"
	.include	"hgr_sprite.s"

title_data:
	.incbin "graphics/czmg4ap_title.hgr.zx02"
vid_top:
	.incbin "graphics/videlectrix_top.hgr.zx02"

purple_data:
	.incbin "sound/purple.btc.zx02"

	; offsets of arrow
arrow_y:
	.byte 111,121,131,141,151,161
