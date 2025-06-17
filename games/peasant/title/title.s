; o/~ It's the Title Screen, Yes it's the Title Screen o/~

; by Vince `deater` Weaver	vince@deater.net

.include "../hardware.inc"
.include "../zp.inc"
.include "../common_defines.inc"

.include "../qload.inc"
.include "../music/music.inc"

title:

	jsr	hgr2				; clear screen, HGR page 2

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

	;================================
	; load regular title image to $40

	lda	#<(title_trogfree_zx02)
	sta	zx_src_l+1
	lda	#>(title_trogfree_zx02)
	sta	zx_src_h+1

	lda	#$40				; decompress to $40 (PAGE2)

	jsr	zx02_full_decomp


	;=================================
	; load trogdor title image to $20

	lda	#<(title_zx02)
	sta	zx_src_l+1
	lda	#>(title_zx02)
	sta	zx_src_h+1

	lda	#$20				; decompress to $20 (PAGE1)

	jsr	zx02_full_decomp

	bit	KEYRESET


	lda	SOUND_STATUS
	and	#SOUND_MOCKINGBOARD
	beq	mockingboard_notfound

	jsr	mockingboard_title
	jmp	title_loop_done

mockingboard_notfound:

	jsr	duet_title

title_loop_done:


	;========================
	; Tips
	;========================

	jsr	directions


	lda	#LOAD_INTRO
	sta	WHICH_LOAD


	rts


.include "../hgr_routines/hgr_sprite.s"

.include "title_mockingboard.s"

.include "title_duet.s"

.include "tips.s"

.include "../music/duet.s"

peasant_ed:
.incbin "../music/peasant.ed"

.include "../pt3_lib/pt3_lib_mockingboard_patch.s"

.include "graphics_title/title_graphics.inc"

;altfire:
;.include "graphics_title/altfire.inc"

.include "sprites_title/title_sprites.inc"
