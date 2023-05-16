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
.if 0
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
.endif

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

PT3_LOC = $b000


.if 0
	lda	#<fighting_zx02
	sta	ZX0_src

	lda     #>fighting_zx02
	sta	ZX0_src+1

	lda     #$b0		; decompress at $b000

	jsr	full_decomp


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
.endif
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

	;==================================
        ; get exact vblank region
        ;==================================
	; from Sather / Apple IIe / 3-26
	;
	; takes up to 7 frames

poll1:
	lda	VBLANK		; Find end of VBL
	bmi	poll1		; Fall through at VBL
poll2:
	lda	VBLANK
	bpl	poll2		; Fall through at VBL'                  ; 2

	lda	$00		; Now slew back in 17029 cycle loops    ; 3
lp17029:
        ldx	#17		;					; 2
        jsr	waitx1k		;					; 17000
        jsr	delay_12	;					; 12
        lda	$00		; nop3					; 3
        lda	$00		; nop3					; 3
	lda	VBLANK		; Back to VBL yet?			; 4
	nop			;					; 2
	bmi     lp17029		; no, slew back				; 2/3



	;=================================
	; do effects
	;=================================

midline_loop:

effect_midline:


outer_loop:

	ldx	#192		; 2
; 2
	lda	$00	; nop 3	; 3
; 5
	jmp	skip_nop
; 8

inner_loop:

	nop			; 2
	nop			; 2
	nop			; 2
	nop			; 2

skip_nop:

; 8

	; set text
	sta	LORES		; 4
	sta	SET_TEXT	; 4
	sta	SETAN3		; 4
	sta	CLR80COL	; 4
;	bit	PAGE1		; 4
	nop
	nop

; 28

	jsr	delay_12	; 12

; 40

	; set double-hires
	sta	SET_GR		; 4
	sta	HIRES		; 4
	sta	CLRAN3		; 4
	sta	SET80COL	; 4
	bit	PAGE2		; 4

; 60

	dex			; 2
; 62
	bne	inner_loop	; 2/3
; 65


				; -1

	;==================================
        ; vblank = 4550 cycles

        ; Try X=226 Y=4 cycles=4545
skip_vblank:
	lda	$00	; nop3

        ldy     #4                                                      ; 2
loop3:  ldx     #226                                                    ; 2
loop4:  dex                                                             ; 2
        bne     loop4                                                   ; 2nt/3
        dey                                                             ; 2
        bne     loop3                                                   ; 2nt/3

	jmp	midline_loop	; 3

.align $100

	;===================================
        ; wait y-reg times 10
        ;===================================

loop10:
        bne     skip
waitx10:
        dey                     ; wait y-reg times 10                   ; 2
skip:
        dey                                                             ; 2
        nop                                                             ; 2
        bne     loop10                                                  ; 2/3
        rts                                                             ; 6


	;===================================
        ; wait x-reg times 1000
        ;===================================

loop1k:
        pha                                                             ; 3
        pla                                                             ; 4
        nop                                                             ; 2
        nop                                                             ; 2
waitx1k:
        ldy     #98                     ; wait x-reg times 1000         ; 2
        jsr     waitx10                                                 ; 980
        nop                                                             ; 2
        dex                                                             ; 2
        bne     loop1k                                                  ; 2/3
rts1:
        rts                                                             ; 6



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


;fighting_zx02:
;.incbin "music/fighting.zx02"

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
