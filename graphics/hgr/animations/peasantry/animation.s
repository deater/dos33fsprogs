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
	sta	NEXT_LYRIC

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
	; Burninating Background
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
	; Lake East graphics
	;=============================================
	;=============================================

	;=============================================
	; East Lake Part1
	;=============================================

	ldx	#<graphics_lake_e
	ldy	#>graphics_lake_e
	jsr	reload_graphics

	; lda	#<our_text3

el1_loop:
	jsr	hgr_copy
	jsr	increment_lyrics
	bcs	done_el1_loop
	jsr	hgr_page_flip
	jmp	el1_loop
done_el1_loop:

	;=============================================
	; East Lake Part2
	;=============================================

	ldx	#<graphics_lake_e
	ldy	#>graphics_lake_e
	jsr	reload_graphics

	; lda	#<our_text3

el2_loop:
	jsr	hgr_copy
	jsr	increment_lyrics
	bcs	done_el2_loop
	jsr	hgr_page_flip
	jmp	el2_loop
done_el2_loop:

	;=============================================
	;=============================================
	; First Kerrek1 sequence
	;=============================================
	;=============================================

	;=============================================
	; 1st Kerrek1 Part1
	;=============================================

	ldx	#<graphics_kerrek1
	ldy	#>graphics_kerrek1
	jsr	reload_graphics
	jsr	grey_sky

	; lda	#<our_text5

	lda	#0
	sta	WHICH
	sta	WHICH_RAIN

fkp1_loop:
	inc	FRAME
	jsr	hgr_copy
	jsr	draw_rain
	jsr	increment_lyrics
	bcs	done_fkp1_loop
	jsr	hgr_page_flip
	jmp	fkp1_loop
done_fkp1_loop:

	;=============================================
	; 1st Kerrek Part2
	;=============================================

	ldx	#<graphics_kerrek1
	ldy	#>graphics_kerrek1
	jsr	reload_graphics
	jsr	grey_sky

	; lda	#<our_text6

	lda	#0
	sta	WHICH
	sta	WHICH_RAIN

fkp2_loop:
	inc	FRAME
	jsr	hgr_copy
	jsr	draw_rain
	jsr	increment_lyrics
	bcs	done_fkp2_loop
	jsr	hgr_page_flip
	jmp	fkp2_loop
done_fkp2_loop:

	;=============================================
	; 1st Kerrek Part3
	;=============================================

	ldx	#<graphics_kerrek1
	ldy	#>graphics_kerrek1
	jsr	reload_graphics
	jsr	grey_sky

	; lda	#<our_text7

	lda	#0
	sta	WHICH
	sta	WHICH_RAIN

fkp3_loop:
	inc	FRAME
	jsr	hgr_copy
	jsr	draw_rain
	jsr	increment_lyrics
	bcs	done_fkp3_loop
	jsr	hgr_page_flip
	jmp	fkp3_loop
done_fkp3_loop:

	;=============================================
	; 1st Kerrek Part4
	;=============================================

	ldx	#<graphics_kerrek1
	ldy	#>graphics_kerrek1
	jsr	reload_graphics
	jsr	grey_sky

	; lda	#<our_text75

	lda	#0
	sta	WHICH
	sta	WHICH_RAIN

fkp4_loop:
	inc	FRAME
	jsr	hgr_copy
	jsr	draw_rain
	jsr	increment_lyrics
	bcs	done_fkp4_loop
	jsr	hgr_page_flip
	jmp	fkp4_loop
done_fkp4_loop:

	;=============================================
	;=============================================
	; Knight sequence
	;=============================================
	;=============================================

	;=============================================
	; Knight Part1
	;=============================================

	ldx	#<graphics_knight
	ldy	#>graphics_knight
	jsr	reload_graphics

	; lda	#<our_text8

kp1_loop:
	inc	FRAME
	jsr	hgr_copy
	jsr	increment_lyrics
	bcs	done_kp1_loop
	jsr	hgr_page_flip
	jmp	kp1_loop
done_kp1_loop:

	;=============================================
	; Knight Part2
	;=============================================

	ldx	#<graphics_knight
	ldy	#>graphics_knight
	jsr	reload_graphics

	; lda	#<our_text9

kp2_loop:
	inc	FRAME
	jsr	hgr_copy
	jsr	increment_lyrics
	bcs	done_kp2_loop
	jsr	hgr_page_flip
	jmp	kp2_loop
