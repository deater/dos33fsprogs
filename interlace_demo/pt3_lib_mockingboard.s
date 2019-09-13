; Mockingboad programming:
; + Has two 6522 I/O chips connected to two AY-3-8910 chips
; + Optionally has some speech chips controlled via the outport on the AY
; + Often in slot 4
;	TODO: how to auto-detect?
; References used:
;	http://macgui.com/usenet/?group=2&id=8366
;	6522 Data Sheet
;	AY-3-8910 Data Sheet

;========================
; Mockingboard card
; Essentially two 6522s hooked to the Apple II bus
; Connected to AY-3-8910 chips
;	PA0-PA7 on 6522 connected to DA0-DA7 on AY
;	PB0     on 6522 connected to BC1
;	PB1	on 6522 connected to BDIR
;	PB2	on 6522 connected to RESET


; left speaker
MOCK_6522_ORB1	=	$C400	; 6522 #1 port b data
MOCK_6522_ORA1	=	$C401	; 6522 #1 port a data
MOCK_6522_DDRB1	=	$C402	; 6522 #1 data direction port B
MOCK_6522_DDRA1	=	$C403	; 6522 #1 data direction port A

; right speaker
MOCK_6522_ORB2	=	$C480	; 6522 #2 port b data
MOCK_6522_ORA2	=	$C481	; 6522 #2 port a data
MOCK_6522_DDRB2	=	$C482	; 6522 #2 data direction port B
MOCK_6522_DDRA2	=	$C483	; 6522 #2 data direction port A

; AY-3-8910 commands on port B
;						RESET	BDIR	BC1
MOCK_AY_RESET		=	$0	;	0	0	0
MOCK_AY_INACTIVE	=	$4	;	1	0	0
MOCK_AY_READ		=	$5	;	1	0	1
MOCK_AY_WRITE		=	$6	;	1	1	0
MOCK_AY_LATCH_ADDR	=	$7	;	1	1	1


	;========================
	; Mockingboard Init
	;========================
	; Initialize the 6522s
	; set the data direction for all pins of PortA/PortB to be output

mockingboard_init:
	lda	#$ff		; all output (1)
	sta	MOCK_6522_DDRB1
	sta	MOCK_6522_DDRA1
	sta	MOCK_6522_DDRB2
	sta	MOCK_6522_DDRA2
	rts

	;======================
	; Reset Left AY-3-8910
	;======================
reset_ay_both:
	lda	#MOCK_AY_RESET
	sta	MOCK_6522_ORB1
	lda	#MOCK_AY_INACTIVE
	sta	MOCK_6522_ORB1

	;======================
	; Reset Right AY-3-8910
	;======================
;reset_ay_right:
;could be merged with both
	lda	#MOCK_AY_RESET
	sta	MOCK_6522_ORB2
	lda	#MOCK_AY_INACTIVE
	sta	MOCK_6522_ORB2
	rts


;	Write sequence
;	Inactive -> Latch Address -> Inactive -> Write Data -> Inactive

	;=========================================
	; Write Right/Left to save value AY-3-8910
	;=========================================
	; register in X
	; value in MB_VALUE

write_ay_both:
	; address
	stx	MOCK_6522_ORA1		; put address on PA1		; 3
	stx	MOCK_6522_ORA2		; put address on PA2		; 3
	lda	#MOCK_AY_LATCH_ADDR	; latch_address on PB1		; 2
	sta	MOCK_6522_ORB1		; latch_address on PB1		; 3
	sta	MOCK_6522_ORB2		; latch_address on PB2		; 3
	ldy	#MOCK_AY_INACTIVE	; go inactive			; 2
	sty	MOCK_6522_ORB1						; 3
	sty	MOCK_6522_ORB2						; 3

	; value
	lda	MB_VALUE						; 3
	sta	MOCK_6522_ORA1		; put value on PA1		; 3
	sta	MOCK_6522_ORA2		; put value on PA2		; 3
	lda	#MOCK_AY_WRITE		;				; 2
	sta	MOCK_6522_ORB1		; write on PB1			; 3
	sta	MOCK_6522_ORB2		; write on PB2			; 3
	sty	MOCK_6522_ORB1						; 3
	sty	MOCK_6522_ORB2						; 3

	rts								; 6
								;===========
								;       51
	;=======================================
	; clear ay -- clear all 14 AY registers
	; should silence the card
	;=======================================
clear_ay_both:
	ldx	#14
	lda	#0
	sta	MB_VALUE
clear_ay_left_loop:
	jsr	write_ay_both
	dex
	bpl	clear_ay_left_loop
	rts

	;=======================================
	; Detect a Mockingboard card
	;=======================================
	; Based on code from the French Touch "Pure Noise" Demo
	; Attempts to time an instruction sequence with a 6522
	;
	; If found, puts in  bMB
	; MB_ADDRL:MB_ADDRH has address of Mockingboard
	; returns X=0 if not found, X=1 if found

mockingboard_detect:
	lda	#0
	sta	MB_ADDRL

mb_detect_loop:	; self-modifying
	lda	#$07	; we start in slot 7 ($C7) and go down to 0 ($C0)
	ora	#$C0	; make it start with C
	sta	MB_ADDRH
	ldy	#04	; $CX04
	ldx	#02	; 2 tries?
mb_check_cycle_loop:
	lda	(MB_ADDRL),Y		; timer 6522 (Low Order Counter)
					; count down
	sta	PT3_TEMP		; 3 cycles
	lda	(MB_ADDRL),Y		; + 5 cycles = 8 cycles
					; between the two accesses to the timer
	sec
	sbc	PT3_TEMP		; subtract to see if we had 8 cycles
	cmp	#$f8			; -8
	bne	mb_not_in_this_slot
	dex				; decrement, try one more time
	bne	mb_check_cycle_loop	; loop detection
	inx				; Mockingboard found (X=1)
