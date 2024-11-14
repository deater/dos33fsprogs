; Desire Logo to Driven transistion

; Memory used:
;	Loads at $8000	(no reason can't load at $2000?)
;	Uses hi-res at $2000
;	Second half uses $4000

;
; by deater (Vince Weaver) <vince@deater.net>

.include "../zp.inc"
.include "../hardware.inc"
.include "../qload.inc"
.include "../common_defines.inc"
.include "../music.inc"

desire_start:
	;=====================
	; initializations
	;=====================

	;===================
	; Load graphics
	;===================
load_loop:
;	jsr	wait_until_keypress


	; already in hires when we come in?

	bit	KEYRESET

	bit	SET_GR
	bit	HIRES
	bit	FULLGR
	bit	PAGE1

	lda	#0
	jsr	hgr_page1_clearscreen


	; load image $4000

	lda	#<logo_data_01
	sta	zx_src_l+1
	lda	#>logo_data_01
	sta	zx_src_h+1
	lda	#$40
	jsr	zx02_full_decomp

	; wait a bit

	lda	#1
	jsr	wait_seconds

	; wipe the logo onto the screen

	jsr	do_wipe_lr


wait_till_right_pattern5:
        lda     #2
        jsr     wait_for_pattern
        bcc     wait_till_right_pattern5

	; wait a bit

;	lda	#3
;	jsr	wait_seconds

	;==============================
	; gradually erase edges
	;==============================

	jsr	erase_frame

	;==============================
	; rotate D into place
	;==============================

	lda	#0
	sta	X_OFFSET

d_rotate_loop:
	ldx	X_OFFSET

	lda     d_sprite_x,X
        sta     CURSOR_X

        lda     d_sprite_y,X
        sta     CURSOR_Y

	lda	d_sprite_l,X
	sta	INL
	lda	d_sprite_h,X
	sta	INH

	jsr	hgr_draw_sprite

;	jsr	wait_until_keypress

	lda	#5
	jsr	wait_ticks

	inc	X_OFFSET
	lda	X_OFFSET
	cmp	#13
	bne	d_rotate_loop


	;==============================
	; gradually load in final logo
	;==============================

;	lda	#0
;	jsr	hgr_page1_clearscreen

	; load bg image $4000

	lda	#<logo_data_46
	sta	zx_src_l+1
	lda	#>logo_data_46
	sta	zx_src_h+1
	lda	#$40
	jsr	zx02_full_decomp

	;==============================
	; logo transition (left/right)

	lda	#10
	sta	LEFT_X
	lda	#36
	sta	RIGHT_X
	lda	#0
	sta	X_OFFSET


logo_transit_outer_loop:
	ldx	#70
logo_transit_inner_loop:
	lda	hposn_low,X
	sta	OUTL
	sta	INL

	lda	hposn_high,X
	sta	OUTH
	eor	#$60
	sta	INH

	stx	SAVE_X

	ldx	X_OFFSET

	ldy	LEFT_X
	lda	(INL),Y
	and	masks,X
	sta	(OUTL),Y

	ldy	RIGHT_X
	lda	(INL),Y
	and	masks_reverse,X
	sta	(OUTL),Y


	ldx	SAVE_X
	inx
	cpx	#95
	bne	logo_transit_inner_loop

	lda	#100
	jsr	wait

	inc	X_OFFSET
	lda	X_OFFSET
	cmp	#7
	bne	logo_transit_outer_loop

	lda	#0
	sta	X_OFFSET

	dec	RIGHT_X
	inc	LEFT_X
	lda	LEFT_X
	cmp	#20
	bne	logo_transit_outer_loop

	;==============================
	; logo transition (down)

	; 161 (23),70 -> 181 (26),106


	ldx	#70

logo_transit2_inner_loop:
	lda	hposn_low,X
	sta	OUTL
	sta	INL

	lda	hposn_high,X
	sta	OUTH
	eor	#$60
	sta	INH

	stx	SAVE_X

	ldy	#23
	lda	(INL),Y
	sta	(OUTL),Y
	iny
	lda	(INL),Y
	sta	(OUTL),Y
	iny
	lda	(INL),Y
	sta	(OUTL),Y
	iny
	lda	(INL),Y
	sta	(OUTL),Y

	lda	#100
	jsr	wait

	ldx	SAVE_X
	inx
	cpx	#106
	bne	logo_transit2_inner_loop


	;==============================
	; logo transition (up)

	; 140 (20),66 -> 161 (23),106


	ldx	#106
logo_transit3_inner_loop:
	lda	hposn_low,X
	sta	OUTL
	sta	INL

	lda	hposn_high,X
	sta	OUTH
	eor	#$60
	sta	INH

	stx	SAVE_X

	ldy	#20
	lda	(INL),Y
	sta	(OUTL),Y
	iny
	lda	(INL),Y
	sta	(OUTL),Y
	iny
	lda	(INL),Y
	sta	(OUTL),Y

	lda	#100
	jsr	wait

	ldx	SAVE_X
	dex
	cpx	#65
	bne	logo_transit3_inner_loop



	; wait for intro music to stop

wait_till_right_pattern:
	lda	#4
	jsr	wait_for_pattern
	bcc	wait_till_right_pattern

	; done
logo_done:
	rts



;	.include	"../hgr_clear_screen.s"
;	.include	"../irq_wait.s"

logo_data_01:
	.incbin "graphics/logo_frame01.hgr.zx02"

logo_data_46:
	.incbin "graphics/logo_frame46.hgr.zx02"


masks:
	.byte $81,$83,$87,$8f,$9f,$BF,$FF

masks_reverse:
	.byte $C0,$E0,$F0,$F8,$FC,$FE,$FF

.include "erase.s"
;.include "../wait_keypress.s"

.include "graphics/d_sprites.inc"

.include "../part01_dni/dni_plasma.s"

;.include "../hgr_sprite.s"

d_sprite_h:
	.byte >d11_sprite,>d12_sprite,>d13_sprite
	.byte >d14_sprite,>d15_sprite,>d16_sprite
	.byte >d17_sprite,>d18_sprite,>d19_sprite
	.byte >d20_sprite,>d21_sprite,>d22_sprite
	.byte >d23_sprite
d_sprite_l:
	.byte <d11_sprite,<d12_sprite,<d13_sprite
	.byte <d14_sprite,<d15_sprite,<d16_sprite
	.byte <d17_sprite,<d18_sprite,<d19_sprite
	.byte <d20_sprite,<d21_sprite,<d22_sprite
	.byte <d23_sprite
d_sprite_x:
	.byte	10,10,10
	.byte	 8, 8, 6
	.byte	 6, 6, 4
	.byte	 4, 2, 2
	.byte 	 2
d_sprite_y:
	.byte	55,55,55
	.byte	55,56,56
	.byte	56,56,56
	.byte	56,55,55
	.byte	54
