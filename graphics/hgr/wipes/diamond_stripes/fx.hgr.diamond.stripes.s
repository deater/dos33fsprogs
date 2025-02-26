;license:MIT
;(c) 2021 by 4am
;
;!cpu 6502
;!to "build/FX.INDEXED/DIAMOND.STRIPES",plain
;*=$6000

;hgrlo    = $0201                     ; [$C0 bytes] HGR base addresses (defined in constants.a)
;hgrhi    = $0301                     ; [$C0 bytes] HGR base addresses (defined in constants.a)

src      = $F0
dst      = $F2
row1     = $F4
row2     = $F5
mask1    = $F6
mask2    = $F7

 ;        !source "src/fx/macros.a"
 ;        !source "src/constants.a"
	.include "../macros.s"
	.include "../constants.s"

do_wipe_diamond_stripes:

	jsr     BuildHGRTables

;         jsr   iBuildHGRTables

         lda   #$00
         sta   row1
         lda   #$C0
         sta   row2
         lda   #0
         sta   mask1
         ldy   #15
         sty   mask2
dsm1:        lda   copymasks_even2, y
         eor   #$7F
         sta   copymasks_even1, y
         lda   copymasks_odd2, y
         eor   #$7F
         sta   copymasks_odd1, y
         dey
         bpl   dsm1

RowLoop:
         ldx   row1
         lda   hgrlo, x
         sta   src
         sta   dst
         lda   hgrhi, x
         sta   dst+1
         eor   #$60
         sta   src+1

         ldx   mask1
         ldy   #39
dsm2:        lda   (src), y
         eor   (dst), y              ; merge source and destination bits
         and   copymasks_odd1, x     ; isolate the bits to replace, zero the rest
         eor   (dst), y              ; unmerge source and destination bits, leaves 'to keep' destination bits intact
         sta   (dst), y              ; write the result
         dey
         lda   (src), y
         eor   (dst), y              ; merge source and destination bits
         and   copymasks_even1, x    ; isolate the bits to replace, zero the rest
         eor   (dst), y              ; unmerge source and destination bits, leaves 'to keep' destination bits intact
         sta   (dst), y              ; write the result
         dey
         bpl   dsm2

         ldx   row2
         lda   hgrlo-1, x            ; row2 is off-by-1 so we can use a BEQ to terminate
         sta   src
         sta   dst
         lda   hgrhi-1, x
         sta   dst+1
         eor   #$60
         sta   src+1

         ldx   mask2
         ldy   #39
dsm3:        lda   (src), y
         eor   (dst), y              ; merge source and destination bits
         and   copymasks_odd2, x     ; isolate the bits to replace, zero the rest
         eor   (dst), y              ; unmerge source and destination bits, leaves 'to keep' destination bits intact
         sta   (dst), y              ; write the result
         dey
         lda   (src), y
         eor   (dst), y              ; merge source and destination bits
         and   copymasks_even2, x    ; isolate the bits to replace, zero the rest
         eor   (dst), y              ; unmerge source and destination bits, leaves 'to keep' destination bits intact
         sta   (dst), y              ; write the result
         dey
         bpl   dsm3

         inc   mask1
         lda   mask1
         cmp   #16
         bne   dsp1
         lda   #0
         sta   mask1
dsp1:
         dec   mask2
         bpl   dsp2
         lda   #15
         sta   mask2
dsp2:
         bit   KBD
         bmi   Exit
         inc   row1
         dec   row2
         LBNE RowLoop

Exit:     rts

copymasks_even2:
         .byte %10000000
         .byte %11000000
         .byte %11100000
         .byte %11110000
         .byte %11111000
         .byte %11111100
         .byte %11111110
         .byte %11111111
         .byte %11111111
         .byte %11111110
         .byte %11111100
         .byte %11111000
         .byte %11110000
         .byte %11100000
         .byte %11000000
         .byte %10000000
copymasks_odd2:
         .byte %10000000
         .byte %10000001
         .byte %10000011
         .byte %10000111
         .byte %10001111
         .byte %10011111
         .byte %10111111
         .byte %11111111
         .byte %11111111
         .byte %10111111
         .byte %10011111
         .byte %10001111
         .byte %10000111
         .byte %10000011
         .byte %10000001
         .byte %10000000

copymasks_even1=*
copymasks_odd1=*+16
