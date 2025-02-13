; Apple II graphics/music in 256B

; by deater (Vince Weaver) <vince@deater.net>

; this is based off of Tjoppen's 128 byte demo (w/o sync)
; which is based off of viznut's combination of xpansive's
; and varjohukka's stuff from the pouet thread
; http://pouet.net/topic.php?which=8357&page=4
; (t>>7|t|t>>6)*10+4*(t&t>>13|t>>6)


        ; 8kHz (bytebeat frequency) = 125us
        ; Apple II = 1.023MHz = .98us = ~128 cycles

; Zero Page

; zero page RAM addresses

COLOR	= $30

COUNTER1	= $F0   ; t
COUNTER2	= $F1	; t >> 6
COUNTER3	= $F2	; t >> 7
COUNTER4	= $F3	; t >> 13
TEMP	 	= $F4
TEMP2		= $F5

OUTL		= $F6
OUTH		= $F7
XSAVE		= $F8
COUNT		= $F9

FULLGR	= $C052
SETGR	= $FB40
VLINE  = $F828                 ; VLINE A,$2D at Y


volume_lookup	= $2000

; for a 256 entry we need to fit in 252 bytes

bytebeat:
	jsr	SETGR			; enable lo-res graphics
					; A=$D0, Z=1

	bit	FULLGR			; make graphcs full screen


	; clear to white
	lda	#$ff
	sta	COLOR

	lda	#24
	sta	COUNT
heart_loop:
	ldy	COUNT

	lda	vlin_stop-16,Y
	sta	$2D

	lda	vlin_start-16,Y

	jsr	VLINE

	dec	COUNT
	lda	COUNT
	cmp	#15
	bne	heart_loop

;over:
;	jmp	over



	lda	#0
	sta	COUNTER1		; init counters
	sta	COUNTER2
	sta	COUNTER3
	sta	COUNTER4
	sta	OUTL			; init graphics out pointer

	jsr	make_volume_lookup

	lda	#$04			; init rest of graphics out pointer
	sta	OUTH			; LORES PAGE1





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
;	stx	MOCK_6522_DDRB2		; 3	$C402
;	stx	MOCK_6522_DDRA2		; 3	$C403

	inx				; 1	#MOCK_AY_RESET $0
	stx	MOCK_6522_ORB1		; 3	$C400
;	stx	MOCK_6522_ORB2		; 3	$C400
	ldx	#MOCK_AY_INACTIVE	; 2	$4
	stx	MOCK_6522_ORB1		; 3	$C400
;	stx	MOCK_6522_ORB2		; 3	$C400

	;============================
	; set up registers

	;
	; either set r0/r1 to 0
	; or set mute channel bit to 1
	;	either sets constant high value out
	;	which you can modulate with the Volume registers

;	ldx	#0			; fine
;	lda	#$0
;	jsr	ay3_write_reg

;	inx
;	lda	#$00			; coarse
;	jsr	ay3_write_reg

	ldx	#7
;	lda	#$3e
	lda	#$3F		; if all off, the output rides high
	jsr	ay3_write_reg	;



main_loop:

; 137
sample_loop:
	; repeat 64 times (COUNTER1)
	ldx	#64							; 2

; 2 / 109 (need 20 more) / 139
output_loop:

	; (t>>7|t|t>>6)*10+4*(t&t>>13|t>>6)
	; (COUNTER1 | COUNTER2 | COUNTER3)*5 +
	;	2*(COUNTER1 & COUNTER4 | COUNTER2) >> 3

	lda	COUNTER1						; 3
	ora	COUNTER2						; 3
	ora	COUNTER3						; 3
	sta	TEMP		; temp=counter1|counter2|counter3	; 3
; 14
	asl			; A=temp*4				; 2
	asl								; 2
	clc								; 2
	adc	TEMP							; 3
	sta	TEMP		; temp = (c1|c2|c3)*5			; 3
; 26
	lda	COUNTER1						; 3
	and	COUNTER4						; 3
	ora	COUNTER2	; A=(c1&c4)|c2				; 3
	asl			; *2					; 2
	clc								; 2
	adc	TEMP		; A=(c1|c2|c3)*5 + ((c1&c4)|c2)*2	; 3

	; compared to the C version, A is /2 here
; 42
	asl								; 2
; 44
output:
	tay								; 2
	lda	volume_lookup,Y						; 4+
; 50
	sta	TEMP2			; save amplitude		; 3

	stx	XSAVE			; save X, urgh			; 3

; 56
	ldx	#8							; 2
	jsr	ay3_write_reg_temp2					; 6+38
; 102
	ldx	XSAVE			; restore X			; 3
; 105
	inc	COUNTER1		; t++				; 5
; 110
	dex								; 2
;	bne	output_loop		; loop 64 times			; 2/3
	beq	div_64

	;=================================
	; 20 cycles of visualization

	ldy	#0							; 2
	lda	(OUTL),Y
	cmp	#$FF
	beq	skip
	lda	COUNTER3						; 3
	and	#$33

	sta	(OUTL),Y						; 6
skip:

	lda	OUTL							; 3
	clc								; 2
	adc	#1							; 2
	sta	OUTL							; 3
	lda	OUTH							; 3
	adc	#0							; 2
;	sta	OUTH							; 3


