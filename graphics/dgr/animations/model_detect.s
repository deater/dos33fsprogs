
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
;        lda     #<gs_interrupt_handler
;        sta     $3FE
;        lda     #>gs_interrupt_handler
;        sta     $3FF

not_iigs:


	rts

	;===========================
	; Check Apple II model
	;===========================
	; this is mostly for IIc support
	; as it does interrupts differently

	; some of this info from the document:
	; Apple II Family Identification Routines 2.2
	;

	; ' ' = Apple II
	; '+' = Apple II+
	; 'e' = Apple IIe
	; 'c' = Apple IIc
	; 'g' = Apple IIgs
	; 'm' = mac L/C with board
	; 'j' = jplus
	; '3' = Apple III

detect_appleii_model:
	lda	#' '

	ldx	$FBB3

				; II is $38
				; J-plus is $C9
				; II+ is $EA (so is III)
				; IIe and newer is $06

	cpx	#$38			; ii
	beq	done_apple_detect


					; ii+ is EA FB1E=AD
					; iii is EA FB1E=8A 00

	cpx	#$EA
	bne	not_ii_iii
ii_or_iii:

	lda	#'+'			; ii+/iii

	ldx	$FB1E
	cpx	#$AD
	beq	done_apple_detect	; ii+

	lda	#'3'
	bne	done_apple_detect 	; bra iii

not_ii_iii:
	lda	#'j'			; jplus
	cpx	#$C9
	beq	done_apple_detect


	cpx	#$06
	bne	done_apple_detect

apple_iie_or_newer:



	ldx	$FBC0		; $EA on a IIe
				; $E0 on a IIe enhanced
				; $00 on a IIc/IIc+

				; $FE1F = $60, IIgs

	beq	apple_iic

	lda	#'e'
	cpx	#$EA
	beq	done_apple_detect
;	cpx	#$E0
;	beq	done_apple_detect

	; should do something if not $E0

	; GS and IIe enhanced are the same, need to check

	sec				; set carry
	jsr	$FE1F
	bcs	done_apple_detect	;If carry then IIe enhanced

	; get here we're a IIgs?

	lda	#'g'
	bne	done_apple_detect

apple_iic:
	lda	#'c'

done_apple_detect:
	sta	APPLEII_MODEL
	rts
