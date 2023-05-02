; Animation from SBEMAIL #152
;
; Yet Another HR project
;
; by deater (Vince Weaver) <vince@deater.net>


.include "zp.inc"
.include "hardware.inc"

fortnight_start:

	lda	#$20
	sta	HGR_PAGE

	jsr	hgr_make_tables

	;===================
	; set graphics mode
	;===================
	jsr	HOME

	bit	HIRES
	bit	FULLGR
	bit	SET_GR
	bit	PAGE1


	;==========================
	; Floppy Animation
	;===========================

floppy_animation:


	lda	#<fn_image
	sta	ZX0_src
	lda	#>fn_image
	sta	ZX0_src+1
	lda	#$20


	jsr	full_decomp


	lda	#10
	sta	CURSOR_X
	lda	#10
	sta	CURSOR_Y
	lda	#<disk_sprite0
	sta	INL
	lda	#>disk_sprite0
	sta	INH
	lda	#<disk_mask0
	sta	MASKL
	lda	#>disk_mask0
	sta	MASKH

	jsr	hgr_draw_sprite


	jsr	wait_until_keypress


	;==========================
	; "breakdancing" rat
	;==========================

load_rats:
	lda	#<rat1_image
	sta	ZX0_src
	lda	#>rat1_image
	sta	ZX0_src+1
	lda	#$20
	jsr	full_decomp

	lda	#<rat2_image
	sta	ZX0_src
	lda	#>rat2_image
	sta	ZX0_src+1
	lda	#$40
	jsr	full_decomp


	;=============================
	; play music and animate rat
	;=============================
play_music:
	lda	#<music
	sta	MADDRL
	lda	#>music
	sta	MADDRH

	jsr	play_ed

rat_loop:
;	bit	PAGE1
;	jsr	wait_until_keypress



;	bit	PAGE2
	jsr	wait_until_keypress


;	jmp	rat_loop

	jmp	fortnight_start


wait_until_keypress:
	lda	KEYPRESS				; 4
	bpl	wait_until_keypress			; 3
	bit	KEYRESET	; clear the keyboard buffer
	rts

	.include	"zx02_optim.s"

	.include	"hgr_sprite_mask.s"
	.include	"hgr_tables.s"

.align	$100
	.include	"duet.s"

music:
	.incbin "fn_sound/fortnight.ed"

fn_image:
	.incbin "fn_graphics/a2_fortnight.hgr.zx02"
rat1_image:
	.incbin "fn_graphics/a2_fortnight_rat1.hgr.zx02"
rat2_image:
	.incbin "fn_graphics/a2_fortnight_rat2.hgr.zx02"

	.include "fn_graphics/disk_sprites.inc"
