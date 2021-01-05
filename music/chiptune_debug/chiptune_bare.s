; VMW Chiptune Player

.include	"zp.inc"

	;=============================
	; Setup
	;=============================

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

	;==================
	; load first song
	;==================

	;=========================
	; Init Variables
	;=========================

	lda	#$0
	sta	MB_CHUNK_OFFSET
	lda	#3
	sta	CHUNKSIZE

	;===========================
	; Load in KRW file
	;===========================

	lda	#<UNPACK_BUFFER		; set input pointer
	sta	INL
	lda	#>UNPACK_BUFFER
	sta	INH


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

; left speaker
MOCK_6522_ORB1	EQU	$C400	; 6522 #1 port b data
MOCK_6522_ORA1	EQU	$C401	; 6522 #1 port a data
MOCK_6522_DDRB1	EQU	$C402	; 6522 #1 data direction port B
MOCK_6522_DDRA1	EQU	$C403	; 6522 #1 data direction port A

; right speaker
MOCK_6522_ORB2	EQU	$C480	; 6522 #2 port b data
MOCK_6522_ORA2	EQU	$C481	; 6522 #2 port a data
MOCK_6522_DDRB2	EQU	$C482	; 6522 #2 data direction port B
MOCK_6522_DDRA2	EQU	$C483	; 6522 #2 data direction port A

; AY-3-8910 commands on port B
;						RESET	BDIR	BC1
MOCK_AY_RESET		EQU	$0	;	0	0	0
MOCK_AY_INACTIVE	EQU	$4	;	1	0	0
MOCK_AY_READ		EQU	$5	;	1	0	1
MOCK_AY_WRITE		EQU	$6	;	1	1	0
MOCK_AY_LATCH_ADDR	EQU	$7	;	1	1	1


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
	lda	#MOCK_AY_INACTIVE	; go inactive			; 2
	sta	MOCK_6522_ORB1						; 3
	sta	MOCK_6522_ORB2						; 3

	; value
	lda	MB_VALUE						; 3
	sta	MOCK_6522_ORA1		; put value on PA1		; 3
	sta	MOCK_6522_ORA2		; put value on PA2		; 3
	lda	#MOCK_AY_WRITE		;				; 2
	sta	MOCK_6522_ORB1		; write on PB1			; 3
	sta	MOCK_6522_ORB2		; write on PB2			; 3
	lda	#MOCK_AY_INACTIVE	; go inactive			; 2
	sta	MOCK_6522_ORB1						; 3
	sta	MOCK_6522_ORB2						; 3

	rts								; 6
								;===========
								;       53
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





	;================================
	;================================
	; mockingboard interrupt handler
	;================================
	;================================

interrupt_handler:
	pha			; save A				; 3
				; Should we save X and Y too?

	bit	$C404		; clear 6522 interrupt by reading T1C-L	; 4

mb_play_music:


	;======================================
	; Write frames to Mockingboard
	;======================================
	; actually plays frame loaded at end of
	; last interrupt, so 20ms behind?

mb_write_frame:


	ldx	#0		; set up reg count			; 2
								;============
								;	  2

	;==================================
	; loop through the 14 registers
	; reading the value, then write out
	;==================================



	; CHANNEL A LOW
mb_write_loop_0:
;	lda	REGISTER_DUMP,X	; load register value			; 4
;	cmp	REGISTER_OLD,X	; compare with old values		; 4
;	beq	mb_no_write_0						; 3/2nt

mb_write_0:


	; address
;	stx	MOCK_6522_ORA1		; put address on PA1		; 4
;	stx	MOCK_6522_ORA2		; put address on PA2		; 4
;	lda	#MOCK_AY_LATCH_ADDR	; latch_address for PB1		; 2
;	sta	MOCK_6522_ORB1		; latch_address on PB1          ; 4
;	sta	MOCK_6522_ORB2		; latch_address on PB2		; 4
;	lda	#MOCK_AY_INACTIVE	; go inactive			; 2
;	sta	MOCK_6522_ORB1						; 4
;	sta	MOCK_6522_ORB2						; 4

        ; value
