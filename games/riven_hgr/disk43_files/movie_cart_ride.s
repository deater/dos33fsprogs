; Lo-res movie player of sorts

; This is for the minecart ride, to book binding island

; by deater (Vince Weaver) <vince@deater.net>

.include "../zp.inc"
.include "../hardware.inc"
.include "../qload.inc"

NUM_SCENES	=	2

overlays	=	$2000

	;===================
	; notes for movie_maglev_ride
	;	103..109 = overlay animation
	;	110..112 = sit there
	;	113..270 = fun animation	157! = 30k???
	;	271..285 = handle rotate
	;	286..306 = sit there


	; timing, want whole thing to finish in 200ms or so
	;
	; decompressing:
	;	ade2 = 44,514 cycles
	; do_overlay:
	;	9c78 = 40,056 cycles

movie_cart_ride_start:


	;===================
	; Setup graphics
	;===================

	lda	#0
	sta	DRAW_PAGE
	jsr	clear_gr_all

	bit	SET_GR
	bit	LORES
	bit	FULLGR
	bit	PAGE1

	lda	#0
	sta	SCENE_COUNT

	lda	#4
	sta	DRAW_PAGE

	bit	KEYRESET

	;===============================
	;===============================
	; set up graphics
	;===============================
	;===============================

	;=============================
	; load overlay mask to $c00
	;=============================

	lda	#<overlay_mask_zx02
	sta	ZX0_src
	lda	#>overlay_mask_zx02
        sta	ZX0_src+1

	lda	#$0c

	jsr	full_decomp


	;=============================
	; load overlays to $2000-$2FFF
	;=============================

	lda	#<overlays_combined_zx02
	sta	ZX0_src
	lda	#>overlays_combined_zx02
        sta	ZX0_src+1

	lda	#$20

	jsr	full_decomp

	;===============================
	;===============================
	; initial screen
	;===============================
	;===============================

	lda	#0
	sta	WHICH_OVERLAY

	jsr	draw_scene

	jsr	flip_pages

	;===============================
	; wait 2 frames (400ms)

	; needed?
	; could overlay with sound effect or decompress of overlay?

	ldx	#8
	jsr	wait_50xms

	;===============================
	;===============================
	; move the handle
	;===============================
	;===============================

	lda	#0
	sta	WHICH_OVERLAY

move_handle_loop:

	jsr	draw_scene

	jsr	flip_pages

	inc	WHICH_OVERLAY
	lda	WHICH_OVERLAY
	cmp	#7
	beq	done_move_handle

overlay_good:

	ldx	#2
	jsr	wait_50xms

	jmp	move_handle_loop


done_move_handle:
	lda	#6			; point to last one
	sta	WHICH_OVERLAY

	;===============================
	; wait 4 frames (800ms)

	ldx	#16
	jsr	wait_50xms


	;===============================
	;===============================
	; play the movie
	;===============================
	;===============================

	lda	#1
	sta	SCENE_COUNT

movie2_loop:

	jsr	draw_scene

	jsr	flip_pages

	inc	SCENE_COUNT
	lda	SCENE_COUNT
	cmp	#NUM_SCENES
	beq	done_play_movie2

	ldx	#2
	jsr	wait_50xms

	jmp	movie2_loop


done_play_movie2:

	; TODO: complex handle movement at end

	;===============================
	; wait 9 frames (1.8s?)

	ldx	#36
	jsr	wait_50xms


	;================================
	; indicate level over and return

	lda	#$00
	sta	DRAW_PAGE
	bit	PAGE1

	lda	#$E0|$01	; go to disk50
	sta	LEVEL_OVER
	rts


	;===============================
	;===============================
	; draw_scene
	;===============================
	;===============================

draw_scene:


	;===============================
	; decompress background
	;===============================

before:
	ldx	SCENE_COUNT

	lda	frames_l,X
	sta	ZX0_src
	lda	frames_h,X
        sta	ZX0_src+1

	clc
	lda	DRAW_PAGE
	adc	#$4

	jsr	full_decomp
after:

;	jmp	do_overlay

	; fallthrough


	;===============================
	; do overlay
	;===============================
	;	INL/H   = overlay
	;	MASKL/H = mask
	;	OUTL/H  = gr location
