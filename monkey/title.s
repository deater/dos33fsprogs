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
	sta	CREDITS_OFFSET
	sta	CREDITS_LOGO_ON
	sta	CREDITS_SPLIT_SCREEN
	sta	CREDITS_DISPLAY_TEXT

	lda	#14
	sta	CLOUD_X

	lda	#4
	sta	DRAW_PAGE

	jsr	normal_text

	;====================================
	; load LF logo
	;====================================

        lda	#<logo_lzsa
	sta	LZSA_SRC_LO
        lda	#>logo_lzsa
	sta	LZSA_SRC_HI
	lda	#$c			; load to page $c00
	jsr	decompress_lzsa2_fast

	;=====================================
	; load text overlay
	;=====================================

        lda	#<monkey_lzsa
	sta	LZSA_SRC_LO
        lda	#>monkey_lzsa
	sta	LZSA_SRC_HI
	lda	#$44			; load to page $4800-400=$4400
	jsr	decompress_lzsa2_fast

	;=====================================
	; setup music
	;=====================================

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
	;====================================
	; Intro
	;====================================
	;====================================

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

	; draw cloud

	lda	CLOUD_X
	sta	XPOS
	lda	#4
	sta	YPOS

	lda	#<cloud_sprite
	sta	INL
	lda	#>cloud_sprite
	sta	INH

	jsr	put_sprite_crop

	; draw mountain top back over cloud

	lda	#13
	sta	XPOS
	lda	#4
	sta	YPOS

	lda	#<mountain_top_sprite
	sta	INL
	lda	#>mountain_top_sprite
	sta	INH

	jsr	put_sprite_crop


	; copy title overlay
	lda	CREDITS_LOGO_ON
	beq	dont_overlay

	jsr	gr_overlay_40x40_noload
dont_overlay:

	;=======================
	; draw text if enabled

	lda	CREDITS_DISPLAY_TEXT
	beq	dont_text

	jsr	clear_bottom
	lda	CREDITS_TEXTL
	sta	OUTL
	lda	CREDITS_TEXTH
	sta	OUTH
	jsr	move_and_print
	jsr	move_and_print
	jsr	move_and_print

dont_text:

	;===========
	; page flip

	jsr	page_flip

	jsr	inc_frame

	;=========================
	; update credits sequence
	;=========================

	jsr	update_credit_sequence

	;============================
	; early escape if end of song

	lda	DONE_PLAYING
	bmi	done_with_title

	;===========================
	; early escape if keypressed
	lda	KEYPRESS
	bpl	loop_again

	jmp	done_with_title

loop_again:

	; delay
	lda	#200
	jsr	WAIT

	lda	FRAMEL
	and	#$7
	bne	dont_move_cloud

	dec	CLOUD_X
dont_move_cloud:

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
	.include	"gr_overlay.s"
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

mountain_top_sprite:
.byte	11,6
.byte	$AA,$AA,$AA,$AA,$8A,$98,$8A,$AA,$AA,$AA,$AA
.byte	$AA,$AA,$2A,$20,$25,$2d,$25,$70,$2A,$AA,$AA
.byte	$AA,$AA,$22,$00,$00,$00,$27,$70,$22,$22,$AA
.byte	$AA,$AA,$22,$20,$00,$00,$22,$00,$77,$22,$AA
.byte	$AA,$2A,$22,$22,$00,$00,$22,$07,$70,$00,$AA
.byte	$2A,$22,$00,$22,$00,$22,$02,$22,$07,$70,$0A

; FRAMEH, FRAMEL, ACTION
ACTION_SPLIT_SCREEN	=	$80
ACTION_FULL_SCREEN	=	$81
ACTION_TURN_ON_LOGO	=	$82
ACTION_TURN_OFF_LOGO	=	$83

; 1 E0 is roughly end
credits_sequence:
.byte	$00,$6F,ACTION_SPLIT_SCREEN
.byte	$00,$70,1
.byte	$00,$80,2
.byte	$00,$A0,ACTION_FULL_SCREEN
.byte	$00,$B0,0
.byte	$00,$B6,ACTION_TURN_ON_LOGO
.byte	$00,$B7,ACTION_SPLIT_SCREEN

.byte	$00,$B8,3
.byte	$00,$C8,0

.byte	$00,$D0,4
.byte	$00,$E0,0

.byte	$00,$E8,5
.byte	$00,$F8,0

.byte	$01,$00,6
.byte	$01,$10,0

.byte	$01,$18,7
.byte	$01,$28,0

.byte	$01,$30,8
.byte	$01,$40,0

.byte	$01,$48,9
.byte	$01,$58,0

.byte	$01,$60,10
.byte	$01,$70,0

