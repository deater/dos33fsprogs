; Blargh

; by Vince `deater` Weaver

.include "zp.inc"
.include "hardware.inc"


; 198 bytes -- proof of concept
;  76 bytes -- optimize Apple II Forever printing code

midline:

	;================================
	; Clear screen and setup graphics
	;================================

	sta	FULLGR
	sta	SETMOUSETEXT

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
        jsr     waitx1k         ;                                       ; 17000
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

	ldx	#255

blog_loop:
	jsr	delay_16_setgr		; 16
; 16
	jsr	delay_16_settext	; 16
; 32
	jsr	delay_16_setgr		; 16
; 48
	jsr	delay_12		; 12
; 60
	dex				; 2
	jmp	blog_loop		; 3



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
waitx10:
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
waitx1k:
        ldy     #98                     ; wait x-reg times 1000         ; 2
        jsr     waitx10                                                 ; 980
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