done_kp2_loop:

	;=============================================
	;=============================================
	; Second Kerrek1 sequence
	;=============================================
	;=============================================

	;=============================================
	; 2nd Kerrek1 Part1
	;=============================================

	ldx	#<graphics_kerrek1
	ldy	#>graphics_kerrek1
	jsr	reload_graphics
	jsr	grey_sky

	; lda	#<our_text10

	lda	#0
	sta	WHICH
	sta	WHICH_RAIN

skp1_loop:
	inc	FRAME
	jsr	hgr_copy
	jsr	draw_rain
	jsr	increment_lyrics
	bcs	done_skp1_loop
	jsr	hgr_page_flip
	jmp	skp1_loop
done_skp1_loop:

	;=============================================
	; 2nd Kerrek Part2
	;=============================================

	ldx	#<graphics_kerrek1
	ldy	#>graphics_kerrek1
	jsr	reload_graphics
	jsr	grey_sky

	; lda	#<our_text11

	lda	#0
	sta	WHICH
	sta	WHICH_RAIN

skp2_loop:
	inc	FRAME
	jsr	hgr_copy
	jsr	draw_rain
	jsr	increment_lyrics
	bcs	done_skp2_loop
	jsr	hgr_page_flip
	jmp	skp2_loop
done_skp2_loop:


	;=============================================
	; 2nd Kerrek Part3
	;=============================================

	ldx	#<graphics_kerrek1
	ldy	#>graphics_kerrek1
	jsr	reload_graphics
	jsr	grey_sky

	; lda	#<our_text12

	lda	#0
	sta	WHICH
	sta	WHICH_RAIN

skp3_loop:
	inc	FRAME
	jsr	hgr_copy
	jsr	draw_rain
	jsr	increment_lyrics
	bcs	done_skp3_loop
	jsr	hgr_page_flip
	jmp	skp3_loop
done_skp3_loop:

	;=============================================
	; 2nd Kerrek Part4
	;=============================================

	ldx	#<graphics_kerrek1
	ldy	#>graphics_kerrek1
	jsr	reload_graphics
	jsr	grey_sky

	; lda	#<our_text13

	lda	#0
	sta	WHICH
	sta	WHICH_RAIN

skp4_loop:
	inc	FRAME
	jsr	hgr_copy
	jsr	draw_rain
	jsr	increment_lyrics
	bcs	done_skp4_loop
	jsr	hgr_page_flip
	jmp	skp4_loop
done_skp4_loop:

	;=============================================
	;=============================================
	; Cottage sequence
	;=============================================
	;=============================================

	;=============================================
	; Cottage Part1
	;=============================================

	ldx	#<graphics_cottage
	ldy	#>graphics_cottage
	jsr	reload_graphics

	; lda	#<our_text14

cp1_loop:
	inc	FRAME
	jsr	hgr_copy
	jsr	increment_lyrics
	bcs	done_cp1_loop
	jsr	hgr_page_flip
	jmp	cp1_loop
done_cp1_loop:

	;=============================================
	; Cottage Part2
	;=============================================

	ldx	#<graphics_cottage
	ldy	#>graphics_cottage
	jsr	reload_graphics

	; lda	#<our_text15

cp2_loop:
	inc	FRAME
	jsr	hgr_copy
	jsr	increment_lyrics
	bcs	done_cp2_loop
	jsr	hgr_page_flip
	jmp	cp2_loop
done_cp2_loop:

	;=============================================
	; Cottage Part3
	;=============================================

	ldx	#<graphics_cottage
	ldy	#>graphics_cottage
	jsr	reload_graphics

	; lda	#<our_text16

cp3_loop:
	inc	FRAME
	jsr	hgr_copy
	jsr	increment_lyrics
	bcs	done_cp3_loop
	jsr	hgr_page_flip
	jmp	cp3_loop
done_cp3_loop:

	;=============================================
	;=============================================
	; Third Kerrek1 sequence
	;=============================================
	;=============================================

	;=============================================
	; 3rd Kerrek1 Part1
	;=============================================

	ldx	#<graphics_kerrek1
	ldy	#>graphics_kerrek1
	jsr	reload_graphics
	jsr	grey_sky

	; lda	#<our_text17

	lda	#0
	sta	WHICH
	sta	WHICH_RAIN

tkp1_loop:
	inc	FRAME
	jsr	hgr_copy
	jsr	draw_rain
	jsr	increment_lyrics
	bcs	done_tkp1_loop
	jsr	hgr_page_flip
	jmp	tkp1_loop
