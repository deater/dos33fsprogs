; Double Hi-res / Double lo-res mode switch fun

; by Vince `deater` Weaver

.include "zp.inc"
.include "hardware.inc"


double:

	;================================
	; detect model
	;================================

	jsr	detect_appleii_model


	;======================
	; machine workarounds
	;======================
	; mostly IIgs
	;===================
	; thanks to 4am who provided this code from Total Replay

	lda	ROM_MACHINEID
	cmp	#$06
	bne	not_a_iigs
	sec
	jsr	$FE1F			; check for IIgs
	bcs	not_a_iigs

	; gr/text page2 handling broken on early IIgs models
	; this enables the workaround

	jsr	ROM_TEXT2COPY		; set alternate display mode on IIgs
	cli				; enable VBL interrupts


	; also set background color to black instead of blue
	lda     NEWVIDEO
	and     #%00011111	; bit 7 = 0 -> IIgs Apple II-compat video modes
				; bit 6 = 0 -> IIgs 128K memory map same as IIe
				; bit 5 = 0 -> IIgs DHGR is color, not mono
				; bits 0-4 unchanged
	sta	NEWVIDEO
	lda	#$F0
	sta	TBCOLOR			; white text on black background
	lda	#$00
	sta	CLOCKCTL		; black border
	sta	CLOCKCTL		; set twice for VidHD

not_a_iigs:

	;================================
	; Clear screen and setup graphics
	;================================

	jsr	SETGR		; set lo-res 40x40 mode
	bit	LORES


	;====================================================
	; setup text page2 screen of "Apple II Forever" text
	;====================================================
	; there are much better ways to accomplish this

	sta	SETMOUSETEXT

	ldy	#0
	ldx	#0
	sty	XX
a24e_newy:
	lda	gr_offsets_l,Y
	sta	stringing_smc+1
	lda	gr_offsets_h,Y
	clc
	adc	#4
	sta	stringing_smc+2

a24e_loop:

	lda	a2_string,X
	bne	keep_stringing

	ldx	#0
	lda	a2_string,X

keep_stringing:

	inx

	eor	#$80

stringing_smc:
	sta	$d000

	inc	stringing_smc+1

	inc	XX
	lda	XX
	cmp	#40
	bne	a24e_loop

	lda	#0
	sta	XX
	iny
	cpy	#24
	bne	a24e_newy

stringing_done:

.if 0
	lda	a2_string,X
	eor	#$80

	sta	$800,X
	sta	$880+1,X
	sta	$900+2,X
	sta	$980+3,X
	sta	$A00+4,X
	sta	$A80+5,X
	sta	$B00+6,X
	sta	$B80+7,X

	sta	$828+0,X
	sta	$8A8+1,X
	sta	$928+2,X
	sta	$9A8+3,X
	sta	$A28+4,X
	sta	$AA8+5,X
	sta	$B28+6,X
	sta	$BA8+7,X

	sta	$850+0,X
	sta	$8D0+1,X
	sta	$950+2,X
	sta	$9D0+3,X
	sta	$A50+4,X
	sta	$AD0+5,X
	sta	$B50+6,X
	sta	$BD0+7,X

	dex
	bpl	a24e_loop
.endif


	; set 80-store mode

	sta	EIGHTYSTOREON	; PAGE2 selects AUX memory

	;=========================================================
	; load double lo-res image to $C00 and copy to MAIN:PAGE1
	;=========================================================

	bit	PAGE1

	lda	#<image_dgr_main
	sta	ZX0_src
	lda	#>image_dgr_main
	sta	ZX0_src+1

	lda	#$0c

	jsr	full_decomp

	jsr	copy_to_400

	;=========================================================
	; load double lo-res image to $C00 and copy to AUX:PAGE1
	;=========================================================

	bit	PAGE2			; map in AUX (80store)

	lda	#<image_dgr_aux
	sta	ZX0_src
	lda	#>image_dgr_aux
	sta	ZX0_src+1

	lda	#$0c

	jsr	full_decomp

	jsr	copy_to_400

	;=======================================
	; load double hi-res image to MAIN:PAGE1
	;=======================================
	bit	HIRES			; need to do this for 80store to work
	bit	PAGE1

	lda	#<image_dhgr_bin
	sta	ZX0_src
	lda	#>image_dhgr_bin
	sta	ZX0_src+1

	lda	#$20

	jsr	full_decomp

	;=======================================
	; load double hi-res image to AUX:PAGE1
	;=======================================

	bit	PAGE2			; map in AUX (80store)

	lda	#<image_dhgr_aux
	sta	ZX0_src
	lda	#>image_dhgr_aux
	sta	ZX0_src+1

        lda	#$20

	jsr	full_decomp


	;=================================
	; load hi-res image to MAIN:PAGE2
	;=================================

	; turn off eightystore

	sta	EIGHTYSTOREOFF

	lda	#<image_hgr
	sta	ZX0_src
	lda	#>image_hgr
	sta	ZX0_src+1

        lda	#$40

	jsr	full_decomp



	sta	FULLGR


	; wait for vblank on IIe
	; positive? during vblank

