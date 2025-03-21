.include "../zp.inc"
.include "../hardware.inc"
.include "../qload.inc"
.include "../music.inc"
.include "../common_defines.inc"

; OK: was going to have hi-res top, scroll lo-res bottom
;	vapor lock (but using IIe)
;	problem is that won't work with 50Hz music / 60Hz screen

; I guess can try for smooth scroll bottom hires but do we have code for that?

; page flip  $2000/$4000
; scroll text $6000, 160..192 = 32?
;
;
;
;

	;=============================
	; draw the atrus scene
	;=============================

atrus_opener:
	lda	#0
	sta	PLASMA_GROW

	bit     SET_GR
        bit     HIRES
        bit     TEXTGR
        bit     PAGE1

;	lda	#$A0
;	sta	clear_all_color+1

	jsr	clear_bottoms

	;=================================
	; atrus greetings
	;=================================
	; TODO: a wipe of some sort?

	lda	#<atrus03_graphics
	sta	zx_src_l+1
	lda	#>atrus03_graphics
	sta	zx_src_h+1
	lda	#$20
	jsr	zx02_full_decomp

	lda	#<atrus03_graphics
	sta	zx_src_l+1
	lda	#>atrus03_graphics
	sta	zx_src_h+1
	lda	#$40
	jsr	zx02_full_decomp

	lda	#<atrus_text
	sta	OUTL
	lda	#>atrus_text
	sta	OUTH

	jsr	move_and_print	; Thank....
	lda	#1
	jsr	wait_seconds

	jsr	move_and_print	; I need...
	lda	#1
	jsr	wait_seconds

	jsr	move_and_print	; try again...
	lda	#1
	jsr	wait_seconds

;	jsr	wait_until_keypress

	;=================================
	; scroller
	;=================================
	bit	FULLGR

	jsr	do_scroll

;	jsr	wait_until_keypress


	;=================================
	; book start
	;=================================

	lda	#<atrus10_graphics
	sta	zx_src_l+1
	lda	#>atrus10_graphics
	sta	zx_src_h+1
	lda	#$40				; on both pages
	jsr	zx02_full_decomp

	lda	#<atrus10_graphics
	sta	zx_src_l+1
	lda	#>atrus10_graphics
	sta	zx_src_h+1
	lda	#$20
	jsr	zx02_full_decomp

	lda	#1
	jsr	wait_seconds

;	jsr	wait_until_keypress

	;=================================
	; plasma
	;=================================

	lda	#<atrus11_graphics
	sta	zx_src_l+1
	lda	#>atrus11_graphics
	sta	zx_src_h+1
	lda	#$20
	jsr	zx02_full_decomp

	; load both pages as we page flip

	lda	#<atrus11_graphics
	sta	zx_src_l+1
	lda	#>atrus11_graphics
	sta	zx_src_h+1
	lda	#$40
	jsr	zx02_full_decomp

	jsr	plasma_debut

;	jsr	wait_until_keypress

	;=================================
	; go to overlook graphics
	;=================================

	bit	PAGE1			; show page 1

	lda	#<overlook_graphics	; load to page2
	sta	zx_src_l+1
	lda	#>overlook_graphics
	sta	zx_src_h+1
	lda	#$40
	jsr	zx02_full_decomp

	jsr	do_wipe_fizzle		; wipe

wait_till_right_pattern99:
        lda     #$10
        jsr     wait_for_pattern
        bcc     wait_till_right_pattern99

	rts

atrus03_graphics:
	.incbin "graphics/atrus03_iipix.hgr.zx02"
atrus10_graphics:
	.incbin "graphics/atrus10_iipix.hgr.zx02"
atrus11_graphics:
	.incbin "graphics/atrus11_iipix.hgr.zx02"
overlook_graphics:
	.incbin "graphics/overlook_n.hgr.zx02"

atrus_text:
	.byte 7,20,"Thank God you've returned.",0
	.byte 4,22,"I need... Wait, is this a demo?",0
	.byte 9,23,"Sorry let me try again",0

;.include "../wait_keypress.s"

.include "plasma.s"

.include "font/large_font.inc"

;.include "big_horiz_scroll.s"

.include "horiz_scroll.s"