done_tkp1_loop:

	;=============================================
	; 3rd Kerrek Part2
	;=============================================

	ldx	#<graphics_kerrek1
	ldy	#>graphics_kerrek1
	jsr	reload_graphics
	jsr	grey_sky

	; lda	#<our_text18

	lda	#0
	sta	WHICH
	sta	WHICH_RAIN

tkp2_loop:
	inc	FRAME
	jsr	hgr_copy
	jsr	draw_rain
	jsr	increment_lyrics
	bcs	done_tkp2_loop
	jsr	hgr_page_flip
	jmp	tkp2_loop
done_tkp2_loop:

	;=============================================
	; 3rd Kerrek Part3
	;=============================================

	ldx	#<graphics_kerrek1
	ldy	#>graphics_kerrek1
	jsr	reload_graphics
	jsr	grey_sky

	; lda	#<our_text18

	lda	#0
	sta	WHICH
	sta	WHICH_RAIN

tkp3_loop:
	inc	FRAME
	jsr	hgr_copy
	jsr	draw_rain
	jsr	increment_lyrics
	bcs	done_tkp3_loop
	jsr	hgr_page_flip
	jmp	tkp3_loop
done_tkp3_loop:

blargh:
	jmp	blargh


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
	.byte 1,171,"Burninating",0
	.byte 13,171,"my cot-t-tage",0
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
	.byte $ff

our_text4:
	.byte 1,161,"He turned to me as if to say:",0
	.byte 1,171,34,"Hurry boy",0
	.byte 1,181,"       Trogdor's waiting there for you",34,0
	.byte $ff

;===========================
; 1st kerrek1

our_text5:
	.byte 1,161,"It's going to take a lot",0
	.byte 1,171,"           to keep me away from you",0
	.byte $ff

our_text6:
	.byte 1,161,"That's somethin' a bunch of NPCs",0
	.byte 1,171,"           will try to do",0
	.byte $ff

our_text7:
	.byte 1,161,"I bless the rains down in Peasantry",0
	.byte $ff

our_text75:
	.byte 1,161,"Gonna take some time to solve the",0
	.byte 1,171,"  puzzles in this land,"
	.byte 1,181,"    ooh-hoo",0
	.byte $ff

;============================
; knight

our_text8:
	.byte 1,161,"I hate talking with this knight",0
	.byte 1,171,"As he grows restless from my",0
	.byte 1,181,"            endless questioning",0
	.byte $ff

our_text9:
	.byte 0,161,"I know I must do what's right",0
	.byte 0,171,"Sure as this improbable cliff rises like",0
	.byte 1,181,"    Olympus above the pixelated plain",0
	.byte $ff

;========================
; 2nd kerrek1

our_text10:
	.byte 1,161,"I seek to cure what's deep inside",0
	.byte 1,171,"Frightened of this thing",0
	.byte 1,181,"              that I've become",0
	.byte $ff

our_text11:
	.byte 1,161,"I'm going to climb a mountain",0
	.byte 1,171,"          and cleave you through",0
	.byte $ff

our_text12:
	.byte 0,161,"This disk is over, please insert Side 2",0
	.byte $ff

our_text13:
	.byte 1,161,"I bless the rains down in Peasantry",0
	.byte 1,171,"Gonna take some time to",0
	.byte 1,181,"      get my revenge,",0
	.byte 34,181," ooh-hoo",0
	.byte $ff

;==============
; cottage

our_text14:
	.byte 1,161,"Hurry boy, she's waiting there for you",0
	.byte $ff

our_text15:
	.byte 1,161,"She's gonna take the Jhonka's riches",0
	.byte 1,171,"          away from you",0
	.byte $ff

our_text16:
	.byte 1,161,"Better take good care of that baby,",0
	.byte 1,171,"      what else can you do",0
	.byte $ff

;==================
; 3rd krerek1

our_text17:
	.byte 1,161,"I bless the rains down in Peasantry",0
	.byte 1,171,"I bless the rains down in Peasantry",0
	.byte 1,181,"I bless the rains down in Peasantry",0
	.byte $ff

our_text18:
	.byte 1,161,"I bless the rains down in Peasantry",0
	.byte 1,171,"I bless the rains down in Peasantry",0
	.byte $ff

our_text19:
	.byte 1,161,"     Gonna take some time to make",0
	.byte 1,171,"              Trogdor sad,",0
	.byte 1,181,"               ooh-hoo",0
	.byte $ff


	;==============================
	; increment lyrics
	;==============================
	; OUTL/OUTH points to next lyric
	; NUL terminated
	; ??? means move to next scene