do_overlay:
	lda	DRAW_PAGE
	clc
	adc	#$4
	sta	OUTH

	lda	WHICH_OVERLAY
	asl
	asl
	clc
	adc	#$20
	sta	INH

	lda	#$c
	sta	MASKH

	lda	#0
	sta	OUTL
	sta	INL
	sta	MASKL

do_overlay_outer:

	ldy	#0
do_overlay_inner:

overlayin_smc:
	lda	(INL),Y
	and	(MASKL),Y
	sta	TEMP

	lda	(MASKL),Y
	eor	#$ff
	and	(OUTL),Y
	ora	TEMP
	sta	(OUTL),Y

skip_write:
	dey
	bne	do_overlay_inner


	inc	OUTH
	inc	INH
	inc	MASKH
	lda	MASKH
	cmp	#$10
	bne	do_overlay_inner

	rts


	.include "../flip_pages.s"

;===================================


	.include	"movie_cart_ride/movie_cart_ride.inc"

frames_l:
	.byte	<img096_bg_zx02
	.byte	<img114_bg_zx02
.if 0
	.byte	<img115_bg_zx02
	.byte	<img116_bg_zx02
	.byte	<img117_bg_zx02
	.byte	<img118_bg_zx02
	.byte	<img119_bg_zx02
	.byte	<img120_bg_zx02
	.byte	<img121_bg_zx02
	.byte	<img122_bg_zx02
	.byte	<img123_bg_zx02
	.byte	<img124_bg_zx02
	.byte	<img125_bg_zx02
	.byte	<img126_bg_zx02
	.byte	<img127_bg_zx02
	.byte	<img128_bg_zx02
	.byte	<img129_bg_zx02
	.byte	<img130_bg_zx02
	.byte	<img131_bg_zx02
	.byte	<img132_bg_zx02
	.byte	<img133_bg_zx02
	.byte	<img134_bg_zx02
	.byte	<img135_bg_zx02
	.byte	<img136_bg_zx02
	.byte	<img137_bg_zx02
	.byte	<img138_bg_zx02
	.byte	<img139_bg_zx02
	.byte	<img140_bg_zx02
	.byte	<img141_bg_zx02
	.byte	<img142_bg_zx02
	.byte	<img143_bg_zx02
	.byte	<img144_bg_zx02
	.byte	<img145_bg_zx02
	.byte	<img146_bg_zx02
	.byte	<img147_bg_zx02
	.byte	<img148_bg_zx02
	.byte	<img149_bg_zx02
	.byte	<img150_bg_zx02
	.byte	<img151_bg_zx02
	.byte	<img152_bg_zx02
	.byte	<img153_bg_zx02
	.byte	<img154_bg_zx02
	.byte	<img155_bg_zx02
	.byte	<img156_bg_zx02
	.byte	<img157_bg_zx02
	.byte	<img158_bg_zx02
	.byte	<img159_bg_zx02
	.byte	<img160_bg_zx02
	.byte	<img161_bg_zx02
	.byte	<img162_bg_zx02
	.byte	<img163_bg_zx02
	.byte	<img164_bg_zx02
	.byte	<img165_bg_zx02
	.byte	<img166_bg_zx02
	.byte	<img167_bg_zx02
	.byte	<img168_bg_zx02
	.byte	<img169_bg_zx02
	.byte	<img170_bg_zx02
	.byte	<img171_bg_zx02
	.byte	<img172_bg_zx02
	.byte	<img173_bg_zx02
	.byte	<img174_bg_zx02
	.byte	<img175_bg_zx02
	.byte	<img176_bg_zx02
	.byte	<img177_bg_zx02
	.byte	<img178_bg_zx02
	.byte	<img179_bg_zx02
	.byte	<img180_bg_zx02
	.byte	<img181_bg_zx02
	.byte	<img182_bg_zx02
	.byte	<img183_bg_zx02
	.byte	<img184_bg_zx02
	.byte	<img185_bg_zx02
	.byte	<img186_bg_zx02
	.byte	<img187_bg_zx02
	.byte	<img188_bg_zx02
	.byte	<img189_bg_zx02
	.byte	<img190_bg_zx02
	.byte	<img191_bg_zx02
	.byte	<img192_bg_zx02
	.byte	<img193_bg_zx02
	.byte	<img194_bg_zx02
	.byte	<img195_bg_zx02
	.byte	<img196_bg_zx02
	.byte	<img197_bg_zx02
	.byte	<img198_bg_zx02
	.byte	<img199_bg_zx02
	.byte	<img200_bg_zx02
	.byte	<img201_bg_zx02
	.byte	<img202_bg_zx02
	.byte	<img203_bg_zx02
	.byte	<img204_bg_zx02
	.byte	<img205_bg_zx02
	.byte	<img206_bg_zx02
	.byte	<img207_bg_zx02
	.byte	<img208_bg_zx02
	.byte	<img209_bg_zx02
	.byte	<img210_bg_zx02
	.byte	<img211_bg_zx02
	.byte	<img212_bg_zx02
	.byte	<img213_bg_zx02
	.byte	<img214_bg_zx02
	.byte	<img215_bg_zx02
	.byte	<img216_bg_zx02
	.byte	<img217_bg_zx02
	.byte	<img218_bg_zx02
	.byte	<img219_bg_zx02
	.byte	<img220_bg_zx02
	.byte	<img221_bg_zx02
	.byte	<img222_bg_zx02
	.byte	<img223_bg_zx02
	.byte	<img224_bg_zx02
	.byte	<img225_bg_zx02
	.byte	<img226_bg_zx02
	.byte	<img227_bg_zx02
	.byte	<img228_bg_zx02
	.byte	<img229_bg_zx02
	.byte	<img230_bg_zx02
	.byte	<img231_bg_zx02
	.byte	<img232_bg_zx02
	.byte	<img233_bg_zx02
	.byte	<img234_bg_zx02
	.byte	<img235_bg_zx02
	.byte	<img236_bg_zx02
	.byte	<img237_bg_zx02
	.byte	<img238_bg_zx02
	.byte	<img239_bg_zx02
	.byte	<img240_bg_zx02
	.byte	<img241_bg_zx02
	.byte	<img242_bg_zx02
	.byte	<img243_bg_zx02
	.byte	<img244_bg_zx02
	.byte	<img245_bg_zx02
	.byte	<img246_bg_zx02
	.byte	<img247_bg_zx02
	.byte	<img248_bg_zx02
	.byte	<img249_bg_zx02
