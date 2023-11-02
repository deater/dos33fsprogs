; Weird head lens/rotozoom

; by deater (Vince Weaver) <vince@deater.net>

.include "../zp.inc"
.include "../hardware.inc"
.include "../qload.inc"
.include "../music.inc"

lens_start:
	;=====================
	; initializations
	;=====================

        ; debug
        ; force right location in music

        lda     #34
        sta     current_pattern_smc+1
        jsr     pt3_set_pattern

	;================================
	; Clear screen and setup graphics
	;================================

	bit	SET_GR
	bit	FULLGR
	bit	PAGE1			; set page 1
	bit	LORES			; Lo-res graphics

	lda	#0
	sta	DISP_PAGE
	lda	#4
	sta	DRAW_PAGE

	;===================================
	; Clear top/bottom of page 0 and 1
	;===================================

	jsr	clear_screens

	;===================================
	; init the multiply tables
	;===================================

	jsr	init_multiply_tables

	;======================
	; show the title screen
	;======================

	; Title Screen

title_screen:

load_background:

	;===========================
	; Clear both bottoms

;	jsr     clear_bottoms

	;=============================
	; Load title

	lda     #<lens_zx02
        sta     zx_src_l+1
	lda     #>lens_zx02
	sta	zx_src_h+1

	lda	#$40

        jsr     zx02_full_decomp

	;=================================
	; copy to both pages

	jsr	gr_copy_to_current
	jsr	page_flip
	jsr	gr_copy_to_current

	;=================================
	;TODO: wait 5s?
	;

	;=================================
	;TODO: play sound sample?
	;=================================

	; decompress audio to $6000

;	lda	#<transmission_data
;	sta	zx_src_l+1
;	lda	#>transmission_data
;	sta	zx_src_h+1
;	lda	#$60
;	jsr	zx02_full_decomp

	; play audio

;	lda	#$00
;	sta	BTC_L
;	lda	#$60
;	sta	BTC_H

;	sei                     ; stop music

;	ldx	#11
;	jsr	play_audio

;	cli


	;===============================
	; draw/move lens
	;===============================

	lda	#10
	jsr	setup_timeout


	lda	#10
	sta	LENS_X
	lda	#2
	sta	LENS_Y

	lda	#1
	sta	XADD
	lda	#2
	sta	YADD

	lda	#0
	sta	COUNT

lens_move_loop:

	jsr	gr_copy_to_current

	ldx	COUNT
	lda	LENS_X
	sta	XPOS
	lda	LENS_Y
	sta	YPOS

	lda	#<lens_mask
	sta	MASKL
	lda	#>lens_mask
	sta	MASKH

	lda	#<lens_sprite
	sta	INL
	lda	#>lens_sprite
	sta	INH

	jsr	gr_put_sprite_mask

	jsr	page_flip

	; move lens

	; move x
move_x:
	clc
	lda	LENS_X
	adc	XADD
	sta	LENS_X
	cmp	#2
	bcc	reverse_x
	cmp	#28
	bcc	no_reverse_x
reverse_x:
	lda	XADD
	eor	#$FF
	sta	XADD
	inc	XADD

no_reverse_x:

move_y:
	clc
	lda	LENS_Y
	adc	YADD
	sta	LENS_Y
	cmp	#2
	bcc	reverse_y
	cmp	#22
	bcc	no_reverse_y
reverse_y:
	lda	YADD
	eor	#$FF
	sta	YADD
	inc	YADD

no_reverse_y:




	; wait a bit

	lda	#200
	jsr	wait

no_lens_bounce_oflo:
	jsr	check_timeout
	bcc	lens_move_loop		; clear if not timed out

done_lens_bounce_loop:

	;=================================
	;=================================
	; do rotozoom
	;=================================
	;=================================

	jsr	do_rotozoom

lens_end:
	rts


;===============================================
; External modules
;===============================================

.include "roto.s"
.include "rotozoom.s"

.include "../gr_pageflip.s"
;.include "../gr_fast_clear.s"
.include "../gr_copy.s"

.include "../gr_offsets.s"
.include "../c00_scrn_offsets.s"

.include "../multiply_fast.s"

	.include	"../wait_keypress.s"
	.include	"../zx02_optim.s"
	.include	"../irq_wait.s"
	.include	"gr_putsprite_mask.s"
	.include	"../audio.s"

;===============================================
; Data
;===============================================

lens_zx02:
	.incbin "graphics/lenspic.gr.zx02"


.include "graphics/lens_sprites.inc"

.if 0

lens_coords_x:
	.byte 10,11,12,13,14,15,16,17
	.byte 18,19,20,21,22,23,24,25
	.byte 26,27,28,28,27,26,25,24
	.byte 23,22,21,20,19,18,17,16

lens_coords_y:
	.byte  2, 4, 6, 8,10,12,14,16
	.byte 18,20,22,22,20,18,16,14
	.byte 12,10, 8, 6, 4, 2, 2, 4
	.byte  6, 8,10,12,14,16,18,20
.endif
