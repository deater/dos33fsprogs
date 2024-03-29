; Double Hi-res / Double lo-res mode switch fun

; by Vince `deater` Weaver

.include "zp.inc"
.include "hardware.inc"


double:

	lda	#0
	sta	FRAME
	lda	#$ff
	sta	FRAMEH

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
	; setup vblank routine
	;================================

	lda	APPLEII_MODEL
	cmp	#'G'
	beq	setup_vblank_iigs
	cmp	#'C'
	beq	setup_vblank_iic
setup_vblank_iie:
	lda	#<wait_vblank_iie
	sta	vblank_smc+1
	lda	#>wait_vblank_iie
	sta	vblank_smc+2
	jmp	done_setup_vblank

setup_vblank_iigs:
	lda	#<wait_vblank_iigs
	sta	vblank_smc+1
	lda	#>wait_vblank_iigs
	sta	vblank_smc+2
	jmp	done_setup_vblank

setup_vblank_iic:
	lda	#<wait_vblank_iic
	sta	vblank_smc+1
	lda	#>wait_vblank_iic
	sta	vblank_smc+2
	jmp	done_setup_vblank
done_setup_vblank:


	;====================
	; show title message
	;====================

	lda	#0
	sta	DRAW_PAGE

	jsr	show_title

	;===================
	; print config
	;===================

	lda	#<config_string
	sta	OUTL
	lda	#>config_string
	sta	OUTH

	jsr	move_and_print

	; print detected model

	lda	APPLEII_MODEL
	ora	#$80
	sta	$7d0+8			; 23,8

	; if GS print the extra S
	cmp	#'G'|$80
	bne	not_gs
	lda	#'S'|$80
	sta	$7d0+9

not_gs:

	lda	#0
	sta	SOUND_STATUS	; clear out, sound enabled

	;===========================================
	; skip checks if open-apple being held down

	lda	$C061
	and	#$80			; only bit 7 is affected
	bne	skip_all_checks		; rest is floating bus

	;===================================
        ; Detect Mockingboard
        ;===================================

PT3_ENABLE_APPLE_IIC = 1

	; detect mockingboard
	jsr	mockingboard_detect

	bcc	mockingboard_notfound
mockingboard_found:
        ; print detected location

        lda     #'S'+$80                ; change NO to slot
        sta     $7d0+30

        lda     MB_ADDR_H               ; $C4 = 4, want $B4 1100 -> 1011
        and     #$87
        ora     #$30

        sta     $7d0+31                 ; 23,31

        lda     SOUND_STATUS		; indicate we have mockingboard
        ora     #SOUND_MOCKINGBOARD
        sta     SOUND_STATUS

	;===========================
	; patch mockingboard
	;===========================

	jsr	mockingboard_patch      ; patch to work in slots other than 4

	;============================
	; Init the Mockingboard
	;============================

	jsr	mockingboard_init
	jsr	reset_ay_both
	jsr	clear_ay_both

	;======================
        ; decompress the music
        ;======================

	lda	#<fighting_zx02
	sta	ZX0_src

	lda     #>fighting_zx02
	sta	ZX0_src+1

	lda     #$b0		; decompress at $b000

	jsr	full_decomp

PT3_LOC = $b000

        ;==================
        ; init song
        ;==================

PT3_DISABLE_FREQ_CONVERSION = 1
PT3_DISABLE_SWITCHABLE_FREQ_CONVERSION = 1

        jsr     pt3_init_song

	lda	#0
	sta	DONE_PLAYING

        lda     #1
        sta     LOOP

mockingboard_notfound:

skip_all_checks:


        ;=======================
        ; show title for a bit
        ;=======================
	; you can skip with keypress

        lda     #25
        jsr     wait_a_bit

	;================================
	; Clear screen and setup graphics
	;================================


.include "setup_graphics.s"

	;=================================
	; midline first, no music
	;=================================

.include "effect_midline.s"

	;=================================
	; main static loop
	;=================================
	;	each line 65 cycles (25 hblank+40 bytes)

double_loop:
	;====================
	; update frame count

	inc	FRAME
	bne	frame_no_oflo
	inc	FRAMEH
	bne	frame_no_oflo

	lda	#<effect_dhgr_dgr
	sta	effect_smc+1
	lda	#>effect_dhgr_dgr
	sta	effect_smc+2

