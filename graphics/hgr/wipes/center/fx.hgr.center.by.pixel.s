;license:MIT
;(c) 2019 by 4am
;
;!cpu 6502
;!to "build/FX.INDEXED/CENTER.BY.PIXEL",plain
;*=$6000

copymask1 = $f2
copymask2 = $f3
skipcounter = $f7
top = $f9
bottom = $fa
counter = $fb
maskindex = $fc
row = $fd
col1 = $fe
col2 = $ff

 ;        !source "src/fx/macros.a"
	.include "../macros.s"
  ;       !source "src/constants.a"
	.include "../constants.s"

do_wipe_center:
         lda   #44
         sta   skipcounter
         lda   #$5F
         sta   counter
         lda   #0
         sta   top
         lda   #$BF
         sta   bottom
         lda   #0
         sta   col1
         lda   #39
         sta   col2
ColLoop:
         lda   #6
         sta   maskindex
         jsr   wait_vblank
MaskLoop:
         ldx   maskindex
         lda   copymasks1,x
         sta   copymask1
         lda   copymasks2,x
         sta   copymask2

         lda   #23
         sta   row
RowLoop:
         lda   row
         HGR_ROW_CALC
         ldx   #8
BlockLoop:
         ldy   col1
         lda   ($26),y
         eor   ($3c),y
         and   copymask1
         eor   ($26),y
         sta   ($26),y

         ldy   col2
         lda   ($26),y
         eor   ($3c),y
         and   copymask2
         eor   ($26),y
         sta   ($26),y

         clc
         HGR_INC_WITHIN_BLOCK
         dex
         bne   BlockLoop

         dec   row
         bpl   RowLoop

         dec   skipcounter
         LBPL SkipTopAndBottom

         lda   top
         HGR_CALC
         ldy   #39
cbpm:        lda   ($3c),y
         sta   ($26),y
         dey
         bpl   cbpm
         inc   top

         lda   bottom
         HGR_CALC
         ldy   #39
cbpm2:        lda   ($3c),y
         sta   ($26),y
         dey
         bpl   cbpm2
         dec   bottom

         dec   counter
         bmi   cExit
SkipTopAndBottom:
         lda   $c000
         bmi   cExit
         dec   maskindex
         LBPL MaskLoop
         inc   col1
         dec   col2
         LBNE ColLoop
cExit: ;    jmp   UnwaitForVBL
	rts

copymasks1:
         .byte %11111111
         .byte %10111111
         .byte %10011111
         .byte %10001111
         .byte %10000111
         .byte %10000011
         .byte %10000001
copymasks2:
         .byte %11111111
         .byte %11111110
         .byte %11111100
         .byte %11111000
         .byte %11110000
         .byte %11100000
         .byte %11000000
