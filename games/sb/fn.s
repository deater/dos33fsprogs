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

reset_floppy_loop:
	lda	#0
	sta	XPOS
floppy_loop:
	ldx	XPOS

	lda	floppy_x,X
	sta	CURSOR_X
	lda	#4
	sta	CURSOR_Y
	lda	floppy_sprite_l,X
	sta	INL
	lda	floppy_sprite_h,X
	sta	INH
	lda	floppy_mask_l,X
	sta	MASKL
	lda	floppy_mask_h,X
	sta	MASKH

	jsr	hgr_draw_sprite

	jsr	wait_until_keypress

	inc	XPOS
	lda	XPOS
	cmp	#17
	bcc	floppy_loop
	bcs	reset_floppy_loop



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

floppy_x:
	.byte	10,12,14,16
	.byte	18,20,22,24
	.byte	26,24,22,20,18
	.byte	16,14,12,10

floppy_sprite_l:
	.byte	<disk_sprite0,<disk_sprite1,<disk_sprite2,<disk_sprite3
	.byte	<disk_sprite4,<disk_sprite5,<disk_sprite6,<disk_sprite7
	.byte	<disk_sprite0,<disk_sprite7,<disk_sprite6,<disk_sprite5
	.byte	<disk_sprite4,<disk_sprite3,<disk_sprite2,<disk_sprite1
	.byte	<disk_sprite0
floppy_sprite_h:
	.byte	>disk_sprite0,>disk_sprite1,>disk_sprite2,>disk_sprite3
	.byte	>disk_sprite4,>disk_sprite5,>disk_sprite6,>disk_sprite7
	.byte	>disk_sprite0,>disk_sprite7,>disk_sprite6,>disk_sprite5
	.byte	>disk_sprite4,>disk_sprite3,>disk_sprite2,>disk_sprite1
	.byte	>disk_sprite0

floppy_mask_l:
	.byte	<disk_mask0,<disk_mask1,<disk_mask2,<disk_mask3
	.byte	<disk_mask4,<disk_mask5,<disk_mask6,<disk_mask7
	.byte	<disk_mask6,<disk_mask5,<disk_mask4,<disk_mask3
	.byte	<disk_mask2,<disk_mask1,<disk_mask0,<disk_mask0

floppy_mask_h:
	.byte	>disk_mask0,>disk_mask1,>disk_mask2,>disk_mask3
	.byte	>disk_mask4,>disk_mask5,>disk_mask6,>disk_mask7
	.byte	>disk_mask6,>disk_mask5,>disk_mask4,>disk_mask3
	.byte	>disk_mask2,>disk_mask1,>disk_mask0,>disk_mask0
