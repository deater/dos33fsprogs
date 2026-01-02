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

	lda	#<graphics_burninated
	sta	zx_src_l+1
	lda	#>graphics_burninated
	sta	zx_src_h+1

	lda	#$A0

	jsr	zx02_full_decomp

	;=============================================
	; Burninate Part1
	;=============================================


	jsr	hgr_copy

	lda	#<our_text1
	sta	OUTL
	lda	#>our_text1
	sta	OUTH

	jsr	hgr_put_string
	jsr	hgr_put_string

	jsr	hgr_page_flip

	jsr	wait_until_keypress

	;=============================================
	; Burninate Part2
	;=============================================


	jsr	hgr_copy

	lda	#<our_text2
	sta	OUTL
	lda	#>our_text2
	sta	OUTH

	jsr	hgr_put_string
	jsr	hgr_put_string
	jsr	hgr_put_string

	jsr	hgr_page_flip

	jsr	wait_until_keypress


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


blargh:
	jmp	blargh


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

	lda	#<graphics_frame1
	sta	zx_src_l+1
	lda	#>graphics_frame1
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


.include "rain.s"

;.include "../patch_graphics.s"
;.include "../change_palette.s"
;.include "../sound_bars.s"

.include "hgr_copy.s"
.include "grey_sky.s"

.include "hgr_sprite_mask.s"
.include "hgr_font.s"

graphics_frame1:
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

our_text2:
	.byte 1,161,"He's askin' me for a fight",0
	.byte 1,171,"His moonlit wings reflect the stars",0
	.byte 1,181,"    and brutal carnage",0


;========================
; lake e

our_text3:          ;0123456789012345678901234567890123456789
	.byte 1,161,"I saw an old man sailing in the bay",0
	.byte 1,171,"Hopin' to catch some cold delicious",0
	.byte 1,181,"  fish or peasant hotel guests",0

our_text4:
	.byte 1,161,"He turned to me as if to say:",0
	.byte 1,171,"Hurry boy",0
	.byte 1,181,"       Trogdor's waiting there for you",0

;===========================
; kerrek1

our_text5:
	.byte 1,161,"It's going to take a lot",0
	.byte 1,171,"to keep me away from you",0

our_text6:
	.byte 1,161,"That's something a bunch of NPCs"
	.byte 1,171,"  will try to do",0

our_text7:
	.byte 1,161,"I bless the rains down in Peasantry",0
	.byte 1,171,"Gonna take some time to solve the",0
	.byte 1,181,"puzzles in this land, ooh-hoo",0

;============================
; knight

our_text8:
	.byte 1,161,"I hate talking with this-here knight",0
	.byte 1,171,"As he grows restless from",0
	.byte 1,181,"     incessant questioning",0

our_text9:
	.byte 1,161,"I know I must do what's right",0
	.byte 1,171,"Sure as this improbable cliff rises",0
	.byte 1,181,"like Olympus above these pixelated plains",0

; kerrek1 again

our_text10:
	.byte 1,161,"I seek to cure what's deep inside",0
	.byte 1,171,"Frightened of this thing that I've become",0

our_text11:
	.byte 1,161,"I'm going to climb a mountain",0
	.byte 1,171,"    and cleave you through",0

our_text12:
	.byte 1,161,"This disk is over, please insert Side 2",0

our_text13:
	.byte 1,161,"I bless the rains down in Peasantry",0
	.byte 1,171,"Gonna take some time to",0
	.byte 1,181,"      get my revenge, ooh-hoo",0

; cottage

our_text14:
	.byte 1,161,"Hurry boy, she's waiting there for you",0

our_text15:
	.byte 1,161,"I think she stole the Jhonka's",0
	.byte 1,171,"          riches away from you",0


our_text16:
	.byte 1,161,"Better take good care of that baby,",0
	.byte 1,171,"what else can you do",0

; krerek1 again

our_text17:
	.byte 1,161,"I bless the rains down in Peasantry",0
	.byte 1,171,"I bless the rains down in Peasantry",0
	.byte 1,181,"I bless the rains down in Peasantry",0

our_text18:
	.byte 1,161,"I bless the rains down in Peasantry",0
	.byte 1,171,"I bless the rains down in Peasantry",0

our_text19:
	.byte 1,161,"Gonna take some time to make",0
	.byte 1,171," Trogdor sad, ooh-hoo",0

