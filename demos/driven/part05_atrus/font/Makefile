
HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite
HGR_LARGEFONT = ../../../../utils/hgr-utils/png2largefont

all:	font.inc large_font.inc

large_font.inc:	a2_big_font.png
	$(HGR_LARGEFONT) -r a2_big_font.png > large_font.inc

font.inc:	a2_big_font.png
	$(HGR_SPRITE) -l font_space a2_big_font.png  0  0  13 16 > font.inc
	$(HGR_SPRITE) -l font_A a2_big_font.png     14  0  27 16 >> font.inc
	$(HGR_SPRITE) -l font_B a2_big_font.png     28  0  41 16 >> font.inc
	$(HGR_SPRITE) -l font_C a2_big_font.png     42  0  55 16 >> font.inc
	$(HGR_SPRITE) -l font_D a2_big_font.png     56  0  69 16 >> font.inc
	$(HGR_SPRITE) -l font_E a2_big_font.png     70  0  83 16 >> font.inc
	$(HGR_SPRITE) -l font_F a2_big_font.png     84  0  97 16 >> font.inc
	$(HGR_SPRITE) -l font_G a2_big_font.png     98  0 111 16 >> font.inc
	$(HGR_SPRITE) -l font_H a2_big_font.png    112  0 125 16 >> font.inc
	$(HGR_SPRITE) -l font_I a2_big_font.png    126  0 139 16 >> font.inc
	$(HGR_SPRITE) -l font_J a2_big_font.png    140  0 153 16 >> font.inc
	$(HGR_SPRITE) -l font_K a2_big_font.png    154  0 167 16 >> font.inc
	$(HGR_SPRITE) -l font_L a2_big_font.png    168  0 181 16 >> font.inc
	$(HGR_SPRITE) -l font_M a2_big_font.png    182  0 195 16 >> font.inc
	$(HGR_SPRITE) -l font_N a2_big_font.png    196  0 209 16 >> font.inc
	$(HGR_SPRITE) -l font_O a2_big_font.png    210  0 223 16 >> font.inc
	$(HGR_SPRITE) -l font_P a2_big_font.png      0  18  13 34 >> font.inc
	$(HGR_SPRITE) -l font_Q a2_big_font.png     14  18  27 34 >> font.inc
	$(HGR_SPRITE) -l font_R a2_big_font.png     28  18  41 34 >> font.inc
	$(HGR_SPRITE) -l font_S a2_big_font.png     42  18  55 34 >> font.inc
	$(HGR_SPRITE) -l font_T a2_big_font.png     56  18  69 34 >> font.inc
	$(HGR_SPRITE) -l font_U a2_big_font.png     70  18  83 34 >> font.inc
	$(HGR_SPRITE) -l font_V a2_big_font.png     84  18  97 34 >> font.inc
	$(HGR_SPRITE) -l font_W a2_big_font.png     98  18 111 34 >> font.inc
	$(HGR_SPRITE) -l font_X a2_big_font.png    112  18 125 34 >> font.inc
	$(HGR_SPRITE) -l font_Y a2_big_font.png    126  18 139 34 >> font.inc
	$(HGR_SPRITE) -l font_Z a2_big_font.png    140  18 153 34 >> font.inc
	$(HGR_SPRITE) -l font_PERIOD a2_big_font.png    154  18 167 34 >> font.inc
	$(HGR_SPRITE) -l font_SHORA1 a2_big_font.png    168  18 181 34 >> font.inc
	$(HGR_SPRITE) -l font_SHORA2 a2_big_font.png    182  18 195 34 >> font.inc
	$(HGR_SPRITE) -l font_SHORA3 a2_big_font.png    196  18 209 34 >> font.inc
	$(HGR_SPRITE) -l font_SHORA4 a2_big_font.png    210  18 223 34 >> font.inc



clean:
	rm -f *~ \
		font.inc large_font.inc
