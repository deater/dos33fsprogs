;license:MIT
;(c) 2018-2021 by 4am & qkumba
;
; common assembler macros (6502 compatible)
;

;!ifndef _MACROS_ {
.ifndef _MACROS_
;         !source "src/constants.a"
	.include "constants.s"

; appears to put string and length?

;!macro   PSTRING .string {
.macro	PSTRING string
	.Local end_pstring
;         !byte +-*-1
;         !text .string
	.byte end_pstring-*-1
	.byte string
end_pstring:
;+
;}
.endmacro

;!macro   DEFINE_INDIRECT_VECTOR .name, .target {
;         !if (RELBASE != $2000) and (* != .name) { !serious .name,"!=",*,", fix constants.a" }
;         jmp   .target
;}

; for functions that take parameters on the stack
; set (PARAM) to point to the parameters and
; move the stack pointer to the first byte after the parameters
; clobbers A,Y
; preserves X
;!macro   PARAMS_ON_STACK .bytes {
;         pla
;         sta   PARAM
;         clc
;         adc   #.bytes
;        tay
;         pla
;         sta   PARAM+1
;         adc   #0
;         pha
;         tya
;         pha
;}

; for functions that take parameters on the stack
; load a 16-bit value from the parameters on the stack into A (low) and Y (high)
; (assumes PARAMS_ON_STACK was used first)
;!macro   LDPARAM .offset {
;         ldy   #.offset
;         lda   (PARAM),y
;         pha
;         iny
;         lda   (PARAM),y
;         tay
;         pla
;}

; for functions that take parameters on the stack
; load a 16-bit value from the parameters on the stack into A (low) and Y (high)
; then store it as new source
; (assumes PARAMS_ON_STACK was used first)
;!macro   LDPARAMPTR .offset,.dest {
;         ldy   #.offset
;         lda   (PARAM),y
;         sta   .dest
;         iny
;         lda   (PARAM),y
;         sta   .dest+1
;}

; load the address of .ptr into A (low) and Y (high)
;!macro   LDADDR .ptr {
.macro LDADDR ptr
	lda   #<ptr
	ldy   #>ptr
;}
.endmacro

; load a 16-bit value into A (low) and Y (high)
;!macro   LD16 .ptr {
;         lda   .ptr
;         ldy   .ptr+1
;}

; load a 16-bit value into X (low) and Y (high)
;!macro   LDX16 .ptr {
;         ldx   .ptr
;         ldy   .ptr+1
;}

; store a 16-bit value from A (low) and Y (high)
;!macro   ST16 .ptr {
.macro	ST16 ptr
         sta   ptr
         sty   ptr+1
.endmacro
;}

; store a 16-bit value from X (low) and Y (high)
;!macro   STX16 .ptr {
;         stx   .ptr
;         sty   .ptr+1
;}

; decrement a 16-bit value in A (low) and Y (high)
;!macro   DEC16 {
;        sec
;         sbc   #1
;         bcs   +
;         dey
;+
;}

; decrement a 16-bit value in X (low) and Y (high)
; destroys A!
;!macro   DEX16 {
;        txa
;         bne   +
;         dey
;+        dex
;}

; increment a 16-bit value in A (low) and Y (high)
;!macro   INC16 {
;         clc
;         adc   #1
;         bne   +
;         iny
;+
;}

; increment a 16-bit value in X (low) and Y (high)
;!macro   INX16 {
;         inx
;         bne   +
;         iny
;+
;}

; compare a 16-bit value in A (low) and Y (high) to an absolute address
; branch to target if no match
; zeroes A!
;!macro   CMP16ADDR_NE .addr, .target {
;        eor   .addr
;         bne   .target
;         cpy   .addr+1
;         bne   .target
;}

; compare a 16-bit value in X (low) and Y (high) to an absolute address
; branch to target if no match
;!macro   CPX16ADDR_NE .addr, .target {
;         cpx   .addr
;         bne   .target
;         cpy   .addr+1
;         bne   .target
;}

; compare a 16-bit value in A (low) and Y (high) to an immediate value
; branch to target if match
;!macro   CMP16_E .val, .target {
;         cmp   #<.val
;         bne   +
;         cpy   #>.val
;         beq   .target
;+
;}

; compare a 16-bit value in A (low) and Y (high) to an immediate value
; branch to target if no match
;!macro   CMP16_NE .val, .target {
;         cmp   #<.val
;         bne   .target
;         cpy   #>.val
;         bne   .target
;}

; compare a 16-bit value in X (low) and Y (high) against zero
; branch to target if not zero
; requires LDX16 immediately prior, since Y comparison is implicit!
; destroys A!
;!macro   CPX16_0_NE .target {
;         bne   .target
;         txa
;         bne   .target
;}

;!macro   LBPL .target {
.macro LBPL target
;         bmi   +
;         jmp   .target
;+
	.local plus
	bmi	plus
	jmp	target
plus:

.endmacro
;}

;!macro   LBMI .target {
;         bpl   +
;         jmp   .target
;+
;}

;!macro   LBNE .target {
.macro	LBNE target
;         beq   +
;         jmp   .target
;+
	.local lbnep
	beq	lbnep
	jmp	target
lbnep:

.endmacro
;}

;!macro   LBCS .target {
;        bcc   +
;         jmp   .target
;+
;}

; use BIT to swallow the following 1-byte opcode
;!macro   HIDE_NEXT_BYTE {
;         !byte $24
;}

; use BIT to swallow the following 2-byte opcode
;!macro   HIDE_NEXT_2_BYTES {
;         !byte $2C
;}

; debugging
;!macro   DEBUGWAIT {
;         bit   $c010
;-        bit   $c000
;         bpl   -
;         bit   $c010
;}

; various language card configurations
;!macro   READ_RAM1_NO_WRITE {
;         sta   $C088
;}

;!macro   READ_RAM1_WRITE_RAM1 {
.macro READ_RAM1_WRITE_RAM1
         bit   $C08B
         bit   $C08B
.endmacro
;}

;!macro   READ_RAM2_NO_WRITE {
;         sta   $C080
;}

;!macro   READ_RAM2_WRITE_RAM2 {
;         bit   $C083
;         bit   $C083
;}

;!macro   READ_ROM_WRITE_RAM1 {
;         bit   $C089
;         bit   $C089
;}

;!macro   READ_ROM_WRITE_RAM2 {
;         bit   $C081
;         bit   $C081
;}

;!macro   READ_ROM_NO_WRITE {
.macro	READ_ROM_NO_WRITE
         sta   $C082
.endmacro
;}

;!macro   WRITE_AUX {
;         sta   WRITEAUXMEM
;}

;!macro   WRITE_MAIN {
;         sta   WRITEMAINMEM
;}

; requires setting zpCharMask in zero page to #$FF or #$DF before use
;!macro   FORCE_UPPERCASE_IF_REQUIRED {
;         cmp   #$E1
;         bcc   +
;         and   zpCharMask
;+
;}

;!macro   HGR_BYTE_TO_DHGR_BYTES {
;1GFEDCBA ->
;1GGFFEED (main) +
;1DCCBBAA (aux)
;
; in:    A = HGR byte
; out:   A = DHGR byte in mainmem
;        X = DHGR byte in auxmem
;        preserves Y
;        clobbers zero page $00,$01,$02
;         sty   $02
;         ldy   #$02
;--       stx   $01
;         ldx   #$04
;-        ror   $00                   ; duplicate previous bit
;         lsr                         ; fetch bit
 ;        php
 ;        ror   $00                   ; insert bit
 ;        plp
;         dex
;         bne   -
;         ldx   $00
;        dey
;         bne   --
;         txa
;         sec
;         ror   $01                   ; set bit 7 explicitly on auxmem value
;         ldx   $01
;         ldy   $02
;}

; these are mostly for prelaunchers -- code in the main program should keep track of which bank is active to minimize code size
;!macro   ENABLE_ACCEL {
;         +ENABLE_ACCEL_LC
;         +READ_ROM_NO_WRITE
;}

; leave LC active on exit
;!macro   ENABLE_ACCEL_LC {
;         +READ_RAM2_NO_WRITE
;         jsr   EnableAccelerator
;}

;!macro   DISABLE_ACCEL {
;         +READ_RAM2_NO_WRITE
;         jsr   DisableAccelerator
;         +READ_ROM_NO_WRITE
;}

;!macro   GET_MACHINE_STATUS {
 ;        +READ_RAM2_NO_WRITE
;         lda   MachineStatus
;         +READ_ROM_NO_WRITE
;}

;!macro   GET_MOCKINGBOARD_SPEECH { ;sign set if SC-01, overflow set if SSI-263
;         +READ_RAM2_NO_WRITE
;         bit   MockingboardStuff
;         +READ_ROM_NO_WRITE
;}

;!macro   GET_MOCKINGBOARD_SPEECH_AND_MACHINE_STATUS { ;sign set if SC-01, overflow set if SSI-263
 ;        +READ_RAM2_NO_WRITE
  ;       lda   MachineStatus
   ;      bit   MockingboardStuff
    ;     +READ_ROM_NO_WRITE
;}

;!macro   GET_MOCKINGBOARD_SLOT { ;carry set if present
 ;        +READ_RAM2_NO_WRITE
  ;       lda   MockingboardStuff
   ;      cmp   #1
    ;     and   #7
     ;    ora   #$C0
      ;   +READ_ROM_NO_WRITE
;}

;!macro   GET_MOCKINGBOARD_SLOT_AND_MACHINE_STATUS { ;carry set if present
 ;        +READ_RAM2_NO_WRITE
  ;       lda   MockingboardStuff
   ;      cmp   #1
    ;     and   #7
     ;    ora   #$C0
      ;   tax
;         lda   MachineStatus
 ;        +READ_ROM_NO_WRITE
;}

; ROM must be banked in!
;!macro   USES_TEXT_PAGE_2 {          ; If we know we are going into a game one-time
 ;        lda   ROM_MACHINEID         ; only we can just blindly turn on TEXT2COPY, as
  ;       cmp   #$06                  ; Alternate Display Mode turns off on reset or reboot.
   ;      bne   +
    ;     sec
;         jsr   $FE1F                 ; check for IIgs
 ;        bcs   +
  ;       jsr   ROM_TEXT2COPY         ; set alternate display mode on IIgs (required for some games)
   ;      cli                         ; enable VBL interrupts
;+
;}

; ROM must be banked in!
;!macro   TEST_TEXT_PAGE_2 {          ; On a ROM3 IIgs we can test if Alternate Display Mode
 ;;        lda   ROM_MACHINEID         ; is already on. ROM0 and ROM1 versions of ADM use
   ;      cmp   #$06                  ; interrupts and can cause hangs, so safer to just
    ;     bne   ++                    ; leave it turned off, especially in ATTRACT/DEMO mode.
     ;    sec
      ;   jsr   $FE1F                 ; check for IIgs
       ;  bcs   ++
;         tya                         ; GS ID routine returns with ROM version in Y
 ;        cmp   #0                    ; ROM 0?
  ;       beq   ++
   ;      cmp   #1                    ; ROM 1?
    ;     beq   ++
     ;    lda   #$20
      ;   sta   $0800                 ; check if Alternate Display Mode is already on
       ;  lda   #$FF
;         jsr   ROM_WAIT              ; skip a VBL cycle
;!cpu 65816
;         lda   $E00800               ; did we shadow copy data to bank $E0?
;         cmp   #$20
;         beq   +                     ; only call TEXT2COPY if we know it's off
;!cpu 6502              ; https://archive.org/details/develop-04_9010_October_1990/page/n51/mode/1up
;         jsr   ROM_TEXT2COPY         ; set alternate display mode on IIgs (required for some games)
;+        cli                         ; enable VBL interrupts
;++
;}

;!macro   RESET_VECTOR .addr {
 ;        lda   #<.addr
  ;       sta   $3F2
;  !ifndef .addr {
 ;   !set emitted=1
  ;       lda   #>.addr
   ;      sta   $3F3
    ;     eor   #$A5
     ;    sta   $3F4
;  } else {
 ;   !ifdef emitted {
  ;       lda   #>.addr
   ;      sta   $3F3
    ;     eor   #$A5
     ;    sta   $3F4
;    } else {
 ;     !if (>.addr != 1) or (.addr = $100) {
  ;       lda   #>.addr
   ;      sta   $3F3
    ;     eor   #$A5
     ;    sta   $3F4
;      }
;    }
;  }
;}

;!macro   RESET_VECTOR_HALF .addr {
;         lda   #>.addr
 ;        sta   $3F3
 ;        eor   #$A5
  ;       sta   $3F4
;}

;!macro   RESET_AND_IRQ_VECTOR .addr {
 ;        lda   #<.addr
  ;       sta   $3F2
   ;      sta   $3FE
    ;     lda   #>.addr
     ;    sta   $3F3
      ;   sta   $3FF
       ;  eor   #$A5
;         sta   $3F4
;}
; for games that clobber $100-$105, the prelaunch code constructs a new reset vector
; somewhere else and sets the reset vector to point at it.
;!macro   NEW_RESET_VECTOR .addr {
;         ldx   #5
;-        lda   $100,x
 ;        sta   .addr,x
  ;       dex
   ;      bpl   -
    ;     +RESET_VECTOR .addr
;}

;!macro   NEW_RESET_VECTOR_64K .addr {
 ;        lda   #$2C
  ;       sta   .addr
   ;      lda   #$89
    ;     sta   .addr+1
     ;    lda   #$C0
      ;   sta   .addr+2
;         lda   #$4C       ; JMP $FAA6 to reboot
 ;        sta   .addr+3
  ;       lda   #$A6
   ;      sta   .addr+4
    ;     lda   #$FA
     ;    sta   .addr+5
      ;   lda   #<.addr
       ;  sta   $3F2
;         sta   $FFFC
 ; !if >.addr != 1 {
  ;       lda   #>.addr
   ;      sta   $3F3
    ;     sta   $FFFD
     ;    eor   #$A5
      ;   sta   $3F4
;  }
;}

; for 64k games on ][+ which either hang or restart
; updates reset hook to reboot on ctrl-reset
;!macro   LC_REBOOT {
 ;        inc   $101       ; (assumes LC is switched in)
  ;       lda   #$A6
   ;      sta   $104
    ;     lda   #$FA
     ;    sta   $105       ; update reset hook to reboot
;         lda   #1
 ;        sta   $FFFD
  ;       lsr
   ;      sta   $FFFC      ; LC reset vector fix
;}

; load an external file by pathname
; LC RAM 2 MUST BE BANKED IN
; set .addr to $0000 to load to any aligned addres in main
; LOW BYTE OF .addr MUST BE $00 IN THAT CASE
;!macro   LOAD_FILE_AT .filepath, .addr {
;  !if .addr > 0 {
 ;        lda   #>.addr
  ;       sta   ldrhi
;  }
;  !if <.addr > 0 {
;         lda   #<.addr
;         sta   ldrlo
;  }
;         lda   iCurBlockLo
;         pha
;         lda   iCurBlockHi
;         pha
;         ldx   #0         ; read to main memory
;  !if <.addr = 0 {
;         stx   ldrlo
;  }
;         +LDADDR .filepath
 ;        jsr   iLoadFileDirect
  ;       pla
   ;      sta   iCurBlockHi
    ;     pla
     ;    sta   iCurBlockLo
;}

; load an external file by pathname
; set path to new directory
; LC RAM 2 MUST BE BANKED IN
;!macro   LOAD_FILE_KEEP_DIR .filepath, .dirlen {
 ;        ldx   #0         ; read to main memory
  ;       stx   ldrhi
   ;      stx   ldrlo
    ;     +LDADDR .filepath
     ;    jsr   iLoadFileDirect
;
 ;        ldx   #.dirlen
  ;       stx   $BFD0
;-        lda   .filepath,x
 ;        sta   $BFD0,x
  ;       dex
   ;      bne   -
;
;}

;!macro   LOAD_FILE_KEEP_DIR .filepath, .addr, .dirlen {
 ;        lda   #>.addr
  ;       sta   ldrhi
   ;      lda   #<.addr
    ;     sta   ldrlo
     ;    ldx   #0         ; read to main memory
      ;   +LDADDR .filepath
       ;  jsr   iLoadFileDirect
;
 ;        ldx   #.dirlen
  ;       stx   $BFD0
;-        lda   .filepath,x
 ;        sta   $BFD0,x
  ;       dex
   ;      bne   -
;}

;!macro   LOAD_XSINGLE .title {
 ;        +READ_RAM1_WRITE_RAM1
  ;       +LDADDR .title
   ;      jsr   iLoadXSingle
    ;     +READ_ROM_NO_WRITE
;}

; Macros for demo launchers that need to check whether they should run
; on the current machine. Exit demo if the requirements are not met.
;!macro   GAME_REQUIRES_JOYSTICK {
 ;        +GET_MACHINE_STATUS
  ;       and   #HAS_JOYSTICK
   ;      bne   +
    ;     jmp   $100
;+
;}

_MACROS_=*
;}
.endif