;	lda	REGISTER_DUMP,X		; load register value		; 4
;	sta	MOCK_6522_ORA1		; put value on PA1		; 4
;	sta	MOCK_6522_ORA2		; put value on PA2		; 4
;	lda	#MOCK_AY_WRITE		;				; 2
;	sta	MOCK_6522_ORB1		; write on PB1			; 4
;	sta	MOCK_6522_ORB2		; write on PB2			; 4
;	lda	#MOCK_AY_INACTIVE	; go inactive			; 2
;	sta	MOCK_6522_ORB1						; 4
;	sta	MOCK_6522_ORB2						; 4
								;===========
								; 	62
mb_no_write_0:
	inx				; point to next register	; 2


	; CHANNEL A HIGH
mb_write_loop_1:
;	lda	REGISTER_DUMP,X	; load register value			; 4
;	cmp	REGISTER_OLD,X	; compare with old values		; 4
;	beq	mb_no_write_1						; 3/2nt

mb_write_1:


	; address
;	stx	MOCK_6522_ORA1		; put address on PA1		; 4
;	stx	MOCK_6522_ORA2		; put address on PA2		; 4
;	lda	#MOCK_AY_LATCH_ADDR	; latch_address for PB1		; 2
;	sta	MOCK_6522_ORB1		; latch_address on PB1          ; 4
;	sta	MOCK_6522_ORB2		; latch_address on PB2		; 4
;	lda	#MOCK_AY_INACTIVE	; go inactive			; 2
;	sta	MOCK_6522_ORB1						; 4
;	sta	MOCK_6522_ORB2						; 4

        ; value
;	lda	REGISTER_DUMP,X		; load register value		; 4
;	sta	MOCK_6522_ORA1		; put value on PA1		; 4
;	sta	MOCK_6522_ORA2		; put value on PA2		; 4
;	lda	#MOCK_AY_WRITE		;				; 2
;	sta	MOCK_6522_ORB1		; write on PB1			; 4
;	sta	MOCK_6522_ORB2		; write on PB2			; 4
;	lda	#MOCK_AY_INACTIVE	; go inactive			; 2
;	sta	MOCK_6522_ORB1						; 4
;	sta	MOCK_6522_ORB2						; 4
								;===========
								; 	62
mb_no_write_1:
	inx				; point to next register	; 2

	; CHANNEL B LOW
mb_write_loop_2:
;	lda	REGISTER_DUMP,X	; load register value			; 4
;	cmp	REGISTER_OLD,X	; compare with old values		; 4
;	beq	mb_no_write_2						; 3/2nt

mb_write_2:


	; address
;	stx	MOCK_6522_ORA1		; put address on PA1		; 4
;	stx	MOCK_6522_ORA2		; put address on PA2		; 4
;	lda	#MOCK_AY_LATCH_ADDR	; latch_address for PB1		; 2
;	sta	MOCK_6522_ORB1		; latch_address on PB1          ; 4
;	sta	MOCK_6522_ORB2		; latch_address on PB2		; 4
;	lda	#MOCK_AY_INACTIVE	; go inactive			; 2
;	sta	MOCK_6522_ORB1						; 4
;	sta	MOCK_6522_ORB2						; 4

        ; value
;	lda	REGISTER_DUMP,X		; load register value		; 4
;	sta	MOCK_6522_ORA1		; put value on PA1		; 4
;	sta	MOCK_6522_ORA2		; put value on PA2		; 4
;	lda	#MOCK_AY_WRITE		;				; 2
;	sta	MOCK_6522_ORB1		; write on PB1			; 4
;	sta	MOCK_6522_ORB2		; write on PB2			; 4
;	lda	#MOCK_AY_INACTIVE	; go inactive			; 2
;	sta	MOCK_6522_ORB1						; 4
;	sta	MOCK_6522_ORB2						; 4
								;===========
								; 	62
mb_no_write_2:
	inx				; point to next register	; 2

	; CHANNEL B HIGH
mb_write_loop_3:
;	lda	REGISTER_DUMP,X	; load register value			; 4
;	cmp	REGISTER_OLD,X	; compare with old values		; 4
;	beq	mb_no_write_3						; 3/2nt

mb_write_3:


	; address
;	stx	MOCK_6522_ORA1		; put address on PA1		; 4
;	stx	MOCK_6522_ORA2		; put address on PA2		; 4
;	lda	#MOCK_AY_LATCH_ADDR	; latch_address for PB1		; 2
;	sta	MOCK_6522_ORB1		; latch_address on PB1          ; 4
;	sta	MOCK_6522_ORB2		; latch_address on PB2		; 4
;	lda	#MOCK_AY_INACTIVE	; go inactive			; 2
;	sta	MOCK_6522_ORB1						; 4
;	sta	MOCK_6522_ORB2						; 4
;
       ; value
;	lda	REGISTER_DUMP,X		; load register value		; 4
;	sta	MOCK_6522_ORA1		; put value on PA1		; 4
;	sta	MOCK_6522_ORA2		; put value on PA2		; 4
;	lda	#MOCK_AY_WRITE		;				; 2
;	sta	MOCK_6522_ORB1		; write on PB1			; 4
;	sta	MOCK_6522_ORB2		; write on PB2			; 4
;	lda	#MOCK_AY_INACTIVE	; go inactive			; 2
;	sta	MOCK_6522_ORB1						; 4
;	sta	MOCK_6522_ORB2						; 4
								;===========
								; 	62
mb_no_write_3:
	inx				; point to next register	; 2

	; C CHANNEL LOW
mb_write_loop_4:
	lda	REGISTER_DUMP,X	; load register value			; 4
	cmp	REGISTER_OLD,X	; compare with old values		; 4
	beq	mb_no_write_4						; 3/2nt

mb_write_4:


	; address
	stx	MOCK_6522_ORA1		; put address on PA1		; 4
	stx	MOCK_6522_ORA2		; put address on PA2		; 4
	lda	#MOCK_AY_LATCH_ADDR	; latch_address for PB1		; 2
	sta	MOCK_6522_ORB1		; latch_address on PB1          ; 4
	sta	MOCK_6522_ORB2		; latch_address on PB2		; 4
	lda	#MOCK_AY_INACTIVE	; go inactive			; 2
	sta	MOCK_6522_ORB1						; 4
	sta	MOCK_6522_ORB2						; 4

        ; value
	lda	REGISTER_DUMP,X		; load register value		; 4
	sta	MOCK_6522_ORA1		; put value on PA1		; 4
	sta	MOCK_6522_ORA2		; put value on PA2		; 4
	lda	#MOCK_AY_WRITE		;				; 2
	sta	MOCK_6522_ORB1		; write on PB1			; 4
	sta	MOCK_6522_ORB2		; write on PB2			; 4
	lda	#MOCK_AY_INACTIVE	; go inactive			; 2
	sta	MOCK_6522_ORB1						; 4
	sta	MOCK_6522_ORB2						; 4
								;===========
								; 	62
mb_no_write_4:
	inx				; point to next register	; 2

	; C CHANNEL HIGH
mb_write_loop_5:
	lda	REGISTER_DUMP,X	; load register value			; 4
	cmp	REGISTER_OLD,X	; compare with old values		; 4
	beq	mb_no_write_5						; 3/2nt

