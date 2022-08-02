; o/~ It's the Title Screen, Yes it's the Title Screen o/~

; by Vince `deater` Weaver	vince@deater.net

.include "hardware.inc"
.include "zp.inc"

.include "qload.inc"
.include "music.inc"

title:
	jsr	hgr2				; clear screen, HGR page 2

	;=========================
	; set up hgr lookup tables
	;=========================

	jsr	hgr_make_tables			; necessary?


	;=========================
	;=========================
	; Title
	;=========================
	;=========================

do_title:

	lda	#0
	sta	FRAME

	;================================
	; load regular title image to $40

	lda	#<(title_trogfree_zx02)
	sta	zx_src_l+1
	lda	#>(title_trogfree_zx02)
	sta	zx_src_h+1

	lda	#$40

;	jsr	decompress_lzsa2_fast
	jsr	zx02_full_decomp


	;=================================
	; load trogdor title image to $20

	lda	#<(title_zx02)
	sta	zx_src_l+1
	lda	#>(title_zx02)
	sta	zx_src_h+1

	lda	#$20

;	jsr	decompress_lzsa2_fast
	jsr	zx02_full_decomp

	bit	KEYRESET


	lda	SOUND_STATUS
	and	#SOUND_MOCKINGBOARD
	beq	mockingboard_notfound

	jsr	mockingboard_loop
	jmp	title_loop_done

mockingboard_notfound:

	jsr	duet_loop

title_loop_done:


	;************************
	; Tips
	;************************

	jsr	directions


	lda	#LOAD_INTRO
	sta	WHICH_LOAD


	rts





	;=====================
	;=====================
	; mockingboard loop
	;=====================
	;=====================

mockingboard_loop:

	;===================================
	; Setup Mockingboard
	;===================================

PT3_ENABLE_APPLE_IIC = 1

	;==================================
	; load music into the language card
	;	into $D000 set 2
	;==================================

	; switch in language card
	; read/write RAM, $d000 bank 2

	lda	$C083
	lda	$C083

;	lda	$C081		; enable ROM
;	lda	$C081		; enable write

	; actually load it
	lda	#LOAD_MUSIC
	sta	WHICH_LOAD

	jsr	load_file

	lda	#0
	sta	DONE_PLAYING

	lda	#1
	sta	LOOP

	jsr     mockingboard_patch      ; patch to work in slots other than 4?

	;=======================
	; Set up 50Hz interrupt
	;========================

	jsr     mockingboard_init
	jsr     mockingboard_setup_interrupt


zurg:

	;============================
	; Init the Mockingboard
	;============================

	jsr     reset_ay_both
	jsr     clear_ay_both

	;==================
	; init song
	;==================

	jsr	pt3_init_song



	;=======================
	; start music
	;=======================

	cli


	; we're supposed to animate flame, flash the "CLICK ANYWHERE" sign
	; and show trogdor when his music plays

reset_altfire:
	lda	#50
	sta	ALTFIRE				; start on yy=50 on screen

	lda	#<altfire_sprite		; point to alternate fire
	sta	alt_smc1+1			; sprite in memory
	sta	alt_smc2+1

	lda	#>altfire_sprite
	sta	alt_smc1+2
	sta	alt_smc2+2

title_loop:

	lda	C_VOLUME	; see if volume on trogdor channel
	beq	no_trog

	bit	PAGE1		; if it did, flip page to trogdor
	jmp	done_trog

no_trog:
	bit	PAGE2		; otherwise stay at regular

done_trog:

				; work on flame
	lda	FRAME		; skip most of time
	and	#$3f
	bne	altfire_good

	; do altfire loop

	ldx	ALTFIRE		; point (GBASL) to current line to copy
	lda	hposn_high,X
	sta	GBASH
	lda	hposn_low,X
	sta	GBASL

	ldy	#34		; xx=34*7
inner_altfire:

	; swap sprite data with screen data

	lda	(GBASL),Y	; get pixels from screen
	pha			; save for later
alt_smc1:
	lda	$d000		; get pixels from sprite
	sta	(GBASL),Y	; store to screen
	pla			; restore saved pixels
alt_smc2:
	sta	$d000		; store to pixel area

	inc	alt_smc1+1	; increment the sprite pointers
	inc	alt_smc2+1
	bne	alt_noflo

	inc	alt_smc1+2	; handle 16-bit if overflowed
	inc	alt_smc2+2

alt_noflo:
	iny
	cpy	#40		; continue to xx=(40*7)
	bne	inner_altfire


	inc	ALTFIRE
	lda	ALTFIRE
	cmp	#135		; continue until yy=135
	beq	reset_altfire

altfire_good:

	inc	FRAME

	lda	KEYPRESS				; 4
	bpl	title_loop				; 3

	;==========================
	; key was pressed, exit

	bit	KEYRESET		; clear the keyboard buffer

	bit	PAGE2			; return to viewing PAGE2


	;==============
	; disable music

	sei	; disable music

	jsr	clear_ay_both

	rts




	;=====================
	;=====================
	; Electric Duet Loop
	;=====================
	;=====================

duet_loop:


	lda	#<peasant_ed
	sta	MADDRL
	lda	#>peasant_ed
	sta	MADDRH

duet_loop_again:
	jsr	play_ed

	lda	#1
	sta	peasant_ed+24
	lda	#0
	sta	peasant_ed+25
	sta	peasant_ed+26


	lda	#<(peasant_ed+24)
	sta	MADDRL
	lda	#>(peasant_ed+24)
	sta	MADDRH

	lda	duet_done
	beq	duet_loop_again

duet_finished:
	bit	KEYRESET

	rts



;.include "decompress_fast_v2.s"
;.include "wait_keypress.s"

.include "directions.s"

;.include "hgr_font.s"
;.include "hgr_tables.s"
;.include "hgr_hgr2.s"

.include "duet.s"

peasant_ed:
.incbin "music/peasant.ed"

.include "pt3_lib_mockingboard_patch.s"

.include "graphics_title/title_graphics.inc"

altfire:
.include "graphics_title/altfire.inc"
