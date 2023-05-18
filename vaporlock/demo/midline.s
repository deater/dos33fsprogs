; Blargh

; by Vince `deater` Weaver

.include "zp.inc"
.include "hardware.inc"


; 198 bytes -- proof of concept
;  76 bytes -- optimize Apple II Forever printing code
; 183 bytes -- stable window
; 248 bytes -- sine code added

midline:

	;================================
	; Clear screen and setup graphics
	;================================

	sta	FULLGR
	sta	SETMOUSETEXT

	jsr	initSineTable

	;====================================================
	; setup text page1 screen of "Apple II Forever" text
	;====================================================

	ldy	#0
restart:
	ldx	#0
	iny
	beq	print_done
print_loop:
	lda	a2_string,X
	beq	restart
	jsr	COUT		; output char in A to stdout
	inx
	bne	print_loop
print_done:



	;==================================
        ; get exact vblank region
        ;==================================
	; code by Sather
	; "Understanding the Apple IIe"

poll1:
        lda     VBLANK          ; Find end of VBL
        bmi     poll1           ; Fall through at VBL
poll2:
        lda     VBLANK
        bpl     poll2           ; Fall through at VBL'                  ; 2

        lda     $00             ; Now slew back in 17029 cycle loops    ; 3
lp17029:
        ldx     #17             ;                                       ; 2
        jsr     wait_x_x_1k	;                                       ; 17000
        jsr     rts1            ;                                       ; 12
        lda     $00             ; nop3                                  ; 3
        lda     $00             ; nop3                                  ; 3
        lda     VBLANK          ; Back to VBL yet?                      ; 4
        nop                     ;                                       ; 2
        bmi     lp17029         ; no, slew back                         ; 2/3



	;==============================
	; do the cycle counting
	;==============================

blog:
	; 192 + 70 (vblank) = 262
	; if 42 high, then day 220 on, 42 off
	; how start in middle?

	;	.byte $A5

	lda	$EA	; nop3		; 3
top_smc:
	ldx	#90			; 2
	bne	top8	; bra		; 3/2


top_loop:
	nop				; 2
	nop				; 2
;blog_loop:
; 4
	nop				; 2
	nop				; 2
; 8

top8:
	ldy	FRAME			; 3
	lda	sine,Y			; 4 (aligned)
	clc				; 2
	adc	#4			; 2
	sta	top_smc+1		; 4
	adc	#56			; 2
	sta	bottom_smc+1		; 4
; 29
	ldy	#2			; 2
; 31
	jsr	wait_y_x_10		; 20
; 51
	lda	$00		; nop3	; 3
	nop				; 2
; 56
	nop				; 2
	nop				; 2
; 60
	dex				; 2
	bne	top_loop		; 3/2



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
	ldx	#178			; 2
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
	bne	bottom_loop		; 3/2

					; -1
	ldx	#4			; 2
	jsr	wait_x_x_1k		; 4000
	ldy	#54			; 2
	jsr	wait_y_x_10		; 540
;  4543
	inc	FRAME			; 5
; 4548 (-2)
	nop				; 2
; 0
	jmp	top_smc
; 3

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


	;===================================
        ; wait x-reg times 1000
        ;===================================

loop1k:
        pha                                                             ; 3
        pla                                                             ; 4
        nop                                                             ; 2
        nop                                                             ; 2
wait_x_x_1k:
        ldy     #98                     ; wait x-reg times 1000         ; 2
        jsr     wait_y_x_10						; 980
        nop                                                             ; 2
        dex                                                             ; 2
        bne     loop1k                                                  ; 2/3
rts1:
        rts                                                             ; 6

a2_string:
	;      012345678901234567   8       9
;	.byte "Apple II Forever!! ",'@'+$80," ",0
	.byte 'A'+$80,'p'+$80,'p'+$80,'l'+$80,'e'+$80,' '+$80
	.byte 'I'+$80,'I'+$80,' '+$80,'F'+$80,'o'+$80,'r'+$80
	.byte 'e'+$80,'v'+$80,'e'+$80,'r'+$80,'!'+$80,'!'+$80
	.byte ' '+$80,'@'+$00,' '+$80,0



initSineTable:

	ldy	#$3f
	ldx	#$00

; Accumulate the delta (normal 16-bit addition)
:
	lda	value
	clc
	adc	delta
	sta	value
	lda	value+1
	adc	delta+1
	sta	value+1

	; Reflect the value around for a sine wave
	sta	sine+$c0,x
	sta	sine+$80,y
	eor	#$7f
	sta	sine+$40,x
	sta	sine+$00,y

; Increase the delta, which creates the "acceleration" for a parabola
	lda	delta
;	adc	#$10   ; this value adds up to the proper amplitude
	adc	#$08   ; this value adds up to the proper amplitude
	sta	delta
	bcc :+
	inc	delta+1
:

	; Loop
	inx
	dey
	bpl :--

	rts

value: .word 0
delta: .word 0


sine = $c00
