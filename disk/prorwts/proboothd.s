;license:BSD-3-Clause

; based on minimal open/read binary file in ProDOS filesystem
; from 4cade
;
;copyright (c) Peter Ferrie 2016-2019

; zpage usage, arbitrary selection except for the "ProDOS constant" ones
	command   = $42         ;ProDOS constant
	unit      = $43         ;ProDOS constant
	adrlo     = $44         ;ProDOS constant
	adrhi     = $45         ;ProDOS constant
	bloklo    = $46         ;ProDOS constant
	blokhi    = $47         ;ProDOS constant

	A2L       = $3e
	A2H       = $3f
	sizehi    = $53

;constants
	scrn2p2   = $f87b
	dirbuf    = $1e00       ;for size-optimisation

; start of boot sector, how many sectors to load
.byte 1

proboot_start:
	txa
	pha

	lda	#'A'+$80
	sta	$400		; write A to upper-left of screen

forever:
	jmp	forever


;src  "src/4cade.init.machine.a"

; src  "src/4cade.init.screen.a"


;         pla
 ;        sta   unit
  ;       tax
   ;      ; X = boot slot x16
    ;     ; Y = 0

         ; set up ProDOS shim

;-        txa
;         jsr   scrn2p2
;         and   #7
;         ora   #$c0
;         sta   $be30, y
;         sta   slot+2
;         sta   entry+2
;slot     lda   $cfff
;         sta   entry+1
;         lda   fakeMLI_e-$100, y
;         sta   $be00+fakeMLI_e-fakeMLI, y
;         iny
;         bne   -
;         sty   adrlo
;         stx   $bf30
;         sty   $200

opendir:
	; read volume directory key block
	ldx	#2

	; include volume directory header in count

firstent:
	lda	#>dirbuf
	sta	adrhi
	sta	A2H
	jsr	seekread
	lda	#4
	sta	A2L
nextent:
	ldy	#0

	; match name lengths before attempting to match names

;	lda   (A2L), y
;	and   #$0f
;	tax
;	inx
;-        cmp   filename, y
;         beq   foundname

         ;move to next directory in this block

;         clc
 ;        lda   A2L
  ;       adc   #$27
   ;      sta   A2L
    ;     bcc   +

         ;there can be only one page crossed, so we can increment instead of adc

;         inc   A2H
;+        cmp   #$ff ;4+($27*$0d)
;         bne   nextent

         ;read next directory block when we reach the end of this block

;         ldx   dirbuf+2
;         ldy   dirbuf+3
;         bcs   firstent

foundname:
;         iny
;         lda   (A2L), y
;         dex
;         bne -
;         stx   $ff

         ;cache KEY_POINTER

;         ldy   #$11
;         lda   (A2L), y
;         tax
;         iny
;         lda   (A2L), y
;         tay

readfile:
; jsr   seekread
;         inc   adrhi
;         inc   adrhi

         ;fetch data block and read it

blockind:
;	 ldy   $ff
;         inc   $ff
;         ldx   dirbuf, y
;         lda   dirbuf+256, y
;         tay
;         bne   readfile
;         txa
;         bne   readfile

readdone:
;	 jmp   ProBootEntry

seekread:
;	 stx   bloklo
;         sty   blokhi
;         lda   #1
;         sta   command
;         lda   adrhi
;        pha
;entry    jsr   $d1d1
;         pla
;         sta   adrhi
;         rts

;fakeMLI  bne   retcall
;readblk  dey
;         dey
;         sty   adrhi
;         tay
;         jsr   $bf00+seekread-fakeMLI
;retcall  pla
;         tax
;         inx
;         inx
;         inx
;         txa
;         pha
;-        rts
;fakeMLI_e


;filename +PSTRING "LAUNCHER.SYSTEM"

;         !src  "src/4cade.branding.a"

;!if (* > $9f7) {
;         !serious "Bootloader is too large"
;}

;*=$9f8
;!byte $D3,$C1,$CE,$A0,$C9,$CE,$C3,$AE
;       S   A   N       I   N   C   .
;
