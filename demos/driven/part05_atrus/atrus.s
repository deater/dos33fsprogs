.include "../zp.inc"
.include "../hardware.inc"
.include "../qload.inc"



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

	bit     SET_GR
        bit     HIRES
        bit     FULLGR
        bit     PAGE1

	lda	#<atrus03_graphics
	sta	zx_src_l+1
	lda	#>atrus03_graphics
	sta	zx_src_h+1
	lda	#$20
	jsr	zx02_full_decomp


	jsr	wait_until_keypress

	rts

atrus03_graphics:
	.incbin "graphics/atrus03_iipix.hgr.zx02"
atrus10_graphics:
	.incbin "graphics/atrus10_iipix.hgr.zx02"
atrus11_graphics:
	.incbin "graphics/atrus11_iipix.hgr.zx02"

.include "../wait_keypress.s"
