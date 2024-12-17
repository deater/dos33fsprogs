; !cpu 6502
; !to "build/FXCODE/HGR2",plain
; *=$6200

;         !source "src/fx/macros.a"

;HGRPrecomputed2Bit
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
         ldy   #0
input=*+1
         ldx   Coordinates2Bit       ; first value: HGR row + 1
         beq   Exit2Bit             ; if 0 then we're done
         ROW_X_TO_2BIT_BASE_ADDRESSES src1, src2, dest1, dest2

         inc   <input
         lda   (<input), y
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
         bit   KBD
         bmi   Exit2Bit
         inc   <input+1
         bne   InputLoop            ; always branches
;}
;.end
.reloc
end:
