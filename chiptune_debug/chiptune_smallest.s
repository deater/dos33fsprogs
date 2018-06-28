; VMW Minimal Mockingboard Issue Reproducer

; ZP addresses
MB_CHUNK_OFFSET = $94
MB_VALUE = $91

WAIT = $FCA8

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



	;=========================
	; Init Variables
	;=========================

	lda	#$0
	sta	MB_CHUNK_OFFSET

	;============================
	; Init the Mockingboard
	;============================

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


	nop
	nop
	nop
	nop
	nop
	nop


	;=========================
	; Setup initial conditions
	;=========================


	; 5: C CHANNEL COARSE
	ldx	#5
	lda	#$0			; always 0
	sta	MB_VALUE
	jsr	write_ay_address_right

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


main_loop:


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
;	ldx	#4
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


	;============================
	; delay 20ms?
	;============================
	lda     #85
	jsr     WAIT    ; wait 20ms or so

	jmp	main_loop



;	Write sequence
;	Inactive -> Latch Address -> Inactive -> Write Data -> Inactive

	;=========================================
	; Write Right/Left to save value AY-3-8910
	;=========================================
	; register in X
	; value in MB_VALUE


write_ay_address_right:

	lda	#MOCK_AY_LATCH_ADDR	; latch_address on PB1		; 2
	sta	MOCK_6522_2_ORB		; latch_address on PB1		; 3

	; address
	stx	MOCK_6522_2_ORA		; put address on PA1		; 3
	; on AY-3-8913 hold 300ns


	lda	#MOCK_AY_INACTIVE	; go inactive			; 2
	sta	MOCK_6522_2_ORB						; 3

	; on AY-3-8913 hold at least 50ns


write_ay_value_right:

	lda	MB_VALUE						; 3
	sta	MOCK_6522_2_ORA		; put value on PA2		; 3
			; AY-3-8913 must hold 50ns

	lda	#MOCK_AY_WRITE		;				; 2
	sta	MOCK_6522_2_ORB		; write on PB2			; 3
			; AY-3-8913 must hold 1800ns

	lda	#MOCK_AY_INACTIVE	; go inactive			; 2
	sta	MOCK_6522_2_ORB						; 3
			; AY-3-8913 must hold 100ns


	rts								; 6
								;===========
								;       53

c_fine:

.byte $51,$3c
;.byte $32,$50, $3d,$32,$50,$3c, $33,$50,$3c,$32,$51,$3c,$32,$50



