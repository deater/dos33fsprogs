;license:MIT
;(c) 2018-2020 by 4am/qkumba
;
; reverse engineered from Sapphire's crack screen of 'Crystal Castles'
;
;!cpu 6502
;!to "build/FX.INDEXED/CRYSTAL",plain
;*=$6000

 ;        !source "src/fx/macros.a"

	.include "../macros.s"

do_wipe_crystal:
         ldx   #0
         stx   $51
         ldx   #4
         stx   $50
         ldx   #$17
         stx   $53
         READ_ROM_NO_WRITE
cwmmm:      lda   $53
         jsr   $FBC1                 ; BASCALC
         ldy   #$27
cwmm:       ldx   $51
         lda   table1, x
         ldx   $50
         .byte $2C
cwm:        lsr
         lsr
         dex
         bne   cwm
         and   #3
         dec   $50
         bne   cwp
         ldx   #4
         stx   $50
         inc   $51
cwp:        sta   ($28), y
         dey
         bpl   cwmm
         dec   $53
         bpl   cwmmm
         iny
         sty   $54
         lda   #<Coordinates
         sta   $FE
         ldx   #>Coordinates
         stx   $FF
cwmmm2:      ldx   #0
cwmm2:       txa
         jsr   $FBC1                 ; BASCALC
cwm2:        lda   ($28), y
         cmp   $54
         bne   cwp2
         tya
         pha
         txa
         jsr   stainc
         pla
         jsr   stainc
         tay
cwp2:        iny
         cpy   #$28
         bne   cwm2
         lda   #$FF
         jsr   stainc2
         inx
         cpx   #$18
         bcc   cwmm2
         inc   $54
         lda   $54
         cmp   #4
         bne   cwmm2
         READ_RAM1_WRITE_RAM1

         lda   #$80
         sta   Coordinates+$840

         lda   #$01
         sta   $FD
outerloop:
         dec   $FD
         lda   #<Coordinates
         sta   $FE
         lda   #>Coordinates
         sta   $FF
         ldy   #$00
loop:
         lda   ($fe),y
         bpl   copy
         lda   #$10
;         jsr   iWaitForKeyWithTimeout
         bmi   cexit
         bpl   next                 ; always branches
copy:
         tax
         iny
         lda   ($fe),y
         tay
         txa
         bit   $FD
         bpl   cwp3
         jsr   HGRBlockCopy
         beq   next                 ; always branches
cwp3:        jsr   HGRBlockToWhite
next:
         inc   $FE
         bne   cwp4
         inc   $FF
cwp4:        inc   $FE
         bne   cwp5
         inc   $FF
cwp5:        ldy   #$00
         lda   ($FE),y
         cmp   #$80
         bne   loop
         bit   $FD
         bpl   outerloop
cexit:    rts

stainc2: jsr   stainc
stainc:  ldy   #0
         sta   ($FE), y
         inc   $FE
         bne   cwp6
         inc   $FF
cwp6:        rts

table1:
         .byte $05, $AF, $05, $AF, $06, $90, $FA, $50, $FA, $50, $50, $5A, $F0, $5A, $F0, $0F
         .byte $A5, $0F, $A5, $05, $A5, $05, $AF, $05, $AF, $FA, $50, $FA, $50, $5A, $FA, $50
         .byte $5A, $F0, $5A, $A5, $0F, $A5, $05, $AF, $0F, $A5, $05, $AF, $05, $50, $FA, $50
         .byte $5A, $F0, $50, $FE, $54, $5E, $F4, $0B, $A1, $01, $AB, $01, $A1, $0B, $A1, $01
         .byte $AB, $FE, $54, $5E, $F4, $5E, $FE, $54, $FE, $54, $5E, $A1, $01, $AB, $01, $AB
         .byte $0B, $A1, $0B, $A1, $01, $54, $5E, $F4, $5E, $F4, $54, $FE, $54, $FE, $54, $01
         .byte $AB, $01, $AB, $01, $A1, $0B, $A1, $0B, $A1, $5E, $F0, $5A, $F0, $5A, $3A, $50
         .byte $FA, $50, $FA, $AF, $01, $AB, $01, $A8, $3E, $54, $FE, $54, $FE, $AB, $01, $AB
         .byte $01, $A8, $A1, $0B, $A1, $0B, $A1, $5E, $F4, $5E, $F4, $5E, $54, $FE, $54, $FE
         .byte $54, $01, $AB, $01, $AB, $01, $0B, $A1, $0B, $A1, $01, $54, $5E, $F4, $5E, $F4
         .byte $FE, $50, $FA, $50, $5A, $A5, $05, $AF, $05, $AF, $A5, $0F, $A5, $05, $AF, $FA
         .byte $50, $5A, $F0, $5A, $50, $FA, $50, $5A, $F0, $0F, $A5, $05, $AF, $05, $0F, $A5
         .byte $05, $AF, $05, $50, $FA, $50, $5A, $F0, $FA, $50, $5A, $F0, $5A, $A5, $0F, $A5
         .byte $05, $AF, $A5, $05, $AF, $05, $AF, $FA, $50, $FA, $50, $5A, $50, $5A, $F0, $5A
         .byte $F0, $0F, $A5, $0F, $A5, $05, $05, $AF, $05, $AF, $06, $90, $FA, $50, $FA, $50

         HGR_WHITE_ROUTINES
         HGR_BLOCK_COPY_ROUTINES
.align 2
;blah:
;.if (blah & 1)
;         .byte 0
;.endif

Coordinates:
