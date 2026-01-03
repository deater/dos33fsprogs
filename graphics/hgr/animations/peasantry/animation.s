.include "zp.inc"
.include "../hardware.inc"
.include "qload.inc"
.include "music.inc"
.include "common_defines.inc"

	;=======================================
	; draw the rain down in peasantry
	;=======================================

peasantry:

	bit	KEYRESET	; just to be safe

	;=================================
	; init vars
	;=================================

	lda	#3
	sta	FRAME_RATE

	lda	#0
	sta	FRAME

	;=================================
	; init graphics
	;=================================

	bit	SET_GR
        bit	HIRES
        bit	FULLGR

        bit	PAGE2		; display page1

	;=======================
	; start music

	lda	SOUND_STATUS
	and	#SOUND_MOCKINGBOARD
	beq	no_music

yes_music:
	cli
no_music:



	;=============================================
	;=============================================
	; Load burninating graphics
	;=============================================
	;=============================================

	lda	#$0
	sta	DRAW_PAGE

	bit	KEYRESET

	;=============================================
	; Burninate Part1
	;=============================================

	lda	#<our_text1
	sta	OUTL
	lda	#>our_text1
	sta	OUTH

	ldx	#<graphics_burninated
	ldy	#>graphics_burninated
	jsr	reload_graphics

bp1_loop:
	jsr	hgr_copy
	jsr	increment_lyrics
	bcs	done_bp1_loop
	jsr	hgr_page_flip
	jmp	bp1_loop
done_bp1_loop:

	;=============================================
	; Burninate Part2
	;=============================================

	ldx	#<graphics_burninated
	ldy	#>graphics_burninated
	jsr	reload_graphics

bp2_loop:
	jsr	hgr_copy
	jsr	increment_lyrics
	bcs	done_bp2_loop
	jsr	hgr_page_flip
	jmp	bp2_loop
done_bp2_loop:


	;=============================================
	;=============================================
	; Load Lake East graphics
	;=============================================
	;=============================================

	lda	#<graphics_lake_e
	sta	zx_src_l+1
	lda	#>graphics_lake_e
	sta	zx_src_h+1

	lda	#$A0

	jsr	zx02_full_decomp

	;=============================================
	; East Lake Part1
	;=============================================


	jsr	hgr_copy

	lda	#<our_text3
	sta	OUTL
	lda	#>our_text3
	sta	OUTH

	jsr	hgr_put_string
	jsr	hgr_put_string
	jsr	hgr_put_string

	jsr	hgr_page_flip

	jsr	wait_until_keypress

	;=============================================
	; East Lake Part2
	;=============================================


	jsr	hgr_copy

	lda	#<our_text4
	sta	OUTL
	lda	#>our_text4
	sta	OUTH

	jsr	hgr_put_string
	jsr	hgr_put_string
	jsr	hgr_put_string

	jsr	hgr_page_flip

	jsr	wait_until_keypress



	;=============================================
	;=============================================
	; First Kerrek1 sequence
	;=============================================
	;=============================================

	lda	#<graphics_kerrek1
	sta	zx_src_l+1
	lda	#>graphics_kerrek1
	sta	zx_src_h+1

	lda	#$A0

	jsr	zx02_full_decomp

	jsr	grey_sky

	;=============================================
	; 1st Kerrek1 Part1
	;=============================================

	lda	#<our_text5
	sta	OUTL
	lda	#>our_text5
	sta	OUTH

	jsr	hgr_put_string
	jsr	hgr_put_string

	lda	#0
	sta	WHICH
	sta	WHICH_RAIN

fkp1_loop:
	inc	FRAME

	jsr	hgr_copy

	jsr	draw_rain

	jsr	hgr_page_flip

	lda	KEYPRESS
	bmi	fkp1_done



	jmp	fkp1_loop

fkp1_done:
	bit	KEYRESET


	;=============================================
	; 1st Kerrek Part2
	;=============================================


	jsr	hgr_copy

	lda	#<our_text6
	sta	OUTL
	lda	#>our_text6
	sta	OUTH

	jsr	hgr_put_string
	jsr	hgr_put_string

	jsr	hgr_page_flip

	jsr	wait_until_keypress


	;=============================================
	; 1st Kerrek Part3
	;=============================================


	jsr	hgr_copy

	lda	#<our_text7
	sta	OUTL
	lda	#>our_text7
	sta	OUTH

	jsr	hgr_put_string

	jsr	hgr_page_flip

	jsr	wait_until_keypress

	;=============================================
	; 1st Kerrek Part4
	;=============================================


	jsr	hgr_copy

	lda	#<our_text75
	sta	OUTL
	lda	#>our_text75
	sta	OUTH

	jsr	hgr_put_string
	jsr	hgr_put_string

	jsr	hgr_page_flip

	jsr	wait_until_keypress




	;=============================================
	;=============================================
	; Knight sequence
	;=============================================
	;=============================================

	lda	#<graphics_knight
	sta	zx_src_l+1
	lda	#>graphics_knight
	sta	zx_src_h+1

	lda	#$A0

	jsr	zx02_full_decomp

	;=============================================
	; Knight Part1
	;=============================================


	jsr	hgr_copy

	lda	#<our_text8
	sta	OUTL
	lda	#>our_text8
	sta	OUTH

	jsr	hgr_put_string
	jsr	hgr_put_string
	jsr	hgr_put_string

	jsr	hgr_page_flip

	jsr	wait_until_keypress

	;=============================================
	; Knight Part2
	;=============================================


	jsr	hgr_copy

	lda	#<our_text9
	sta	OUTL
	lda	#>our_text9
	sta	OUTH

	jsr	hgr_put_string
	jsr	hgr_put_string
	jsr	hgr_put_string

	jsr	hgr_page_flip

	jsr	wait_until_keypress



	;=============================================
	;=============================================
	; Second Kerrek1 sequence
	;=============================================
	;=============================================

	lda	#<graphics_kerrek1
	sta	zx_src_l+1
	lda	#>graphics_kerrek1
	sta	zx_src_h+1

	lda	#$A0

	jsr	zx02_full_decomp

	;=============================================
	; 2nd Kerrek1 Part1
	;=============================================


	jsr	hgr_copy

	lda	#<our_text10
	sta	OUTL
	lda	#>our_text10
	sta	OUTH

	jsr	hgr_put_string
	jsr	hgr_put_string
	jsr	hgr_put_string

	jsr	hgr_page_flip

	jsr	wait_until_keypress

	;=============================================
	; 2nd Kerrek Part2
	;=============================================


	jsr	hgr_copy

	lda	#<our_text11
	sta	OUTL
	lda	#>our_text11
	sta	OUTH

	jsr	hgr_put_string
	jsr	hgr_put_string

	jsr	hgr_page_flip

	jsr	wait_until_keypress


	;=============================================
	; 2nd Kerrek Part3
	;=============================================


	jsr	hgr_copy

	lda	#<our_text12
	sta	OUTL
	lda	#>our_text12
	sta	OUTH

	jsr	hgr_put_string

	jsr	hgr_page_flip

	jsr	wait_until_keypress

	;=============================================
	; 2nd Kerrek Part4
	;=============================================


	jsr	hgr_copy

	lda	#<our_text13
	sta	OUTL
	lda	#>our_text13
	sta	OUTH

	jsr	hgr_put_string
	jsr	hgr_put_string
	jsr	hgr_put_string

	jsr	hgr_page_flip

	jsr	wait_until_keypress




	;=============================================
	;=============================================
	; Cottage sequence
	;=============================================
	;=============================================

	lda	#<graphics_cottage
	sta	zx_src_l+1
	lda	#>graphics_cottage
	sta	zx_src_h+1

	lda	#$A0

	jsr	zx02_full_decomp

	;=============================================
	; Cottage Part1
	;=============================================


	jsr	hgr_copy

	lda	#<our_text14
	sta	OUTL
	lda	#>our_text14
	sta	OUTH

	jsr	hgr_put_string

	jsr	hgr_page_flip

	jsr	wait_until_keypress

	;=============================================
	; Cottage Part2
	;=============================================


	jsr	hgr_copy

	lda	#<our_text15
	sta	OUTL
	lda	#>our_text15
	sta	OUTH

	jsr	hgr_put_string
	jsr	hgr_put_string

	jsr	hgr_page_flip

	jsr	wait_until_keypress


	;=============================================
	; Cottage Part3
	;=============================================

	jsr	hgr_copy

	lda	#<our_text16
	sta	OUTL
	lda	#>our_text16
	sta	OUTH

	jsr	hgr_put_string
	jsr	hgr_put_string

	jsr	hgr_page_flip

	jsr	wait_until_keypress




	;=============================================
	;=============================================
	; Third Kerrek1 sequence
	;=============================================
	;=============================================

	lda	#<graphics_kerrek1
	sta	zx_src_l+1
	lda	#>graphics_kerrek1
	sta	zx_src_h+1

	lda	#$A0

	jsr	zx02_full_decomp

	;=============================================
	; 3rd Kerrek1 Part1
	;=============================================


	jsr	hgr_copy

	lda	#<our_text17
	sta	OUTL
	lda	#>our_text17
	sta	OUTH

	jsr	hgr_put_string
	jsr	hgr_put_string
	jsr	hgr_put_string

	jsr	hgr_page_flip

	jsr	wait_until_keypress

	;=============================================
	; 3rd Kerrek Part2
	;=============================================


	jsr	hgr_copy

	lda	#<our_text18
	sta	OUTL
	lda	#>our_text18
	sta	OUTH

	jsr	hgr_put_string
	jsr	hgr_put_string

	jsr	hgr_page_flip

	jsr	wait_until_keypress


	;=============================================
	; 3rd Kerrek Part3
	;=============================================


	jsr	hgr_copy

	lda	#<our_text19
	sta	OUTL
	lda	#>our_text19
	sta	OUTH

	jsr	hgr_put_string
	jsr	hgr_put_string

	jsr	hgr_page_flip

	jsr	wait_until_keypress



blargh:
	jmp	blargh

.if 0
	;============================
	;============================
	;============================
	; rain scene
	;============================
	;============================
	;============================

	;===========================
	; decompress frame1 to $A000

	lda	#$0
	sta	DRAW_PAGE

	lda	#<graphics_kerrek1
	sta	zx_src_l+1
	lda	#>graphics_kerrek1
	sta	zx_src_h+1

	lda	#$A0

	jsr	zx02_full_decomp

;	jsr	grey_sky


	lda	#0
	sta	DRAW_PAGE
	sta	WHICH
	sta	WHICH_RAIN

animation_loop:

	jsr	hgr_copy

	jsr	draw_rain

	jsr	hgr_page_flip

	;=====================
	; handle keyboard
;wait_loop:
;	lda	KEYPRESS
;	bpl	wait_loop

;	bit	KEYRESET


keep_going:

	inc	WHICH_RAIN
	lda	WHICH_RAIN
	and	#$1
	sta	WHICH_RAIN

	inc	FRAME

	jmp	animation_loop

.endif

.include "rain.s"

;.include "../patch_graphics.s"
;.include "../change_palette.s"
;.include "../sound_bars.s"

.include "hgr_copy.s"
.include "grey_sky.s"

.include "hgr_sprite_mask.s"
.include "hgr_font.s"

graphics_kerrek1:
	.incbin "graphics/kerrek1.hgr.zx02"

graphics_burninated:
	.incbin "graphics/crooked_tree_night.hgr.zx02"

graphics_lake_e:
	.incbin "graphics/lake_e.hgr.zx02"

graphics_knight:
	.incbin "graphics/knight.hgr.zx02"

graphics_cottage:
	.incbin "graphics/inside_cottage.hgr.zx02"


;=======================
; burninated