mb_write_5:


	; address
	stx	MOCK_6522_ORA1		; put address on PA1		; 4
	stx	MOCK_6522_ORA2		; put address on PA2		; 4
	lda	#MOCK_AY_LATCH_ADDR	; latch_address for PB1		; 2
	sta	MOCK_6522_ORB1		; latch_address on PB1          ; 4
	sta	MOCK_6522_ORB2		; latch_address on PB2		; 4
	lda	#MOCK_AY_INACTIVE	; go inactive			; 2
	sta	MOCK_6522_ORB1						; 4
	sta	MOCK_6522_ORB2						; 4

        ; value
	lda	REGISTER_DUMP,X		; load register value		; 4
	sta	MOCK_6522_ORA1		; put value on PA1		; 4
	sta	MOCK_6522_ORA2		; put value on PA2		; 4
	lda	#MOCK_AY_WRITE		;				; 2
	sta	MOCK_6522_ORB1		; write on PB1			; 4
	sta	MOCK_6522_ORB2		; write on PB2			; 4
	lda	#MOCK_AY_INACTIVE	; go inactive			; 2
	sta	MOCK_6522_ORB1						; 4
	sta	MOCK_6522_ORB2						; 4
								;===========
								; 	62
mb_no_write_5:
	inx				; point to next register	; 2

	; NOISE PERIOD
mb_write_loop_6:
;	lda	REGISTER_DUMP,X	; load register value			; 4
;	cmp	REGISTER_OLD,X	; compare with old values		; 4
;	beq	mb_no_write_6						; 3/2nt

mb_write_6:


	; address
;	stx	MOCK_6522_ORA1		; put address on PA1		; 4
;	stx	MOCK_6522_ORA2		; put address on PA2		; 4
;	lda	#MOCK_AY_LATCH_ADDR	; latch_address for PB1		; 2
;	sta	MOCK_6522_ORB1		; latch_address on PB1          ; 4
;	sta	MOCK_6522_ORB2		; latch_address on PB2		; 4
;	lda	#MOCK_AY_INACTIVE	; go inactive			; 2
;	sta	MOCK_6522_ORB1						; 4
;	sta	MOCK_6522_ORB2						; 4

        ; value
;	lda	REGISTER_DUMP,X		; load register value		; 4
;	sta	MOCK_6522_ORA1		; put value on PA1		; 4
;	sta	MOCK_6522_ORA2		; put value on PA2		; 4
;	lda	#MOCK_AY_WRITE		;				; 2
;	sta	MOCK_6522_ORB1		; write on PB1			; 4
;	sta	MOCK_6522_ORB2		; write on PB2			; 4
;	lda	#MOCK_AY_INACTIVE	; go inactive			; 2
;	sta	MOCK_6522_ORB1						; 4
;	sta	MOCK_6522_ORB2						; 4
								;===========
								; 	62
mb_no_write_6:
	inx				; point to next register	; 2

	; ENABLE
mb_write_loop_7:
	lda	REGISTER_DUMP,X	; load register value			; 4
	cmp	REGISTER_OLD,X	; compare with old values		; 4
	beq	mb_no_write_7						; 3/2nt

mb_write_7:


	; address
	stx	MOCK_6522_ORA1		; put address on PA1		; 4
	stx	MOCK_6522_ORA2		; put address on PA2		; 4
	lda	#MOCK_AY_LATCH_ADDR	; latch_address for PB1		; 2
	sta	MOCK_6522_ORB1		; latch_address on PB1          ; 4
	sta	MOCK_6522_ORB2		; latch_address on PB2		; 4
	lda	#MOCK_AY_INACTIVE	; go inactive			; 2
	sta	MOCK_6522_ORB1						; 4
	sta	MOCK_6522_ORB2						; 4

        ; value
	lda	REGISTER_DUMP,X		; load register value		; 4
	sta	MOCK_6522_ORA1		; put value on PA1		; 4
	sta	MOCK_6522_ORA2		; put value on PA2		; 4
	lda	#MOCK_AY_WRITE		;				; 2
	sta	MOCK_6522_ORB1		; write on PB1			; 4
	sta	MOCK_6522_ORB2		; write on PB2			; 4
	lda	#MOCK_AY_INACTIVE	; go inactive			; 2
	sta	MOCK_6522_ORB1						; 4
	sta	MOCK_6522_ORB2						; 4
								;===========
								; 	62