.byte	$01,$78,11
.byte	$01,$88,0

.byte	$01,$90,12
.byte	$01,$A0,0

.byte	$01,$A8,ACTION_FULL_SCREEN

.byte	$01,$B0,ACTION_TURN_OFF_LOGO

.byte	$ff


credits_text:
.word	credits_nothing
.word	credits1,credits2,credits3,credits4
.word	credits5,credits6,credits7,credits8
.word	credits9,credits10,credits11,credits12


credits1:     ;0123456789012345678901234567890123456789
.byte	10,21,"DEEP IN THE CARIBBEAN",0
.byte	10,22," ",0
.byte	10,23," ",0

credits2:
.byte	10,20,"               ^ ,",0
.byte	10,21,"THE ISLAND OF MELEE",0
.byte	10,22," ",0

; TITLE CARD APPEARS
credits3:
.byte	10,20," ",0
.byte	 7,21,"TM & (C) 1990 LUCAS ARTS",0
.byte	10,22,"ALL RIGHTS RESERVED",0

credits4:
.byte	10,20," ",0
.byte	 9,21,"CREATED AND DESIGNED BY",0
.byte	15,22,"RON GILBERT",0

credits5:
.byte	 7,21,"WRITTEN AND PROGRAMMED BY",0
.byte	 7,22,"RON GILBERT, DAVE GROSSMAN",0
.byte	12,23,"AND TIM SCHAFER",0

credits6:
.byte	11,21,"BACKGROUND ART BY",0
.byte	 6,22,"STEVE PURCELL, MARK FERRARI",0
.byte	13,23,"AND MIKE EBERT",0

credits7:
.byte	14,21,"ANIMATION BY",0
.byte	 7,22,"STEVE PURCELL, MIKE EBERT",0
.byte	 5,23,"AND MARTIN CAMERON AS 'BUCKY'",0

credits8:
.byte	10,20," ",0
.byte	11,21,"ORIGINAL MUSIC BY",0
.byte	13,22,"MICHAEL LAND",0

credits9:
.byte	10,20," ",0
.byte	 6,21,"BARNEY JONES AND ANDY NEWELL",0
.byte	 8,22,"OF EARWAX PRODUCTIONS...",0

credits10:
.byte	10,20," ",0
.byte	16,21,"... AND",0
.byte	13,22,"PATRICK MUNDY",0

; TESTERS, PRODUCER, SCUMM

credits11:
.byte	10,20," ",0
.byte	11,21,"APPLE II VERSION",0
.byte	 9,22,"VINCE 'DEATER' WEAVER",0

credits12:
.byte	10,20," ",0
.byte	10,21,"CPC AY-3-8910 THEME",0
.byte	 9,22,"EPYTEOR/SUTEKH/STARKOS",0

credits_nothing:
.byte	10,20," ",0
.byte	10,21," ",0
.byte	10,22," ",0


	;=========================
	; update credits sequence
	;=========================
update_credit_sequence:

	ldy	CREDITS_OFFSET
	cpy	#$ff
	beq	done_credit_sequence

	; see if we've hit FRAMEH
	lda	credits_sequence,Y
	cmp	FRAMEH
	bne	done_credit_sequence

	lda	credits_sequence+1,Y
	cmp	FRAMEL
	bne	done_credit_sequence

	; made it this far, we actually need to update!
	lda	credits_sequence+2,Y
	iny
	iny
	iny
	sty	CREDITS_OFFSET

	cmp	#ACTION_SPLIT_SCREEN
	beq	do_split_screen
	cmp	#ACTION_FULL_SCREEN
	beq	do_full_screen
	cmp	#ACTION_TURN_ON_LOGO
	beq	do_turn_on_logo
	cmp	#ACTION_TURN_OFF_LOGO
	beq	do_turn_off_logo
	bne	do_update_text

done_credit_sequence:
	rts

do_split_screen:
	bit	TEXTGR

	lda	#1
	sta	CREDITS_DISPLAY_TEXT
	lda	#<credits_nothing
	sta	CREDITS_TEXTL
	lda	#>credits_nothing
	sta	CREDITS_TEXTH

	rts

do_full_screen:
	lda	#0
	sta	CREDITS_DISPLAY_TEXT
	bit	FULLGR
	rts

do_turn_on_logo:
	lda	#1
	sta	CREDITS_LOGO_ON
	rts

do_turn_off_logo:
	lda	#0
	sta	CREDITS_LOGO_ON
	rts

do_update_text:
	; A has string offset

	asl
	tay
	lda	credits_text,Y
	sta	CREDITS_TEXTL
	lda	credits_text+1,Y
	sta	CREDITS_TEXTH

	rts


