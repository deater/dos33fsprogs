; Monkey Title

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
	.include "zp.inc"
	.include "hardware.inc"
	.include "common_defines.inc"

music_start = $4800

title_start:
	;===================
	; init screen
	jsr	TEXT
	jsr	HOME
	bit	KEYRESET

	bit	SET_GR
	bit	PAGE0
	bit	LORES
	bit	FULLGR

	lda	#0
	sta	clear_all_color+1
	jsr	clear_all

	lda	#0
	sta	ANIMATE_FRAME
	sta	FRAMEL
	sta	FRAMEH
	sta	DISP_PAGE

	lda	#4
	sta	DRAW_PAGE


setup_music:
	; decompress music

        lda	#<theme_lzsa
	sta	LZSA_SRC_LO
        lda	#>theme_lzsa
	sta	LZSA_SRC_HI
	lda	#$48			; load to page $4800
	jsr	decompress_lzsa2_fast

	jsr	mockingboard_detect

title_loop:

	;====================================
	; load LF logo
	;====================================

        lda	#<logo_lzsa
	sta	LZSA_SRC_LO
        lda	#>logo_lzsa
	sta	LZSA_SRC_HI
	lda	#$c			; load to page $c00
	jsr	decompress_lzsa2_fast

	jsr	gr_copy_to_current

logo_loop:

	; draw sprites

;	lda	GUYBRUSH_X
;	sta	XPOS
;	lda	GUYBRUSH_Y
;	sta	YPOS

;	lda	#<guybrush_back_sprite
;	sta	INL
;	lda	#>guybrush_back_sprite
;	sta	INH

;	jsr	put_sprite_crop

	jsr	gr_copy_to_current

	jsr	page_flip

	; incrememnt frame

	jsr	inc_frame

	; if it's been x seconds then go to next part
	lda	FRAMEH
	cmp	#3
	beq	do_monkey_loop

	; early escape if keypressed
	lda	KEYPRESS
	bpl	do_logo_loop

	jmp	done_with_title

do_logo_loop:
	jmp	logo_loop


	;====================================
	; load Background logo
	;====================================
do_monkey_loop:
        lda	#<title_lzsa
	sta	LZSA_SRC_LO
        lda	#>title_lzsa
	sta	LZSA_SRC_HI
	lda	#$c			; load to page $c00
	jsr	decompress_lzsa2_fast

monkey_loop:
	jsr	gr_copy_to_current

	jsr	page_flip

	; early escape if keypressed
	lda	KEYPRESS
	bpl	loop_again

	jmp	done_with_title

loop_again:
	jmp	monkey_loop


	;==========================
	; turn off music
	;==========================
done_with_title:
	bit	KEYRESET	; clear keypress
	sei			; clear interrupts

	jsr	clear_ay_both	; silence ay-3-8910 chips

	;==========================
	; load main program
	;==========================

	lda	#LOAD_MONKEY
	sta	WHICH_LOAD

	rts

	;==========================
	; includes
	;==========================

	; level graphics
	.include	"graphics_intro/title_graphics.inc"



	.include	"text_print.s"
	.include	"gr_offsets.s"
	.include	"gr_fast_clear.s"
	.include	"gr_copy.s"
	.include	"gr_putsprite_crop.s"
	.include	"gr_pageflip.s"
	.include	"decompress_fast_v2.s"

	.include	"ym_play.s"
	.include	"interrupt_handler.s"
	.include	"mockingboard.s"

;wait_until_keypressed:
;	lda	KEYPRESS
;	bpl	wait_until_keypressed

;	bit	KEYRESET

;	rts


	;====================================
	; inc frame count
	;====================================
inc_frame:
	inc	FRAMEL
	bne	room_frame_no_oflo
	inc	FRAMEH
room_frame_no_oflo:
	rts


; music is compressed
; decompressed it is 30720 bytes
; we decompress to $4800
; so total size of our code can't be biggr than $2800 = 10k

theme_lzsa:
.incbin	"music/theme.lzsa"

logo_sprites:
	.word logo_sprite0
	.word logo_sprite1
	.word logo_sprite2
	.word logo_sprite1
	.word logo_sprite0

logo_sprite0:
	.byte 3,2
	.byte $AA,$AA,$AA
	.byte $AA,$AF,$AA

logo_sprite1:
	.byte 3,2
	.byte $AA,$3A,$AA
	.byte $A3,$3F,$A3

logo_sprite2:
	.byte 3,3
	.byte $AA,$b3,$AA
	.byte $Ab,$bF,$Ab
	.byte $Aa,$a3,$Aa

; spark locations  (grow+shrink)

sparks:
	;      X,Y    timestamp
	.byte  0,10,	0	; first:	0,10
	.byte  3,26,	2	; second:	3,26
	.byte  6,10,	4	; third:	6,10
	.byte  6,28,	6	; 4th		6,28
	.byte 10,14,	8	; 5th		10,14
	.byte 15,22,	10	; 6th		15,22
	.byte 19,14,	12	; 7th		19,14
	.byte 25,24,	14	; 8th		25,24
	.byte 28,10,	16	; 9th 		28,10
	.byte 32,30,	18	; 10th		32,30
	.byte 37,10,	20	; 11th		37,10
	.byte $ff
