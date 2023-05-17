; Blargh

; by Vince `deater` Weaver

.include "zp.inc"
.include "hardware.inc"


double:

	lda	#0
	sta	FRAME
	lda	#$ff
	sta	FRAMEH

	;================================
	; Clear screen and setup graphics
	;================================

	jsr	SETGR		; set lo-res 40x40 mode
	bit	LORES
	sta	FULLGR

	;====================================================
	; setup text page2 screen of "Apple II Forever" text
	;====================================================
	; there are much better ways to accomplish this

	sta	SETMOUSETEXT

	ldy	#0
	ldx	#0
	sty	XX
a24e_newy:
	lda	gr_offsets_l,Y
	sta	stringing_smc+1
	lda	gr_offsets_h,Y
	clc
	adc	#4
	sta	stringing_smc+2

a24e_loop:

	lda	a2_string,X
	bne	keep_stringing

	ldx	#0
	lda	a2_string,X

keep_stringing:

	inx

	eor	#$80

stringing_smc:
	sta	$d000

	inc	stringing_smc+1

	inc	XX
	lda	XX
	cmp	#40
	bne	a24e_loop

	lda	#0
	sta	XX
	iny
	cpy	#24
	bne	a24e_newy

stringing_done:

	bit	PAGE2

blog:

	ldx	#255

blog_loop:
	jsr	delay_12	; 12
	bit	SET_GR		; 4
; 16
	jsr	delay_12	; 12
; 28
	bit	SET_TEXT	; 4
; 32
	jsr	delay_12	; 12
; 44
	bit	SET_GR		; 4
; 48
	jsr	delay_12	; 12
; 60
	dex			; 2
;	bne	blog_loop	; 2/3

	jmp	blog_loop	; 3

delay_12:
	rts

.if 0

				; -1

	;==================================
        ; vblank = 4550 cycles

        ; Try X=226 Y=4 cycles=4545
skip_vblank:
	lda	$00	; nop3

        ldy     #4                                                      ; 2
loop3:  ldx     #226                                                    ; 2
loop4:  dex                                                             ; 2
        bne     loop4                                                   ; 2nt/3
        dey                                                             ; 2
        bne     loop3                                                   ; 2nt/3

	jmp	midline_loop	; 3

.align $100

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



.include "vblank.s"

.endif

.include "gr_offsets.s"

a2_string:
	;      012345678901234567   8       9
	.byte "Apple II Forever!! ",'@'+$80," "
	.byte "Apple II Forever! ",'@'+$80," ",0







