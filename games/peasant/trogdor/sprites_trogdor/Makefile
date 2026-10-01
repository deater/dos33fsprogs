HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite

all:	trogdor_sprites.inc sleep_sprites.inc tiny_dashing.inc sleep_flame.inc

tiny_dashing.inc:	trogdor_sprites.png
	$(HGR_SPRITE) -l tiny0r_sprite trogdor_sprites.png  70 99  83 104 > tiny_dashing.inc
	$(HGR_SPRITE) -l tiny1r_sprite trogdor_sprites.png  84 99  97 104 >> tiny_dashing.inc
	$(HGR_SPRITE) -l tiny2r_sprite trogdor_sprites.png  98 99 111 104 >> tiny_dashing.inc
	$(HGR_SPRITE) -l tiny3r_sprite trogdor_sprites.png 112 99 125 104 >> tiny_dashing.inc
	$(HGR_SPRITE) -l tiny0r_mask trogdor_sprites.png    70 113  83 118 >> tiny_dashing.inc
	$(HGR_SPRITE) -l tiny1r_mask trogdor_sprites.png    84 113  97 118 >> tiny_dashing.inc
	$(HGR_SPRITE) -l tiny2r_mask trogdor_sprites.png    98 113 111 118 >> tiny_dashing.inc
	$(HGR_SPRITE) -l tiny3r_mask trogdor_sprites.png   112 113 125 118 >> tiny_dashing.inc


sleep_flame.inc:	sleep_flame.png
	$(HGR_SPRITE) -l little_flame_sprite sleep_flame.png  147 39 174  59 > sleep_flame.inc
	$(HGR_SPRITE) -l big_flame_sprite    sleep_flame.png   63 35 132  77 >> sleep_flame.inc
	$(HGR_SPRITE) -l little_flame_mask   sleep_flame.png  147 88 174 108 >> sleep_flame.inc
	$(HGR_SPRITE) -l big_flame_mask      sleep_flame.png   63 84 132 126 >> sleep_flame.inc





sleep_sprites.inc:	sleep_sprites.png
	$(HGR_SPRITE) -s -l sleep_sprite0 sleep_sprites.png  14  26  69  44 > sleep_sprites.inc
	$(HGR_SPRITE) -s -l sleep_sprite1 sleep_sprites.png  14  44  69  62 >> sleep_sprites.inc
	$(HGR_SPRITE) -s -l smoke0_sprite sleep_sprites.png   7 130  20 139 >> sleep_sprites.inc
	$(HGR_SPRITE) -s -l smoke1_sprite sleep_sprites.png  35 118  48 138 >> sleep_sprites.inc
	$(HGR_SPRITE) -s -l smoke2_sprite sleep_sprites.png  63 111  76 133 >> sleep_sprites.inc
	$(HGR_SPRITE) -s -l smoke3_sprite sleep_sprites.png  91 103 104 114 >> sleep_sprites.inc
	$(HGR_SPRITE) -s -l smoke4_sprite sleep_sprites.png 217  96 230 107 >> sleep_sprites.inc
	$(HGR_SPRITE) -s -l smoke5_sprite sleep_sprites.png 245  87 265 101 >> sleep_sprites.inc

trogdor_sprites.inc:	trogdor_sprites.png
	$(HGR_SPRITE) -s -l dashing0_sprite trogdor_sprites.png 14 6 20 45 > trogdor_sprites.inc
	$(HGR_SPRITE) -s -l dashing1_sprite trogdor_sprites.png 28 6 34 45 >> trogdor_sprites.inc
	$(HGR_SPRITE) -s -l dashing2_sprite trogdor_sprites.png 42 6 48 45 >> trogdor_sprites.inc
	$(HGR_SPRITE) -s -l dashing3_sprite trogdor_sprites.png 56 6 62 45 >> trogdor_sprites.inc
	$(HGR_SPRITE) -s -l dashing4_sprite trogdor_sprites.png 70 6 76 45 >> trogdor_sprites.inc
	$(HGR_SPRITE) -s -l dashing5_sprite trogdor_sprites.png 84 6 90 45 >> trogdor_sprites.inc
	$(HGR_SPRITE) -s -l dashing6_sprite trogdor_sprites.png 98 6 104 45 >> trogdor_sprites.inc
	$(HGR_SPRITE) -s -l dashing7_sprite trogdor_sprites.png 112 6 118 45 >> trogdor_sprites.inc
	$(HGR_SPRITE) -s -l dashing8_sprite trogdor_sprites.png 126 6 132 45 >> trogdor_sprites.inc
	$(HGR_SPRITE) -s -l tiny_r1_sprite trogdor_sprites.png 14 49 20 54 >> trogdor_sprites.inc
	$(HGR_SPRITE) -s -l tiny_r2_sprite trogdor_sprites.png 28 49 34 54 >> trogdor_sprites.inc
	$(HGR_SPRITE) -s -l tiny_l1_sprite trogdor_sprites.png 14 56 20 61 >> trogdor_sprites.inc
	$(HGR_SPRITE) -s -l tiny_l2_sprite trogdor_sprites.png 28 56 34 61 >> trogdor_sprites.inc
	$(HGR_SPRITE) -s -l sword1_sprite trogdor_sprites.png 42 48 48 53 >> trogdor_sprites.inc
	$(HGR_SPRITE) -s -l sword2_sprite trogdor_sprites.png 49 48 55 53 >> trogdor_sprites.inc
	$(HGR_SPRITE) -s -l sword3_sprite trogdor_sprites.png 56 48 62 53 >> trogdor_sprites.inc
	$(HGR_SPRITE) -s -l sword4_sprite trogdor_sprites.png 63 48 69 53 >> trogdor_sprites.inc
	$(HGR_SPRITE) -s -l sword5_sprite trogdor_sprites.png 70 48 76 53 >> trogdor_sprites.inc
	$(HGR_SPRITE) -s -l sword6_sprite trogdor_sprites.png 77 48 83 53 >> trogdor_sprites.inc


clean:
	rm -f *~ trogdor_sprites.inc sleep_sprites.inc tiny_dashing.inc sleep_flame.inc