mb_no_write_7:
	inx				; point to next register	; 2

	; A amplitude
mb_write_loop_8:
;	lda	REGISTER_DUMP,X	; load register value			; 4
;	cmp	REGISTER_OLD,X	; compare with old values		; 4
;	beq	mb_no_write_8						; 3/2nt

mb_write_8:


	; address
;	stx	MOCK_6522_ORA1		; put address on PA1		; 4
;	stx	MOCK_6522_ORA2		; put address on PA2		; 4
;	lda	#MOCK_AY_LATCH_ADDR	; latch_address for PB1		; 2
;	sta	MOCK_6522_ORB1		; latch_address on PB1          ; 4
;	sta	MOCK_6522_ORB2		; latch_address on PB2		; 4
;	lda	#MOCK_AY_INACTIVE	; go inactive			; 2
;	sta	MOCK_6522_ORB1						; 4
;	sta	MOCK_6522_ORB2						; 4

        ; value
;	lda	REGISTER_DUMP,X		; load register value		; 4
;	sta	MOCK_6522_ORA1		; put value on PA1		; 4
;	sta	MOCK_6522_ORA2		; put value on PA2		; 4
;	lda	#MOCK_AY_WRITE		;				; 2
;	sta	MOCK_6522_ORB1		; write on PB1			; 4
;	sta	MOCK_6522_ORB2		; write on PB2			; 4
;	lda	#MOCK_AY_INACTIVE	; go inactive			; 2
;	sta	MOCK_6522_ORB1						; 4
;	sta	MOCK_6522_ORB2						; 4
								;===========
								; 	62
mb_no_write_8:
	inx				; point to next register	; 2

	; B Amplitude
mb_write_loop_9:
;	lda	REGISTER_DUMP,X	; load register value			; 4
;	cmp	REGISTER_OLD,X	; compare with old values		; 4
;	beq	mb_no_write_9						; 3/2nt

mb_write_9:


	; address
;	stx	MOCK_6522_ORA1		; put address on PA1		; 4
;	stx	MOCK_6522_ORA2		; put address on PA2		; 4
;	lda	#MOCK_AY_LATCH_ADDR	; latch_address for PB1		; 2
;	sta	MOCK_6522_ORB1		; latch_address on PB1          ; 4
;	sta	MOCK_6522_ORB2		; latch_address on PB2		; 4
;	lda	#MOCK_AY_INACTIVE	; go inactive			; 2
;	sta	MOCK_6522_ORB1						; 4
;	sta	MOCK_6522_ORB2						; 4

        ; value
;	lda	REGISTER_DUMP,X		; load register value		; 4
;	sta	MOCK_6522_ORA1		; put value on PA1		; 4
;	sta	MOCK_6522_ORA2		; put value on PA2		; 4
;	lda	#MOCK_AY_WRITE		;				; 2
;	sta	MOCK_6522_ORB1		; write on PB1			; 4
;	sta	MOCK_6522_ORB2		; write on PB2			; 4
;	lda	#MOCK_AY_INACTIVE	; go inactive			; 2
;	sta	MOCK_6522_ORB1						; 4
;	sta	MOCK_6522_ORB2						; 4
;								;===========
								; 	62
mb_no_write_9:
	inx				; point to next register	; 2

	; C Amplitude
mb_write_loop_10:
	lda	REGISTER_DUMP,X	; load register value			; 4
	cmp	REGISTER_OLD,X	; compare with old values		; 4
	beq	mb_no_write_10						; 3/2nt

