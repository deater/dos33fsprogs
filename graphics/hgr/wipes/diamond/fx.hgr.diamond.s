;license:MIT
;(c) 2019 by 4am
;
;!cpu 6502
;!to "build/FX.INDEXED/DIAMOND",plain
;*=$6000

YY = $fc
row = $fd
col = $fe
counter = $ff

;        !source "src/fx/macros.a"
;         !source "src/constants.a"

do_wipe_diamond:
         lda   #32
         sta   counter

         lda   #39
         sta   col
colloop:
         lda   #23
         sta   row
         ldy   col
         sty   YY
;         jsr   WaitForVBL
         jsr   wait_vblank
rowloop:
         ; check if this column is visible
         ldy   YY
         bpl   dp
dm:        jmp   skip1
dp:        cpy   #40
         bcs   dm
         ; do corner 1
         SWITCH_TO_MASKS copymasks1
         lda   row
         jsr   HGRBlockCopyWithMask
         ; do corner 2 (same row, opposing col)
         SWITCH_TO_MASKS copymasks2
         lda   #39
         sec
         sbc   YY
         tay
         lda   row
         jsr   HGRBlockCopyWithMask
         ; do corner 3 (opposing row, opposing col)
         SWITCH_TO_MASKS copymasks3
         lda   #39
         sec
         sbc   YY
         tay
         lda   #23
         sec
         sbc   row
         jsr   HGRBlockCopyWithMask
         ; do corner 4 (opposing row, same col)
         SWITCH_TO_MASKS copymasks4
         ldy   YY
         lda   #23
         sec
         sbc   row
         jsr   HGRBlockCopyWithMask
         ; reset y for looping
         ldy   YY
skip1:
         iny
         sty   YY
         ; now check if *this* column is visible
         bpl   dp2
dm2:        jmp   skip2
dp2:        cpy   #40
         bcs   dm2
         ; do corner 1
         lda   row
         jsr   HGRBlockCopy
         ; do corner 2
         lda   #39
         sec
         sbc   YY
         tay
         lda   #23
         sec
         sbc   row
         jsr   HGRBlockCopy
         ; do corner 3
         lda   #39
         sec
         sbc   YY
         tay
         lda   row
         jsr   HGRBlockCopy
         ; do corner 4
         ldy   YY
         lda   #23
         sec
         sbc   row
         jsr   HGRBlockCopy
skip2:
         dec   row
         bmi   dp3
         jmp   rowloop
dp3:        lda   $c000
         bmi   dexit
         dec   col
         dec   counter
         beq   dexit
         jmp   colloop
dexit:    jmp   unwait_for_vblank

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

         HGR_COPY_MASK_ROUTINES
         HGR_BLOCK_COPY_ROUTINES
