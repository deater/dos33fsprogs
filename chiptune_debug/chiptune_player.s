; VMW Chiptune Player

.include	"zp.inc"

	;=============================
	; Setup
	;=============================

	; init variables

	lda	#0
	sta	DONE_PLAYING
	sta	MB_CHUNK_OFFSET

	jsr	mockingboard_detect_slot4	; call detection routine

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
	; FIXME: should chain any existing handler

.ifdef NOIRQ
.else
	lda	#<interrupt_handler
	sta	$03fe
	lda	#>interrupt_handler
	sta	$03ff
.endif

	;============================
	; Enable 50Hz clock on 6522
	;============================
.ifdef NOIRQ
.else
	sei			; disable interrupts just in case

	lda	#$40		; Continuous interrupts, don't touch PB7
	sta	$C40B		; ACR register
	lda	#$7F		; clear all interrupt flags
	sta	$C40E		; IER register (interrupt enable)

	lda	#$C0
	sta	$C40D		; IFR: 1100, enable interrupt on timer one oflow
	sta	$C40E		; IER: 1100, enable timer one interrupt

.ifdef F25HZ
        lda     #$40
        sta     $C404           ; write into low-order latch
        lda     #$9c
        sta     $C405           ; write into high-order latch,
                                ; load both values into counter
                                ; clear interrupt and start counting

        ; 9c40 / 1e6 = .040s, 25Hz


.else
	lda	#$E7
	sta	$C404		; write into low-order latch
	lda	#$4f
	sta	$C405		; write into high-order latch,
				; load both values into counter
				; clear interrupt and start counting
	; 4fe7 / 1e6 = .020s, 50Hz
.endif

.endif

	;==================
	; load first song
	;==================

	jsr	new_song

	;============================
	; Enable 6502 interrupts
	;============================

.ifdef NOIRQ
.else
	cli		; clear interrupt mask
.endif

	;============================
	; Loop forever
	;============================
main_loop:

.ifdef NOIRQ
	jsr	interrupt_handler

	lda	#85
	jsr	WAIT	; wait 20ms-xms
.else
.endif
	jmp	main_loop


	;=================
	; load a new song
	;=================

new_song:

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

	; Decompress first chunks

	lda	#$3
	sta	CHUNKSIZE

	rts

;=========
;routines
;=========
.include	"mockingboard_a.s"
.include	"interrupt_handler.s"

.align 256
UNPACK_BUFFER:
.incbin		"sdemo.raw"
