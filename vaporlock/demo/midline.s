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

sine = $c00	; location of sine table


midline:

	;================================
	; Clear screen and setup graphics
	;================================

	sta	FULLGR
	sta	SETMOUSETEXT		; enable mouse text for Apple char

	.include "sinetable.s"		; Y is FF after this
					; A = 1, X = $40
	iny		; needed?
	sty	FRAME

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

; 2

top_smc:
	ldx	#66			; 2
	lda	$00	; nop3		; 5
	bne	top10	; bra		; 3/2


top_loop:
	nop				; 2
	nop				; 2
	nop				; 2
	nop				; 2
	nop				; 2
top10:

; 10
	ldy	#4			; 2
; 12
	jsr	wait_y_x_10		; 40
; 52
	nop				; 2
	nop				; 2
; 56
	nop				; 2
	nop				; 2
; 60
	dex				; 2
	bne	top_loop		; 3/2


	; middle


					; -1
	nop				; 2
	nop				; 2
	ldx	#56			; 2
	bne	middle_8	; bra	; 3


middle_loop:
	nop				; 2
	nop				; 2
	nop				; 2
	nop				; 2
; 8
middle_8:
	jsr	delay_16_setgr		; 16
; 24
	jsr	delay_16_settext	; 16
; 40
	jsr	delay_16_setgr		; 16
; 56
	nop				; 2
	nop				; 2
; 60
	dex				; 2
	bne	middle_loop		; 3/2




					; -1
	nop				; 2
	nop				; 2
bottom_smc:
	ldx	#118			; 2
	bne	bottom_8	; bra	; 3/2

bottom_loop:

	nop				; 2
	nop				; 2
	nop				; 2
	nop				; 2
; 8
bottom_8:
	ldy	#4			; 2
; 10
	jsr	wait_y_x_10		; 40
; 50
	nop
	nop
	nop

; 56
	nop


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
					; -1
	inc	FRAME			; 5
; 4
	ldy	FRAME			; 3
	lda	sine,Y			; 4 (aligned)
; 11
	clc				; 2
	adc	#2			; 2
	sta	top_smc+1		; 4
	adc	#56			; 2
	sta	bottom_smc+1		; 4

; 25
	lda	#1			; 2
	ldy	#244			; 2
; 29
	jsr	size_delay		; 4520
; 4549

	jmp	cycle_start
; +2


delay_16_setgr:
	bit	SET_GR
delay_12:
	rts

delay_16_settext:
	bit	SET_TEXT
	rts


	;===================================
        ; wait y-reg times 10
        ;===================================

loop10:
        bne     skip
wait_y_x_10:
        dey                     ; wait y-reg times 10                   ; 2
skip:
        dey                                                             ; 2
        nop                                                             ; 2
        bne     loop10                                                  ; 2/3
        rts                                                             ; 6

.if 0
	;===================================
        ; wait x-reg times 1000
        ;===================================

loop1k:
        pha                                                             ; 3
        pla                                                             ; 4
        nop                                                             ; 2
        nop                                                             ; 2
wait_X_x_1k:
        ldy     #98                     ; wait x-reg times 1000         ; 2
        jsr     wait_y_x_10						; 980
        nop                                                             ; 2
        dex                                                             ; 2
        bne     loop1k                                                  ; 2/3
rts1:
        rts                                                             ; 6
.endif
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
	rts

a2_string:
	;      012345678901234567   8       9
;	.byte "Apple II Forever!! ",'@'+$80," ",0
	.byte 'A'+$80,'p'+$80,'p'+$80,'l'+$80,'e'+$80,' '+$80
	.byte 'I'+$80,'I'+$80,' '+$80,'F'+$80,'o'+$80,'r'+$80
	.byte 'e'+$80,'v'+$80,'e'+$80,'r'+$80,'!'+$80,'!'+$80
	.byte ' '+$80,'@'+$00,' '+$80,0
