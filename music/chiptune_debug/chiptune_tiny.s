; VMW Minimal Mockingboard Issue Reproducer

; ZP addresses
MB_CHUNK_OFFSET = $94
MB_VALUE = $91

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


	;=========================
	; Init Variables
	;=========================

	lda	#$0
	sta	MB_CHUNK_OFFSET

	;============================
	; Init the Mockingboard
	;============================

	jsr	mockingboard_init
	jsr	reset_ay_both
	jsr	clear_ay_both

	;=========================
	; Setup Interrupt Handler
	;=========================
	; Vector address goes to 0x3fe/0x3ff

	lda	#<interrupt_handler
	sta	$03fe
	lda	#>interrupt_handler
	sta	$03ff

	;============================
	; Enable 50Hz clock on 6522
	;============================

	sei			; disable interrupts just in case

	lda	#$40		; Continuous interrupts, don't touch PB7
	sta	MOCK_6522_1_ACR	; ACR register
	lda	#$7F		; clear all interrupt flags
	sta	MOCK_6522_1_IER	; IER register (interrupt enable)

	lda	#$C0
	sta	MOCK_6522_1_IFR	; IFR: 1100 0000
				; clear timer interrupt in flag register
				; should we try to clear all?

	sta	MOCK_6522_1_IER	; IER: 1100 0000, enable timer1 interrupt

	lda	#$E7
	sta	MOCK_6522_1_T1C_L	; write into low-order latch
	lda	#$4f
	sta	MOCK_6522_1_T1C_H	; write into high-order latch,
					; load both values into counter
					; clear interrupt and start counting
	; 4fe7 / 1e6 = .020s, 50Hz


	;=========================
	; Setup initial conditions
	;=========================


	; 5: C CHANNEL COARSE
;	ldx	#5
;	lda	#$0			; always 0
;	sta	MB_VALUE
;	jsr	write_ay_both

	; 7: ENABLE
	ldx	#7
	lda	#$38			; noise disabled, ABC enabled
	sta	MB_VALUE
	jsr	write_ay_address_right

	; 10: C Amplitude
	ldx	#10
	lda	#$c			; always volume 12
	sta	MB_VALUE
	jsr	write_ay_address_right

	; 4: C CHANNEL FINE
	ldx	#4
	lda	#$51
	sta	MB_VALUE
	jsr	write_ay_address_right


	;============================
	; Enable 6502 interrupts
	;============================

	cli		; clear interrupt mask

	;============================
	; Loop forever
	;============================
main_loop:

	jmp	main_loop




;=========
;routines
;=========


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


	rts

reset_ay_both:
	;======================
	; Reset Left AY-3-8910
	;======================
reset_ay_left:
	lda	#MOCK_AY_RESET
	sta	MOCK_6522_1_ORB
	lda	#MOCK_AY_INACTIVE
	sta	MOCK_6522_1_ORB

	;======================
	; Reset Right AY-3-8910
	;======================
reset_ay_right:
	lda	#MOCK_AY_RESET
	sta	MOCK_6522_2_ORB
	lda	#MOCK_AY_INACTIVE
	sta	MOCK_6522_2_ORB
	rts


;	Write sequence
;	Inactive -> Latch Address -> Inactive -> Write Data -> Inactive

	;=========================================
	; Write Right/Left to save value AY-3-8910
	;=========================================
	; register in X
	; value in MB_VALUE

write_ay_both:

write_ay_address_left:

	; address
	stx	MOCK_6522_1_ORA		; put address on PA1		; 3
	; on AY-3-8913 hold 300ns
	nop

	lda	#MOCK_AY_LATCH_ADDR	; latch_address on PB1		; 2
	sta	MOCK_6522_1_ORB		; latch_address on PB1		; 3
	nop

	lda	#MOCK_AY_INACTIVE	; go inactive			; 2
	sta	MOCK_6522_1_ORB						; 3

	; on AY-3-8913 hold at least 50ns

	nop



write_ay_value_left:

	lda	MB_VALUE						; 3
	sta	MOCK_6522_1_ORA		; put value on PA1		; 3
			; AY-3-8913 must hold 50ns
	nop


	lda	#MOCK_AY_WRITE		;				; 2
	sta	MOCK_6522_1_ORB		; write on PB1			; 3
			; AY-3-8913 must hold 1800ns
	nop
	nop
	nop
	nop
	nop



	lda	#MOCK_AY_INACTIVE	; go inactive			; 2
	sta	MOCK_6522_1_ORB						; 3
			; AY-3-8913 must hold 100ns
	nop

write_ay_address_right:

	; address
	stx	MOCK_6522_2_ORA		; put address on PA2		; 3
	; on AY-3-8913 hold 300ns
	nop

	lda	#MOCK_AY_LATCH_ADDR	; latch_address on PB2		; 2
	sta	MOCK_6522_2_ORB		; latch_address on PB2		; 3
	nop

	lda	#MOCK_AY_INACTIVE	; go inactive			; 2
	sta	MOCK_6522_2_ORB						; 3

	; on AY-3-8913 hold at least 50ns

	nop

write_ay_value_right:

	lda	MB_VALUE						; 3
	sta	MOCK_6522_2_ORA		; put value on PA2		; 3
			; AY-3-8913 must hold 50ns
	nop


	lda	#MOCK_AY_WRITE		;				; 2
	sta	MOCK_6522_2_ORB		; write on PB2			; 3
			; AY-3-8913 must hold 1800ns
	nop
	nop
	nop
	nop
	nop



	lda	#MOCK_AY_INACTIVE	; go inactive			; 2
	sta	MOCK_6522_2_ORB						; 3
			; AY-3-8913 must hold 100ns
	nop



	rts								; 6
								;===========
								;       53



	;=======================================
	; clear ay -- clear all 14 AY registers
	; should silence the card
	;=======================================
clear_ay_both:
	ldx	#13
	lda	#0
	sta	MB_VALUE
clear_ay_left_loop:
	jsr	write_ay_both
	dex
	bpl	clear_ay_left_loop
	rts





	;================================
	;================================
	; mockingboard interrupt handler
	;================================
	;================================

interrupt_handler:
	pha			; save A				; 3
				; Should we save X and Y too?


	bit	MOCK_6522_1_T1C_L	; clear 6522 interrupt by
					; reading T1C-L	; 4

mb_play_music:


	;======================================
	; Write frames to Mockingboard
	;======================================
	; actually plays frame loaded at end of
	; last interrupt, so 20ms behind?

mb_write_frame:

	ldy	MB_CHUNK_OFFSET


	; 4: C CHANNEL FINE
	lda	c_fine,Y
	sta	MB_VALUE
	ldx	#4
	jsr	write_ay_value_right

increment_offset:
	inc	MB_CHUNK_OFFSET		; increment offset
	lda	MB_CHUNK_OFFSET

	and	#$1			; reduce number played
					; $f = 16
					; $3 = 4
					; $1 = 2
					; $0 = 1

	sta	MB_CHUNK_OFFSET

done_interrupt:
	pla			; restore a				; 4
	rti			; return from interrupt			; 6



; 4: C fine frequency

c_fine:

.byte $51,$3c,$32,$50, $3d,$32,$50,$3c, $33,$50,$3c,$32,$51,$3c,$32,$50