our_text1:
	.byte 1,161,"I hear Trogdor coming in the night",0
	.byte 1,171,"Burninating my cottage",0
	.byte $FF

our_text2:
	.byte 1,161,"He's askin' me for a fight",0
	.byte 1,171,"His moonlit wings reflect the stars",0
	.byte 1,181,"    and brutal carnage",0
	.byte $FF


;========================
; lake e

our_text3:          ;0123456789012345678901234567890123456789
	.byte 1,161,"I saw an old man sailing in the bay",0
	.byte 1,171,"Hopin' to catch some fish",0
	.byte 1,181,"    but he has no chicken feed",0

our_text4:
	.byte 1,161,"He turned to me as if to say:",0
	.byte 1,171,34,"Hurry boy",0
	.byte 1,181,"       Trogdor's waiting there for you",34,0

;===========================
; 1st kerrek1

our_text5:
	.byte 1,161,"It's going to take a lot",0
	.byte 1,171,"           to keep me away from you",0

our_text6:
	.byte 1,161,"That's somethin' a bunch of NPCs",0
	.byte 1,171,"           will try to do",0

our_text7:
	.byte 1,161,"I bless the rains down in Peasantry",0

our_text75:
	.byte 1,161,"Gonna take some time to solve the",0
	.byte 1,171,"  puzzles in this land, ooh-hoo",0

;============================
; knight

our_text8:
	.byte 1,161,"I hate talking with this blue knight",0
	.byte 1,171,"As he grows restless from my",0
	.byte 1,181,"            endless questioning",0

our_text9:
	.byte 0,161,"I know I must do what's right",0
	.byte 0,171,"Sure as this improbable cliff rises like",0
	.byte 1,181,"    Olympus above the pixelated plain",0

;========================
; 2nd kerrek1

our_text10:
	.byte 1,161,"I seek to cure what's deep inside",0
	.byte 1,171,"Frightened of this thing",0
	.byte 1,181,"              that I've become",0

our_text11:
	.byte 1,161,"I'm going to climb a mountain",0
	.byte 1,171,"          and cleave you through",0

our_text12:
	.byte 0,161,"This disk is over, please insert Side 2",0

our_text13:
	.byte 1,161,"I bless the rains down in Peasantry",0
	.byte 1,171,"Gonna take some time to",0
	.byte 1,181,"      get my revenge, ooh-hoo",0

;==============
; cottage

our_text14:
	.byte 1,161,"Hurry boy, she's waiting there for you",0

our_text15:
	.byte 1,161,"She's gonna take the Jhonka's riches",0
	.byte 1,171,"          away from you",0


our_text16:
	.byte 1,161,"Better take good care of that baby,",0
	.byte 1,171,"      what else can you do",0

;==================
; 3rd krerek1

our_text17:
	.byte 1,161,"I bless the rains down in Peasantry",0
	.byte 1,171,"I bless the rains down in Peasantry",0
	.byte 1,181,"I bless the rains down in Peasantry",0

our_text18:
	.byte 1,161,"I bless the rains down in Peasantry",0
	.byte 1,171,"I bless the rains down in Peasantry",0

our_text19:
	.byte 1,161,"     Gonna take some time to make",0
	.byte 1,171,"        Trogdor sad, ooh-hoo",0



	;==============================
	; increment lyrics
	;==============================
	; OUTL/OUTH points to next lyric
	; NUL terminated
	; ??? means move to next scene

increment_lyrics:
	lda	KEYPRESS
	bpl	done_increment_lyrics

	bit	KEYRESET

	lda	#$0
	sta	SCENE_DONE

	jsr	hgr_put_string

	lda	SCENE_DONE
	bne	really_done_increment_lyrics

done_increment_lyrics:
	clc
	rts

really_done_increment_lyrics:
	sec
	rts

	;=================================
	; reload graphics
	;=================================
reload_graphics:
	stx	zx_src_l+1
	sty	zx_src_h+1
	lda	#$A0
	jmp	zx02_full_decomp

