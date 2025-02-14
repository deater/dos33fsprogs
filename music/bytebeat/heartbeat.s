; Heartbeat 256B demo for Lovebyte 2025

; Apple II lo-res graphics and bytebeat music

; You need a mockingboard in slot #4
;	also note sound only comes out one channel

; by deater (Vince Weaver) <vince@deater.net>

; for a 256 entry we need to fit in 252 bytes (4 bytes of header)

; this is based off of Tjoppen's 128 byte demo (w/o sync)
; which is based off of viznut's combination of xpansive's
; and varjohukka's stuff from the pouet thread
; http://pouet.net/topic.php?which=8357&page=4
; (t>>7|t|t>>6)*10+4*(t&t>>13|t>>6)

; 8kHz (bytebeat frequency) = 125us
; Apple II = 1.023MHz = .98us = ~128 cycles for 8kHZ

; Zero Page

; zero page RAM addresses

GBASL		= $26
GBASH		= $27
COLOR		= $30	; LORES color for VLIN

COUNTER1	= $F0   ; t
COUNTER2	= $F1	; t >> 6
COUNTER3	= $F2	; t >> 7
COUNTER4	= $F3	; t >> 13
TEMP	 	= $F4
TEMP2		= $F5

;OUTL		= $F6
;OUTH		= $F7
XSAVE		= $F8
COUNT		= $F9

; Soft switches

FULLGR		= $C052			; full screen of graphics

; ROM routines

SETGR		= $FB40
VLINE		= $F828                 ; VLINE A,$2D at Y  (X preserved?)

; data locations

volume_lookup	= $2000			; log volume table we'll build



heartbeat:
	jsr	SETGR			; enable lo-res graphics
					; A=$D0, Z=1

	bit	FULLGR			; make graphcs full screen


	;================================
	; draw red heart to screen
	;================================

	lda	#$11			; red
	sta	COLOR

	ldx	#24			; draw columns 16...24
heart_loop:
	txa				; move X into Y
	tay

	lda	vlin_stop-16,Y		; get stop address
	sta	$2D

	lda	vlin_start-16,Y		; get start address

	jsr	VLINE			; draw vertical line
					; A is V2 at end, X preserved?

	dex
	cpx	#15
	bne	heart_loop

	lda	#0
	sta	COUNTER1		; init counters
	sta	COUNTER2
	sta	COUNTER3
	sta	COUNTER4


	;======================================
	; make logarithmic volume lookup table
	;   probably not the most efficient
	;   way to do this....
	;======================================

	; assume A is 0

make_volume_lookup:
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

	; note: GBASL/GBASH for graphics output already set by VLIN

	;===================
	; music Player Setup

	; assume mockingboard in slot#4

	; inline mockingboard_init

; left speaker
MOCK_6522_ORB1	=	$C400	; 6522 #1 port b data
MOCK_6522_ORA1	=	$C401	; 6522 #1 port a data
MOCK_6522_DDRB1	=	$C402	; 6522 #1 data direction port B
MOCK_6522_DDRA1	=	$C403	; 6522 #1 data direction port A

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
	; set up AY-3-8910 registers

	; set channel A to be mute (which pulls high)
	; we can still manipulate with the amplitude register
	; to make a 4-bit DAC

	ldx	#7
	lda	#$3F		; if all off, the output rides high
	jsr	ay3_write_reg	;



	;===============================
	;===============================
	; main loop
	;===============================
	;===============================

main_loop:

; 144
sample_loop:
	; repeat 64 times (COUNTER1)
	ldx	#64							; 2

; 2 / 146 / 165
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
	asl			; make it full value			; 2
; 44
output:
	tay				; convert to log volume		; 2
	lda	volume_lookup,Y						; 4+
; 50
	sta	TEMP2			; save amplitude		; 3

	stx	XSAVE			; save X, urgh			; 3

; 56
	ldx	#8			; write amplitude to AY reg8	; 2
	jsr	ay3_write_reg_temp2					; 6+38
; 102
	ldx	XSAVE			; restore X			; 3
; 105
	inc	COUNTER1		; t++				; 5
; 110
	dex								; 2
;	bne	output_loop		; loop 64 times			;
	beq	div_64							; 2/3

; 114
	;====================
	; 20 Visualization

	ldy	#0							; 2
	lda	(GBASL),Y		; get color under pointer	; 5+

	cmp	#$11			; check if red			; 2
	beq	skip			; if so, don't draw		; 2/3
; 125

	lda	COUNTER3		; write out color based on	; 3
	and	#$EE			; counter3, masked to limit	; 2

	sta	(GBASL),Y		; store out new color		; 6
; 136
skip:
; 126 / 136

	;==========================
	; increment output pointer

	lda	GBASL			; 16-bit increment		; 3
	clc								; 2
	adc	#1							; 2
	sta	GBASL							; 3
	lda	GBASH							; 3
	adc	#0							; 2
; 143 / 153

	cmp	#$8			; see if need to wrap		; 2
	bne	noflo							; 2/3
; 147 / 157

	lda	#$4			; reset to start of gr-page0	; 2
noflo:
; 149 / 159 / 148 / 158
	sta	GBASH							; 3

	bne	output_loop		; bra				; 3

; 165 worst case

	;=============================
	; call this every 64 cycles

div_64:

; 115
	;==============================
	; here only every 1/64 of time

	inc	COUNTER2	; c2++ (t >> 6)				; 5
	lda	COUNTER2						; 3
	; if counter2 == 128 or counter2 == 0 then inc counter4
	and	#$7F							; 2
	bne	Counter4_OK						; 2/3
; 127

	inc	COUNTER4	; only inc 1/128 of time (t>>13)	; 5

; 128 / 132
Counter4_OK:
	lsr			; check bottom bit			; 2
	bcs	Counter3_OK						; 2/3
; 132 / 136

	inc	COUNTER3	; only inc 1/2 of time (t>>7)		; 5

; 133 / 137 / 141
Counter3_OK:
	jmp	sample_loop						; 3
; 144 worst case



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
	; write both channels code
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
; 31
	lda	TEMP2							; 3
	sta	MOCK_6522_ORA1          ; put value on PA1              ; 4
	sta	MOCK_6522_ORA2          ; put value on PA2              ; 4
	lda	#MOCK_AY_WRITE          ;                               ; 2
	sta	MOCK_6522_ORB1          ; write on PB1                  ; 4
	sta	MOCK_6522_ORB2          ; write on PB2                  ; 4
	sty	MOCK_6522_ORB1                                          ; 4
	sty	MOCK_6522_ORB2                                          ; 4
; 60
        rts                                                             ; 6
; 66
.endif





inc_volume_table:
.byte $02,$03,$04,$05,$07,$0A,$0E,$13,$1B,$26,$36,$4C,$6C,$98,$D7

	; data for drawing the heart

	; start at 16
vlin_start:
	.byte	18,14,12,14,18,14,12,14,18

vlin_stop:
	.byte	23,25,27,31,33,31,29,25,23
