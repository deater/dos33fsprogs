;license:MIT
;(c) 2020 by 4am & qkumba
;

	; !source "src/fx/macros.a"

	.include "../macros.s"

InitOnce:
	; self modify to run next code only once

	bit	Start
	lda	#$4C
	sta	InitOnce

	; load effect from disk?  Originally at $6200?

;	LDADDR	FXCodeFile
;	ldx	#>FXCode
;	jsr	iLoadFXCODE

	; load fxcode from disk?

	; initialize and copy stage drawing routines table into place


	; write 256 bytes of 0s off end of EndStageHi?
	; why? do we need padding?
;	ldx	#0
;	txa
;io_m1:
;	sta	EndStagesHi, X
;	inx
;	bne	io_m1

	ldx	#0
io_m2:
	lda	StagesHi, X
	sta	DHGR48StageDrawingRoutines, X
	inx
	bne	io_m2
	beq	Start		; always branches

FXCodeFile:
;	+PSTRING "DHGR48"

Start:
	jsr	FXCode		; vector to building phase
				; to inititalize drawing routines and tables

	; copy this effect's initial stages to zp
	ldx   #47
s_m1:
	ldy	BoxInitialStages, X
	sty	DHGR48BoxStages, X
	dex
	bpl	s_m1

	jmp	FXCode+3              ; exit via vector to drawing phase

;BoxInitialStages:

