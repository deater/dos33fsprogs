;license:MIT
;(c) 2018 by 4am
;
;!cpu 6502
;!to "build/FX.INDEXED/TWOPASS.LR",plain
;*=$6000

; 4-cade LR wipe


wipe_lr:
do_wipe_lr:
	lda	#$00			; reset pointers
	sta	h1_smc+1
	sta	h2_smc+1

outerloop1:
	lda	#$BF
	sta	WIPE_ROW
loop1:
	jsr	HGRCalc
h1_smc:
	ldy	#$00
;	lda	($3c),y
	lda	#0		; always wipe to black

	sta	($26),y
	dec	WIPE_ROW
	dec	WIPE_ROW
	lda	WIPE_ROW
	cmp	#$FF
	bne	loop1

	lda	#$10
	jsr	WaitForKeyWithTimeout
	bmi	lrexit

	inc	h1_smc+1
	lda	h1_smc+1
	cmp	#$28
	bne	outerloop1

outerloop2:
	lda	#$BE
	sta	WIPE_ROW
loop2:
	jsr   HGRCalc
h2_smc:
	ldy	#$00
;	lda	($3c),Y
	lda	#0			; always wipe to black
	sta	($26),Y
	dec	WIPE_ROW
	dec	WIPE_ROW
	lda	WIPE_ROW
	cmp	#$FE
	bne	loop2

	lda	#$10
	jsr	WaitForKeyWithTimeout
	bmi	lrexit

	inc	h2_smc+1
	lda	h2_smc+1
	cmp	#$28
	bne	outerloop2
lrexit:
	rts


;===============================================
; in:    A = HGR row (0x00..0xBF)
; out:   A/X clobbered
;        Y preserved
;        ($26) points to first byte of given HGR row on hi-res page 1
;        ($3C) points to same byte on hi-res page 2
; based on 'Woz Recodes Hi-Res Address Calculations'
; Apple Assembly Line vol. 7 issue 3 (December 1986)
; http://www.txbobsc.com/aal/1986/aal8612.html#a9
;
; in:    A = HGR row (0x00..0xBF)
; out:   A/X clobbered
;        Y preserved
;        ($26) points to first byte of given HGR row on hi-res page 1
;        ($3C) points to same byte on hi-res page 2
; based on 'Woz Recodes Hi-Res Address Calculations'
; Apple Assembly Line vol. 7 issue 3 (December 1986)
; http://www.txbobsc.com/aal/1986/aal8612.html#a9

HGRCalc:
         asl
         tax
         and   #$F0
         bpl   calc1
         ora   #$05
calc1:   bcc   calc2
         ora   #$0A
calc2:   asl
         asl
         sta   $26
         txa
         and   #$0E
         adc   #$10
         asl   $26
         rol
         sta   $27

	clc
	adc	#$80		; load from $A000 not $4000

;         eor   #$60
         sta   $3d

	lda	$26		; same bottom bits
	sta	$3c

         rts




WaitForKeyWithTimeout:
; in:    A = timeout length (like standard $FCA8 wait routine)
; out:   A clobbered (not always 0 if key is pressed, but also not the key pressed)
;        X/Y preserved
         sec
wait1:   pha
wait2:   sbc   #1
         bne   wait2
         pla
         bit   KEYPRESS
         bmi   wfk_exit
         sbc   #1
         bne   wait1
wfk_exit:    rts



;================================================
;license:MIT
;(c) 2019 by 4am
;
;!cpu 6502
;!to "build/FX.INDEXED/DIAMOND",plain
;*=$6000

; 4am diamond wipe

wipe_diamond:
	lda	#32
	sta	COUNTER

	lda	#39
	sta	COL
colloop:
	lda	#23
	sta	ROW
	ldy	COL
	sty	YY

	jsr	wait_vblank

rowloop:
	; check if this column is visible
	ldy	YY
	bpl	dp
dm:
	jmp	skip1
