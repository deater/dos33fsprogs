;license:MIT
;(c) 2019-2022 by 4am
;

;!ifndef _FX_MACROS_MISC_ {
.ifndef _FX_MACROS_MISC_

;!macro HIGH_3_LOW_5 .input {
.macro HIGH_3_LOW_5 input
         and   #%11100000            ; second value: high 3 bits = index into tables to find bitmasks
         tax
         eor   (<input), y          ; second value: low 5 bits = byte offset within the row (implicitly "and #%00011111")
         tay
;}
.endmacro

; must set N flag based on Y immediately before using these macros
; e.g. LDY, INY, DEY, TYA
;!macro IS_Y_OFFSCREEN {
;.macro IS_Y_OFFSCREEN
;         bpl   +
;         sec
;         bcs   ++
;+        cpy   #40
;++
;}
;.endmacro

;!macro BRANCH_IF_Y_IS_OFFSCREEN .target {
;         cpy   #40
;         bcs   .target
;}
;!macro LONG_BRANCH_IF_Y_IS_OFFSCREEN .target {
;         cpy   #40
;         bcc   +
;         jmp   .target
;+
;}

;!macro COPY_TO_0 .start, .end {
.macro COPY_TO_0 start, end
; out:   X=0
;        Z=1
	.Local m1
	ldx	#(end-start)
m1:	lda	start-1, x
	sta	$FF, x
	dex
	bne	m1
;}
.endmacro

;!macro OVERCOPY_TO_0 .start, .end {
.macro OVERCOPY_TO_0 start, end
; over-copy region to $00
; clobbers $FF

.local oczm

; out:   X=0
;        Y=last byte before start (e.g. 0 if the last instruction is JMP $0000)
         ldx   #(end-start+1)
oczm:        ldy   start-2, x
         sty   $FE, x
         dex
         bne   oczm
.endmacro
;}

;!macro INC_INPUT_AND_LOOP .input, .loop {
.macro INC_INPUT_AND_LOOP input, loop
	.Local p1
	.Local p2
	inc	<input
	beq	p1
	jmp	loop
p1:
	bit	KBD
	bmi	p2
	inc	<input+1
	jmp	loop
p2:
	rts
;}
.endmacro

;!macro DEC_INPUT_AND_LOOP .input, .loop {
;        lda   .input
;         php
;         dec   .input
;         dec   .input
;         plp
;         bne   +
;         dec   .input+1
;         bit   KBD
;         bpl   .loop
;         bmi   ++
;+        jmp   .loop
;++       rts
;}

_FX_MACROS_MISC_=*
;}
.endif
