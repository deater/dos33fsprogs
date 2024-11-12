;license:MIT
;(c) 2019 by qkumba

;!cpu 6502
;!to "build/FX.INDEXED/CASCADE",plain
;*=$6000

 ;        !source "src/constants.a"

	.include "../constants.s"

do_wipe_cascade:

         ldx   #191

dwc_mmm:
         jsr   wait_vblank
         lda   #$40
         sta   $e6
         lsr
         sta   $29
         jsr   vposn
         lsr   $e6

         ldy   #$27
dwc_m:        lda   ($26), y
         sta   $2000, y
         dey
         bpl   dwc_m

         stx   maxline + 1

         ldx   #0
         stx   $28
         beq   dwc_p ;always

dwc_mm:
	       lda   $26
         sta   $28
         lda   $27
         sta   $29
dwc_p:        inx
         jsr   vposn

         ldy   #$27
dwc_m1:        lda   ($28), y
         sta   ($26), y
         dey
         bpl   dwc_m1

maxline:
         cpx   #$d1 ;SMC
         bne   dwc_mm

         ldy  #5

dwc_mm2:       tya
         pha
         dex
         jsr   vposn

         lda   $26
         sta   $28
         lda   $27
         eor   #$60
         sta   $29

         ldy   #$27
dwc_m2:        lda   ($28), y
         sta   ($26), y
         dey
         bpl   dwc_m2

         pla
         tay
         dey
         bne   dwc_m2

         txa
         beq   done
         dex
         lda   $c000
         bpl   dwc_mmm

done: ;    jmp   UnwaitForVBL
	rts

vposn:    txa
         pha
         and   #$c0
         sta   $26
         lsr
         lsr
         ora   $26
         sta   $26
         pla
         sta   $27
         asl
         asl
         asl
         rol   $27
         asl
         rol   $27
         asl
         ror   $26
         lda   $27
         and   #$1f
         ora   $e6
         sta   $27
         rts
