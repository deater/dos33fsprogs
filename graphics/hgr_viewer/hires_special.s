; fancy images

.include "hires_main.s"

MAX_FILES = 44

filenames_low:
	.byte <bbl_filename
	.byte <bbl2_filename
	.byte <grl_filename
	.byte <obg_filename
	.byte <fup_filename
	.byte <witch_filename
	.byte <ob_filename
	.byte <bg2_filename
	.byte <oopb_filename
	.byte <ooc5_filename
	.byte <fze_filename
	.byte <fjj_filename
	.byte <dadz_filename
	.byte <mope_filename
	.byte <lh_filename
	.byte <fcd_filename
	.byte <facd_filename
	.byte <fif_filename
	.byte <fif2_filename
	.byte <oo4_filename
	.byte <oo2_filename
	.byte <fwq_filename
	.byte <piz_filename
	.byte <cit_filename
	.byte <cel_filename
	.byte <mug_filename
	.byte <quad_filename
	.byte <gb_filename
	.byte <jis_filename
	.byte <ojm_filename
	.byte <nda_filename
	.byte <fri_filename
	.byte <win_filename
	.byte <bar_filename
	.byte <ani_filename
	.byte <gld_filename
	.byte <rnu_filename
	.byte <ooh_filename
	.byte <two_filename
	.byte <rug_filename
	.byte <ndz_filename
	.byte <crd_filename
	.byte <gfa_filename
	.byte <sxy_filename

filenames_high:
	.byte >bbl_filename
	.byte >bbl2_filename
	.byte >grl_filename
	.byte >obg_filename
	.byte >fup_filename
	.byte >witch_filename
	.byte >ob_filename
	.byte >bg2_filename
	.byte >oopb_filename
	.byte >ooc5_filename
	.byte >fze_filename
	.byte >fjj_filename
	.byte >dadz_filename
	.byte >mope_filename
	.byte >lh_filename
	.byte >fcd_filename
	.byte >facd_filename
	.byte >fif_filename
	.byte >fif2_filename
	.byte >oo4_filename
	.byte >oo2_filename
	.byte >fwq_filename
	.byte >piz_filename
	.byte >cit_filename
	.byte >cel_filename
	.byte >mug_filename
	.byte >quad_filename
	.byte >gb_filename
	.byte >jis_filename
	.byte >ojm_filename
	.byte >nda_filename
	.byte >fri_filename
	.byte >win_filename
	.byte >bar_filename
	.byte >ani_filename
	.byte >gld_filename
	.byte >rnu_filename
	.byte >ooh_filename
	.byte >two_filename
	.byte >rug_filename
	.byte >ndz_filename
	.byte >crd_filename
	.byte >gfa_filename
	.byte >sxy_filename



; filename to open is 30-character Apple text:
bbl_filename:	; .byte "BBL.ZX02",0
	.byte 'B'|$80,'B'|$80,'L'|$80,'.'|$80,'Z'|$80,'X'|$80,'0'|$80
	.byte '2'|$80,$00

bbl2_filename:	; .byte "BBL2.ZX02",0
	.byte 'B'|$80,'B'|$80,'L'|$80,'2'|$80,'.'|$80,'Z'|$80,'X'|$80
	.byte '0'|$80,'2'|$80,$00

grl_filename:	; .byte "GRL.ZX02",0
	.byte 'G'|$80,'R'|$80,'L'|$80,'.'|$80,'Z'|$80,'X'|$80
	.byte '0'|$80,'2'|$80,$00

obg_filename:	; .byte "OBG.ZX02",0
	.byte 'O'|$80,'B'|$80,'G'|$80,'.'|$80,'Z'|$80,'X'|$80
	.byte '0'|$80,'2'|$80,$00

fup_filename:	; .byte "FUP.ZX02",0
	.byte 'F'|$80,'U'|$80,'P'|$80,'.'|$80,'Z'|$80,'X'|$80
	.byte '0'|$80,'2'|$80,$00

witch_filename:	; .byte "WITCH.ZX02",0
	.byte 'W'|$80,'I'|$80,'T'|$80,'C'|$80,'H'|$80
	.byte '.'|$80,'Z'|$80,'X'|$80,'0'|$80,'2'|$80,$00

ob_filename:	; .byte "OB.ZX02",0
	.byte 'O'|$80,'B'|$80
	.byte '.'|$80,'Z'|$80,'X'|$80,'0'|$80,'2'|$80,$00

bg2_filename:	; .byte "BG2.ZX02",0
	.byte 'B'|$80,'G'|$80,'2'|$80
	.byte '.'|$80,'Z'|$80,'X'|$80,'0'|$80,'2'|$80,$00

oopb_filename:	; .byte "OOPB.ZX02",0
	.byte 'O'|$80,'O'|$80,'P'|$80,'B'|$80
	.byte '.'|$80,'Z'|$80,'X'|$80,'0'|$80,'2'|$80,$00

ooc5_filename:	; .byte "OOC5.ZX02",0
	.byte 'O'|$80,'O'|$80,'C'|$80,'5'|$80
	.byte '.'|$80,'Z'|$80,'X'|$80,'0'|$80,'2'|$80,$00

fze_filename:	; .byte "FZE.ZX02",0
	.byte 'F'|$80,'Z'|$80,'E'|$80
	.byte '.'|$80,'Z'|$80,'X'|$80,'0'|$80,'2'|$80,$00

fjj_filename:	; .byte "FJJ.ZX02",0
	.byte 'F'|$80,'J'|$80,'J'|$80
	.byte '.'|$80,'Z'|$80,'X'|$80,'0'|$80,'2'|$80,$00

dadz_filename:	; .byte "DADZ.ZX02",0
	.byte 'D'|$80,'A'|$80,'D'|$80,'Z'|$80
	.byte '.'|$80,'Z'|$80,'X'|$80,'0'|$80,'2'|$80,$00

mope_filename:	; .byte "MOPE.ZX02",0
	.byte 'M'|$80,'O'|$80,'P'|$80,'E'|$80
	.byte '.'|$80,'Z'|$80,'X'|$80,'0'|$80,'2'|$80,$00

lh_filename:	; .byte "LH.ZX02",0
	.byte 'L'|$80,'H'|$80
	.byte '.'|$80,'Z'|$80,'X'|$80,'0'|$80,'2'|$80,$00

fcd_filename:	; .byte "FCD.ZX02",0
	.byte 'F'|$80,'C'|$80,'D'|$80
	.byte '.'|$80,'Z'|$80,'X'|$80,'0'|$80,'2'|$80,$00

facd_filename:	; .byte "FACD.ZX02",0
	.byte 'F'|$80,'A'|$80,'C'|$80,'D'|$80
	.byte '.'|$80,'Z'|$80,'X'|$80,'0'|$80,'2'|$80,$00

fif_filename:	; .byte "FIF.ZX02",0
	.byte 'F'|$80,'I'|$80,'F'|$80
	.byte '.'|$80,'Z'|$80,'X'|$80,'0'|$80,'2'|$80,$00

fif2_filename:	; .byte "FIF2.ZX02",0
	.byte 'F'|$80,'I'|$80,'F'|$80,'2'|$80
	.byte '.'|$80,'Z'|$80,'X'|$80,'0'|$80,'2'|$80,$00

oo4_filename:	; .byte "OO4.ZX02",0
	.byte 'O'|$80,'O'|$80,'4'|$80
	.byte '.'|$80,'Z'|$80,'X'|$80,'0'|$80,'2'|$80,$00

oo2_filename:	; .byte "OO2.ZX02",0
	.byte 'O'|$80,'O'|$80,'2'|$80
	.byte '.'|$80,'Z'|$80,'X'|$80,'0'|$80,'2'|$80,$00

fwq_filename:	; .byte "FWQ.ZX02",0
	.byte 'F'|$80,'W'|$80,'Q'|$80
	.byte '.'|$80,'Z'|$80,'X'|$80,'0'|$80,'2'|$80,$00

piz_filename:	; .byte "PIZ.ZX02",0
	.byte 'P'|$80,'I'|$80,'Z'|$80
	.byte '.'|$80,'Z'|$80,'X'|$80,'0'|$80,'2'|$80,$00

cit_filename:	; .byte "CIT.ZX02",0
	.byte 'C'|$80,'I'|$80,'T'|$80
	.byte '.'|$80,'Z'|$80,'X'|$80,'0'|$80,'2'|$80,$00

cel_filename:	; .byte "CEL.ZX02",0
	.byte 'C'|$80,'E'|$80,'L'|$80
	.byte '.'|$80,'Z'|$80,'X'|$80,'0'|$80,'2'|$80,$00

mug_filename:	; .byte "MUG.ZX02",0
	.byte 'M'|$80,'U'|$80,'G'|$80
	.byte '.'|$80,'Z'|$80,'X'|$80,'0'|$80,'2'|$80,$00

quad_filename:	; .byte "QUAD.ZX02",0
	.byte 'Q'|$80,'U'|$80,'A'|$80,'D'|$80
	.byte '.'|$80,'Z'|$80,'X'|$80,'0'|$80,'2'|$80,$00

gb_filename:	; .byte "GB.ZX02",0
	.byte 'G'|$80,'B'|$80
	.byte '.'|$80,'Z'|$80,'X'|$80,'0'|$80,'2'|$80,$00

jis_filename:	; .byte "JIS.ZX02",0
	.byte 'J'|$80,'I'|$80,'S'|$80
	.byte '.'|$80,'Z'|$80,'X'|$80,'0'|$80,'2'|$80,$00

ojm_filename:	; .byte "OJM.ZX02",0
	.byte 'O'|$80,'J'|$80,'M'|$80
	.byte '.'|$80,'Z'|$80,'X'|$80,'0'|$80,'2'|$80,$00

nda_filename:	; .byte "NDA.ZX02",0
	.byte 'N'|$80,'D'|$80,'A'|$80
	.byte '.'|$80,'Z'|$80,'X'|$80,'0'|$80,'2'|$80,$00

fri_filename:	; .byte "FRI.ZX02",0
	.byte 'F'|$80,'R'|$80,'I'|$80
	.byte '.'|$80,'Z'|$80,'X'|$80,'0'|$80,'2'|$80,$00

win_filename:	; .byte "WIN.ZX02",0
	.byte 'W'|$80,'I'|$80,'N'|$80
	.byte '.'|$80,'Z'|$80,'X'|$80,'0'|$80,'2'|$80,$00

bar_filename:	; .byte "BAR.ZX02",0
	.byte 'B'|$80,'A'|$80,'R'|$80
	.byte '.'|$80,'Z'|$80,'X'|$80,'0'|$80,'2'|$80,$00

ani_filename:	; .byte "ANI.ZX02",0
	.byte 'A'|$80,'N'|$80,'I'|$80
	.byte '.'|$80,'Z'|$80,'X'|$80,'0'|$80,'2'|$80,$00

gld_filename:	; .byte "GLD.ZX02",0
	.byte 'G'|$80,'L'|$80,'D'|$80
	.byte '.'|$80,'Z'|$80,'X'|$80,'0'|$80,'2'|$80,$00

rnu_filename:	; .byte "RNU.ZX02",0
	.byte 'R'|$80,'N'|$80,'U'|$80
	.byte '.'|$80,'Z'|$80,'X'|$80,'0'|$80,'2'|$80,$00

ooh_filename:	; .byte "OOH.ZX02",0
	.byte 'O'|$80,'O'|$80,'H'|$80
	.byte '.'|$80,'Z'|$80,'X'|$80,'0'|$80,'2'|$80,$00

two_filename:	; .byte "TWO.ZX02",0
	.byte 'T'|$80,'W'|$80,'O'|$80
	.byte '.'|$80,'Z'|$80,'X'|$80,'0'|$80,'2'|$80,$00

rug_filename:	; .byte "RUG.ZX02",0
	.byte 'R'|$80,'U'|$80,'G'|$80
	.byte '.'|$80,'Z'|$80,'X'|$80,'0'|$80,'2'|$80,$00

ndz_filename:	; .byte "NDZ.ZX02",0
	.byte 'N'|$80,'D'|$80,'Z'|$80
	.byte '.'|$80,'Z'|$80,'X'|$80,'0'|$80,'2'|$80,$00

crd_filename:	; .byte "CRD.ZX02",0
	.byte 'C'|$80,'R'|$80,'D'|$80
	.byte '.'|$80,'Z'|$80,'X'|$80,'0'|$80,'2'|$80,$00

gfa_filename:	; .byte "GFA.ZX02",0
	.byte 'G'|$80,'F'|$80,'A'|$80
	.byte '.'|$80,'Z'|$80,'X'|$80,'0'|$80,'2'|$80,$00

sxy_filename:	; .byte "SXY.ZX02",0
	.byte 'S'|$80,'X'|$80,'Y'|$80
	.byte '.'|$80,'Z'|$80,'X'|$80,'0'|$80,'2'|$80,$00

