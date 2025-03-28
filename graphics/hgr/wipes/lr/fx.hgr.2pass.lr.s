;license:MIT
;(c) 2018 by 4am
;
;!cpu 6502
;!to "build/FX.INDEXED/TWOPASS.LR",plain
;*=$6000

row = $FF

 ;        !source "src/fx/macros.a"
	.include "../macros.s"

do_wipe_lr:

         lda   #$00
         sta   h1
         sta   h2
outerloop1:
         lda   #$BF
         sta   row
loop1:   jsr   HGRCalc
h1=*+1
         ldy   #$00
         lda   ($3c),y
         sta   ($26),y
         dec   row
         dec   row
         lda   row
         cmp   #$FF
         bne   loop1

         lda   #$10
	jsr   WaitForKeyWithTimeout
         bmi   lrexit

         inc   h1
         lda   h1
         cmp   #$28
         bne   outerloop1

outerloop2:
         lda   #$BE
         sta   row
loop2:   jsr   HGRCalc
h2=*+1
         ldy   #$00
         lda   ($3c),y
         sta   ($26),y
         dec   row
         dec   row
         lda   row
         cmp   #$FE
         bne   loop2

         lda   #$10
	jsr   WaitForKeyWithTimeout
         bmi   lrexit

         inc   h2
         lda   h2
         cmp   #$28
         bne   outerloop2
lrexit:    rts

         HGR_CALC_ROUTINES
