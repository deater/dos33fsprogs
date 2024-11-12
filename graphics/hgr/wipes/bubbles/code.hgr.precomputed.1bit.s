;!cpu 6502
;!to "build/FXCODE/HGR1",plain
;*=$6200

;         !source "src/fx/macros.a"
;	.include "macros.s"



HGRPrecomputed1Bit:
;	jsr	BuildHGRTables
;	jsr	BuildHGRMirrorTables
;	jsr	BuildHGRMirrorCols
;	jsr	BuildHGRSparseBitmasks1Bit
	COPY_TO_0 start, end			; copies to page0????
	jmp	InputLoop

start:

.org $00
;!pseudopc 0 {
Exit1Bit:
	rts
InputLoop:
	ldy   #0
input=*+1
         ldx   Coordinates1Bit       ; first value: HGR row (only 0..95 will be in input array)
         bmi   Exit1Bit             ; if > 127 then we're done
         ROW_X_TO_BASE_ADDRESSES   src1, src2, dest1, dest2
         ROW_X_TO_MIRROR_ADDRESSES mirror_src1, mirror_src2, mirror_dest1, mirror_dest2

         inc   input
         lda   (<input), y
         HIGH_3_LOW_5 input

         ; main 1x2 block in top-left quadrant
src1=*+1
         lda   $FDFD, y
         eor   (<dest1), y
         and   copymasks1bit, x
         eor   (<dest1), y
dest1=*+1
         sta   $FDFD, y
src2=*+1
         lda   $FDFD, y
         eor   (<dest2), y
         and   copymasks1bit, x
         eor   (<dest2), y
dest2=*+1
         sta   $FDFD, y

         ; corresponding 1x2 block in top-right quadrant (same row, opposite column)
         lda   mirror_cols, y
         tay
         COPY_BIT src1, dest1, mirror_copymasks1bit
         COPY_BIT src2, dest2, mirror_copymasks1bit

         ; corresponding 1x2 block in bottom-right quadrant (opposite row, opposite column)
mirror_src1=*+1
         lda   $FDFD, y
         eor   (<mirror_dest1), y
         and   mirror_copymasks1bit, x
         eor   (<mirror_dest1), y
mirror_dest1=*+1
         sta   $FDFD, y
mirror_src2=*+1
         lda   $FDFD, y
         eor   (<mirror_dest2), y
         and   mirror_copymasks1bit, x
         eor   (<mirror_dest2), y
mirror_dest2=*+1
         sta   $FDFD, y

         ; corresponding 1x2 block in bottom-left quadrant (opposite row, original column)
         lda   mirror_cols, y
         tay
         COPY_BIT mirror_src1, mirror_dest1, copymasks1bit
         COPY_BIT mirror_src2, mirror_dest2, copymasks1bit

         INC_INPUT_AND_LOOP input, InputLoop
;}
.reloc
end:


