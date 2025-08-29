HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite

all:	ned_sprites.inc

# 84,98 ->132,133
# 84,98 -> 132,115
# 84,115 -> 132,133

ned_sprites.inc:	ned_sprites.png
	$(HGR_SPRITE) -s -l rock_moved_sprite ned_sprites.png 161 144 181 155 > ned_sprites.inc
	$(HGR_SPRITE) -s -l door_open_top_sprite ned_sprites.png   84  98 132 115 >> ned_sprites.inc
	$(HGR_SPRITE) -s -l door_open_bottom_sprite ned_sprites.png   84  115 132 133 >> ned_sprites.inc

clean:
	rm -f *~ ned_sprites.inc

