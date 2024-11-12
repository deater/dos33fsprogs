;license:MIT
;(c) 2022 by 4am
;
;!cpu 6502
;!to "build/FX.INDEXED/THIN.DISSOLVE",plain
;*=$6000

row1 = $fe
row2 = $ff
src  = $3c
dst  = $26

 ;        !source "src/fx/macros.a"
	.include "../macros.s"

do_wipe_thin_bar:

         lda   #$00
         sta   row1
         lda   #$BF
         sta   row2
loop:    lda   row1
         jsr   HGRCalc
         ldy   #$27
tbm:        tya
         and   #$03
         tax
         lda   (src),y
         eor   (dst),y               ; merge source and destination bits
         and   mask1,x               ; isolate the bits to replace, zero the rest
         eor   (dst),y               ; unmerge source and destination bits, leaves 'to keep' destination bits intact
         sta   (dst),y               ; write the result
         dey
         bpl   tbm
         lda   row2
         jsr   HGRCalc
         ldy   #$27
tbm2:        tya
         and   #$03
         tax
         lda   (src),y
         eor   (dst),y
         and   mask3,x
         eor   (dst),y
         sta   (dst),y
         dey
         bpl   tbm2
         lda   #$30
         jsr   WaitForKeyWithTimeout
         bmi   tb_exit
.if 0
         ldx   mask1
         ldy   mask3
         stx   mask3
         sty   mask1
         ldx   mask2
         ldy   mask4
         stx   mask4
         sty   mask2
.endif
         inc   row1
         dec   row2
         lda   row1
         cmp   #$C0
         bne   loop
tb_exit:    rts

         HGR_CALC_ROUTINES

mask1:    .byte %10110011
mask2:    .byte %11100110
mask3:    .byte %11001100
mask4:    .byte %10011001
         .byte %10110011
         .byte %11100110
