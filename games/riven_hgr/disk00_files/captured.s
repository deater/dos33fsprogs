; Riven then Captured

; by deater (Vince Weaver) <vince@deater.net>

.include "../zp.inc"
.include "../hardware.inc"
.include "../qload.inc"

.include "disk00_defines.inc"


RIVEN_FRAMES	=	23

; new
; 1 = 163.5
; 2 = 163.75
; 3 = 164
; 5 = 164.5
; 7 = 165
; 9 = 165.5
;11 = 166
;13 = 166.5
;15 = 167
;17 = 167.5
;19 = 168
;21 = 168.5
;23 = 169 = end (empty)


NUM_OVERLAYS	=	6


captured_start:

	;===================
	; Setup graphics
	;===================

	bit	SET_GR
	bit	HIRES
	bit	FULLGR
	bit	PAGE1

	lda	#0
	sta	SCENE_COUNT

	bit	KEYRESET

	;===============================
	;===============================
	; Riven Logo Loop
	;===============================
	;===============================

	lda	#$20
	sta	DRAW_PAGE

riven_logo_loop:

	; decompress graphics

	ldx	SCENE_COUNT
	lda	riven_l,X
	sta	ZX0_src
	lda	riven_h,X
	sta	ZX0_src+1

	lda	DRAW_PAGE
	jsr	full_decomp

	; flip pages

	lda	DRAW_PAGE
	cmp	#$20
	beq	hgr_flip_page2

hgr_flip_page1:
	bit	PAGE2
	lda	#$20
	bne	done_hgr_flip

hgr_flip_page2:

	bit	PAGE1
	lda	#$40
done_hgr_flip:
	sta	DRAW_PAGE


	; wait a bit before continuing

	ldx	#2
	jsr	wait_a_bit

	inc	SCENE_COUNT
	lda	SCENE_COUNT
	cmp	#RIVEN_FRAMES

	bne	riven_logo_loop



	;===================
        ; Setup lo-res graphics
        ;===================

	; clear it first

	jsr	clear_gr_all

        bit     SET_GR
        bit     LORES
        bit     FULLGR
        bit     PAGE1

        lda     #0
        sta     SCENE_COUNT

        lda     #4
        sta     DRAW_PAGE

        bit     KEYRESET

	;======================
	; fade in
	;======================

	; load bg

	lda	#<captured_bg
	sta	ZX0_src
	lda	#>captured_bg
	sta	ZX0_src+1

	lda     #$0c    ; decompress to $c00

	jsr     full_decomp

	jsr	fade_in

	;===============================
	;===============================
	; captured!
	;===============================
	;===============================

	lda	#0
	sta	WHICH_OVERLAY

captured_loop:

	jsr	draw_scene

	jsr	flip_pages

	inc	WHICH_OVERLAY
	lda	WHICH_OVERLAY
	cmp	#NUM_OVERLAYS
	beq	done_captured

	ldx	#2
	jsr	wait_a_bit

	jmp	captured_loop


done_captured:

	;===================
	; play sound effect
	;	if applicable

	;===============================
	; load sound into language card
	;===============================

	lda	SOUND_STATUS
	and	#SOUND_IN_LC
	beq	do_not_load_audio

	; load sounds into LC

	; read ram, write ram, use $d000 bank1
	bit	$C08B
	bit	$C08B

	lda	#<capture_audio
	sta	ZX0_src
	lda	#>capture_audio
	sta	ZX0_src+1

	lda     #$D0    ; decompress to $D000

	jsr     full_decomp

        ; read rom, nowrite, use $d000 bank1
	bit	$C08A


do_not_load_audio:

	; only play sound if language card

        lda     SOUND_STATUS
        and     #SOUND_IN_LC
        bne	do_play_audio

	; wait a bit instead

	ldx	#20
	jsr	wait_50xms

do_play_audio:
        ; switch in language card
        ; read/write RAM $d000 bank 1

         bit     $C08B
         bit     $C08B

        ; call the btc player

	lda	#$00
	sta	BTC_L

	lda	#$D0
	sta	BTC_H

	ldx	#45		; length

	jsr	play_audio

	; read ROM/no-write

	bit	$c08A		; restore language card

done_play_audio:


	;======================
	; done, move on to next
	;======================

	bit     KEYRESET

	lda     #LOAD_CAPTURED
	sta     WHICH_LOAD

	lda     #$1
	sta     LEVEL_OVER

	rts

	.include "flip_pages.s"
	.include "draw_scene.s"
	.include "../audio.s"

	.include "gr_fade.s"

captured_graphics:
	.include	"graphics_captured/captured_graphics.inc"

riven_l:
	.byte <riven01_zx02
	.byte <riven02_zx02
	.byte <riven03_zx02
	.byte <riven04_zx02
	.byte <riven05_zx02
	.byte <riven06_zx02
	.byte <riven07_zx02
	.byte <riven08_zx02
	.byte <riven09_zx02
	.byte <riven10_zx02
	.byte <riven11_zx02
	.byte <riven12_zx02
	.byte <riven13_zx02
	.byte <riven14_zx02
	.byte <riven15_zx02
	.byte <riven16_zx02
	.byte <riven17_zx02
	.byte <riven18_zx02
	.byte <riven19_zx02
	.byte <riven20_zx02
	.byte <riven21_zx02
	.byte <riven22_zx02
	.byte <riven23_zx02



riven_h:
	.byte >riven01_zx02
	.byte >riven02_zx02
	.byte >riven03_zx02
	.byte >riven04_zx02
	.byte >riven05_zx02
	.byte >riven06_zx02
	.byte >riven07_zx02
	.byte >riven08_zx02
	.byte >riven09_zx02
	.byte >riven10_zx02
	.byte >riven11_zx02
	.byte >riven12_zx02
	.byte >riven13_zx02
	.byte >riven14_zx02
	.byte >riven15_zx02
	.byte >riven16_zx02
	.byte >riven17_zx02
	.byte >riven18_zx02
	.byte >riven19_zx02
	.byte >riven20_zx02
	.byte >riven21_zx02
	.byte >riven22_zx02
	.byte >riven23_zx02

frames_l:
	.byte <trap_overlay0
	.byte <trap_overlay1
	.byte <trap_overlay2
	.byte <trap_overlay3
	.byte <trap_overlay4
	.byte <trap_overlay5

frames_h:
	.byte >trap_overlay0
	.byte >trap_overlay1
	.byte >trap_overlay2
	.byte >trap_overlay3
	.byte >trap_overlay4
	.byte >trap_overlay5



capture_audio:
.incbin "audio/capture.btc.zx02"
