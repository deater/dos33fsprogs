;==============================
; OOTW -- Intro -- The Elevator
;==============================


intro_03_elevator:

;===============================
;===============================
; Elevator going down
;===============================
;===============================

elevator:
	;=============================
	; Load background to $c00 and $1000

	lda	#<(intro_elevator_lzsa)
        sta     getsrc_smc+1    ; LZSA_SRC_LO
	lda	#>(intro_elevator_lzsa)
        sta     getsrc_smc+2    ; LZSA_SRC_HI

	lda	#$c			; load to off-screen $c00
	jsr	decompress_lzsa2_fast

	lda	#<(intro_elevator_lzsa)
        sta     getsrc_smc+1    ; LZSA_SRC_LO
	lda	#>(intro_elevator_lzsa)
        sta     getsrc_smc+2    ; LZSA_SRC_HI

	lda	#$10			; load also to off-screen $1000
	jsr	decompress_lzsa2_fast


	jsr	gr_copy_to_current

	lda	#$66
	sta	COLOR

	; elevator outer door

	ldx	#39
	stx	V2
	ldx	#4
	ldy	#14
	jsr	vlin	; VLIN 4,39 AT 14 (X, V2 at Y)

	ldx	#35
	stx	V2
	ldx	#7
	ldy	#18
	jsr	vlin	; VLIN 7,35 AT 18 (X, V2 at Y)

	; elevator inner door
	ldx	#2
	stx	ELEVATOR_COUNT
elevator_middle:
	ldx	#38
	stx	V2
	ldx	#5
	ldy	#15

	jsr	vlin	; X, V2 at Y

	ldx	#36
	stx	V2
	ldx	#6
	ldy	#17

	jsr	vlin	; X, V2 at Y

elevator_inner:
	ldx	#37
	stx	V2
	ldx	#5
	ldy	#16

	jsr	vlin	; X, V2 at Y



	jsr	page_flip

	jsr	gr_copy_to_current

	ldx	#50
	jsr	long_wait

	dec	ELEVATOR_COUNT
	lda	ELEVATOR_COUNT
	beq	elevator_inner
	cmp	#1
	beq	elevator_middle

	; door closed

	jsr	page_flip

	ldx	#100
	jsr	long_wait

	;======================
	; yellow line goes down
	;======================

	lda	#0
	sta	COLOR
	lda	#5
	sta	V2
yellow_line_down:

	jsr	gr_copy_to_current

	ldx	#5
	ldy	#16
	jsr	vlin	; X, V2 at Y

	jsr	page_flip

	ldx	#12
	jsr	long_wait

	inc	V2
	lda	V2
	cmp	#37
	bne	yellow_line_down

	lda	DRAW_PAGE
	pha

	lda	#$c				; erase yellow line
	sta	DRAW_PAGE			; on page $1000 version
	ldx	#5
	ldy	#16
	jsr	vlin	; X, V2 at Y

	pla
	sta	DRAW_PAGE

	;========================
	; change floor indicators
	;========================

	lda	#$33
	sta	COLOR
	lda	#5
	sta	V2

	lda	#4
	sta	PARTICLE_COUNT
floor_loop:

	jsr	gr_copy_to_current_1000

	lda	 PARTICLE_COUNT
	asl
	tay
	ldx     indicators,Y
        lda     indicators+1,Y

	jsr     plot

	jsr	page_flip
	ldx	#150
	jsr	long_wait

	dec	PARTICLE_COUNT
	bpl	floor_loop

	;====================
	; dark elevator
	;====================

	; clear $c00 to black

	lda	DRAW_PAGE
	pha

	lda	#$8
	sta	DRAW_PAGE
	jsr	clear_all

	pla
	sta	DRAW_PAGE

	; blue from 20, 30 - 20,34 and yellow (brown?) from 20,0 to 20,30
	; scrolls down until all yellow

	lda	#30
	sta	ELEVATOR_COUNT
going_down_loop:

	jsr	gr_copy_to_current	; copy black screen in

	; draw the yellow part

	lda	#$DD
	sta	COLOR
	lda	ELEVATOR_COUNT
	sta	V2
	ldx	#0
	ldy	#20
	jsr	vlin	; X, V2 at Y

	lda	#$22			; draw the blue part
	sta	COLOR

	lda	ELEVATOR_COUNT
	clc
	adc	#4
	cmp	#40
	bmi	not_too_big

	lda	#40
not_too_big:
	sta	V2
	ldx	ELEVATOR_COUNT
	ldy	#20
	jsr	vlin	; X, V2 at Y

	jsr	page_flip

	ldx	#8			; pause
	jsr	long_wait

	inc	ELEVATOR_COUNT
	lda	ELEVATOR_COUNT
	cmp	#40
	bne	going_down_loop

	;=====================
	; all yellow for a bit
	;=====================

	jsr	gr_copy_to_current	; copy black screen in
	lda	#$DD
	sta	COLOR
	lda	#40
	sta	V2
	ldx	#0
	ldy	#20
	jsr	vlin	; X, V2 at Y
	jsr	page_flip

	ldx	#100			; wait a bit
	jsr	long_wait


	; single blue dot
	; solid blue line 10 later

	lda	#2
	sta	ELEVATOR_CYCLE

going_down_repeat:

	lda	#1
	sta	ELEVATOR_COUNT
going_down_blue:

	jsr	gr_copy_to_current	; copy black screen in

	; draw the blue part

	lda	#$22
	sta	COLOR
	lda	ELEVATOR_COUNT
	sta	V2
	ldx	#0
	ldy	#20
	jsr	vlin	; X, V2 at Y

gdb_smc:
	lda	#$dd			; draw the blue part
	sta	COLOR

	lda	#40
	sta	V2
	ldx	ELEVATOR_COUNT
	ldy	#20
	jsr	vlin	; X, V2 at Y

	jsr	page_flip

	ldx	#8			; pause
	jsr	long_wait

	inc	ELEVATOR_COUNT
	lda	ELEVATOR_COUNT
	cmp	#40
	bne	going_down_blue

	dec	ELEVATOR_CYCLE
	beq	elevator_exit


	lda	#1
	sta	ELEVATOR_COUNT
going_down_black:

	jsr	gr_copy_to_current	; copy black screen in

	; draw the blue part

	lda	#$00
	sta	COLOR
	lda	ELEVATOR_COUNT
	sta	V2
	ldx	#0
	ldy	#20
	jsr	vlin	; X, V2 at Y

	lda	#$22			; draw the blue part
	sta	COLOR

	lda	#40
	sta	V2
	ldx	ELEVATOR_COUNT
	ldy	#20
	jsr	vlin	; X, V2 at Y

	jsr	page_flip

	ldx	#8			; pause
	jsr	long_wait

	inc	ELEVATOR_COUNT
	lda	ELEVATOR_COUNT
	cmp	#40
	bne	going_down_black

	lda	#$00
	sta	gdb_smc+1

	jmp	going_down_repeat


	; black, 2, blue, black about 20
	; blue until hit bottom, doors open

elevator_exit:

	ldx	#100			; pause
	jsr	long_wait



;===============================
;===============================
; Getting out of Elevator
;===============================
;===============================


	;=============================
	; Load elevator background

	lda	#<(intro_off_elevator_lzsa)
        sta     getsrc_smc+1    ; LZSA_SRC_LO
	lda	#>(intro_off_elevator_lzsa)
	sta     getsrc_smc+2    ; LZSA_SRC_HI

	lda	#$c			; load to off-screen $c00
	jsr	decompress_lzsa2_fast

	lda	#<(walking00_lzsa)
        sta     getsrc_smc+1    ; LZSA_SRC_LO
	lda	#>(walking00_lzsa)
	sta     getsrc_smc+2    ; LZSA_SRC_HI

	lda	#$10			; load to off-screen $1000
	jsr	decompress_lzsa2_fast


	lda	#10
	sta	ELEVATOR_COUNT

elevator_open_loop:
	jsr	gr_overlay		; note: overwrites color
	lda	#$00
	sta	COLOR

; Would have liked to have a central purple stripe, but not easy

; 9 10 11 12 13 14 15 16 17 18 19     20    21 22 23 24 25 26 27 28 29 30


	lda	ELEVATOR_COUNT
	sta	ELEVATOR_CYCLE
elevator_inner_loop:
	lda	#9
	clc
	adc	ELEVATOR_CYCLE
	tay

	lda	#40
	sta	V2
	ldx	#0
	jsr	vlin	; X, V2 at Y

	sec
	lda	#30
	sbc	ELEVATOR_CYCLE
	tay

	lda	#40
	sta	V2
	ldx	#0
	jsr	vlin	; X, V2 at Y

	dec	ELEVATOR_CYCLE
	bne	elevator_inner_loop

	jsr	page_flip

	ldx	#25
	jsr	long_wait		; pause

	dec	ELEVATOR_COUNT
	bne	elevator_open_loop

	;==================================
	; draw walking off the elevator

	lda	#<walking_sequence
	sta	INTRO_LOOPL
	lda	#>walking_sequence
	sta	INTRO_LOOPH

	jsr	run_sequence

	;======================================
	; make background black and pause a bit

	jsr	clear_all
	jsr	page_flip

	ldx	#80
	jmp	long_wait		; returns for us



;=================================
;=================================
; Intro Segment 03 Data (Elevator)
;=================================
;=================================

.include "graphics/03_elevator/intro_elevator.inc"
.include "graphics/03_elevator/intro_off_elevator.inc"
.include "graphics/03_elevator/intro_walking.inc"


	; Elevator light co-ordinates
	; we load them backwards
indicators:
	.byte 	18,4	; 4
	.byte	16,3	; 3
	.byte 	14,2	; 2
	.byte	18,2	; 1
	.byte	16,1	; 0

; Walking off elevator sequence

walking_sequence:
	.byte	20
	.word	walking01_lzsa
	.byte	128+20	;	.word	walking02_lzsa
	.byte	128+20	;	.word	walking03_lzsa
	.byte	128+20	;	.word	walking04_lzsa
	.byte	128+20	;	.word	walking05_lzsa
	.byte	128+20	;	.word	walking06_lzsa
	.byte	128+20	;	.word	walking07_lzsa
	.byte	128+20	;	.word	walking08_lzsa
	.byte	20
	.word	walking08_lzsa
	.byte	0
