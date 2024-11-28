; Breakdancing RAT
;
; Animation from SBEMAIL #152
;
; Yet Another HR project
;
; by deater (Vince Weaver) <vince@deater.net>


.include "../zp.inc"
.include "../hardware.inc"

div7_table     = $9C00
mod7_table     = $9D00
hposn_high     = $9E00
hposn_low      = $9F00

fortnight_start:

	lda	#$20
	sta	HGR_PAGE		; why?

	lda	#$00			; will be $00/$20
	sta	DRAW_PAGE

	lda	#0
	sta	WHICH_PAGE

	; disp page1
	; erase old page2
	; save page2
	; draw page2

	; disp page2
	; erase old page1
	; save page1
	; draw page1

	jsr	hgr_make_tables

	;===================
	; set graphics mode
	;===================
	jsr	HOME

	bit	HIRES
	bit	FULLGR
	bit	SET_GR
	bit	PAGE1

	ldx	#0
	sta	FRAME
	sta	FRAMEH

	;==========================
	; Floppy Animation
	;===========================

floppy_animation:

	; decompress background to page1

	lda	#<fn_image
	sta	ZX0_src
	lda	#>fn_image
	sta	ZX0_src+1
	lda	#$20

	jsr	full_decomp

	; decompress background to page2
	; would it be faster to copy?

	lda	#<fn_image
	sta	ZX0_src
	lda	#>fn_image
	sta	ZX0_src+1
	lda	#$40

	jsr	full_decomp

	lda	#4
	sta	SPRITE_Y

	lda	#$FF
	sta	backup_sprite1
	sta	backup_sprite2


reset_floppy_loop:
	lda	#0
	sta	XPOS

floppy_loop:

	;=========================
	; switch visible page
	;=========================

	lda	WHICH_PAGE
	tax
	sta	PAGE1,X
	eor	#$1
	sta	WHICH_PAGE


	;========================
	; switch draw page
	;========================

	lda	DRAW_PAGE
	eor	#$20
	sta	DRAW_PAGE

	;=======================
	; erase sprite
	;=======================

	lda	OLDER_X
	sta	SPRITE_X

	lda	WHICH_PAGE
;	eor	#$1
	tax
	lda	backup_sprites_l,X
	sta	INL
	lda	backup_sprites_h,X
	sta	INH

	ldy	#0
	lda	(INL),Y
	bmi	goog

	jsr	hgr_draw_sprite

goog:

	lda	WHICH_PAGE
;	eor	#$1
	tax
	lda	backup_sprites_l,X
	sta	OUTL
	lda	backup_sprites_h,X
	sta	OUTH


	;=======================
	; save/draw
	;=======================

	ldx	XPOS

	lda	OLD_X
	sta	OLDER_X

	lda	floppy_x,X		; save/draw offscreen
	sta	SPRITE_X
	sta	OLD_X
;	lda	#4
;	sta	SPRITE_Y
;	sta	OLD_Y
	lda	floppy_sprite_l,X
	sta	INL
	lda	floppy_sprite_h,X
	sta	INH
	lda	floppy_mask_l,X
	sta	MASKL
	lda	floppy_mask_h,X
	sta	MASKH

	; draw sprite
	jsr	hgr_draw_sprite_mask_and_save

time_loop:

	; check keypress

	lda	KEYPRESS				; 4
	bmi	done_floppy

	lda	#160
	jsr	WAIT

	jsr	inc_frame

	lda	FRAMEH
	cmp	#3
	beq	done_floppy

	lda	FRAME
	and	#$3
	bne	time_loop

	; move sprite

	inc	XPOS

	lda	XPOS
	cmp	#18
	bcc	floppy_loop
	jmp	reset_floppy_loop


done_floppy:
	bit	KEYRESET	; clear the keyboard buffer


	;==========================
	; Show 99%
	;==========================

	bit	PAGE2

	lda	#<fn_99_image
	sta	ZX0_src
	lda	#>fn_99_image
	sta	ZX0_src+1
	lda	#$20
	jsr	full_decomp

	lda	#24
	sta	SPRITE_X

	lda	#<disk_sprite7
	sta	INL
	lda	#>disk_sprite7
	sta	INH

	lda	#<disk_mask7
	sta	MASKL
	lda	#>disk_mask7
	sta	MASKH

	lda	#$00
	sta	DRAW_PAGE

	jsr	hgr_draw_sprite_mask_and_save


	bit	PAGE1

	jsr	long_wait


	;==========================
	; Show 100%
	;==========================

	lda	#<fn_100_image
	sta	ZX0_src
	lda	#>fn_100_image
	sta	ZX0_src+1
	lda	#$40

	jsr	full_decomp

	lda	#26
	sta	SPRITE_X

	lda	#<disk_sprite0
	sta	INL
	lda	#>disk_sprite0
	sta	INH

	lda	#<disk_mask0
	sta	MASKL
	lda	#>disk_mask0
	sta	MASKH

	lda	#$20
	sta	DRAW_PAGE

	jsr	hgr_draw_sprite_mask_and_save

	bit	PAGE2

	jsr	long_wait

;	jsr	wait_until_keypress

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

	;============================
	; print "not really" message
	;============================

	bit	KEYRESET

	lda	#<break_image
	sta	ZX0_src
	lda	#>break_image
	sta	ZX0_src+1
	lda	#$20
	jsr	full_decomp

	bit	PAGE1

	jsr	wait_until_keypress


	lda	#0
	sta	WHICH_LOAD

	rts

;	jmp	fortnight_start


wait_until_keypress:
	lda	KEYPRESS				; 4
	bpl	wait_until_keypress			; 3
	bit	KEYRESET	; clear the keyboard buffer
	rts

inc_frame:
	inc	FRAME
	bne	no_frame_oflo
	inc	FRAMEH
no_frame_oflo:
	rts

long_wait:
	ldx	#10
long_wait_loop:
	lda	#255
	jsr	WAIT
	dex
	bne	long_wait_loop
	rts

	.include	"../zx02_optim.s"

	.include	"../hgr_sprite.s"
	.include	"../hgr_sprite_mask.s"
	.include	"../hgr_tables.s"

.align	$100
	.include	"../duet.s"

music:
	.incbin "sound/fortnight.ed"

fn_image:
	.incbin "graphics/a2_fortnight.hgr.zx02"
fn_99_image:
	.incbin "graphics/a2_fortnight_99.hgr.zx02"
fn_100_image:
	.incbin "graphics/a2_fortnight_100.hgr.zx02"


rat1_image:
	.incbin "graphics/a2_fortnight_rat1.hgr.zx02"
rat2_image:
	.incbin "graphics/a2_fortnight_rat2.hgr.zx02"
break_image:
	.incbin "graphics/a2_break.hgr.zx02"

	.include "graphics/disk_sprites.inc"

floppy_x:
	.byte	10,12,14,16
	.byte	18,20,22,24
	.byte	26,26,24,22
	.byte   20,18,16,14,12,10

floppy_sprite_l:
	.byte	<disk_sprite0,<disk_sprite1,<disk_sprite2,<disk_sprite3
	.byte	<disk_sprite4,<disk_sprite5,<disk_sprite6,<disk_sprite7
	.byte	<disk_sprite0,<disk_sprite0,<disk_sprite7,<disk_sprite6
	.byte	<disk_sprite5,<disk_sprite4,<disk_sprite3,<disk_sprite2
	.byte	<disk_sprite1,<disk_sprite0
floppy_sprite_h:
	.byte	>disk_sprite0,>disk_sprite1,>disk_sprite2,>disk_sprite3
	.byte	>disk_sprite4,>disk_sprite5,>disk_sprite6,>disk_sprite7
	.byte	>disk_sprite0,>disk_sprite0,>disk_sprite7,>disk_sprite6
	.byte	>disk_sprite5,>disk_sprite4,>disk_sprite3,>disk_sprite2
	.byte	>disk_sprite1,>disk_sprite0

floppy_mask_l:
	.byte	<disk_mask0,<disk_mask1,<disk_mask2,<disk_mask3
	.byte	<disk_mask4,<disk_mask5,<disk_mask6,<disk_mask7
	.byte	<disk_mask0,<disk_mask0,<disk_mask7,<disk_mask6
	.byte	<disk_mask5,<disk_mask4,<disk_mask3,<disk_mask2
	.byte	<disk_mask1,<disk_mask0

floppy_mask_h:
	.byte	>disk_mask0,>disk_mask1,>disk_mask2,>disk_mask3
	.byte	>disk_mask4,>disk_mask5,>disk_mask6,>disk_mask7
	.byte	>disk_mask0,>disk_mask0,>disk_mask7,>disk_mask6
	.byte	>disk_mask5,>disk_mask4,>disk_mask3,>disk_mask2
	.byte	>disk_mask1,>disk_mask0


backup_sprites_l:
	.byte <backup_sprite1,<backup_sprite2

backup_sprites_h:
	.byte >backup_sprite1,>backup_sprite2

