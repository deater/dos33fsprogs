; Double Hi-res / Double lo-res mode switch fun

; by Vince `deater` Weaver

.include "zp.inc"
.include "hardware.inc"


double:

	;================================
	; detect model
	;================================

	jsr	detect_appleii_model


	;===================
	; machine workarounds
	;===================
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


	; set 80-store mode

	sta	EIGHTYSTOREON	; PAGE2 selects AUX memory
	bit	PAGE1

	;===================
	; draw lo-res lines

	ldx	#39
draw_lores_lines:
	txa
	tay
	jsr	SETCOL

	lda	#47
	sta	V2
	lda	#0
	jsr	VLINE	; VLINE A,$2D at Y

	dex
	bpl	draw_lores_lines

	; copy to 800 temporarily
	; yes this is a bit of a hack

	ldy	#0
cp_loop:
	lda	$400,Y
	sta	$800,Y

	lda	$500,Y
	sta	$900,Y

	lda	$600,Y
	sta	$A00,Y

	lda	$700,Y
	sta	$B00,Y

	iny
	bne	cp_loop

	bit	PAGE1

	; copy to $400 in AUX

	bit	PAGE2	; $400 now maps to AUX:$400

	ldy	#0
cp2_loop:
	lda	$800,Y
	eor	#$FF
	sta	$400,Y

	lda	$900,Y
	eor	#$FF
	sta	$500,Y

	lda	$A00,Y
	eor	#$FF
	sta	$600,Y

	lda	$B00,Y
	eor	#$FF
	sta	$700,Y

	iny
	bne	cp2_loop

	bit	PAGE1


	;=======================================
	; load double hi-res image to MAIN:PAGE1
	;=======================================

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


; 3 LINES 80-COL AN3

	sta	SET80COL	; 4
	bit	SET_TEXT	; 4

	; wait 6*4=24 lines
	; (24*65)-8 = 1560-8 = 1552

	jsr	delay_1552

; 3 LINES 40-COL AN3

	sta	CLR80COL	; 4
	bit	SET_TEXT	; 4
	jsr	delay_1552

; 3 LINES 40-col LORES AN3

	lda	LORES		; 4
	bit	SET_GR		; 4
	jsr	delay_1552

; 3 LINES 80-col DLORES AN3

	sta	SET80COL	; 4
	sta	CLRAN3		; 4
	jsr	delay_1552

; 3 lines 40-col LORES

	sta	CLR80COL	; 4
	sta	SETAN3		; 4	; doublehiresoff
	jsr	delay_1552

; 3 lines HIRES PAGE2
	sta	HIRES		; 4
	sta	PAGE2		; 4
	jsr	delay_1552

; 3 lines Double-hires
	sta	SET80COL	; 4	; set 80 column mode
	sta	CLRAN3		; 4	; doublehireson
	jsr	delay_1552

; 3 line Double-HIRES

;	sta	PAGE1		; 4
	sta	SET_GR		; 4
	sta	SET_GR		; 4
	jsr	delay_1552



	;==================================
	; vblank = 4550 cycles

	; Try X=226 Y=4 cycles=4545
skip_vblank:
	nop

	ldy	#4							; 2
loop3:	ldx	#226							; 2
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
delay_1552:

        ldy     #19							; 2
loop5:  ldx     #15							; 2
loop6:  dex								; 2
        bne     loop6							; 2nt/3
        dey								; 2
        bne     loop5							; 2nt/3

	rts



	.include "pt3_lib_detect_model.s"
;	.include "pt3_lib_mockingboard_setup.s"
;	.include "pt3_lib_mockingboard_detect.s"

	.include "zx02_optim.s"

image_hgr:
	.incbin "graphics/sworg_hgr.hgr.zx02"
image_dhgr_aux:
	.incbin "graphics/sworg_dhgr.aux.zx02"
image_dhgr_bin:
	.incbin "graphics/sworg_dhgr.bin.zx02"