increment_lyrics:

	; first check pattern list

	ldx	NEXT_LYRIC
	lda	pattern_increment,X
	cmp	current_pattern_smc+1
	bne	il_check_keyboard

	lda	pattern_increment+1,X
	cmp	current_line_smc+1
	bcs	il_check_keyboard		; in case we increment too fast

	inc	NEXT_LYRIC
	inc	NEXT_LYRIC

	jmp	il_do_increment

il_check_keyboard:
	lda	KEYPRESS
	bpl	done_increment_lyrics

il_do_increment:
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




pattern_increment:
.byte $02,$0	; "I hear Trogdor coming in the night",0
.byte $03,$10	; "Burninating",0
.byte $03,$38	; "my cot-t-tage",0
.byte $04,$28	; $FF

.byte $05,$00	; "He's askin' me for a fight",0
.byte $06,$08	; "His moonlit wings reflect the stars",0
.byte $06,$28	; "    and brutal carnage",0
.byte $07,$28	; $FF

.byte $08,$00	; "I saw an old man sailing in the bay",0
.byte $09,$10	; "Hopin' to catch some fish",0
.byte $09,$20	; "    but he has no chicken feed",0
.byte $0A,$28	; $ff

.byte $0B,$00	; "He turned to me as if to say:",0
.byte $0C,$10	; "Hurry boy",0
.byte $0C,$18	; "       Trogdor's waiting there for you",34,0
.byte $0D,$28	; $FF

.byte $0E,$00	; "It's going to take a lot",0
.byte $0E,$18	; "           to keep me away from you",0
.byte $0E,$28	; $ff

.byte $0F,$00	; "That's somethin' a bunch of NPCs",0
.byte $0F,$28	; "           will try to do",0
.byte $10,$00	; $ff

.byte $10,$10	; "I bless the rains down in Peasantry",0
.byte $11,$00	; $ff

.byte $11,$08	; "Gonna take some time to solve the",0
.byte $11,$11	; "  puzzles in this land,"
.byte $13,$00	; "    ooh-hoo",0
.byte $15,$20	; $ff

;============================
; knight

.byte $16,$00	; "I hate talking with this knight",0
.byte $17,$08	; "As he grows restless from my",0
.byte $17,$28	; "            endless questioning",0
.byte $19,$00	; $ff

.byte $19,$08	; "I know I must do what's right",0
.byte $1A,$08	; "Sure as this improbable cliff rises like",0
.byte $1A,$28	; "    Olympus above the pixelated plain",0
.byte $1C,$00	; $ff

;========================
; 2nd kerrek1

.byte $1C,$08	; "I seek to cure what's deep inside",0
.byte $1D,$08	; "Frightened of this thing",0
.byte $1E,$08	; "              that I've become",0
.byte $1E,$28	; $ff

.byte $1F,$08	; "I'm going to climb a mountain",0
.byte $1F,$20	; "          and cleave you through",0
.byte $20,$00

.byte $20,$08	; "This disk is over, please insert Side 2",0
.byte $21,$00	; $ff

.byte $21,$08	; "I bless the rains down in Peasantry",0
.byte $21,$38	; "Gonna take some time to",0
.byte $22,$18	; "      get my revenge,",0
.byte $23,$28	; " ooh-hoo",0
.byte $2A,$00	; $ff

;==============
; cottage

.byte $2A,$10	; "Hurry boy, she's waiting there for you",0
.byte $2B,$00	; $ff

.byte $2C,$00	; "She's gonna take the Jhonka's riches",0
.byte $2C,$20	; "          away from you",0
.byte $2D,$00	; $ff

.byte $2D,$08	; "Better take good care of that baby,",0
.byte $2D,$20	; "      what else can you do",0
.byte $2E,$00	; $ff

;==================
; 3rd krerek1

.byte $2E,$08	; "I bless the rains down in Peasantry",0
.byte $2F,$00	; "I bless the rains down in Peasantry",0
.byte $30,$08	; "I bless the rains down in Peasantry",0
.byte $30,$38	; .byte $ff

.byte $31,$08	; "I bless the rains down in Peasantry",0
.byte $32,$08	; "I bless the rains down in Peasantry",0
.byte $33,$00	; .byte $ff

.byte $33,$08	; "     Gonna take some time to make",0
.byte $33,$28	; "        Trogdor sad,"
.byte $34,$08	; " ooh-hoo",0

.byte $ff
