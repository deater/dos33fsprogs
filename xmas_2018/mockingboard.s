; ZP addresses

; left channel
MOCK_6522_1_ORB	=	$C400	; 6522 #1 port b data
MOCK_6522_1_ORA	=	$C401	; 6522 #1 port a data
MOCK_6522_1_DDRB =	$C402	; 6522 #1 data direction port B
MOCK_6522_1_DDRA =	$C403	; 6522 #1 data direction port A
MOCK_6522_1_T1C_L =	$C404	; 6522 #1 Low-order counter
MOCK_6522_1_T1C_H =	$C405	; 6522 #1 High-order counter
MOCK_6522_1_T1L_L =	$C406	; 6522 #1 Low-order latch
MOCK_6522_1_T1L_H =	$C407	; 6522 #1 High-order latch
MOCK_6522_1_T2C_L =	$C408	; 6522 #1 Timer2 Low-order Latch/Counter
MOCK_6522_1_T2C_H =	$C409	; 6522 #1 Timer2 High-order Latch/Counter
MOCK_6522_1_SR	=	$C40A	; 6522 #1 Shift Register
MOCK_6522_1_ACR	=	$C40B	; 6522 #1 Auxiliary Control Register
MOCK_6522_1_PCR	=	$C40C	; 6522 #1 Peripheral Control Register
MOCK_6522_1_IFR	=	$C40D	; 6522 #1 Interrupt Flag Register
MOCK_6522_1_IER	=	$C40E	; 6522 #1 Interrupt Enable Register
MOCK_6522_1_ORAN =	$C40F	; 6522 #1 port a data, no handshake

; right channel
MOCK_6522_2_ORB	=	$C480	; 6522 #2 port b data
MOCK_6522_2_ORA	=	$C481	; 6522 #2 port a data
MOCK_6522_2_DDRB =	$C482	; 6522 #2 data direction port B
MOCK_6522_2_DDRA =	$C483	; 6522 #2 data direction port A
MOCK_6522_2_T1C_L =	$C484	; 6522 #2 Low-order counter
MOCK_6522_2_T1C_H =	$C485	; 6522 #2 High-order counter
MOCK_6522_2_T1L_L =	$C486	; 6522 #2 Low-order latch
MOCK_6522_2_T1L_H =	$C487	; 6522 #2 High-order latch
MOCK_6522_2_T2C_L =	$C488	; 6522 #2 Timer2 Low-order Latch/Counter
MOCK_6522_2_T2C_H =	$C489	; 6522 #2 Timer2 High-order Latch/Counter
MOCK_6522_2_SR	=	$C48A	; 6522 #2 Shift Register
MOCK_6522_2_ACR	=	$C48B	; 6522 #2 Auxiliary Control Register
MOCK_6522_2_PCR	=	$C48C	; 6522 #2 Peripheral Control Register
MOCK_6522_2_IFR	=	$C48D	; 6522 #2 Interrupt Flag Register
MOCK_6522_2_IER	=	$C48E	; 6522 #2 Interrupt Enable Register
MOCK_6522_2_ORAN =	$C48F	; 6522 #2 port a data, no handshake


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
	lda	#$ff		; all 8 pins output (1), portA

	sta	MOCK_6522_1_DDRA
	sta	MOCK_6522_2_DDRA
				; only 3 pins output (1), port B
	lda	#$7
	sta	MOCK_6522_1_DDRB

	sta	MOCK_6522_2_DDRB


reset_ay_both:
	;======================
	; Reset Left AY-3-8910
	;======================
reset_ay_left:
	lda	#MOCK_AY_RESET
	sta	MOCK_6522_1_ORB
	lda	#MOCK_AY_INACTIVE
	sta	MOCK_6522_1_ORB

	; AY-3-8913: Wait 5 us
	nop
	nop
	nop
	nop
	nop

	;======================
	; Reset Right AY-3-8910
	;======================
reset_ay_right:
	lda	#MOCK_AY_RESET
	sta	MOCK_6522_2_ORB
	lda	#MOCK_AY_INACTIVE
	sta	MOCK_6522_2_ORB

	; AY-3-8913: Wait 5 us
	nop
	nop
	nop
	nop
	nop

	;=========================
	; Setup initial conditions
	;=========================

	; 7: ENABLE
	ldx	#7
	lda	#$38			; noise disabled, ABC enabled
	sta	MB_VALUE
	jsr	write_ay_both

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
	; Enable 60Hz clock on 6522
	;============================

	sei			; disable interrupts just in case

	lda	#$40		; Continuous interrupts, don't touch PB7
	sta	$C40B		; ACR register
	lda	#$7F		; clear all interrupt flags
	sta	$C40E		; IER register (interrupt enable)

	lda	#$C0
	sta	$C40D		; IFR: 1100, enable interrupt on timer one oflow
	sta	$C40E		; IER: 1100, enable timer one interrupt

	lda	#$1a
	sta	$C404		; write into low-order latch
	lda	#$41
	sta	$C405		; write into high-order latch,
				; load both values into counter
				; clear interrupt and start counting

	; 9c40 / 1e6 = .040s, 25Hz
	; 4fe7 / 1e6 = .020s, 50Hz
	; 411a / 1e6 = .016s, 60Hz

	rts

interrupt_handler:
	; A saved by firmware in $45
;	sta	$45
	txa
	pha			; save X
	tya
	pha			; save Y

	bit     $C404           ; clear 6522 interrupt by reading T1C-L ; 4

	jsr	play_music

	pla
	tay			; restore Y
	pla
	tax			; restore X
	lda	$45		; restore A

	rti			; return from interrupt                 ; 6


	;=========================================
	; Write Right/Left to save value AY-3-8910
	;=========================================
	; register in X
	; value in MB_VALUE

write_ay_both:
	; address
	stx	MOCK_6522_1_ORA		; put address on PA1		; 4
	stx	MOCK_6522_2_ORA		; put address on PA2		; 4
	lda	#MOCK_AY_LATCH_ADDR	; latch_address on PB1		; 2
	sta	MOCK_6522_1_ORB		; latch_address on PB1		; 4
	sta	MOCK_6522_2_ORB		; latch_address on PB2		; 4
	lda	#MOCK_AY_INACTIVE	; go inactive			; 2
	sta	MOCK_6522_1_ORB						; 4
	sta	MOCK_6522_2_ORB						; 4
								;===========
								;        28
	; value
	lda	MB_VALUE						; 3
	sta	MOCK_6522_1_ORA		; put value on PA1		; 4
	sta	MOCK_6522_2_ORA		; put value on PA2		; 4
	lda	#MOCK_AY_WRITE		;				; 2
	sta	MOCK_6522_1_ORB		; write on PB1			; 4
	sta	MOCK_6522_2_ORB		; write on PB2			; 4
	lda	#MOCK_AY_INACTIVE	; go inactive			; 2
	sta	MOCK_6522_1_ORB						; 4
	sta	MOCK_6522_2_ORB						; 4
								;===========
								;        31

	rts								; 6
								;===========
								;       65

mockingboard_mute:
	ldx	#7
	lda	#$ff
	sta	MB_VALUE
	jmp	write_ay_both
