; o/~ It's the Title Screen, Yes it's the Title Screen o/~

; by Vince `deater` Weaver	vince@deater.net

.include "hardware.inc"
.include "zp.inc"

.include "qload.inc"
.include "music.inc"

title:
	jsr	hgr2

	;=========================
	; set up hgr lookup tables
	;=========================

	jsr	hgr_make_tables





	;=========================
	;=========================
	; Title
	;=========================
	;=========================

do_title:

	lda	#0
	sta	FRAME

	;======================
	; load regular to $40

	lda	#<(title_trogfree_lzsa)
	sta	getsrc_smc+1
	lda	#>(title_trogfree_lzsa)
	sta	getsrc_smc+2

	lda	#$40

	jsr	decompress_lzsa2_fast


	;======================
	; load trogdor to $20

	lda	#<(title_lzsa)
	sta	getsrc_smc+1
	lda	#>(title_lzsa)
	sta	getsrc_smc+2

	lda	#$20

	jsr	decompress_lzsa2_fast


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
	sta	ALTFIRE

	lda	#<altfire_sprite
	sta	alt_smc1+1
	sta	alt_smc2+1

	lda	#>altfire_sprite
	sta	alt_smc1+2
	sta	alt_smc2+2

title_loop:

	lda	C_VOLUME	; see if volume on trogdor channel
	beq	no_trog

	bit	PAGE1
	jmp	done_trog

no_trog:
	bit	PAGE2
done_trog:

	lda	FRAME		; skip most of time
	and	#$3f
	bne	altfire_good


	; do altfire loop

	ldx	ALTFIRE
	lda	hposn_high,X
	sta	GBASH
	lda	hposn_low,X
	sta	GBASL

	ldy	#34
inner_altfire:

	lda	(GBASL),Y
	pha
alt_smc1:
	lda	$d000
	sta	(GBASL),Y
	pla
alt_smc2:
	sta	$d000

	inc	alt_smc1+1
	inc	alt_smc2+1
	bne	alt_noflo

	inc	alt_smc1+2
	inc	alt_smc2+2


alt_noflo:
	iny
	cpy	#40
	bne	inner_altfire


	inc	ALTFIRE
	lda	ALTFIRE
	cmp	#135
	beq	reset_altfire

altfire_good:

	inc	FRAME

	lda	KEYPRESS				; 4
	bpl	title_loop				; 3
	bit	KEYRESET	; clear the keyboard buffer


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
