	;================================
	;================================
	; mockingboard interrupt handler
	;================================
	;================================
	; On Apple II/6502 the interrupt handler jumps to address in 0xfffe
	; This is in the ROM, which saves the registers
	;   on older IIe it saved A to $45 (which could mess with DISK II)
	;   newer IIe doesn't do that.
	; It then calculates if it is a BRK or not (which trashes A)
	; Then it sets up the stack like an interrupt and calls 0x3fe

	; Note: the IIc is much more complicated
	;	its firmware tries to decode the proper source
	;	based on various things, including screen hole values
	;	we bypass that by switching out ROM and replacing the
	;	$fffe vector with this, but that does mean we have
	;	to be sure status flag and accumulator set properly


TIME_OFFSET	=	13

interrupt_handler:
	php
	pha			; save A				; 3
				; A is saved in $45 by firmware
	txa
	pha			; save X
	tya
	pha			; save Y

;	inc	$0404		; debug (flashes char onscreen)


.include "pt3_lib_irq_handler.s"

	;==============================================
	; only update time counter if not done playing
	;==============================================

	lda	DONE_PLAYING						; 3
	bne	check_keyboard

	;=====================
	; Update time counter
	;=====================
	; self-modifying version via qkumba
update_time:
	inc	frame_count_smc+1					; 5
frame_count_smc:
	lda	#$0							; 2
	eor	#50							; 3
	bne	done_time						; 3/2nt

	sta	frame_count_smc+1					; 3

	ldx	$7d0+TIME_OFFSET+3					; 4
	cpx	#'9'+$80						; 2
	bne	update_second_ones					; 3/2nt

	ldx	$7d0+TIME_OFFSET+2					; 4
	cpx	#'5'+$80	; 6-1 (for 60 seconds)			; 2
	bne	update_second_tens					; 3/2nt

update_minutes:
	inc	$7d0+TIME_OFFSET					; 6
	inc	$bd0+TIME_OFFSET					; 6

	ldx	#'0'+$80-1						; 2

update_second_tens:
	inx								; 2
	stx	$7d0+TIME_OFFSET+2					; 4
	stx	$bd0+TIME_OFFSET+2					; 4

	ldx	#'0'+$80-1						; 2

update_second_ones:
	inx								; 2
	stx	$7d0+TIME_OFFSET+3					; 4
	stx	$bd0+TIME_OFFSET+3					; 4
				; we don't handle > 9:59 songs yet
done_time:
								;=============
								;     52 worst


	;=================================
	; Handle keyboard
	;=================================

check_keyboard:

	jsr	get_key
	tax
	beq	exit_interrupt

	;====================
	; space pauses

	cmp	#(' '+$80)		; set carry if true
	bne	key_M
key_space:
	lda	#$80
	eor	DONE_PLAYING

	; disable fire when paused

	sta	DONE_PLAYING
	beq	yes_bar
	lda	#0
	beq	lowbar			; branch always
yes_bar:
	lda	#7
lowbar:
	jsr	fire_setline

	ldx	DONE_PLAYING

	bcs	quiet_exit		; branch always

	;===========================
	; M key switches MHz mode

key_M:
	cmp	#'M'
	bne	key_L			; set carry if true

	ldx	#'0'+$80
	lda	convert_177_smc1
	eor	#$20
	sta	convert_177_smc1
	sta	convert_177_smc2
	sta	convert_177_smc3
	sta	convert_177_smc4
	sta	convert_177_smc5
	cmp	#$18
	beq	at_MHz

	; update text on screen

	ldx	#'7'+$80

at_MHz:
	stx	$7F4
	stx	$BF4

	bcs	done_key		; branch always


	;===========================
	; L enables loop mode

key_L:
	cmp	#'L'
	bne	key_left		; set carry if true

	ldx	#'/'+$80
	lda	LOOP
	eor	#$1
	sta	LOOP
	beq	music_looping

	; update text on screen

	ldx	#'L'+$80

music_looping:
	stx	$7D0+18
	stx	$BD0+18

	bcs	done_key		; branch always


	;======================
	; left key, to prev song

key_left:
	ldx	#$40
	cmp	#'A'
	beq	quiet_exit

	;========================
	; right key, to next song

key_right:
	ldx	#$20
	cmp	#'D'
	bne	done_key

	;========================
	; stop playing for now
	; quiet down the Mockingboard
	; (otherwise will be stuck on last note)

quiet_exit:
	stx	DONE_PLAYING
	jsr	clear_ay_both

	;ldx	#$ff		; also mute the channel
	stx	AY_REGISTERS+7 ; just in case

done_key:
exit_interrupt:

	pla
	tay			; restore Y
	pla
	tax			; restore X

	pla			; restore a				; 4

	; this is needed on II+/IIe not not IIc
interrupt_smc:
	lda	$45		; restore A
	plp

	rti			; return from interrupt			; 6

								;============
								; typical
								; ???? cycles


