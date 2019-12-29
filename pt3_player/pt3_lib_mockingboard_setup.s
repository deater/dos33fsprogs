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
	; Mockingboard Init
	;========================
	; Initialize the 6522s
	; set the data direction for all pins of PortA/PortB to be output

mockingboard_init:
	lda	#$ff		; all output (1)

mock_init_smc1:
	sta	MOCK_6522_DDRB1
	sta	MOCK_6522_DDRA1
mock_init_smc2:
	sta	MOCK_6522_DDRB2
	sta	MOCK_6522_DDRA2
	rts

	;===================================
	;===================================
	; Reset Both AY-3-8910s
	;===================================
	;===================================

	;======================
	; Reset Left AY-3-8910
	;======================
reset_ay_both:
	lda	#MOCK_AY_RESET
reset_ay_smc1:
	sta	MOCK_6522_ORB1
	lda	#MOCK_AY_INACTIVE
reset_ay_smc2:
	sta	MOCK_6522_ORB1

	;======================
	; Reset Right AY-3-8910
	;======================
;reset_ay_right:
;could be merged with both
	lda	#MOCK_AY_RESET
reset_ay_smc3:
	sta	MOCK_6522_ORB2
	lda	#MOCK_AY_INACTIVE
reset_ay_smc4:
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

write_ay_smc1:
	stx	MOCK_6522_ORA1		; put address on PA1		; 4
	stx	MOCK_6522_ORA2		; put address on PA2		; 4
	lda	#MOCK_AY_LATCH_ADDR	; latch_address on PB1		; 2
write_ay_smc2:
	sta	MOCK_6522_ORB1		; latch_address on PB1		; 4
	sta	MOCK_6522_ORB2		; latch_address on PB2		; 4
	ldy	#MOCK_AY_INACTIVE	; go inactive			; 2
write_ay_smc3:
	sty	MOCK_6522_ORB1						; 4
	sty	MOCK_6522_ORB2						; 4
								;===========
								;        28
	; value
	lda	MB_VALUE						; 3
write_ay_smc4:
	sta	MOCK_6522_ORA1		; put value on PA1		; 4
	sta	MOCK_6522_ORA2		; put value on PA2		; 4
	lda	#MOCK_AY_WRITE		;				; 2
write_ay_smc5:
	sta	MOCK_6522_ORB1		; write on PB1			; 4
	sta	MOCK_6522_ORB2		; write on PB2			; 4
write_ay_smc6:
	sty	MOCK_6522_ORB1						; 4
	sty	MOCK_6522_ORB2						; 4
								;===========
								;        29

	rts								; 6
								;===========
								;       63
write_ay_both_end:
;.assert >write_ay_both = >write_ay_both_end, error, "write_ay_both crosses page"

	;=======================================
	; clear ay -- clear all 14 AY registers
	; should silence the card
	;=======================================
	; 7+(74*14)+5=1048
clear_ay_both:
	ldx	#13				; 2
	lda	#0				; 2
	sta	MB_VALUE			; 3
clear_ay_left_loop:
	jsr	write_ay_both			; 6+63
	dex					; 2
	bpl	clear_ay_left_loop		; 3
						; -1
	rts					; 6

clear_ay_end:
;.assert >clear_ay_both = >clear_ay_end, error, "clear_ay_both crosses page"

	;=============================
	; Setup
	;=============================
mockingboard_setup_interrupt:

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

	; don't bother patching these, IIc mockingboard always slot 4?

	sta	MOCK_6522_DDRA1
	sta	MOCK_6522_T1CL

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

	; 4fe7 / 1e6 = .020s, 50Hz

	; 9c40 / 1e6 = .040s, 25Hz
	; 411a / 1e6 = .016s, 60Hz

	sei			; disable interrupts just in case

	lda	#$40		; Continuous interrupts, don't touch PB7
setup_irq_smc1:
	sta	MOCK_6522_ACR	; ACR register
	lda	#$7F		; clear all interrupt flags
setup_irq_smc2:
	sta	MOCK_6522_IER	; IER register (interrupt enable)

	lda	#$C0
setup_irq_smc3:
	sta	MOCK_6522_IFR	; IFR: 1100, enable interrupt on timer one oflow
setup_irq_smc4:
	sta	MOCK_6522_IER	; IER: 1100, enable timer one interrupt

	lda	#$E7
setup_irq_smc5:
	sta	MOCK_6522_T1CL	; write into low-order latch
	lda	#$4f
setup_irq_smc6:
	sta	MOCK_6522_T1CH	; write into high-order latch,
				; load both values into counter
				; clear interrupt and start counting

	rts
