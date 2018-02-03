; http://macgui.com/usenet/?group=2&id=8366

; Mockingboad programming:
; + Has two 6522 I/O chips connected to two AY-3-8910 chips
; + Optionally has some speech chips controlled via the outport on the AY
; + Often in slot 4
;	TODO: how to auto-detect?

.include	"zp.inc"

	;=============================
	; set low-res graphics, page 0
	;=============================
	jsr     HOME
	jsr     TEXT

	lda	#0
	sta	DRAW_PAGE
	sta	CH
	sta	CV
	lda	#<mocking_message
	sta	OUTL
	lda	#>mocking_message
	sta	OUTH
	jsr	move_and_print

	;============================
	; Init the Mockingboard
	;============================

	jsr	mockingboard_init
	jsr	reset_ay_left
	jsr	reset_ay_right

	;===========================
	; load pointer to the music
	;===========================

	lda	#<ksptheme
	sta	INL
	lda	#>ksptheme
	sta	OUTL

play_loop:


delay_a_bit:

	lda	#86
	jsr	WAIT			; delay 1/2(26+27A+5A^2) us
					; 50Hz = 20ms = 20000us
					; 40000 = 26+27A+5A^2
					; 5a^2+27a-39974 = 0
					; A = 86.75
done_play:
	lda	#0
	sta	CH
	lda	#2
	sta	CV
	lda	#<done_message
	sta	OUTL
	lda	#>done_message
	sta	OUTH
	jsr	move_and_print


forever_loop:
	jmp	forever_loop



; left speaker
MOCK_6522_ORB1	EQU	$C400	; function to perform, OUT 1
MOCK_6522_ORA1	EQU	$C401	; data, OUT 1
MOCK_6522_DDRB1	EQU	$C402	; data direction, OUT 1
MOCK_6522_DDRA1	EQU	$C403	; data direction, OUT 1

; right speaker
MOCK_6522_ORB2	EQU	$C480	; function to perform, OUT 2
MOCK_6522_ORA2	EQU	$C481	; data, OUT 2
MOCK_6522_DDRB2	EQU	$C482	; data direction, OUT 2
MOCK_6522_DDRA2	EQU	$C483	; data direction, OUT 2

; AY-3-8910 commands on port B
;						RESET	BDIR	BC1
MOCK_AY_RESET		EQU	$0	;	0	0	0
MOCK_AY_INACTIVE	EQU	$4	;	1	0	0
MOCK_AY_READ		EQU	$5	;	1	0	1
MOCK_AY_WRITE		EQU	$6	;	1	1	0
MOCK_AY_LATCH_ADDR	EQU	$7	;	1	1	1


	;========================
	; Mockingboard card
	; Essentially two 6522s hooked to the Apple II bus
	; Connected to AY-3-8910 chips
	;	PA0-PA7 on 6522 connected to DA0-DA7 on AY
	;	PB0     on 6522 connected to BC1
	;	PB1	on 6522 connected to BDIR
	;	PB2	on 6522 connected to RESET

	;========================
	; Mockingboard Init
	;========================
mockingboard_init:
	; Initialize the 6522s
	; set the data direction for all pins of PortA/PortB to be output
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
	; register in X
	; value in Y

write_right_ay:
	; address
	stx	MOCK_6522_ORA1		; put address on PA
	lda	#MOCK_AY_LATCH_ADDR	; latch_address on PB
	sta	MOCK_6522_ORB1
	lda	#MOCK_AY_INACTIVE	; go inactive
	sta	MOCK_6522_ORB1

	; value
	sty	MOCK_6522_ORA1		; put value on PA
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

write_left_ay:
	; address
	stx	MOCK_6522_ORA2		; put address on PA
	lda	#MOCK_AY_LATCH_ADDR	; latch_address on PB
	sta	MOCK_6522_ORB2
	lda	#MOCK_AY_INACTIVE	; go inactive
	sta	MOCK_6522_ORB2

	; value
	sty	MOCK_6522_ORA2		; put value on PA
	lda	#MOCK_AY_WRITE		; write on PB
	sta	MOCK_6522_ORB2
	lda	#MOCK_AY_INACTIVE	; go inactive
	sta	MOCK_6522_ORB2

	rts


;routines
.include	"../asm_routines/gr_offsets.s"
.include	"../asm_routines/text_print.s"

; music
.include	"ksptheme_uncompressed.inc"

mocking_message:	.asciiz "ASSUMING MOCKINGBOARD IN SLOT #4"
done_message:		.asciiz "DONE PLAYING"