wait_vblank_iie:
	lda	VBLANK
	bmi	wait_vblank_iie		; wait for positive (in vblank)
wait_vblank_done_iie:
	lda	VBLANK			; wait for negative (vlank done)
	bpl	wait_vblank_done_iie

	;
double_loop:
	;===========================
	; text mode first 6*4 (24) lines
	;	each line 65 cycles (25 hblank+40 bytes)


; 3 LINES 80-COL TEXT AN3=0 PAGE=2

	bit	PAGE2

	nop
	nop
	sta	SET80COL	; 4
	bit	SET_TEXT	; 4

	; wait 6*4=24 lines
	; (24*65)-8 = 1560-8 = 1552

	jsr	delay_1552

; 3 LINES 40-COL TEXT AN3=0 PAGE=2

	nop
	nop

	nop
	nop
	sta	CLR80COL	; 4
	bit	SET_TEXT	; 4

	jsr	delay_1552

; 3 LINES 40-col LORES AN3=0 PAGE=1

	nop
	nop

	nop
	nop
	bit	PAGE1		; 4
	bit	SET_GR		; 4

	jsr	delay_1552

; 3 LINES 80-col DLORES AN3=0 PAGE=1

	nop
	nop

	sta	LORES
	sta	SET80COL	; 4
	sta	CLRAN3		; 4

	jsr	delay_1552


; 3 LINES 80-col DLORES AN3=0 PAGE=1

	nop
	nop

	nop
	nop

	nop
	nop

	nop
	nop

	jsr	delay_1552

; 3 lines HIRES 40-COL AN3=1 PAGE=2

	sta	CLR80COL
	sta	HIRES		; 4
	sta	PAGE2		; 4
	sta	SETAN3

	jsr	delay_1552

; 3 lines Double-hires AN3=0 PAGE=1
	sta	PAGE1
	bit	HIRES
	sta	SET80COL	; 4	; set 80 column mode
	sta	CLRAN3		; 4	; doublehireson

	jsr	delay_1552

; 3 line Double-HIRES

	nop
	nop

	nop
	nop

	nop
	nop

	nop
	nop

	jsr	delay_1552


	jmp	skip_vblank

.align $100

	;==================================
	; vblank = 4550 cycles
	; -6
	; 4544
	; Try X=226 Y=4 cycles=4545
	; Try X=9 Y=89 cycles=4540

skip_vblank:

	nop
	nop

	ldy	#89							; 2
loop3:	ldx	#9							; 2
loop4:	dex								; 2
	bne	loop4							; 2nt/3
	dey								; 2
	bne	loop3							; 2nt/3

	jmp	double_loop	; 3

;=======================================================
; need to align because if we straddle a page boundary
;	the time counts end up off

.align $100

	; actually want 1552-12 (6 each for jsr/rts)
	; 1540
	; Try X=15 Y=19 cycles=1540
	; 1532
	; Try X=1 Y=139 cycles=1530

delay_1552:

	nop



        ldy     #139							; 2
loop5:  ldx     #1							; 2
loop6:  dex								; 2
        bne     loop6							; 2nt/3
        dey								; 2
        bne     loop5							; 2nt/3

	rts



	.include "pt3_lib_detect_model.s"
;	.include "pt3_lib_mockingboard_setup.s"
;	.include "pt3_lib_mockingboard_detect.s"

	.include "zx02_optim.s"

	.include "copy_400.s"

image_hgr:
	.incbin "graphics/sworg_hgr.hgr.zx02"
image_dhgr_aux:
	.incbin "graphics/sworg_dhgr.aux.zx02"
image_dhgr_bin:
	.incbin "graphics/sworg_dhgr.bin.zx02"
image_dgr_aux:
	.incbin "graphics/sworg_dgr.aux.zx02"
image_dgr_main:
	.incbin "graphics/sworg_dgr.main.zx02"

a2_string:
	;      012345678901234567   8       9
	.byte "Apple II Forever!! ",'@'+$80," "
	.byte "Apple II Forever! ",'@'+$80," ",0
	.byte "Apple II Forever! ",'@'+$80," "
	.byte "Apple II Forever! ",'@'+$80," "
	.byte "Apple II Forever! ",'@'+$80," "

.include "gr_offsets.s"
