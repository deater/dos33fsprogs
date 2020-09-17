
mockingboard_detect:

	;================================
	; Mockingboard detect
	;================================

	jsr	mockingboard_detect_slot4       ; call detection routine
	stx	MB_DETECTED

	;================================
	; Mockingboard start
	;================================

mockingboard_setup:
	sei			; disable interrupts just in case

	jsr	mockingboard_init
	jsr	reset_ay_both
	jsr	clear_ay_both

	;=========================
	; Setup Interrupt Handler
	;=========================
	; Vector address goes to 0x3fe/0x3ff
	; FIXME: should chain any existing handler

	lda	#<interrupt_handler
	sta	$03fe
	lda	#>interrupt_handler
	sta	$03ff

	;============================
	; Enable 50Hz clock on 6522
	;============================

	lda	#$40		; Continuous interrupts, don't touch PB7
	sta	$C40B		; ACR register
	lda	#$7F		; clear all interrupt flags
	sta	$C40E		; IER register (interrupt enable)

	lda	#$C0
	sta	$C40D		; IFR: 1100, enable interrupt on timer one oflow
	sta	$C40E		; IER: 1100, enable timer one interrupt

	lda	#$e7
	sta	$C404		; write into low-order latch
	lda	#$4f
	sta	$C405		; write into high-order latch,
				; load both values into counter
				; clear interrupt and start counting

	; 4fe7 / 1e6 = .020s, 50Hz
	; 9c40 / 1e6 = .040s, 25Hz

	;============================
	; Start Playing
	;============================
main_loop:
	lda	MB_DETECTED
	beq	mockingboard_setup_done

	lda	#0
	sta	DONE_PLAYING
	sta	WHICH_CHUNK
	sta	MB_CHUNK_OFFSET
	sta	MB_ADDRL		; we are aligned, so should be 0

	lda	#>music_start
	sta	MB_ADDRH

	;=====================================
	; clear register area
	;=====================================
	ldx	#13							; 2
	lda	#0							; 2
mb_setup_clear_reg:
	sta	REGISTER_DUMP,X	; clear register value			; 4
	sta	REGISTER_OLD,X	; clear old values			; 4
	dex								; 2
	bpl	mb_setup_clear_reg					; 2nt/3

	cli			; start interrupts

mockingboard_setup_done:

	rts
