;====================
; Hardware Detect
;	called for disk1 and disk2

; simplified version that just detects model and mockingboard
;	for the fake BIOS we do a bit more, but we do rely
;	on this being run first

hardware_detect:

	;=======================
	; Hardware Detect Model
	;=======================
	; Yes Michaelangel007 I will eventually update linux_logo 6502

	jsr	detect_appleii_model

	lda	APPLEII_MODEL
	cmp	#'g'
	bne	not_iigs

is_a_iigs:

	; enable 1MHz mode
	; see hw.accel.a in 4cade
setspeed:
	lda	CYAREG
	and	#$7f
	sta	CYAREG

	; gr/text page2 handling broken on early IIgs models
	; this enables the workaround

	jsr	ROM_TEXT2COPY           ; set alternate display mode on IIgs


	; set background color to black instead of blue
	lda     NEWVIDEO
	and	#%00011111	; bit 7 = 0 -> IIgs Apple II-compat video modes
				; bit 6 = 0 -> IIgs 128K memory map same as IIe
				; bit 5 = 0 -> IIgs DHGR is color, not mono
				; bits 0-4 unchanged
	sta	NEWVIDEO
	lda	#$F0
	sta	TBCOLOR		; white text on black background
	lda	#$00
	sta	CLOCKCTL	; black border
	sta	CLOCKCTL	; set twice for VidHD

        ; gs always swaps in RAM
        lda     #<gs_interrupt_handler
        sta     $3FE
        lda     #>gs_interrupt_handler
        sta     $3FF

not_iigs:


	;======================
	; detect mockingboard

	lda	#0
	sta	SOUND_STATUS

;PT3_ENABLE_APPLE_IIC = 1		; we set this earlier

	jsr	mockingboard_detect
	bcc	mockingboard_notfound

mockingboard_found:

	lda	SOUND_STATUS
	ora	#SOUND_MOCKINGBOARD
	sta	SOUND_STATUS

mockingboard_notfound:

	rts

.include "pt3_lib_mockingboard.inc"
