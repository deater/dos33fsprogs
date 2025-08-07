HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite

all:	haystack_gone_sprite.inc jump_in_hay_sprite.inc \
	haystack_sprite.inc

# 189 49 244 96
haystack_gone_sprite.inc:	haystack_gone.png
	$(HGR_SPRITE) -s -l hg_sprite0 haystack_gone.png 189  49 244  73 > haystack_gone_sprite.inc


haystack_sprite.inc:	haystack.png
	$(HGR_SPRITE) -l haystack_sprite0 haystack.png  14  52  55  94 > haystack_sprite.inc
	$(HGR_SPRITE) -l haystack_sprite1 haystack.png  70  52 111  94 >> haystack_sprite.inc
	$(HGR_SPRITE) -l haystack_sprite2 haystack.png 126  52 167  94 >> haystack_sprite.inc
	$(HGR_SPRITE) -l haystack_mask0	  haystack.png  14  97  55 139 >> haystack_sprite.inc
	$(HGR_SPRITE) -l haystack_mask1   haystack.png  70  97 111 139 >> haystack_sprite.inc
	$(HGR_SPRITE) -l haystack_mask2   haystack.png 126  97 167 139 >> haystack_sprite.inc

jump_in_hay_sprite.inc:	jump_in_hay.png
	$(HGR_SPRITE) -l jump_sprite0 jump_in_hay.png  14 133  27 157 > jump_in_hay_sprite.inc
	$(HGR_SPRITE) -l jump_sprite1 jump_in_hay.png  42 134  55 157 >> jump_in_hay_sprite.inc
	$(HGR_SPRITE) -l jump_sprite2 jump_in_hay.png  70 127  83 157 >> jump_in_hay_sprite.inc
	$(HGR_SPRITE) -l jump_sprite3 jump_in_hay.png  98 129 118 157 >> jump_in_hay_sprite.inc
	$(HGR_SPRITE) -l jump_sprite4 jump_in_hay.png 126 140 153 157 >> jump_in_hay_sprite.inc
	$(HGR_SPRITE) -l jump_sprite5 jump_in_hay.png 168 138 195 157 >> jump_in_hay_sprite.inc
	$(HGR_SPRITE) -l jump_sprite6 jump_in_hay.png 210 148 223 157 >> jump_in_hay_sprite.inc
	$(HGR_SPRITE) -l jump_mask0 jump_in_hay.png  14 166  27 190 >> jump_in_hay_sprite.inc
	$(HGR_SPRITE) -l jump_mask1 jump_in_hay.png  42 167  55 190 >> jump_in_hay_sprite.inc
	$(HGR_SPRITE) -l jump_mask2 jump_in_hay.png  70 159  83 190 >> jump_in_hay_sprite.inc
	$(HGR_SPRITE) -l jump_mask3 jump_in_hay.png  98 162 118 190 >> jump_in_hay_sprite.inc
	$(HGR_SPRITE) -l jump_mask4 jump_in_hay.png 126 173 153 190 >> jump_in_hay_sprite.inc
	$(HGR_SPRITE) -l jump_mask5 jump_in_hay.png 168 171 195 190 >> jump_in_hay_sprite.inc
	$(HGR_SPRITE) -l jump_mask6 jump_in_hay.png 210 181 223 190 >> jump_in_hay_sprite.inc







clean:
	rm -f *~ haystack_gone_sprite.inc jump_in_hay_sprite.inc \
		haystack_sprite.inc