mb_write_10:


	; address
	stx	MOCK_6522_ORA1		; put address on PA1		; 4
	stx	MOCK_6522_ORA2		; put address on PA2		; 4
	lda	#MOCK_AY_LATCH_ADDR	; latch_address for PB1		; 2
	sta	MOCK_6522_ORB1		; latch_address on PB1          ; 4
	sta	MOCK_6522_ORB2		; latch_address on PB2		; 4
	lda	#MOCK_AY_INACTIVE	; go inactive			; 2
	sta	MOCK_6522_ORB1						; 4
	sta	MOCK_6522_ORB2						; 4

        ; value
	lda	REGISTER_DUMP,X		; load register value		; 4
	sta	MOCK_6522_ORA1		; put value on PA1		; 4
	sta	MOCK_6522_ORA2		; put value on PA2		; 4
	lda	#MOCK_AY_WRITE		;				; 2
	sta	MOCK_6522_ORB1		; write on PB1			; 4
	sta	MOCK_6522_ORB2		; write on PB2			; 4
	lda	#MOCK_AY_INACTIVE	; go inactive			; 2
	sta	MOCK_6522_ORB1						; 4
	sta	MOCK_6522_ORB2						; 4
								;===========
								; 	62
mb_no_write_10:
	inx				; point to next register	; 2

mb_write_loop_11:
;	lda	REGISTER_DUMP,X	; load register value			; 4
;	cmp	REGISTER_OLD,X	; compare with old values		; 4
;	beq	mb_no_write_11						; 3/2nt

mb_write_11:


	; address
;	stx	MOCK_6522_ORA1		; put address on PA1		; 4
;	stx	MOCK_6522_ORA2		; put address on PA2		; 4
;	lda	#MOCK_AY_LATCH_ADDR	; latch_address for PB1		; 2
;	sta	MOCK_6522_ORB1		; latch_address on PB1          ; 4
;	sta	MOCK_6522_ORB2		; latch_address on PB2		; 4
;	lda	#MOCK_AY_INACTIVE	; go inactive			; 2
;	sta	MOCK_6522_ORB1						; 4
;	sta	MOCK_6522_ORB2						; 4
;
        ; value
;	lda	REGISTER_DUMP,X		; load register value		; 4
;	sta	MOCK_6522_ORA1		; put value on PA1		; 4
;	sta	MOCK_6522_ORA2		; put value on PA2		; 4
;	lda	#MOCK_AY_WRITE		;				; 2
;	sta	MOCK_6522_ORB1		; write on PB1			; 4
;	sta	MOCK_6522_ORB2		; write on PB2			; 4
;	lda	#MOCK_AY_INACTIVE	; go inactive			; 2
;	sta	MOCK_6522_ORB1						; 4
;	sta	MOCK_6522_ORB2						; 4
								;===========
								; 	62
mb_no_write_11:
	inx				; point to next register	; 2

mb_write_loop_12:
;	lda	REGISTER_DUMP,X	; load register value			; 4
;	cmp	REGISTER_OLD,X	; compare with old values		; 4
;	beq	mb_no_write_12						; 3/2nt

mb_write_12:


	; address
;	stx	MOCK_6522_ORA1		; put address on PA1		; 4
;	stx	MOCK_6522_ORA2		; put address on PA2		; 4
;	lda	#MOCK_AY_LATCH_ADDR	; latch_address for PB1		; 2
;	sta	MOCK_6522_ORB1		; latch_address on PB1          ; 4
;	sta	MOCK_6522_ORB2		; latch_address on PB2		; 4
;	lda	#MOCK_AY_INACTIVE	; go inactive			; 2
;	sta	MOCK_6522_ORB1						; 4
;	sta	MOCK_6522_ORB2						; 4
;
        ; value
;	lda	REGISTER_DUMP,X		; load register value		; 4
;	sta	MOCK_6522_ORA1		; put value on PA1		; 4
;	sta	MOCK_6522_ORA2		; put value on PA2		; 4
;	lda	#MOCK_AY_WRITE		;				; 2
;	sta	MOCK_6522_ORB1		; write on PB1			; 4
;	sta	MOCK_6522_ORB2		; write on PB2			; 4
;	lda	#MOCK_AY_INACTIVE	; go inactive			; 2
;	sta	MOCK_6522_ORB1						; 4
;	sta	MOCK_6522_ORB2						; 4
								;===========
								; 	62
