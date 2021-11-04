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
MOCK_6522_T1CL	=	$C404	; 6522 #1 t1 low order latches
MOCK_6522_T1CH	=	$C405	; 6522 #1 t1 high order counter
MOCK_6522_T1LL	=	$C406	; 6522 #1 t1 low order latches
MOCK_6522_T1LH	=	$C407	; 6522 #1 t1 high order latches
MOCK_6522_T2CL	=	$C408	; 6522 #1 t2 low order latches
MOCK_6522_T2CH	=	$C409	; 6522 #1 t2 high order counters
MOCK_6522_SR	=	$C40A	; 6522 #1 shift register
MOCK_6522_ACR	=	$C40B	; 6522 #1 auxilliary control register
MOCK_6522_PCR	=	$C40C	; 6522 #1 peripheral control register
MOCK_6522_IFR	=	$C40D	; 6522 #1 interrupt flag register
MOCK_6522_IER	=	$C40E	; 6522 #1 interrupt enable register
MOCK_6522_ORANH	=	$C40F	; 6522 #1 port a data no handshake


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
	;========================
	; Mockingboard Init
	;========================
	;========================

mockingboard_init:



	;=========================
	; Initialize the 6522s
	; set the data direction for all pins of PortA/PortB to be output


	lda	#$ff		; all output (1)

	sta	MOCK_6522_DDRB1	; set for 6522 #1
	sta	MOCK_6522_DDRA1

	sta	MOCK_6522_DDRB2	; set for 6522 #2
	sta	MOCK_6522_DDRA2


mockingboard_setup_interrupt:

	;=========================
	; Setup Interrupt Handler
	;=========================

	; NOTE: we don't support IIc as it's a hack
	;	traditionally Mockingboard on IIc was rare

	;========================
	; set up interrupt
	; Vector address goes to 0x3fe/0x3ff

	lda	#<interrupt_handler
	sta	$03fe
	lda	#>interrupt_handler
	sta	$03ff

	;============================
	; Enable 50Hz clock on 6522
	;============================


	; Note, on Apple II the clock isn't 1MHz but is actually closer to
	;       roughly 1.023MHz, and every 65th clock is stretched (it's complicated)

	; 9c40 / 1.023e6 = .040s, 25Hz
	; 8534 / 1.023e6 = .033s, 30Hz
	; 4fe7 / 1.023e6 = .020s, 50Hz
	; 411a / 1.023e6 = .016s, 60Hz

	; French Touch uses
	; 4e20 / 1.000e6 = .020s, 50Hz, which assumes 1MHz clock freq

	sei			; disable interrupts just in case

	lda	#$40		; Continuous interrupts, don't touch PB7
	sta	MOCK_6522_ACR	; ACR register

	lda	#$7F		; clear all interrupt flags
	sta	MOCK_6522_IER	; IER register (interrupt enable)

	lda	#$C0
	sta	MOCK_6522_IFR	; IFR: 1100, enable interrupt on timer one oflow
	sta	MOCK_6522_IER	; IER: 1100, enable timer one interrupt

	lda	#$34
;	lda	#$E7
	sta	MOCK_6522_T1CL	; write into low-order latch

	lda	#$85
;	lda	#$4f
	sta	MOCK_6522_T1CH	; write into high-order latch,
				; load both values into counter
				; clear interrupt and start counting



	;===================================
	;===================================
	; Reset Both AY-3-8910s
	;===================================
	;===================================

	;===========================
	; Reset Right/Left AY-3-8910
	;===========================
	lda	#MOCK_AY_RESET
	sta	MOCK_6522_ORB1
	sta	MOCK_6522_ORB2
	lda	#MOCK_AY_INACTIVE
	sta	MOCK_6522_ORB1
	sta	MOCK_6522_ORB2

init_registers:

	; init song data

	lda	#0
	sta	SONG_OFFSET
	sta	SONG_COUNTDOWN

	; read 14 bytes from beginning of song to init

	ldx	#13
init_loop:
init_smc:
	txa
	tay
	lda	(SONG_L),Y
	jsr	ay3_write_reg
	dex
	bne	init_loop

	; update SONG_L to point to beginning
	lda	SONG_L
	clc
	adc	#14
	sta	SONG_L
	bcc	no_oflo
	inc	SONG_H
no_oflo:

	rts


	;=====================
	;=====================
	;=====================
	; ay3 write reg
	;=====================
	;=====================
	;=====================
	; writes to both chips (so same output to both Right/Left)
	; address in X (preserved)
	; value in A

	; NOTE: it looks like you could interleave things to save bytes
	; but technically this violates the AY-3-8910 spec sheet on
	; finishing accesses in less than 10us (10 cycles)

ay3_write_reg:
	pha
	lda	#MOCK_AY_LATCH_ADDR     ; latch_address for PB1         ; 2
	ldy	#MOCK_AY_INACTIVE       ; go inactive                   ; 2

	stx	MOCK_6522_ORA1          ; put address on PA1            ; 4
	sta	MOCK_6522_ORB1          ; latch_address on PB1          ; 4
	sty	MOCK_6522_ORB1                                          ; 4

	stx	MOCK_6522_ORA2          ; put address on PA2            ; 4
	sta	MOCK_6522_ORB2          ; latch_address on PB2		; 4
	sty	MOCK_6522_ORB2						; 4
	pla

	; value
	sta	MOCK_6522_ORA1          ; put value on PA1              ; 4
	sta	MOCK_6522_ORA2          ; put value on PA2              ; 4
	lda	#MOCK_AY_WRITE          ;                               ; 2

	sta	MOCK_6522_ORB1          ; write on PB1                  ; 4
	sty	MOCK_6522_ORB1                                          ; 4

	sta	MOCK_6522_ORB2          ; write on PB2                  ; 4
	sty	MOCK_6522_ORB2                                          ; 4

	rts