.endif


frames_h:
	.byte	>img096_bg_zx02
	.byte	>img114_bg_zx02
.if 0
	.byte	>img115_bg_zx02
	.byte	>img116_bg_zx02
	.byte	>img117_bg_zx02
	.byte	>img118_bg_zx02
	.byte	>img119_bg_zx02
	.byte	>img120_bg_zx02
	.byte	>img121_bg_zx02
	.byte	>img122_bg_zx02
	.byte	>img123_bg_zx02
	.byte	>img124_bg_zx02
	.byte	>img125_bg_zx02
	.byte	>img126_bg_zx02
	.byte	>img127_bg_zx02
	.byte	>img128_bg_zx02
	.byte	>img129_bg_zx02
	.byte	>img130_bg_zx02
	.byte	>img131_bg_zx02
	.byte	>img132_bg_zx02
	.byte	>img133_bg_zx02
	.byte	>img134_bg_zx02
	.byte	>img135_bg_zx02
	.byte	>img136_bg_zx02
	.byte	>img137_bg_zx02
	.byte	>img138_bg_zx02
	.byte	>img139_bg_zx02
	.byte	>img140_bg_zx02
	.byte	>img141_bg_zx02
	.byte	>img142_bg_zx02
	.byte	>img143_bg_zx02
	.byte	>img144_bg_zx02
	.byte	>img145_bg_zx02
	.byte	>img146_bg_zx02
	.byte	>img147_bg_zx02
	.byte	>img148_bg_zx02
	.byte	>img149_bg_zx02
	.byte	>img150_bg_zx02
	.byte	>img151_bg_zx02
	.byte	>img152_bg_zx02
	.byte	>img153_bg_zx02
	.byte	>img154_bg_zx02
	.byte	>img155_bg_zx02
	.byte	>img156_bg_zx02
	.byte	>img157_bg_zx02
	.byte	>img158_bg_zx02
	.byte	>img159_bg_zx02
	.byte	>img160_bg_zx02
	.byte	>img161_bg_zx02
	.byte	>img162_bg_zx02
	.byte	>img163_bg_zx02
	.byte	>img164_bg_zx02
	.byte	>img165_bg_zx02
	.byte	>img166_bg_zx02
	.byte	>img167_bg_zx02
	.byte	>img168_bg_zx02
	.byte	>img169_bg_zx02
	.byte	>img170_bg_zx02
	.byte	>img171_bg_zx02
	.byte	>img172_bg_zx02
	.byte	>img173_bg_zx02
	.byte	>img174_bg_zx02
	.byte	>img175_bg_zx02
	.byte	>img176_bg_zx02
	.byte	>img177_bg_zx02
	.byte	>img178_bg_zx02
	.byte	>img179_bg_zx02
	.byte	>img180_bg_zx02
	.byte	>img181_bg_zx02
	.byte	>img182_bg_zx02
	.byte	>img183_bg_zx02
	.byte	>img184_bg_zx02
	.byte	>img185_bg_zx02
	.byte	>img186_bg_zx02
	.byte	>img187_bg_zx02
	.byte	>img188_bg_zx02
	.byte	>img189_bg_zx02
	.byte	>img190_bg_zx02
	.byte	>img191_bg_zx02
	.byte	>img192_bg_zx02
	.byte	>img193_bg_zx02
	.byte	>img194_bg_zx02
	.byte	>img195_bg_zx02
	.byte	>img196_bg_zx02
	.byte	>img197_bg_zx02
	.byte	>img198_bg_zx02
	.byte	>img199_bg_zx02
	.byte	>img200_bg_zx02
	.byte	>img201_bg_zx02
	.byte	>img202_bg_zx02
	.byte	>img203_bg_zx02
	.byte	>img204_bg_zx02
	.byte	>img205_bg_zx02
	.byte	>img206_bg_zx02
	.byte	>img207_bg_zx02
	.byte	>img208_bg_zx02
	.byte	>img209_bg_zx02
	.byte	>img210_bg_zx02
	.byte	>img211_bg_zx02
	.byte	>img212_bg_zx02
	.byte	>img213_bg_zx02
	.byte	>img214_bg_zx02
	.byte	>img215_bg_zx02
	.byte	>img216_bg_zx02
	.byte	>img217_bg_zx02
	.byte	>img218_bg_zx02
	.byte	>img219_bg_zx02
	.byte	>img220_bg_zx02
	.byte	>img221_bg_zx02
	.byte	>img222_bg_zx02
	.byte	>img223_bg_zx02
	.byte	>img224_bg_zx02
	.byte	>img225_bg_zx02
	.byte	>img226_bg_zx02
	.byte	>img227_bg_zx02
	.byte	>img228_bg_zx02
	.byte	>img229_bg_zx02
	.byte	>img230_bg_zx02
	.byte	>img231_bg_zx02
	.byte	>img232_bg_zx02
	.byte	>img233_bg_zx02
	.byte	>img234_bg_zx02
	.byte	>img235_bg_zx02
	.byte	>img236_bg_zx02
	.byte	>img237_bg_zx02
	.byte	>img238_bg_zx02
	.byte	>img239_bg_zx02
	.byte	>img240_bg_zx02
	.byte	>img241_bg_zx02
	.byte	>img242_bg_zx02
	.byte	>img243_bg_zx02
	.byte	>img244_bg_zx02
	.byte	>img245_bg_zx02
	.byte	>img246_bg_zx02
	.byte	>img247_bg_zx02
	.byte	>img248_bg_zx02
	.byte	>img249_bg_zx02
.endif


overlay_mask_zx02:
	.incbin		"../disk39_files/movie_maglev_ride/overlays/maglev_overlay_mask.gr.zx02"

overlays_combined_zx02:
	.incbin		"../disk39_files/movie_maglev_ride/overlays/overlay_combined.zx02"


