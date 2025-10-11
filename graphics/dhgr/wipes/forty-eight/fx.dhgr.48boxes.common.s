;license:MIT
;(c) 2020 by 4am & qkumba
;

	; !source "src/fx/macros.a"

	.include "../macros.s"

InitOnce:
	bit	Start
	lda	#$4C
	sta	InitOnce

;	LDADDR	FXCodeFile
;	ldx	#>FXCode
;	jsr	iLoadFXCODE

	; load fxcode from disk?

	; initialize and copy stage drawing routines table into place
	ldx	#0
	txa
io_m1:
	sta	EndStagesHi, X
	inx
	bne	io_m1
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

BoxInitialStages:
