;license:MIT
;(c) 2019-2024 by 4am/qkumba

; star wipe

Coordinates2Bit=$8100
EndCoordinates2Bit = Coordinates2Bit+15360

.include "common_defines.inc"

copymasks1bit  = $BE00               ; $100 bytes but sparse, index is 0..6 but in high 3 bits, so $00,$20,$40,$60,$80,$A0,$C0
copymasks2bit  = copymasks1bit       ; $100 bytes but sparse, index is 0..4 but in high 3 bits, so $00,$20,$40,$60,$80
copymasks3bit  = copymasks1bit       ; $100 bytes but sparse, index is 0..7 but in high 3 bits, so $00,$20,$40,$60,$80,$A0,$C0,$E0
mirror_copymasks1bit = copymasks1bit+1
mirror_copymasks2bit = copymasks2bit+1

mirror_cols    = hposn_low+$c0               ; $28 bytes


	;=================================
	; do star wipe
	;=================================

wipe_star:


InitOnce:
	bit	Start
	lda	#$4C		; patch with jmp after first time through
	sta	InitOnce

	; from code.hgr.precomputed.2bit

	jsr	BuildHGRMirrorCols
	jsr	BuildHGRSparseBitmasks2Bit


	; ???

	lda	#$00
	sta	EndCoordinates2Bit
Start:


;!macro COPY_BIT .src1, .dest1, .copymasks {
.macro COPY_BIT src1, dest1, copymasks
         lda   (src1),y
         eor   (dest1),y            ; merge source and destination bits
         and   copymasks,x          ; isolate the bits to replace, zero the rest
         eor   (dest1),y            ; unmerge source and destination bits, leaves 'to keep' destination bits intact
         sta   (dest1),y            ; write the result
;}
.endmacro

;!macro HIGH_3_LOW_5 .input {
.macro HIGH_3_LOW_5 input
         and   #%11100000            ; second value: high 3 bits = index into tables to find bitmasks
         tax
         eor   (<input), y          ; second value: low 5 bits = byte offset within the row (implicitly "and #%00011111")
         tay
;}
.endmacro


;!macro COPY_TO_0 .start, .end {
.macro COPY_TO_0 start, end
; out:   X=0
;        Z=1
	.Local m1
	ldx	#(end-start)
m1:	lda	start-1, x
	sta	$FF, x
	dex
	bne	m1
;}
.endmacro

;!macro ROW_X_TO_2BIT_BASE_ADDRESSES .src1, .src2, .dest1, .dest2 {
.macro ROW_X_TO_2BIT_BASE_ADDRESSES src1, src2, dest1, dest2
         ; X = $01..$C0, mapping to row 0..191
         lda   hposn_low-1, x
         sta   <dest1
         sta   <src1
         lda   hposn_high-1, x
         sta   <dest1+1
         eor   #$60
         sta   <src1+1
         lda   hposn_low, x
         sta   <dest2
         sta   <src2
         lda   hposn_high, x
         sta   <dest2+1
         eor   #$60
         sta   <src2+1
;}
.endmacro


HGRPrecomputed2Bit:

;         jsr   iBuildHGRTables
;         jsr   iBuildHGRMirrorCols
;         jsr   iBuildHGRSparseBitmasks2Bit
         COPY_TO_0 start, end
         jmp   InputLoop

start:

.org $00

;!pseudopc 0 {

Exit2Bit:
	rts

InputLoop:
	ldy	#0
input=*+1
;input_smc:
	ldx	Coordinates2Bit		; first value: HGR row + 1
	beq	Exit2Bit		; if 0 then we're done

	ROW_X_TO_2BIT_BASE_ADDRESSES src1, src2, dest1, dest2

	inc	<input
	lda	(<input), Y
	HIGH_3_LOW_5 input

         ; main 2x2 block in left half
src1=*+1
         lda   $FDFD, y
         eor   (<dest1), y
         and   copymasks2bit, x
         eor   (<dest1), y
dest1=*+1
         sta   $FDFD, y
src2=*+1
         lda   $FDFD, y
         eor   (<dest2), y
         and   copymasks2bit, x
         eor   (<dest2), y
dest2=*+1
         sta   $FDFD, y

         ; corresponding 2x2 block in right half (same row, opposite column)
         lda   mirror_cols, y
         tay
         COPY_BIT src1, dest1, mirror_copymasks2bit
         COPY_BIT src2, dest2, mirror_copymasks2bit

         inc   <input
         bne   InputLoop
         bit   KEYPRESS
         bmi   Exit2Bit
         inc   <input+1
         bne   InputLoop            ; always branches
;}
;.end
.reloc
end:




BuildHGRMirrorCols:
; in:    none
; out:   mirror_cols populated with lookup table to get $27-y for y in $00..$27
;        all registers and flags clobbered

	ldx	#$27
	ldy	#$00
bhmc_m1:
	tya
	sta	mirror_cols, X
	iny
	dex
	bpl	bhmc_m1
	rts


BuildHGRSparseBitmasks2Bit:
         lda   #%10000011
         sta   copymasks2bit
         sta   mirror_copymasks2bit+$E0

         lda   #%10001100
         sta   copymasks2bit+$20
         sta   mirror_copymasks2bit+$C0

         lda   #%10110000
         sta   copymasks2bit+$40
         sta   mirror_copymasks2bit+$A0

         lda   #%11000000
         sta   copymasks2bit+$60
         sta   mirror_copymasks2bit+$80

         lda   #%10000001
         sta   copymasks2bit+$80
         sta   mirror_copymasks2bit+$60

         lda   #%10000110
         sta   copymasks2bit+$A0
         sta   mirror_copymasks2bit+$40

         lda   #%10011000
         sta   copymasks2bit+$C0
         sta   mirror_copymasks2bit+$20

         lda   #%11100000
         sta   copymasks2bit+$E0
         sta   mirror_copymasks2bit
         rts

.if 0

ReverseCoordinates2Bit:
	ldy	#0                    ; <Coordinates2Bit
	sty	$f0
	lda	#>Coordinates2Bit
	sta	$f1
	lda	#<(EndCoordinates2Bit - 2)
	sta	$f2
	lda	#>(EndCoordinates2Bit - 2)
	sta	$f3

	ldx	#$1E                  ; #$3C/2
	clc
	.byte $24			; bit ZP
rc2_m:
	sec
rc2_mm:
	lda	($f0), Y
	pha
	lda	($f2), Y
	sta	($f0), Y
	pla
	sta	($f2), Y
	iny
	bcc	rc2_m
	ldy	#0
	.byte $24
rc2_m2:
	clc
	inc	$f0
	bne	rc2_p
	inc	$f1
	dex
	beq	rc2_pp
rc2_p:
	lda	$f2
	bne	rc2_p2
	dec	$f3
rc2_p2:
	dec	$f2
	bcs	rc2_m2
	bcc	rc2_mm                    ; always branches
rc2_pp:
	rts

.endif

.if 0

RippleCoordinates2Bit:
	ldy	#0

	ldx	#$33
ric2_m:
	lda	ric2_ptrtbl, X
	sta	$c0, X
	dex
	bpl	ric2_m

	lda	#$9b
	sta	$fe
	iny
	sty	$ff

	ldx	#6
ric2_m2:
	lda	Coordinates2Bit + 1, X
	sta	$7f, X
	lda	Coordinates2Bit + 9, X
	sta	$85, X
	lda	Coordinates2Bit + 17, X
	sta	$8b, X
	lda	Coordinates2Bit + 65, X
	sta	$9b, X
	dex
	bne	ric2_m2
	lda	Coordinates2Bit + 28
	sta	$92
	lda	Coordinates2Bit + 29
	sta	$93
	ldx	#4
ric2_m3:
	lda	Coordinates2Bit + 33, X
	sta	$93, X
	lda	Coordinates2Bit + 41, X
	sta	$97, X
	lda	Coordinates2Bit + 83, X
	sta	$a1, X
	dex
	bne	ric2_m3
	ldx	#2
ric2_m4:
	lda	Coordinates2Bit + 125, X
	sta	$a5, X
	lda	Coordinates2Bit + 131, X
	sta	$a7, X
	lda	Coordinates2Bit + 139, X
	sta	$a9, X
	lda	Coordinates2Bit + 169, X
	sta	$ab, X
	lda	Coordinates2Bit + 237, X
	sta	$ad, X
	lda	Coordinates2Bit + 2193, X
	sta	$af, X
	lda	Coordinates2Bit + 6581, X
	sta	$b1, X
	dex
	bne	ric2_m4

ric2_mmm:
	ldx	#$34
ric2_mm:
	lda	$be, X
	tay
	ora	$bf, X
	beq	ric2_p
	lda	$bf, X
	jsr	ric2_aslmod
	sty	$be, X
	sta	$bf, X
	sty	$fc
	clc
	adc	#>Coordinates2Bit
	sta	$fd
	ldy	#0
	.byte $24
ric2_m5:
	sec
	lda	($fc), Y
	pha
	lda	$7e, X
	sta	($fc), Y
	pla
	sta	$7e, X
	inx
	iny
	bcc	ric2_m5
	dex
	dex
ric2_p:
	dex
	dex
	bne	ric2_mm
	ldy	#1
	lda	$fe
	eor	#<(411 - 2)
	beq	ric2_p2
	ldy	#9
	eor	#(<(411 - 2) ^ <(411 - 136))
	bne	ric2_pp
ric2_p2:
ric2_m6:
	ldx	ric2_zerotbl, Y
	sta	$0, X
	sta	$1, X
	dey
	bpl	ric2_m6
ric2_pp:
	dec	$fe
	bne	ric2_mmm
	dec	$ff
	bpl	ric2_mmm
	bmi	ric2_exit		; always branches
ric2_aslmod:
	jsr	ric2_p3
ric2_p3:
	cmp	#$1E
	bcc	ric2_p4
	iny
ric2_p4:
	pha
	tya
	asl
	tay
	pla
	rol
	cmp	#$3C
	bcc	ric2_exit
	sbc	#$3C
ric2_exit:
	rts
ric2_ptrtbl:
	.word 2, 4, 6, 10, 12, 14, 18, 20
	.word 22, 28, 34, 36, 42, 44, 66, 68
	.word 70, 84, 86, 126, 132, 140, 170, 238
	.word 2194, 6582
ric2_zerotbl:
	.byte $f0, $f2, $ca, $d2, $d8, $e0, $e2, $e6, $ea, $ee



.endif