dp:
	cpy	#40
	bcs	dm			; blt

	;==============
	; do corner 1

	lda	#<copymasks1
	sta	CopyMaskAddr
	lda	#>copymasks1
	sta	CopyMaskAddr+1

	lda	ROW
	jsr	HGRBlockCopyWithMask

	;=====================================
	; do corner 2 (same row, opposing col)

	lda	#<copymasks2
	sta	CopyMaskAddr
	lda	#>copymasks2
	sta	CopyMaskAddr+1

	lda	#39
	sec
	sbc	YY
	tay
	lda	ROW

	jsr	HGRBlockCopyWithMask

	;=========================================
	; do corner 3 (opposing row, opposing col)

	lda	#<copymasks3
	sta	CopyMaskAddr
	lda	#>copymasks3
	sta	CopyMaskAddr+1

	lda	#39
	sec
	sbc	YY
	tay
	lda	#23
	sec
	sbc	ROW

	jsr	HGRBlockCopyWithMask

	;=====================================
	; do corner 4 (opposing row, same col)

	lda	#<copymasks4
	sta	CopyMaskAddr
	lda	#>copymasks4
	sta	CopyMaskAddr+1

	ldy	YY
	lda	#23
	sec
	sbc	ROW

	jsr	HGRBlockCopyWithMask

	; reset y for looping
	ldy	YY
skip1:
	iny
	sty	YY
	; now check if *this* column is visible
	bpl	dp2
dm2:
	jmp	skip2
dp2:
	cpy	#40
	bcs	dm2			; bge

	; do corner 1
	lda	ROW
	jsr	HGRBlockCopy
	; do corner 2
	lda	#39
	sec
         sbc   YY
         tay
         lda   #23
         sec
         sbc   ROW
         jsr   HGRBlockCopy
         ; do corner 3
         lda   #39
         sec
         sbc   YY
         tay
         lda   ROW
         jsr   HGRBlockCopy
         ; do corner 4
         ldy   YY
         lda   #23
         sec
         sbc   ROW
         jsr   HGRBlockCopy
skip2:
	dec	ROW
	bmi	dp3
	jmp	rowloop
dp3:
	lda	$c000			; keyboard
	bmi	dexit
	dec	COL
	dec	COUNTER
	beq	dexit
	jmp	colloop
dexit:
	jmp	unwait_for_vblank

copymasks1:
         .byte %11111111
         .byte %11111110
         .byte %11111100
         .byte %11111000
         .byte %11110000
         .byte %11100000
         .byte %11000000
         .byte %10000000
copymasks2:
         .byte %11111111
         .byte %10111111
         .byte %10011111
         .byte %10001111
         .byte %10000111
         .byte %10000011
         .byte %10000001
         .byte %10000000
copymasks3:
         .byte %10000000
         .byte %10000001
         .byte %10000011
         .byte %10000111
         .byte %10001111
         .byte %10011111
         .byte %10111111
         .byte %11111111
copymasks4:
         .byte %10000000
         .byte %11000000
         .byte %11100000
         .byte %11110000
         .byte %11111000
         .byte %11111100
         .byte %11111110
         .byte %11111111




;====================================
; HGR_COPY_MASK_ROUTINES
;====================================

SetCopyMask:
; in:    A/Y points to 8-byte array of bit masks used by HGRBlockCopyWithMask

         sta CopyMaskAddr
         sty CopyMaskAddr+1
         rts

HGRBlockCopyWithMask:
; in:    A = HGR row / 8 (0x00..0x17)
;        Y = HGR column (0x00..0x27)
;        must call SetCopyMask first
; out:   Y preserved
;        A/X clobbered
;        $00 clobbered


	; HGR_ROW_CALC
        asl
        asl
        asl
	jsr	HGRCalc

HGRBlockCopyWithMaskNoRecalc:
         ldx   #7
HGRBlockCopyWithMasksLoop:
         lda   ($26),y
         eor   ($3c),y
CopyMaskAddr=*+1
         and   $FDFD,x               ; call SetCopyMask to set
         eor   ($26),y
         sta   ($26),y
         clc

	; HGR_INC_WITHIN_BLOCK
         lda   $27
         adc   #$04
         sta   $27

	; VMW
	clc
	adc	#$80

;         eor   #$60
         sta   $3d

         dex
         bpl   HGRBlockCopyWithMasksLoop
         rts


;======================================
; HGRBlockCopy
;======================================
; in:    A = HGR row / 8 (0x00..0x17)
;        Y = HGR column (0x00..0x27)
; out:   Y preserved
;        X = #$00
;        Z set
;        C clear
;        all other flags and registers clobbered

HGRBlockCopy:

	; HGR_ROW_CALC
        asl
        asl
        asl
	jsr	HGRCalc

HGRBlockCopyNoRecalc:
         clc
         ldx   #$08
@loop:
         lda   ($3C),y
         sta   ($26),y

	; HGR_INC_WITHIN_BLOCK
         lda   $27
         adc   #$04
         sta   $27
;         eor   #$60
	; VMW

	clc
	adc	#$80
	sta	$3D

         dex
         bne   @loop
         rts




.include "vblank.s"

unwait_for_vblank:
	rts
