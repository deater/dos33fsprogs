; VMW Minimal Mockingboard Issue Reproducer

; ZP addresses
MB_CHUNK_OFFSET = $94
MB_VALUE = $91

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

reset_ay_both:
	;======================
	; Reset Left AY-3-8910
	;======================
reset_ay_left:
	lda	#MOCK_AY_RESET
	sta	MOCK_6522_ORB1
	lda	#MOCK_AY_INACTIVE
	sta	MOCK_6522_ORB1

	;======================
	; Reset Right AY-3-8910
	;======================
reset_ay_right:
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

	ldy	MB_CHUNK_OFFSET


	; 4: C CHANNEL FINE
	ldx	#4
	lda	c_fine,Y
	sta	MB_VALUE
	jsr	write_ay_both

	; 5: C CHANNEL COARSE
	ldx	#5
	lda	#$0			; always 0
	sta	MB_VALUE
	jsr	write_ay_both

	; 7: ENABLE
	ldx	#7
	lda	#$38			; noise disabled, ABC enabled
	sta	MB_VALUE
	jsr	write_ay_both

	; 10: C Amplitude
	ldx	#10
	lda	#$c			; always volume 12
	sta	MB_VALUE
	jsr	write_ay_both

increment_offset:
	inc	MB_CHUNK_OFFSET		; increment offset

done_interrupt:
	pla			; restore a				; 4
	rti			; return from interrupt			; 6




; 4: C fine

c_fine:

.byte $51,$3c,$32,$50,$3d,$32,$50,$3c, $33,$50,$3c,$32,$51,$3c,$32,$50
.byte $3d,$32,$50,$3c,$33,$50,$3c,$32, $51,$3c,$32,$50,$3d,$32,$50,$3c
.byte $33,$50,$3c,$32,$51,$3c,$32,$50, $3d,$33,$50,$3c,$32,$51,$3c,$32
.byte $50,$3d,$33,$50,$3c,$32,$51,$3c, $32,$50,$3d,$33,$50,$3c,$32,$51
.byte $3c,$32,$50,$3d,$33,$50,$3c,$32, $51,$3c,$32,$50,$3d,$33,$50,$3c
.byte $32,$51,$3c,$32,$50,$3d,$33,$50, $3c,$32,$51,$3c,$32,$50,$3d,$33
.byte $4c,$3c,$32,$4b,$3d,$32,$4b,$3c, $33,$4b,$3c,$32,$4c,$3c,$32,$4b
.byte $3d,$32,$4b,$3c,$33,$4b,$3c,$32, $4c,$3c,$32,$4b,$3d,$32,$4b,$3c
.byte $33,$4b,$3c,$32,$4c,$3c,$32,$4b, $3d,$33,$4b,$3c,$32,$4c,$3c,$32
.byte $4b,$3d,$33,$4b,$3c,$32,$4c,$3c, $32,$4b,$3d,$33,$4b,$3c,$32,$4c
.byte $3c,$32,$4b,$3d,$33,$4b,$3c,$32, $4c,$3c,$32,$4b,$3d,$33,$4b,$3c
.byte $32,$4c,$3c,$32,$4b,$3d,$33,$4b, $3c,$32,$4c,$3c,$32,$4b,$3d,$33
.byte $51,$43,$32,$50,$44,$32,$50,$43, $33,$50,$43,$32,$51,$43,$32,$50
.byte $44,$32,$50,$43,$33,$50,$43,$32, $51,$43,$32,$50,$44,$32,$50,$43
.byte $33,$50,$43,$32,$51,$43,$32,$50, $44,$33,$50,$43,$32,$51,$43,$32
.byte $50,$44,$33,$50,$43,$32,$51,$43, $32,$50,$44,$33,$50,$43,$32,$51


