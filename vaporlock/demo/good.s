; a 256-byte midline demo for Outline 2023

; by Vince `deater` Weaver / dSr

; requires an Apple IIe

.include "zp.inc"
.include "hardware.inc"

; 198 bytes -- proof of concept
;  76 bytes -- optimize Apple II Forever printing code
; 183 bytes -- stable window
; 248 bytes -- sine code added
; 274 bytes -- after much frustration, things sorta working
; 261 bytes -- use zp for sine generation
; 257 bytes -- inline sine generation
; 259 bytes -- fix sine generation initialization, shave some message print
; 247 bytes -- start replacing sather delays with something more compact
; 229 bytes -- finish replacing sather delays
; 228 bytes -- optimize and center the middle area
; 226 bytes -- init some of zero page to zero
; 244 bytes -- switch to hires too
; 247 bytes -- clear HGR

sine = $c00	; location of sine table


midline:

	;================================
	; Clear screen and setup graphics
	;================================

	; init $F1-$FF to zero

	lda	#0
	ldx	#15
init_loop:
	sta	$F0,X
	dex
	bne	init_loop

	; setup graphics

	sta	SETMOUSETEXT		; enable mouse text for Apple char

	.include "sinetable.s"		; Y is FF after this
					; A = 1, X = $40

	;====================================================
	; setup text page1 screen of "Apple II Forever" text
	;====================================================

	; X is $40 which is probably OK
	;	ldx	#0
restart:
	tay			; reset Y to 0 (or 1 first time through)
	inx
	beq	print_done
print_loop:
	lda	a2_string,Y
	beq	restart
	jsr	COUT		; output char in A to stdout
	iny
	bne	print_loop
print_done:


	jsr	HGR		; A and Y=0 now
	sta	FULLGR


	;==================================
        ; get exact vblank region
        ;==================================
	; code by Sather
	; "Understanding the Apple IIe"

poll1:
        lda     VBLANK		; Find end of VBL
        bmi     poll1		; Fall through at VBL
poll2:
        lda     VBLANK
        bpl     poll2		; Fall through at VBL'                  ; 2

        lda     $00	;nop3	; Now slew back in 17029 cycle loops    ; 3
lp17029:
	; delay 17020

	lda	#7							; 2
	ldy	#96							; 2
	jsr	size_delay						; 17012
	nop								; 2
	nop								; 2

        lda	VBLANK		; Back to VBL yet?                      ; 4
        nop			;                                       ; 2
        bmi	lp17029		; no, slew back                         ; 2/3



	;==============================
	; do the cycle counting
	;==============================

cycle_start:

	;==============================
	; top

; 2

top_smc:
	ldx	#66			; 2
	bne	top7	; bra		; 3/2

top_loop:
	pha				; 3
	pla				; 4
top7:
; 7
	lda	#0			; 2
	ldy	#3			; 2
; 11
	; want to delay 49

	jsr	size_delay		; 47
; 58
	nop				; 2
; 60
	dex				; 2
	bne	top_loop		; 3/2

	;===================================

	; middle
					; -1
	ldx	#56			; 2
	bne	middle_4	; bra	; 3


middle_loop:
	nop				; 2
	nop				; 2
middle_4:
; 4
	nop				; 2
	lda	$0		; nop3	; 3
; 9
	jsr	delay_16_setgr		; 16
; 25
	jsr	delay_16_settext	; 16
; 41
	jsr	delay_16_setgr		; 16
; 57
	lda	$0		; nop3	; 3
; 60
	dex				; 2
	bne	middle_loop		; 3/2

					; -1
bottom_smc:
	ldx	#118			; 2
	bne	bottom_4	; bra	; 3

bottom_loop:

	nop				; 2
	nop				; 2
; 4
bottom_4:
; 4
	lda	#0			; 2
	ldy	#3			; 2
; 8
	; want to delay 50

	jsr	size_delay		; 47
; 55
	lda	$0		; nop3	; 3
; 58
	inx				; 2
	cpx	#192			; 2
	bcc	bottom_loop		; 3/2

; -1

	;======================================
	; wait 4550 for VBLANK
	;======================================
				; -1 from before
vblank_start:

	; move window

							; -1
	clc						; 2
	lda	FRAME					; 3
	adc	#1					; 2
	sta	FRAME					; 3
	tay			; save for later	; 2
; 11
	lda	#0					; 2
	rol			; get carry bit in A	; 2
	eor	screen_smc+1				; 4
	sta	screen_smc+1				; 4
; 23

screen_smc:
	bit	LORES		; LORES=C056 HIRES=C057	; 4
; 27


	; FRAME should be in Y
	lda	sine,Y			; 4 (aligned)
; 31
	clc				; 2
	adc	#2			; 2
	sta	top_smc+1		; 4
	adc	#56			; 2
	sta	bottom_smc+1		; 4
; 45

	; finish delay

; 45
	lda	#1			; 2
	ldy	#241			; 2
; 49
	jsr	size_delay		; 4493
; 4542

	pha				; 3
	pla				; 4
; 4549
	jmp	cycle_start		; 3
; 4552


; want 4552 here

delay_16_setgr:
	bit	SET_GR
	rts

delay_16_settext:
	bit	SET_TEXT
	rts

	;=====================================
	; short delay by Bruce Clark
	;   any delay between 8 to 589832 with res of 9
	;=====================================
	; 9*(256*A+Y)+8 + 12 for jsr/rts
size_delay:

delay_loop:
	cpy	#1
	dey
	sbc	#0
	bcs	delay_loop
delay_12:
	rts

a2_string:
	;      012345678901234567   8       9
;	.byte "Apple II Forever!! ",'@'+$80," ",0
	.byte 'A'+$80,'p'+$80,'p'+$80,'l'+$80,'e'+$80,' '+$80
	.byte 'I'+$80,'I'+$80,' '+$80,'F'+$80,'o'+$80,'r'+$80
	.byte 'e'+$80,'v'+$80,'e'+$80,'r'+$80,'!'+$80,'!'+$80
	.byte ' '+$80,'@'+$00,' '+$80,0
