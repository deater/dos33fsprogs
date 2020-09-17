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


	;====================================
	; load LF logo
	;====================================

        lda	#<logo_lzsa
	sta	LZSA_SRC_LO
        lda	#>logo_lzsa
	sta	LZSA_SRC_HI
	lda	#$c			; load to page $c00
	jsr	decompress_lzsa2_fast


setup_music:
	; decompress music

        lda	#<theme_lzsa
	sta	LZSA_SRC_LO
        lda	#>theme_lzsa
	sta	LZSA_SRC_HI
	lda	#$48			; load to page $4800
	jsr	decompress_lzsa2_fast

	jsr	mockingboard_detect


	;====================================
	;====================================
	; Main LOGO loop
	;====================================
	;====================================

logo_loop:

	; copy over background

	jsr	gr_copy_to_current

	; draw sparks

	lda	FRAMEH		; only do this once
	bne	done_sparks

	ldy	#0
spark_loop:
	lda	sparks,Y
	bmi	done_sparks

	sta	XPOS
	iny

	lda	sparks,Y
	sta	YPOS
	iny

	; calc which spark

	lda	sparks,Y
	sta	TEMPY

	sec
	lda	FRAMEL
	sbc	TEMPY		; negative if too soon
	bmi	draw_empty_sprite
	cmp	#5		; over 5 if done
	bcs	draw_empty_sprite

	asl
	tax
	lda	spark_sprites,X
	sta	INL
	lda	spark_sprites+1,X
	jmp	draw_spark_sprite

draw_empty_sprite:
	lda	#<empty_sprite
	sta	INL
	lda	#>empty_sprite

draw_spark_sprite:
	sta	INH

	iny
	tya
	pha

	jsr	put_sprite_crop

	pla
	tay

	jmp	spark_loop

done_sparks:

	; flip page

	jsr	page_flip

	; incrememnt frame

	jsr	inc_frame

	; if it's been x seconds then go to next part
	lda	FRAMEL
	cmp	#$50
	beq	do_monkey_loop

	; early escape if keypressed
	lda	KEYPRESS
	bpl	do_logo_loop

	jmp	done_with_title

do_logo_loop:

	; delay
	lda	#200
	jsr	WAIT

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

	lda	#0
	sta	XPOS
	lda	#4
	sta	YPOS

	lda	#<cloud_sprite
	sta	INL
	lda	#>cloud_sprite
	sta	INH

	jsr	put_sprite_crop



	jsr	page_flip


	; early escape if end of song
	lda	DONE_PLAYING
	bmi	done_with_title

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

spark_sprites:
	.word empty_sprite
	.word spark0_sprite
	.word spark1_sprite
	.word spark2_sprite
	.word spark1_sprite
	.word spark0_sprite

empty_sprite:
	.byte 1,1
	.byte $AA

spark0_sprite:
	.byte 3,2
	.byte $AA,$AA,$AA
	.byte $AA,$AF,$AA

spark1_sprite:
	.byte 3,2
	.byte $AA,$3A,$AA
	.byte $A3,$3F,$A3

spark2_sprite:
	.byte 3,3
	.byte $AA,$b3,$AA
	.byte $Ab,$bF,$Ab
	.byte $Aa,$a3,$Aa

; spark locations  (grow+shrink)

sparks:
	;      X,Y    timestamp
	.byte  0,10,	32	; first:	0,10
	.byte  3,26,	34	; second:	3,26
	.byte  6,10,	36	; third:	6,10
	.byte  6,28,	38	; 4th		6,28
	.byte 10,14,	40	; 5th		10,14
	.byte 15,22,	42	; 6th		15,22
	.byte 19,14,	44	; 7th		19,14
	.byte 25,24,	46	; 8th		25,24
	.byte 28,10,	48	; 9th 		28,10
	.byte 32,30,	50	; 10th		32,30
	.byte 37,10,	52	; 11th		37,10
	.byte $ff


cloud_sprite:
.byte	40,6
;line 1
.byte	$AA,$AA,$AA,$AA,$AA,$AA,$AA,$A5,$AA,$AA
.byte	$AA,$AA,$AA,$AA,$5A,$5A,$7A,$75,$55,$05
.byte	$5A,$AA,$AA,$AA,$77,$5A,$AA,$AA,$AA,$AA
.byte	$AA,$AA,$AA,$AA,$AA,$AA,$5A,$5A,$AA,$AA
;line 2
.byte	$7A,$7A,$77,$7A,$7A,$77,$7A,$77,$7A,$AA
.byte	$AA,$5A,$5A,$57,$07,$77,$55,$05,$50,$05
.byte	$77,$00,$5A,$AA,$A5,$A5,$AA,$AA,$AA,$AA
.byte	$7A,$AA,$AA,$AA,$A5,$AA,$77,$07,$77,$AA
;line 3
.byte	$A5,$A7,$55,$05,$50,$55,$05,$05,$55,$57
.byte	$57,$50,$57,$57,$70,$07,$77,$75,$50,$55
.byte	$55,$55,$00,$07,$7A,$77,$77,$77,$AA,$57
.byte	$77,$AA,$5A,$77,$7A,$5A,$07,$75,$05,$AA
;line 4
.byte	$AA,$AA,$A7,$57,$57,$57,$07,$75,$75,$75
.byte	$70,$00,$75,$55,$75,$70,$77,$77,$50,$05
.byte	$07,$55,$75,$75,$07,$57,$50,$00,$50,$05
.byte	$77,$7A,$70,$07,$77,$77,$75,$70,$75,$5A
;line 5
.byte	$AA,$AA,$AA,$AA,$AA,$A5,$A5,$AA,$A0,$A5
.byte	$A5,$A5,$A5,$A5,$A5,$A5,$05,$55,$57,$55
.byte	$55,$57,$57,$00,$57,$57,$55,$07,$07,$57
.byte	$50,$77,$77,$50,$07,$77,$77,$77,$77,$55
;line 6
.byte	$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA
.byte	$AA,$AA,$AA,$AA,$AA,$AA,$AA,$A0,$A5,$A5
.byte	$A5,$A5,$A5,$A0,$AA,$A5,$55,$55,$55,$55
.byte	$55,$A5,$A5,$A7,$A5,$A5,$A5,$A5,$A5,$A0


