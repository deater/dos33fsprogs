;license:MIT
;(c) 2017-2021 by qkumba/4am/John Brooks

;!cpu 6502
;!to "build/FX.INDEXED/FIZZLE",plain
;*=$6000

;         !source "src/fx/macros.a"

	.include "../macros.s"

do_wipe_fizzle:

         OVERCOPY_TO_0 start, end
         ;$FF clobbered
         ;X=0
         ;Y=0
         jmp   loop

start:
.org $00
;!pseudopc 0 {
         ;X=0
         ;Y=0
loop:     txa
loop1:    eor   #$1B                  ; LFSR form 0x1B00 with period 8191
wait:     dex
         bne   wait
         tax
loop2:    txa
         ora   #$20
         sta   <dst+2
         eor   #$60
         sta   <src+2
         jsr   src
         txa
         lsr
         tax
         tya
         ror
         tay
         bcc   loop2
         bne   loop
         bit   KBD
         bmi   fexit
         txa
         bne   loop1
src:      lda   $FD00, y              ; SMC high byte
dst:      sta   $FD00, y              ; SMC high byte
fexit:     rts
;}
.reloc
end:
