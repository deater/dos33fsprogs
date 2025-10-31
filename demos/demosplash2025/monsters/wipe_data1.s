;==============================================
;==============================================
; wipe data
;==============================================
;==============================================

wipes_box_init_l:
	.byte <spiral_BoxInitialStages
;	.byte <snake_BoxInitialStages
	.byte <arrow_BoxInitialStages
;	.byte <down_BoxInitialStages
;	.byte <long_diagonal_BoxInitialStages
;	.byte <side_side_BoxInitialStages
;	.byte <sync_BoxInitialStages
;	.byte <pageturn_BoxInitialStages
wipes_box_init_h:
	.byte >spiral_BoxInitialStages
;	.byte >snake_BoxInitialStages
	.byte >arrow_BoxInitialStages
;	.byte >down_BoxInitialStages
;	.byte >long_diagonal_BoxInitialStages
;	.byte >side_side_BoxInitialStages
;	.byte >sync_BoxInitialStages
;	.byte >pageturn_BoxInitialStages
wipes_stages_l:
	.byte <spiral_StagesHi
;	.byte <snake_StagesHi
	.byte <arrow_StagesHi
;	.byte <down_StagesHi
;	.byte <long_diagonal_StagesHi
;	.byte <side_side_StagesHi
;	.byte <sync_StagesHi
;	.byte <pageturn_StagesHi
wipes_stages_h:
	.byte >spiral_StagesHi
;	.byte >snake_StagesHi
	.byte >arrow_StagesHi
;	.byte >down_StagesHi
;	.byte >long_diagonal_StagesHi
;	.byte >side_side_StagesHi
;	.byte >sync_StagesHi
;	.byte >pageturn_StagesHi
wipes_stages_size:
	.byte spiral_EndStagesHi-spiral_StagesHi
;	.byte snake_EndStagesHi-snake_StagesHi
	.byte arrow_EndStagesHi-arrow_StagesHi
;	.byte down_EndStagesHi-down_StagesHi
;	.byte long_diagonal_EndStagesHi-long_diagonal_StagesHi
;	.byte side_side_EndStagesHi-side_side_StagesHi
;	.byte sync_EndStagesHi-sync_StagesHi
;	.byte pageturn_EndStagesHi-pageturn_StagesHi

;=============================================
; Spiral Wipe

spiral_BoxInitialStages:
	.byte $00,$E9,$EA,$EB,$EC,$ED,$EE,$EF
	.byte $FF,$E8,$D9,$DA,$DB,$DC,$DD,$F0
	.byte $FE,$E7,$D8,$D1,$D2,$D3,$DE,$F1
	.byte $FD,$E6,$D7,$D6,$D5,$D4,$DF,$F2
	.byte $FC,$E5,$E4,$E3,$E2,$E1,$E0,$F3
	.byte $FB,$FA,$F9,$F8,$F7,$F6,$F5,$F4

spiral_StagesHi:	; high bytes of address of drawing routine for each stage
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
spiral_EndStagesHi:

.if 0
;=============================================
; Snake Wipe

snake_BoxInitialStages:

.byte $00,$FF,$FE,$FD,$FC,$FB,$FA,$F9
.byte $F1,$F2,$F3,$F4,$F5,$F6,$F7,$F8
.byte $F0,$EF,$EE,$ED,$EC,$EB,$EA,$E9
.byte $E1,$E2,$E3,$E4,$E5,$E6,$E7,$E8
.byte $E0,$DF,$DE,$DD,$DC,$DB,$DA,$D9
.byte  $D1,$D2,$D3,$D4,$D5,$D6,$D7,$D8

snake_StagesHi:	; high bytes of address of drawing routine for each stage
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
snake_EndStagesHi:
.endif

;=============================================
; Arrow Wipe

arrow_BoxInitialStages:

.byte $FA,$F6,$F4,$F0,$EE,$EA,$E8,$E4
.byte $FC,$FA,$F6,$F4,$F0,$EE,$EA,$E8
.byte $00,$FC,$FA,$F6,$F4,$F0,$EE,$EA
.byte $FF,$FD,$F9,$F7,$F3,$F1,$ED,$EB
.byte $FD,$F9,$F7,$F3,$F1,$ED,$EB,$E7
.byte $F9,$F7,$F3,$F1,$ED,$EB,$E7,$E5

arrow_StagesHi:	; high bytes of address of drawing routine for each stage
.byte dhgr_copy00
.byte dhgr_copy01
.byte dhgr_copy02
.byte dhgr_copy03
.byte dhgr_copy04
.byte dhgr_copy05
.byte dhgr_copy06
.byte dhgr_copy07
.byte dhgr_copy08
.byte dhgr_copy09
.byte dhgr_copy0A
.byte dhgr_copy0B
.byte dhgr_copy0C
.byte dhgr_copy0D
.byte dhgr_copy0E
.byte dhgr_copy0F
arrow_EndStagesHi:

.if 0
;=============================================
; Down Wipe

down_BoxInitialStages:

.byte $00,$FF,$00,$FF,$00,$FF,$00,$FF
.byte $FE,$FD,$FE,$FD,$FE,$FD,$FE,$FD
.byte $FC,$FB,$FC,$FB,$FC,$FB,$FC,$FB
.byte $FA,$F9,$FA,$F9,$FA,$F9,$FA,$F9
.byte $F8,$F7,$F8,$F7,$F8,$F7,$F8,$F7
.byte $F6,$F5,$F6,$F5,$F6,$F5,$F6,$F5

down_StagesHi:	; high bytes of address of drawing routine for each stage
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
down_EndStagesHi:

;=============================================
; Long Diagonal Wipe

long_diagonal_BoxInitialStages:

.byte $00,$FE,$FC,$FA,$F8,$F6,$F4,$F2
.byte $FE,$FC,$FA,$F8,$F6,$F4,$F2,$F0
.byte $FC,$FA,$F8,$F6,$F4,$F2,$F0,$EE
.byte $FA,$F8,$F6,$F4,$F2,$F0,$EE,$EC
.byte $F8,$F6,$F4,$F2,$F0,$EE,$EC,$EA
.byte $F6,$F4,$F2,$F0,$EE,$EC,$EA,$E8

long_diagonal_StagesHi: ; high bytes of address of drawing routine for each stage
.byte dhgr_copy00
.byte dhgr_copy01
.byte dhgr_copy02
.byte dhgr_copy03
.byte dhgr_copy04
.byte dhgr_copy05
.byte dhgr_copy06
.byte dhgr_copy07
.byte dhgr_copy08
.byte dhgr_copy09
.byte dhgr_copy0A
.byte dhgr_copy0B
.byte dhgr_copy0C
.byte dhgr_copy0D
.byte dhgr_copy0E
.byte dhgr_copy0F
long_diagonal_EndStagesHi:


;=============================================
; Side to Side Wipe

side_side_BoxInitialStages:
.byte $00,$FC,$F8,$F4,$F0,$EC,$E8,$E4
.byte $E4,$E8,$EC,$F0,$F4,$F8,$FC,$00
.byte $00,$FC,$F8,$F4,$F0,$EC,$E8,$E4
.byte $E4,$E8,$EC,$F0,$F4,$F8,$FC,$00
.byte $00,$FC,$F8,$F4,$F0,$EC,$E8,$E4
.byte $E4,$E8,$EC,$F0,$F4,$F8,$FC,$00

side_side_StagesHi: ; high bytes of address of drawing routine for each stage
.byte dhgr_copy00
.byte dhgr_copy01
.byte dhgr_copy02
.byte dhgr_copy03
.byte dhgr_copy04
.byte dhgr_copy05
.byte dhgr_copy06
.byte dhgr_copy07
.byte dhgr_copy08
.byte dhgr_copy09
.byte dhgr_copy0A
.byte dhgr_copy0B
.byte dhgr_copy0C
.byte dhgr_copy0D
.byte dhgr_copy0E
.byte dhgr_copy0F
side_side_EndStagesHi:

;=============================================
; Sync Wipe

sync_BoxInitialStages:

.byte $00,$FF,$00,$FF,$00,$FF,$00,$FF
.byte $FF,$00,$FF,$00,$FF,$00,$FF,$00
.byte $00,$FF,$00,$FF,$00,$FF,$00,$FF
.byte $FF,$00,$FF,$00,$FF,$00,$FF,$00
.byte $00,$FF,$00,$FF,$00,$FF,$00,$FF
.byte $FF,$00,$FF,$00,$FF,$00,$FF,$00

sync_StagesHi: ; high bytes of address of drawing routine for each stage
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
sync_EndStagesHi:


;=============================================
; Page Turn Clearn Wipe

pageturn_BoxInitialStages:

.byte $E1,$E2,$E1,$E7,$ED,$F3,$F9,$FF
.byte $E7,$E8,$E7,$E8,$EE,$F4,$FA,$00
.byte $ED,$EE,$ED,$EE,$ED,$F3,$F9,$FF
.byte $F3,$F4,$F3,$F4,$F3,$F4,$FA,$00
.byte $F9,$FA,$F9,$FA,$F9,$FA,$F9,$FF
.byte $FF,$00,$FF,$00,$FF,$00,$FF,$00

pageturn_StagesHi: ; high bytes of address of drawing routine for each stage
.byte dhgr_clear0F
.byte dhgr_clear0E
.byte dhgr_clear0D
.byte dhgr_clear0C
.byte dhgr_clear0B
.byte dhgr_clear0A
.byte dhgr_clear09
.byte dhgr_clear08
.byte dhgr_clear07
.byte dhgr_clear06
.byte dhgr_clear05
.byte dhgr_clear04
.byte dhgr_clear03
.byte dhgr_clear02
.byte dhgr_clear01
.byte dhgr_clear00
.byte 0,0,0,0,0,0,0,0,0,0,0,0,0
.byte dhgr_copy00
.byte dhgr_copy01
.byte dhgr_copy02
.byte dhgr_copy03
.byte dhgr_copy04
.byte dhgr_copy05
.byte dhgr_copy06
.byte dhgr_copy07
.byte dhgr_copy08
.byte dhgr_copy09
.byte dhgr_copy0A
.byte dhgr_copy0B
.byte dhgr_copy0C
.byte dhgr_copy0D
.byte dhgr_copy0E
.byte dhgr_copy0F
pageturn_EndStagesHi:
.endif
