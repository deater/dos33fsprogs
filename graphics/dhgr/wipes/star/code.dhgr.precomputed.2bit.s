; !cpu 6502
; !to "build/FXCODE/DHGR2",plain
; *=$6200
;
;         !source "src/fx/macros.a"
	.include "../macros.s"

;DHGRPrecomputed2Bit
;         jsr   iBuildDHGRSparseBitmasks2Bit
;         jsr   iBuildHGRTables
;         jsr   iBuildDHGRMirrorCols
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
	ldx	Coordinates2Bit		; first value: HGR row + 1
	beq	Exit2Bit		; if 0 then we're done
	ROW_X_TO_2BIT_BASE_ADDRESSES src1, src2, dest1, dest2

	inc	<input
	lda	(<input), Y
	HIGH_3_LOW_5 input

	; main 2x2 block in left half
	clc
p2b_m1:
	lda	copymasks2bit, x
	beq	p2b_p1
src1=*+1
	lda	$FDFD, Y
	eor	(<dest1), Y
	and	copymasks2bit, X
	eor	(<dest1), Y
dest1=*+1
	sta	$FDFD, Y
src2=*+1
	lda	$FDFD, Y
	eor	(<dest2), Y
	and	copymasks2bit, X
	eor	(<dest2), Y
dest2=*+1
	sta	$FDFD, Y
p2b_p1:
	bcs	p2b_p2
	sta	$C003
	sta	$C005
	sec
	bcs	p2b_m1
p2b_p2:
	sta	$C002
	sta	$C004

	; corresponding 2x2 block in right half (same row, opposite column)
	lda	mirror_cols, Y
	tay
	clc
p2b_m2:
	lda	mirror_copymasks2bit, X
	beq	p2b_p3
	COPY_BIT src1, dest1, mirror_copymasks2bit
	COPY_BIT src2, dest2, mirror_copymasks2bit
p2b_p3:
	bcs	p2b_p4
	sta	$C003
	sta	$C005
	sec
	bcs	p2b_m2
p2b_p4:
	sta	$C002
	sta	$C004

	inc	<input
p2b_p5:
	LBNE	InputLoop
	bit	$c000
	bmi	p2b_p6
	inc	<input+1
	jmp	InputLoop
p2b_p6:
	rts
;}
.reloc
end:
