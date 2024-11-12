.include "../zp.inc"
.include "../hardware.inc"
.include "../qload.inc"
.include "../music.inc"
.include "../common_defines.inc"



	;=============================
	; Some graphics scenes, with transitons
	;	we have in theory 24k or so to work with
	;
	; one other? maybe survey island?
	;	spires:  4500
	;	233:	 6600
	;	atrus_l: 5100
	;	floater: 2700

	;=============================



	;=============================
	; draw some graphics
	;=============================

graphics:
	bit	KEYRESET	; just to be safe

	lda	#0

	bit     SET_GR
        bit     HIRES
        bit     FULLGR
        bit     PAGE1

	;=================================
	; minecart
	;=================================

	lda	#<minecart_graphics
	sta	zx_src_l+1
	lda	#>minecart_graphics
	sta	zx_src_h+1
	lda	#$20
	jsr	zx02_full_decomp


	;=================================
	; spires
	;=================================

	lda	#<spires_graphics
	sta	zx_src_l+1
	lda	#>spires_graphics
	sta	zx_src_h+1
	lda	#$40
	jsr	zx02_full_decomp


	jsr	wait_until_keypress

	jsr	do_wipe_center

	jsr	wait_until_keypress


	;=================================
	; World 233
	;=================================

	bit	SET_GR
        bit	HIRES
        bit	FULLGR
        sta	AN3             ; set double hires
        sta	EIGHTYCOLON     ; 80 column
        sta	SET80COL        ; 80 store

        bit	PAGE1   ; start in page1

	lda	#<riven_233_graphics_bin
        sta	zx_src_l+1
        lda	#>riven_233_graphics_bin
        sta	zx_src_h+1
        lda	#$20
        jsr	zx02_full_decomp

        ; auxiliary part
        bit	PAGE2
	lda	#<riven_233_graphics_aux
	sta	zx_src_l+1
	lda	#>riven_233_graphics_aux
	sta	zx_src_h+1
	lda	#$20
	jsr	zx02_full_decomp

	jsr	wait_until_keypress

	; disable 80column mode
	sta	SETAN3
	sta	CLR80COL
	sta	EIGHTYCOLOFF
	bit	PAGE1

	;=================================
	; atrus
	;=================================

	lda	#<atrus_graphics
	sta	zx_src_l+1
	lda	#>atrus_graphics
	sta	zx_src_h+1
	lda	#$20
	jsr	zx02_full_decomp

	jsr	wait_until_keypress

	lda	#0
	sta	DRAW_PAGE

	jsr	clear_bottom

	bit	TEXTGR

	lda	#<atrus_message
	sta	OUTL
	lda	#>atrus_message
	sta	OUTH

	; The path home...
	jsr	move_and_print
	jsr	wait_until_keypress

	; linking book
	jsr	move_and_print
	jsr	wait_until_keypress

	; cleft
	jsr	move_and_print
	jsr	wait_until_keypress

	; meet...
	jsr	move_and_print
	jsr	wait_until_keypress


	bit	FULLGR

	;=================================
	; floater
	;=================================

	lda	#<floater_graphics
	sta	zx_src_l+1
	lda	#>floater_graphics
	sta	zx_src_h+1
	lda	#$20
	jsr	zx02_full_decomp

	jsr	wait_until_keypress

	lda	#0
	sta	DRAW_PAGE

	jsr	clear_bottom

	bit	TEXTGR

	lda	#<atrus_message2
	sta	OUTL
	lda	#>atrus_message2
	sta	OUTH

	; Perhaps1
	jsr	move_and_print
	jsr	move_and_print
	jsr	wait_until_keypress

	; Perhaps2
	jsr	move_and_print
	jsr	move_and_print
	jsr	wait_until_keypress

	bit	FULLGR


	rts

minecart_graphics:
;	.incbin "graphics/a2_minecart.hgr.zx02"
;	.incbin "graphics/minecart1_iipix.hgr.zx02"
	.incbin "graphics/minecart2_iipix.hgr.zx02"


spires_graphics:
	.incbin "graphics/spires_n.hgr.zx02"

floater_graphics:
	.incbin "graphics/floater_wide_steffest.hgr.zx02"


atrus_graphics:
	.incbin "graphics/a2_atrus.hgr.zx02"
;	.incbin "graphics/atrus_light_iipix.hgr.zx02"
;	.incbin "graphics/atrus_iipix.hgr.zx02"


riven_233_graphics_aux:
	.incbin "graphics/riven_233.aux.zx02"
;	.incbin "graphics/atrus.aux.zx02"

riven_233_graphics_bin:
	.incbin "graphics/riven_233.bin.zx02"
;	.incbin "graphics/atrus.bin.zx02"


;.include "../wait_keypress.s"

atrus_message:
	  ; 0123456789012345678901234567890123456789
.byte 0,20,"The path home is now clear for all of us",0
.byte 0,21,"I'll take the linking book",0
.byte 0,22,"        you take the bottomless cleft.",0
.byte 0,23,"Perhaps we will meet again someday...",0

atrus_message2:
	  ; 0123456789012345678901234567890123456789
.byte 0,20,"Perhaps the ending has not yet been",0
.byte 0,21,"written.",0
.byte 0,22,"Perhaps that's because we ran out of",0
.byte 0,23,"time before the submission deadline.",0

.include "wipes/fx.hgr.center.by.pixel.s"

