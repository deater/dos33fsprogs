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
reset_ay_left:
	lda	#MOCK_AY_RESET
	sta	MOCK_6522_ORB1
	lda	#MOCK_AY_INACTIVE
	sta	MOCK_6522_ORB1
	rts

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

	;=======================
	; Write Right AY-3-8910
	;=======================
	; register in Y
	; value in X

write_ay_right:
	; address
	sty	MOCK_6522_ORA1		; put address on PA
	lda	#MOCK_AY_LATCH_ADDR	; latch_address on PB
	sta	MOCK_6522_ORB1
	lda	#MOCK_AY_INACTIVE	; go inactive
	sta	MOCK_6522_ORB1

	; value
	stx	MOCK_6522_ORA1		; put value on PA
	lda	#MOCK_AY_WRITE		; write on PB
	sta	MOCK_6522_ORB1
	lda	#MOCK_AY_INACTIVE	; go inactive
	sta	MOCK_6522_ORB1

	rts

	;=======================
	; Write Left AY-3-8910
	;=======================
	; register in X
	; value in Y

write_ay_left:
	; address
	sty	MOCK_6522_ORA2		; put address on PA
	lda	#MOCK_AY_LATCH_ADDR	; latch_address on PB
	sta	MOCK_6522_ORB2
	lda	#MOCK_AY_INACTIVE	; go inactive
	sta	MOCK_6522_ORB2

	; value
	stx	MOCK_6522_ORA2		; put value on PA
	lda	#MOCK_AY_WRITE		; write on PB
	sta	MOCK_6522_ORB2
	lda	#MOCK_AY_INACTIVE	; go inactive
	sta	MOCK_6522_ORB2

	rts

	;=======================================
	; clear ay -- clear all 14 AY registers
	; should silence the card
	;=======================================
clear_ay_left:
	ldy	#14
	ldx	#0
clear_ay_left_loop:
	jsr	write_ay_left
	dey
	bpl	clear_ay_left_loop
	rts

	;=======================================
	; clear ay -- clear all 14 AY registers
	; should silence the card
	;=======================================
clear_ay_right:

	ldy	#14
	ldx	#0
clear_ay_right_loop:
	jsr	write_ay_right
	dey
	bpl	clear_ay_right_loop
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
	sta	TEMP			; 3 cycles
	lda	(MB_ADDRL),Y		; + 5 cycles = 8 cycles
					; between the two accesses to the timer
	sec
	sbc	TEMP			; subtract to see if we had 8 cycles
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
	sta	TEMP			; 3 cycles
	lda	(MB_ADDRL),Y		; + 5 cycles = 8 cycles
					; between the two accesses to the timer
	sec
	sbc	TEMP			; subtract to see if we had 8 cycles
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