mb_no_write_12:
	inx				; point to next register	; 2

;mb_write_loop_13:
;	lda	REGISTER_DUMP,X	; load register value			; 4
;	cmp	REGISTER_OLD,X	; compare with old values		; 4
;	beq	mb_no_write_13						; 3/2nt

;mb_write_13:

	; special case R13.  If it is 0xff, then don't update
	; otherwise might spuriously reset the envelope settings

;	cmp	#$ff							; 2
;	beq	mb_no_write_13						; 3/2nt


	; address
;	stx	MOCK_6522_ORA1		; put address on PA1		; 4
;	stx	MOCK_6522_ORA2		; put address on PA2		; 4
;	lda	#MOCK_AY_LATCH_ADDR	; latch_address for PB1		; 2
;	sta	MOCK_6522_ORB1		; latch_address on PB1          ; 4
;	sta	MOCK_6522_ORB2		; latch_address on PB2		; 4
;	lda	#MOCK_AY_INACTIVE	; go inactive			; 2
;	sta	MOCK_6522_ORB1						; 4
;	sta	MOCK_6522_ORB2						; 4

        ; value
;	lda	REGISTER_DUMP,X		; load register value		; 4
;	sta	MOCK_6522_ORA1		; put value on PA1		; 4
;	sta	MOCK_6522_ORA2		; put value on PA2		; 4
;	lda	#MOCK_AY_WRITE		;				; 2
;	sta	MOCK_6522_ORB1		; write on PB1			; 4
;	sta	MOCK_6522_ORB2		; write on PB2			; 4
;	lda	#MOCK_AY_INACTIVE	; go inactive			; 2
;	sta	MOCK_6522_ORB1						; 4
;	sta	MOCK_6522_ORB2						; 4
								;===========
								; 	62
mb_no_write_13:








	;=====================================
	; Copy registers to old
	;=====================================
	ldx	#13							; 2
mb_reg_copy:
	lda	REGISTER_DUMP,X	; load register value			; 4
	sta	REGISTER_OLD,X	; compare with old values		; 4
	dex								; 2
	bpl	mb_reg_copy						; 2nt/3
								;=============
								; 	171

	;===================================
	; Load all 14 registers in advance
	;===================================
	; note, assuming not cross page boundary, not any slower
	; then loading from zero page?

mb_load_values:

	ldx	#0		; set up reg count			; 2
	ldy	MB_CHUNK_OFFSET	; get chunk offset			; 3
								;=============
								;	5

mb_load_loop:
	lda	(INL),y		; load register value			; 5
	sta	REGISTER_DUMP,X						; 4
								;============
								;	9
	;====================
	; point to next page
	;====================

	clc				; point to next interleaved	; 2
	lda	INH			; page by adding CHUNKSIZE (3/1); 3
	adc	CHUNKSIZE						; 3
	sta	INH							; 3

	inx				; point to next register	; 2
	cpx	#14			; if 14 we're done		; 2
	bmi	mb_load_loop		; otherwise, loop		; 3/2nt
								;============
								; 	18



	;==============================================
	; incremement offset.  If 0 move to next chunk
	;==============================================

increment_offset:

	inc	MB_CHUNK_OFFSET		; increment offset		; 5

	lda	#0							; 2
	clc								; 2
	adc	#>UNPACK_BUFFER		; in proper chunk 1 or 2	; 2
	sta	INH		; update r0 pointer			; 3



	;=================================
	; Finally done with this interrupt
	;=================================

done_interrupt:
	pla			; restore a				; 4
	rti			; return from interrupt			; 6


REGISTER_OLD:
	.byte	0,0,0,0,0,0,0,0,0,0,0,0,0,0

.align 256
UNPACK_BUFFER:
.incbin		"sdemo.raw"
