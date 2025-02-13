; Apple II graphics/music in 256B

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page

TEMP	= $F0

FULLGR	= $C052
SETGR	= $FB40

; for a 256 entry we need to fit in 252 bytes

bytebeat:

	jsr	SETGR			; enable lo-res graphics
					; A=$D0, Z=1

	bit	FULLGR			; make graphcs full screen


	;===================
	; music Player Setup

	; assume mockingboard in slot#4

	; inline mockingboard_init

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
	; Left channel only

mockingboard_init:

	;=========================
	; Initialize the 6522s
	; Reset Left AY-3-8910
	;===========================
	; 15 bytes


	ldx	#$FF			; 2
	stx	MOCK_6522_DDRB1		; 3	$C402
	stx	MOCK_6522_DDRA1		; 3	$C403

	inx				; 1	#MOCK_AY_RESET $0
	stx	MOCK_6522_ORB1		; 3	$C400
	ldx	#MOCK_AY_INACTIVE	; 2	$4
	stx	MOCK_6522_ORB1		; 3	$C400

	;============================
	; set up registers

	; r0/r1 set for 440Hz A?

	ldx	#0
	lda	#$B7
	jsr	ay3_write_reg

	inx
	lda	#$0
	jsr	ay3_write_reg

	ldx	#7
	lda	#$3e
	jsr	ay3_write_reg	; only A enabled

	ldx	#8
	lda	#$f
	jsr	ay3_write_reg	; amplitude


main_loop:



	jmp	main_loop


	;=====================
	;=====================
	;=====================
	; ay3 write reg
	;=====================
	;=====================
	;=====================
	; X is reg to write
	; A is value

ay3_write_reg:
; 0
	sta	TEMP							; 3
; 3
	lda	#MOCK_AY_LATCH_ADDR     ; latch_address for PB1         ; 2
	ldy	#MOCK_AY_INACTIVE       ; go inactive                   ; 2
; 7
	stx	MOCK_6522_ORA1          ; put address on PA1            ; 4
	sta	MOCK_6522_ORB1          ; latch_address on PB1          ; 4
	sty	MOCK_6522_ORB1                                          ; 4
; 19
	; value
	lda	TEMP							; 2
	sta	MOCK_6522_ORA1          ; put value on PA1              ; 4
	lda	#MOCK_AY_WRITE          ;                               ; 2
	sta	MOCK_6522_ORB1          ; write on PB1                  ; 4
	sty	MOCK_6522_ORB1                                          ; 4
; 35
	rts
; 41
