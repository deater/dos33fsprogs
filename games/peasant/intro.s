; Videlectrix Intro

; HGR is a pain

; by Vince `deater` Weaver	vince@deater.net

; with apologies to everyone

.include "hardware.inc"

NIBCOUNT	= $09
GBASL		= $26
GBASH		= $27
CURSOR_X	= $62
CURSOR_Y	= $63
HGR_COLOR	= $E4
HGR_PAGE	= $E6
DISP_PAGE	= $F0
DRAW_PAGE	= $F1

P0      = $F1
P1      = $F2
P2      = $F3
P3      = $F4
P4      = $F5
P5      = $F6

INL		= $FC
INH		= $FD
OUTL		= $FE
OUTH		= $FF



hgr_display:
	jsr	HGR2		; Hi-res graphics, no text at bottom
				; Y=0, A=0 after this called
				; HGR_PAGE=$40

	lda	#$40
	sta	DISP_PAGE
	lda	#$20
	sta	DRAW_PAGE

	;************************
	; Intro
	;************************


	; Load logo offscreen at $9000

	lda	#<(videlectrix_lzsa)
	sta	getsrc_smc+1
	lda	#>(videlectrix_lzsa)
	sta	getsrc_smc+2

	lda	#$90

	jsr	decompress_lzsa2_fast

;	jsr	wait_until_keypress


	ldy	#0
animation_loop:

	lda	DRAW_PAGE
	cmp	#$40
	beq	show_page2

show_page1:
	bit	PAGE1
	lda	#$40
	bne	done_page	; bra

show_page2:
	bit	PAGE2
	lda	#$20

done_page:
	sta	DRAW_PAGE
	eor	#$60
	sta	DISP_PAGE


	lda	delays,Y
	bmi	done_loop

	lda	animation_low,Y
	sta	getsrc_smc+1
	lda	animation_high,Y
	sta	getsrc_smc+2

	tya
	pha

	lda	DRAW_PAGE

	jsr	decompress_lzsa2_fast

	jsr	hgr_overlay

	pla
	tay

	iny

	jmp	animation_loop

done_loop:

	jsr	wait_until_keypress

	rts

;forever:
;	jmp	forever

animation_low:
	.byte	<title_anim01_lzsa
	.byte	<title_anim02_lzsa
	.byte	<title_anim03_lzsa
	.byte	<title_anim04_lzsa
	.byte	<title_anim05_lzsa
	.byte	<title_anim06_lzsa
	.byte	<title_anim07_lzsa
	.byte	<title_anim08_lzsa
	.byte	<title_anim09_lzsa
	.byte	<title_anim10_lzsa
	.byte	<title_anim11_lzsa
	.byte	<title_anim12_lzsa
	.byte	<title_anim13_lzsa
	.byte	<title_anim14_lzsa
	.byte	<title_anim15_lzsa
	.byte	<title_anim16_lzsa
	.byte	<title_anim17_lzsa
	.byte	<title_anim18_lzsa
	.byte	<title_anim19_lzsa
	.byte	<title_anim20_lzsa
	.byte	<title_anim21_lzsa
	.byte	<title_anim22_lzsa
	.byte	<title_anim23_lzsa
	.byte	<title_anim24_lzsa
	.byte	<title_anim25_lzsa
	.byte	<title_anim26_lzsa
	.byte	<title_anim27_lzsa
	.byte	<title_anim28_lzsa
	.byte	<title_anim29_lzsa
	.byte	<title_anim30_lzsa
	.byte	<title_anim31_lzsa
	.byte	<title_anim32_lzsa
	.byte	<title_anim33_lzsa
	.byte	<title_anim34_lzsa

animation_high:
	.byte	>title_anim01_lzsa
	.byte	>title_anim02_lzsa
	.byte	>title_anim03_lzsa
	.byte	>title_anim04_lzsa
	.byte	>title_anim05_lzsa
	.byte	>title_anim06_lzsa
	.byte	>title_anim07_lzsa
	.byte	>title_anim08_lzsa
	.byte	>title_anim09_lzsa
	.byte	>title_anim10_lzsa
	.byte	>title_anim11_lzsa
	.byte	>title_anim12_lzsa
	.byte	>title_anim13_lzsa
	.byte	>title_anim14_lzsa
	.byte	>title_anim15_lzsa
	.byte	>title_anim16_lzsa
	.byte	>title_anim17_lzsa
	.byte	>title_anim18_lzsa
	.byte	>title_anim19_lzsa
	.byte	>title_anim20_lzsa
	.byte	>title_anim21_lzsa
	.byte	>title_anim22_lzsa
	.byte	>title_anim23_lzsa
	.byte	>title_anim24_lzsa
	.byte	>title_anim25_lzsa
	.byte	>title_anim26_lzsa
	.byte	>title_anim27_lzsa
	.byte	>title_anim28_lzsa
	.byte	>title_anim29_lzsa
	.byte	>title_anim30_lzsa
	.byte	>title_anim31_lzsa
	.byte	>title_anim32_lzsa
	.byte	>title_anim33_lzsa
	.byte	>title_anim34_lzsa

delays:
	.byte	1	; 1
	.byte	1	; 2
	.byte	1	; 3
	.byte	1	; 4
	.byte	1	; 5
	.byte	1	; 6
	.byte	1	; 7
	.byte	1	; 8
	.byte	1	; 9
	.byte	1	; 10
	.byte	1	; 11
	.byte	1	; 12
	.byte	1	; 13
	.byte	1	; 14
	.byte	1	; 15
	.byte	1	; 16
	.byte	1	; 17
	.byte	1	; 18
	.byte	1	; 19
	.byte	1	; 20
	.byte	1	; 21
	.byte	1	; 22
	.byte	1	; 23
	.byte	1	; 24
	.byte	1	; 25
	.byte	1	; 26
	.byte	1	; 27
	.byte	1	; 28
	.byte	1	; 29
	.byte	1	; 30
	.byte	1	; 31
	.byte	1	; 32
	.byte	1	; 33
	.byte	1	; 34
	.byte	$FF



.include "decompress_fast_v2.s"
;.include "decompress_overlay.s"
.include "hgr_overlay.s"

.include "wait_keypress.s"

.include "graphics_intro/intro_graphics.inc"
