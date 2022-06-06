; De-compressor for ZX02 files
; ----------------------------
;
; Decompress ZX02 data (6502 optimized format), optimized for minimal size:
;  130 bytes code, 72.6 cycles/byte in test file.
;
; Compress with:
;    zx02 input.bin output.zx0
;
; (c) 2022 DMSC
; Code under MIT license, see LICENSE file.


ZP=$80

offset          = ZP+0
ZX0_src         = ZP+2
ZX0_dst         = ZP+4
bitr            = ZP+6
pntr            = ZP+7

            ; Initial values for offset, source, destination and bitr
zx0_ini_block:
            .byte $00, $00, <comp_data, >comp_data, <out_addr, >out_addr, $80

;--------------------------------------------------
; Decompress ZX0 data (6502 optimized format)

full_decomp:
              ; Get initialization block
              ldy #7

copy_init:     lda zx0_ini_block-1, y
              sta offset-1, y
              dey
              bne copy_init

; Decode literal: Ccopy next N bytes from compressed file
;    Elias(length)  byte[1]  byte[2]  ...  byte[N]
decode_literal:
              jsr   get_elias

cop0:          jsr   get_byte
              jsr   put_byte
              bne   cop0

              asl   bitr
              bcs   dzx0s_new_offset

; Copy from last offset (repeat N bytes from last offset)
;    Elias(length)
              jsr   get_elias
dzx0s_copy:
              lda   ZX0_dst
              sbc   offset  ; C=0 from get_elias
              sta   pntr
              lda   ZX0_dst+1
              sbc   offset+1
              sta   pntr+1

cop1:
              lda   (pntr), y
              inc   pntr
              bne   plus1
              inc   pntr+1
plus1:             jsr   put_byte
              bne   cop1

              asl   bitr
              bcc   decode_literal

; Copy from new offset (repeat N bytes from new offset)
;    Elias(MSB(offset))  LSB(offset)  Elias(length-1)
dzx0s_new_offset:
              ; Read elias code for high part of offset
              jsr   get_elias
              beq   exit  ; Read a 0, signals the end
              ; Decrease and divide by 2
              dex
              txa
              lsr   ;@
              sta   offset+1

              ; Get low part of offset, a literal 7 bits
              jsr   get_byte

              ; Divide by 2
              ror   ;@
              sta   offset

              ; And get the copy length.
              ; Start elias reading with the bit already in carry:
              ldx   #1
              jsr   elias_skip1

              inx
              bcc   dzx0s_copy

; Read an elias-gamma interlaced code.
; ------------------------------------
get_elias:
              ; Initialize return value to #1
              ldx   #1
              bne   elias_start

elias_get:     ; Read next data bit to result
              asl   bitr
              rol   ;@
              tax

elias_start:
              ; Get one bit
              asl   bitr
              bne   elias_skip1

              ; Read new bit from stream
              jsr   get_byte
              ;sec   ; not needed, C=1 guaranteed from last bit
              rol   ;@
              sta   bitr

elias_skip1:
              txa
              bcs   elias_get
              ; Got ending bit, stop reading
              rts

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
get_byte:
              lda   (ZX0_src), y
              inc   ZX0_src
              bne   plus3
              inc   ZX0_src+1
exit:
plus3:             rts

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
put_byte:
              sta   (ZX0_dst),y
              inc   ZX0_dst
              bne   plus4
              inc   ZX0_dst+1
plus4:             dex
              rts