frame_no_oflo:

	lda	FRAMEH
	lsr
	and	#$7
	tax
	lda	middle_table1,X
	sta	middle_smc1+1
	lda	middle_table2,X
	sta	middle_smc2+1
	lda	middle_table3,X
	sta	middle_smc3+1
	lda	middle_table4,X
	sta	middle_smc4+1

	;====================
	; play music
	;  in theory should be less than the 4550 cycles we have

	lda     SOUND_STATUS		; check if we have mockingboard
	and	#SOUND_MOCKINGBOARD
	beq	no_music_for_you

	jsr	fake_interrupt

no_music_for_you:

	; note, coming out of vblank routines might be
	; 	8-12 cycles in already

vblank_smc:
	jsr	$ffff

effect_smc:
	jsr	effect_static


;	jsr	effect_dhgr_dgr

	jmp	double_loop	; 3

;=======================================================
; need to align because if we straddle a page boundary
;	the time counts end up off

.align $100

sin_table:
.incbin "table/sin.table"

; sin_table is 256 bytes so this should still be aligned

.include "vblank.s"

	; actually want 1524-12 = 1512 (6 each for jsr/rts)

	; 1532
	; Try X=1 Y=139 cycles=1530
	; 1524
	; Try X=5 Y=49 cycles=1520
	; 1512
	; Try X=22 Y=13 cycles=1509

delay_1560:
	nop
	nop
	nop
	nop
delay_1552:
	nop
	nop
delay_1548:
	nop
	nop
delay_1544:

	nop

        ldy     #139							; 2
loop5:  ldx     #1							; 2
loop6:  dex								; 2
        bne     loop6							; 2nt/3
        dey								; 2
        bne     loop5							; 2nt/3
delay_12:
	rts


.include "effect_sin_window.s"

.include "effect_static.s"




;wait_until_keypress:
;	lda	KEYBOARD
;	bpl	wait_until_keypress
;	bit	KEYRESET
;delay_12:
;	rts


	.include "pt3_lib_detect_model.s"
	.include "pt3_lib_core.s"
	.include "pt3_lib_init.s"
	.include "pt3_lib_mockingboard_setup.s"
	.include "interrupt_handler.s"
	.include "pt3_lib_mockingboard_detect.s"
	.include "pt3_lib_mockingboard_patch.s"

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

;	.byte "DOUBLE DOUBLE by DEATER / DsR ",0
top_string_aux:
	.byte "DUL OBEb ETR/DR",0
top_string_main:
	.byte "OBEDUL yDAE  s ",0


	.byte "DOUBLE DOUBLE by DEATER / DsR ",0
;	.byte "       Graphics based on art by @helpcomputer0  Music: N. UEMATSU",0


config_string:
;             0123456789012345678901234567890123456789
.byte   0,23,"APPLE II?       MOCKINGBOARD: NO        ",0


.include "text_print.s"
.include "title.s"
.include "gr_fast_clear.s"
.include "wait_a_bit.s"
.include "wait.s"
.include "gr_offsets.s"
;.include "load_music.s"


fighting_zx02:
.incbin "music/fighting.zx02"

; 0 = DGR page1
; 1 = 40 Column TEXT page2
; 2 = HGR page2
; 3 = 80 Column TEXT page1
; 4 = ?? page 1
; 5 = LO-RES page1
; 6 = ??
; 7 = double hi-res

middle_table1:
	.byte	<LORES,<SET_TEXT,<HIRES,<SET_TEXT
	.byte	<HIRES,<LORES,<HIRES,<HIRES
middle_table2:
	.byte	<SET80COL,<CLR80COL,<CLR80COL,<SET80COL
	.byte	<SET80COL,<SET80COL,<CLR80COL,<SET80COL
middle_table3:
	.byte	<CLRAN3,<SETAN3,<SETAN3,<SETAN3
	.byte	<SETAN3,<SETAN3,<CLRAN3,<CLRAN3
middle_table4:
	.byte	<PAGE1,<PAGE2,<PAGE2,<PAGE1
	.byte	<PAGE1,<PAGE1,<PAGE2,<PAGE1