;	inc	OUTL							; 5
;	bne	noflo							; 2/3
;	inc	OUTH							; 5
;	lda	OUTH							; 3

	cmp	#$8
	bne	noflo
	lda	#$4
noflo:
	sta	OUTH

	jmp	output_loop

div_64:

; 108
	;==============================
	; here only every 1/64 of time

	inc	COUNTER2	; c2++ (t >> 6)				; 5
	lda	COUNTER2						; 3
	; if counter2 == 128 or counter2 == 0 then inc counter4
	and	#$7F							; 2
	bne	Counter4_OK						; 2/3
; 120

	inc	COUNTER4	; only inc 1/128 of time (t>>13)	; 5

; 125 / 121
Counter4_OK:
	lsr			; check bottom bit			; 2
	bcs	Counter3_OK						; 2/3
; 129 / 125

	inc	COUNTER3	; only inc 1/2 of time (t>>7)		; 5

; 134/130/126
Counter3_OK:
	jmp	sample_loop						; 3
; 137



	;============================
	;============================
	;============================
	; ay3 write reg
	;============================
	;============================
	;============================
	; X is reg to write
	; A is value


ay3_write_reg:
; 0
        sta     TEMP2                                                   ; 3
ay3_write_reg_temp2:

; 3
        lda     #MOCK_AY_LATCH_ADDR     ; latch_address for PB1         ; 2
        ldy     #MOCK_AY_INACTIVE       ; go inactive                   ; 2
; 7
        stx     MOCK_6522_ORA1          ; put address on PA1            ; 4
        sta     MOCK_6522_ORB1          ; latch_address on PB1          ; 4
        sty     MOCK_6522_ORB1                                          ; 4
; 19
        ; value
        lda     TEMP2                                                   ; 2
        sta     MOCK_6522_ORA1          ; put value on PA1              ; 4
        lda     #MOCK_AY_WRITE          ;                               ; 2
        sta     MOCK_6522_ORB1          ; write on PB1                  ; 4
        sty     MOCK_6522_ORB1                                          ; 4
; 35
        rts
; 41


.if 0
	;=========================
	; both channels code
	; too slow
	;=========================
ay3_write_reg:
; 0
	sta	TEMP2							; 3
ay3_write_reg_temp2:
; 3
	stx	MOCK_6522_ORA1		; put address on PA1            ; 4
	stx	MOCK_6522_ORA2		; put address on PA2            ; 4
	lda	#MOCK_AY_LATCH_ADDR	; latch_address on PB1          ; 2
	sta	MOCK_6522_ORB1		; latch_address on PB1          ; 4
	sta	MOCK_6522_ORB2		; latch_address on PB2          ; 4
	ldy	#MOCK_AY_INACTIVE	; go inactive                   ; 2
	sty	MOCK_6522_ORB1                                          ; 4
	sty	MOCK_6522_ORB2                                          ; 4

	lda	TEMP2							; 3
	sta	MOCK_6522_ORA1          ; put value on PA1              ; 4
	sta	MOCK_6522_ORA2          ; put value on PA2              ; 4
	lda	#MOCK_AY_WRITE          ;                               ; 2
	sta	MOCK_6522_ORB1          ; write on PB1                  ; 4
	sta	MOCK_6522_ORB2          ; write on PB2                  ; 4
	sty	MOCK_6522_ORB1                                          ; 4
	sty	MOCK_6522_ORB2                                          ; 4
                                                                ;===========
                                                                ;        29

        rts                                                             ; 6
                                                                ;===========
                                                                ;       63
.endif


	;======================================
	; probably not the most efficient way
	; to do this....
	;======================================
	; 32 bytes
	; assume A is 0 when called

make_volume_lookup:
;	lda	#0
	tay
	tax
mvl_loop:
	tya
	cmp	inc_volume_table,X
	bne	mvl_good
	inx
mvl_good:
	txa
	sta	volume_lookup,Y
	iny
	bne	mvl_loop
	rts

inc_volume_table:
.byte $02,$03,$04,$05,$07,$0A,$0E,$13,$1B,$26,$36,$4C,$6C,$98,$D7

.if 0
volume_lookup:
.byte $00,$00,$01,$02,$03,$04,$04,$05,$05,$05,$06,$06,$06,$06,$07,$07
.byte $07,$07,$07,$08,$08,$08,$08,$08,$08,$08,$08,$09,$09,$09,$09,$09
.byte $09,$09,$09,$09,$09,$09,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A
.byte $0A,$0A,$0A,$0A,$0A,$0A,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B
.byte $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0C,$0C,$0C,$0C
.byte $0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C
.byte $0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0D,$0D,$0D,$0D
.byte $0D,$0D,$0D,$0D,$0D,$0D,$0D,$0D,$0D,$0D,$0D,$0D,$0D,$0D,$0D,$0D
.byte $0D,$0D,$0D,$0D,$0D,$0D,$0D,$0D,$0D,$0D,$0D,$0D,$0D,$0D,$0D,$0D
.byte $0D,$0D,$0D,$0D,$0D,$0D,$0D,$0D,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E
.byte $0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E
.byte $0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E
.byte $0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E
.byte $0E,$0E,$0E,$0E,$0E,$0E,$0E,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F
.byte $0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F
.byte $0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F
.endif

	; start at 16
vlin_start:
	.byte	18,14,12,14,18,14,12,14,18

vlin_stop:
	.byte	23,25,27,31,33,31,29,25,23