done_mb_detect:
	;stx	bMB			; store result to bMB
	rts				; return

mb_not_in_this_slot:
	dec	mb_detect_loop+1	; decrement the "slot" (self_modify)
	bne	mb_detect_loop		; loop down to one
	ldx	#00
	beq	done_mb_detect

;alternative MB detection from Nox Archaist
;	lda	#$04
;	sta	MB_ADDRL
;	ldx	#$c7
;
;find_mb:
;	stx	MB_ADDRH
;
;	;detect sound I
;
;	sec
;	ldy	#$00
;	lda	(MB_ADDRL), y
;	sbc	(MB_ADDRL), y
;	cmp	#$05
;	beq	found_mb
;	dex
;	cpx	#$c0
;	bne	find_mb
;	ldx	#$00 ;no mockingboard found
;	rts
;
;found_mb:
;	ldx	#$01 ;mockingboard found
;	rts
;
;	;optionally detect sound II
;
;	sec
;	ldy	#$80
;	lda	(MB_ADDRL), y
;	sbc	(MB_ADDRL), y
;	cmp	#$05
;	beq	found_mb


	;=======================================
	; Detect a Mockingboard card in Slot4
	;=======================================
	; Based on code from the French Touch "Pure Noise" Demo
	; Attempts to time an instruction sequence with a 6522
	;
	; MB_ADDRL:MB_ADDRH has address of Mockingboard
	; returns X=0 if not found, X=1 if found

mockingboard_detect_slot4:
	lda	#0
	sta	MB_ADDRL

mb4_detect_loop:	; self-modifying
	lda	#$04	; we're only looking in Slot 4
	ora	#$C0	; make it start with C
	sta	MB_ADDRH
	ldy	#04	; $CX04
	ldx	#02	; 2 tries?
mb4_check_cycle_loop:
	lda	(MB_ADDRL),Y		; timer 6522 (Low Order Counter)
					; count down
	sta	PT3_TEMP		; 3 cycles
	lda	(MB_ADDRL),Y		; + 5 cycles = 8 cycles
					; between the two accesses to the timer
	sec
	sbc	PT3_TEMP		; subtract to see if we had 8 cycles
	cmp	#$f8			; -8
	bne	mb4_not_in_this_slot
	dex				; decrement, try one more time
	bne	mb4_check_cycle_loop	; loop detection
	inx				; Mockingboard found (X=1)
done_mb4_detect:
	rts				; return

mb4_not_in_this_slot:
	ldx	#00
	beq	done_mb4_detect

.if 0
	;=============================
	; Setup
	;=============================
pt3_setup_interrupt:

	;===========================
	; Check for Apple IIc
	;===========================
	; it does interrupts differently

	lda	$FBB3           ; IIe and newer is $06
	cmp	#6
	beq	apple_iie_or_newer

	jmp	done_apple_detect
apple_iie_or_newer:
	lda	$FBC0		; 0 on a IIc
	bne	done_apple_detect
apple_iic:
	; activate IIc mockingboard?
	; this might only be necessary to allow detection
	; I get the impression the Mockingboard 4c activates
	; when you access any of the 6522 ports in Slot 4
	lda	#$ff
	sta	$C403
	sta	$C404

	; bypass the firmware interrupt handler
	; should we do this on IIe too? probably faster

	sei				; disable interrupts
	lda	$c08b			; disable ROM (enable language card)
	lda	$c08b
	lda	#<interrupt_handler
	sta	$fffe
	lda	#>interrupt_handler
	sta	$ffff

	lda	#$EA			; nop out the "lda $45" in the irq hand
	sta	interrupt_smc
	sta	interrupt_smc+1

done_apple_detect:


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

	sei			; disable interrupts just in case

	lda	#$40		; Continuous interrupts, don't touch PB7
	sta	$C40B		; ACR register
	lda	#$7F		; clear all interrupt flags
	sta	$C40E		; IER register (interrupt enable)

	lda	#$C0
	sta	$C40D		; IFR: 1100, enable interrupt on timer one oflow
	sta	$C40E		; IER: 1100, enable timer one interrupt

	lda	#$E7
	sta	$C404		; write into low-order latch
	lda	#$4f
	sta	$C405		; write into high-order latch,
				; load both values into counter
				; clear interrupt and start counting

	; 4fe7 / 1e6 = .020s, 50Hz

	rts
.endif


	;==================================
	; Print mockingboard detect message
	;==================================
	; note: on IIc must do this before enabling interrupt
	;	as we disable ROM (COUT won't work?)

print_mockingboard_detect:

	; print detection message
	ldy	#0
print_mocking_message:
	lda	mocking_message,Y		; load loading message
	beq	done_mocking_message
	ora	#$80
	jsr	COUT
	iny
	jmp	print_mocking_message
done_mocking_message:
	jsr	CROUT1

	rts

print_mocking_notfound:

	ldy	#0
print_not_message:
	lda	not_message,Y		; load loading message
	beq	print_not_message_done
	ora	#$80
	jsr	COUT
	iny
	jmp	print_not_message
print_not_message_done:
	rts

print_mocking_found:
	ldy	#0
print_found_message:
	lda	found_message,Y		; load loading message
	beq	done_found_message
	ora	#$80
	jsr	COUT
	iny
	jmp	print_found_message
done_found_message:

	rts

;=========
; strings
;=========
mocking_message:	.asciiz "LOOKING FOR MOCKINGBOARD IN SLOT #4"
not_message:		.byte "NOT "
found_message:		.asciiz "FOUND"


