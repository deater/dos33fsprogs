HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite

all:	trogdor_sprites.inc sleep_sprites.inc

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
#	$(HGR_SPRITE) -s -l smoke1_sprite trogdor_sprites.png 14 62 20 69 >> trogdor_sprites.inc
#	$(HGR_SPRITE) -s -l smoke2_sprite trogdor_sprites.png 28 62 34 69 >> trogdor_sprites.inc
#	$(HGR_SPRITE) -s -l smoke3_sprite trogdor_sprites.png 42 62 48 69 >> trogdor_sprites.inc
#	$(HGR_SPRITE) -s -l smoke4_sprite trogdor_sprites.png 56 62 62 69 >> trogdor_sprites.inc
#	$(HGR_SPRITE) -s -l smoke5_sprite trogdor_sprites.png 70 62 76 69 >> trogdor_sprites.inc
#	$(HGR_SPRITE) -s -l sleep1_sprite trogdor_sprites.png 14 70 27 79 >> trogdor_sprites.inc
#	$(HGR_SPRITE) -s -l sleep2_sprite trogdor_sprites.png 28 70 41 79 >> trogdor_sprites.inc


clean:
	rm -f *~ trogdor_sprites.inc sleep_sprites.inc
