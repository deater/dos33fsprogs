HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite

all:	gary_sprites.inc gary_bg.inc gary_scare.inc

gary_sprites.inc:	gary_sprites.png
	$(HGR_SPRITE) -s -l gary_base_sprite gary_sprites.png   21  98 55   124 > gary_sprites.inc
	$(HGR_SPRITE) -s -l gary_fly1_sprite gary_sprites.png   63  98 76   117 >> gary_sprites.inc
	$(HGR_SPRITE) -s -l gary_fly2_sprite gary_sprites.png   91  98 104  117 >> gary_sprites.inc
	$(HGR_SPRITE) -s -l gary_tail1_sprite gary_sprites.png 119  98 132  117 >> gary_sprites.inc
	$(HGR_SPRITE) -s -l gary_tail2_sprite gary_sprites.png 147  98 160  117 >> gary_sprites.inc
	$(HGR_SPRITE) -s -l gary_foot0_sprite gary_sprites.png  63 118  76  128 >> gary_sprites.inc
	$(HGR_SPRITE) -s -l gary_foot1_sprite gary_sprites.png  91 118 104  128 >> gary_sprites.inc
	$(HGR_SPRITE) -s -l gary_foot2_sprite gary_sprites.png 119 118 132  128 >> gary_sprites.inc

gary_bg.inc:	gary_bg.png
	$(HGR_SPRITE) -s -l gary_bg_sprite gary_bg.png   0  101 34   161 > gary_bg.inc

gary_scare.inc:	gary_scare.png gary_fence.png
	$(HGR_SPRITE) -s -l peasant_mask gary_scare.png 105 119  118 127 > gary_scare.inc
	$(HGR_SPRITE) -s -l gary_rear0 gary_scare.png    49 120   97 146 >> gary_scare.inc
	$(HGR_SPRITE) -s -l gary_rear1 gary_scare.png    49  62   97  90 >> gary_scare.inc
	$(HGR_SPRITE) -s -l gary_rear2 gary_scare.png    49  27   90  58 >> gary_scare.inc
	$(HGR_SPRITE) -s -l gary_rear3 gary_scare.png    49 156   90 190 >> gary_scare.inc
	$(HGR_SPRITE) -s -l gary_run0 gary_fence.png     42 115   90 146 >> gary_scare.inc
	$(HGR_SPRITE) -s -l gary_run1 gary_fence.png     21  82   69 111 >> gary_scare.inc
	$(HGR_SPRITE) -s -l gary_run2 gary_fence.png      7  52   55  79 >> gary_scare.inc
	$(HGR_SPRITE) -s -l gary_run3 gary_fence.png    140 102  195 162 >> gary_scare.inc
	$(HGR_SPRITE) -s -l gary_run4 gary_fence.png    140  37  181  97 >> gary_scare.inc
	$(HGR_SPRITE) -s -l gary_run5 gary_fence.png     84  37  125  97 >> gary_scare.inc




clean:
	rm -f *~ gary_sprites.inc gary_bg.inc gary_scare.inc
