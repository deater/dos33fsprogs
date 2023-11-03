; Transmission

;
; by deater (Vince Weaver) <vince@deater.net>

.include "../zp.inc"
.include "../hardware.inc"
.include "../qload.inc"
.include "../music.inc"

mod7_table	= $1c00
div7_table	= $1d00
hposn_low	= $1e00
hposn_high	= $1f00

spheres_start:
	;=====================
	; initializations
	;=====================


	;===================
	; Load graphics
	;===================

	bit	SET_GR
	bit	FULLGR
	bit	PAGE1
	bit	LORES

	lda	#0
	sta	DISP_PAGE
	lda	#4
	sta	DRAW_PAGE

	;===================================
	; Clear top/bottom of page 0 and 1
	;===================================

	jsr	clear_screens

	; load image offscreen $4000

	lda	#<spheres_data
	sta	zx_src_l+1
	lda	#>spheres_data
	sta	zx_src_h+1
	lda	#$40
	jsr	zx02_full_decomp

	;=================================
        ; copy to both pages

        jsr     gr_copy_to_current
        jsr     page_flip
        jsr     gr_copy_to_current


	;===================================
	; Play "transmission" audio
	;===================================


	; decompress audio to $6000

	lda	#<transmission_data
	sta	zx_src_l+1
	lda	#>transmission_data
	sta	zx_src_h+1
	lda	#$60
	jsr	zx02_full_decomp

	; play audio

	lda	#$00
	sta	BTC_L
	lda	#$60
	sta	BTC_H

	sei			; stop music

	ldx	#11
	jsr	play_audio

	cli


	;=============================
	; wait a bit
	;=============================
	; "10 seconds to transmission"
	; do we wait 10s?

	lda	#2
	jsr	wait_seconds


	lda	#0
	sta	XMISSION_COUNT

	;==========================
	; transmit sword
	;==========================

	lda	#<long_sword1
	sta	BASE_SPRITEL
	lda	#>long_sword1
	sta	BASE_SPRITEH

move_sword_loop:
        jsr     gr_copy_to_current

	jsr	draw_sword

	jsr	page_flip

	lda	#16
	jsr	wait_ticks

	lda	KEYPRESS
	bmi	done_sword_loop

	inc	XMISSION_COUNT
	lda	XMISSION_COUNT
	cmp	#60
	bne	move_sword_loop

done_sword_loop:
	bit	KEYRESET


spheres_loop:
	lda	#72
	jsr	wait_for_pattern
	bcc	spheres_loop


spheres_done:
	rts




	;==========================
	; draw skewed sword
	;==========================
draw_sword:

	lda	BASE_SPRITEL
	sta	CURRENT_SPRITEL
	lda	BASE_SPRITEH
	sta	CURRENT_SPRITEH		; copy start for sprite

	ldx	#0
	stx	REFCOUNT

	lda	#3
	sta	COUNT

sword_loop:
	lda	gr_offsets,X
	clc
	adc	COUNT
	sta	GBASL

	lda	gr_offsets+1,X
	clc
	adc	DRAW_PAGE
	sta	GBASH

	ldy	#5
sword_inner_loop:
	lda	(CURRENT_SPRITEL),Y
	beq	skip_pixel
	sta	(GBASL),Y
skip_pixel:
	;====================================

	dey
	bpl	sword_inner_loop

	; handle reflections

	lda	REFCOUNT
	lsr
	bcs	pixel_odd

	tay
	lda	reflect1_h,Y
	clc
	adc	DRAW_PAGE
	sta	REF1H
	lda	reflect1_l,Y
	sta	REF1L

	lda	reflect2_h,Y
	clc
	adc	DRAW_PAGE
	sta	REF2H
	lda	reflect2_l,Y
	sta	REF2L

	ldy	#3
	lda	(CURRENT_SPRITEL),Y
	beq	pixel_odd		; skip if black

	ldy	#0
	sta	(REF1L),Y
	sta	(REF2L),Y

pixel_odd:
	;============================

	inc	REFCOUNT
	inc	COUNT

	clc
	lda	CURRENT_SPRITEL
	adc	#6
	sta	CURRENT_SPRITEL
	lda	#0
	adc	CURRENT_SPRITEH
	sta	CURRENT_SPRITEH

	inx
	inx
	cpx	#28
	bne	sword_loop

	; move to next input line

	clc
	lda	BASE_SPRITEL
	adc	#6
	sta	BASE_SPRITEL
	lda	#0
	adc	BASE_SPRITEH
	sta	BASE_SPRITEH

	rts


        ;==========
        ; page_flip
        ;==========

page_flip:
        lda     DRAW_PAGE                                               ; 3
        beq     page_flip_show_1                                        ; 2nt/3
page_flip_show_0:
	; show page2, draw page1
        bit     PAGE2                                                   ; 4
        lda     #0                                                      ; 2
        sta	DRAW_PAGE
        rts                                                             ; 6

page_flip_show_1:
	; show page1, draw page2
	bit	PAGE1                                                   ; 4
	lda	#4
	sta	DRAW_PAGE
	rts

reflect1_h:
	; 46,44,42,40,38,36,34
	.byte	>$7d0,>$750,>$6d0,>$650,>$5d0,>$550,>$4d0
	; 39, 38, 37, 36, 36, 34, 33
reflect1_l:
	.byte	<$7d0+39,<$750+38,<$6d0+37,<$650+36,<$5d0+35,<$550+34,<$4d0+33


reflect2_h:
	; 4,6,8,10,12,14,16
	.byte	>$500,>$580,>$600,>$680,>$700,>$780,>$428
reflect2_l:
	.byte	<$500+32,<$580+31,<$600+30,<$680+29,<$700+28,<$780+27,<$428+26





	.include	"../wait_keypress.s"

;	.include	"../gr_pageflip.s"
	.include	"../gr_copy.s"

	.include	"../gr_offsets.s"

	.include	"../audio.s"
	.include	"../irq_wait.s"

spheres_data:
;	.incbin "graphics/spheres.hgr.zx02"
	.incbin "graphics/spheres.gr.zx02"

transmission_data:
	.incbin "audio/transmission.btc.zx02"

	.include "graphics/sword_sprite.inc"
