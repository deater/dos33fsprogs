;license:MIT
;(c) 2020 by 4am & qkumba
;
;!cpu 6502
;!to "build/FX.INDEXED/DHGR.48.SPIRAL",plain
;*=$6000

.align	256

	;!source "src/fx/fx.dhgr.48boxes.common.a"
	.include "fx.dhgr.48boxes.common.s"
BoxInitialStages:
	.byte $00,$E9,$EA,$EB,$EC,$ED,$EE,$EF
	.byte $FF,$E8,$D9,$DA,$DB,$DC,$DD,$F0
	.byte $FE,$E7,$D8,$D1,$D2,$D3,$DE,$F1
	.byte $FD,$E6,$D7,$D6,$D5,$D4,$DF,$F2
	.byte $FC,$E5,$E4,$E3,$E2,$E1,$E0,$F3
	.byte $FB,$FA,$F9,$F8,$F7,$F6,$F5,$F4

StagesHi:	 ; high bytes of address of drawing routine for each stage
	.byte dhgr_copy0F
	.byte dhgr_copy0E
	.byte dhgr_copy0D
	.byte dhgr_copy0C
	.byte dhgr_copy0B
	.byte dhgr_copy0A
	.byte dhgr_copy09
	.byte dhgr_copy08
	.byte dhgr_copy07
	.byte dhgr_copy06
	.byte dhgr_copy05
	.byte dhgr_copy04
	.byte dhgr_copy03
	.byte dhgr_copy02
	.byte dhgr_copy01
	.byte dhgr_copy00
EndStagesHi:
