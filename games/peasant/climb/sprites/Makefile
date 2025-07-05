HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite
ZX02 = ~/research/6502_compression/zx02.git/build/zx02
LINKER_SCRIPTS = ../../../../linker_scripts

all:	enemy_sprites.inc climbing_sprites.zx02

####

enemy_sprites.inc:     enemy_sprites.png
	$(HGR_SPRITE) -l bird0_sprite enemy_sprites.png 210 50 230 66 > enemy_sprites.inc
	$(HGR_SPRITE) -l bird0_mask   enemy_sprites.png 238 50 258 66 >> enemy_sprites.inc
	$(HGR_SPRITE) -l bird1_sprite enemy_sprites.png 210 74 230 88 >> enemy_sprites.inc
	$(HGR_SPRITE) -l bird1_mask   enemy_sprites.png 238 74 258 88 >> enemy_sprites.inc
	$(HGR_SPRITE) -l bigrock0_sprite enemy_sprites.png 14  7 34 30 >> enemy_sprites.inc
	$(HGR_SPRITE) -l bigrock0_mask   enemy_sprites.png 42  7 62 30 >> enemy_sprites.inc
	$(HGR_SPRITE) -l bigrock1_sprite enemy_sprites.png 14 35 34 57 >> enemy_sprites.inc
	$(HGR_SPRITE) -l bigrock1_mask   enemy_sprites.png 42 35 62 57 >> enemy_sprites.inc
	$(HGR_SPRITE) -l bigrock2_sprite enemy_sprites.png 14 63 34 84 >> enemy_sprites.inc
	$(HGR_SPRITE) -l bigrock2_mask   enemy_sprites.png 42 63 62 84 >> enemy_sprites.inc
	$(HGR_SPRITE) -l bigrock3_sprite enemy_sprites.png 14 91 34 113 >> enemy_sprites.inc
	$(HGR_SPRITE) -l bigrock3_mask   enemy_sprites.png 42 91 62 113 >> enemy_sprites.inc
	$(HGR_SPRITE) -l bigrock_crash0_sprite enemy_sprites.png 14 119 34 137 >> enemy_sprites.inc
	$(HGR_SPRITE) -l bigrock_crash0_mask   enemy_sprites.png 42 119 62 137 >> enemy_sprites.inc
	$(HGR_SPRITE) -l bigrock_crash1_sprite enemy_sprites.png 14 147 41 168 >> enemy_sprites.inc
	$(HGR_SPRITE) -l bigrock_crash1_mask   enemy_sprites.png 56 147 83 168 >> enemy_sprites.inc
	$(HGR_SPRITE) -l smallrock0_sprite enemy_sprites.png  98  7 111 22 >> enemy_sprites.inc
	$(HGR_SPRITE) -l smallrock0_mask   enemy_sprites.png 126  7 139 22 >> enemy_sprites.inc
	$(HGR_SPRITE) -l smallrock1_sprite enemy_sprites.png  98 35 111 49 >> enemy_sprites.inc
	$(HGR_SPRITE) -l smallrock1_mask   enemy_sprites.png 126 35 139 49 >> enemy_sprites.inc
	$(HGR_SPRITE) -l smallrock2_sprite enemy_sprites.png  98 63 111 78 >> enemy_sprites.inc
	$(HGR_SPRITE) -l smallrock2_mask   enemy_sprites.png 126 63 139 78 >> enemy_sprites.inc
	$(HGR_SPRITE) -l smallrock3_sprite enemy_sprites.png  98 91 111 105 >> enemy_sprites.inc
	$(HGR_SPRITE) -l smallrock3_mask   enemy_sprites.png 126 91 139 105 >> enemy_sprites.inc
	$(HGR_SPRITE) -l smallrock_crash0_sprite enemy_sprites.png 98 119 111 134 >> enemy_sprites.inc
	$(HGR_SPRITE) -l smallrock_crash0_mask   enemy_sprites.png 126 119 139 134 >> enemy_sprites.inc
	$(HGR_SPRITE) -l smallrock_crash1_sprite enemy_sprites.png 126 147 153 166 >> enemy_sprites.inc
	$(HGR_SPRITE) -l smallrock_crash1_mask   enemy_sprites.png 168 147 195 165 >> enemy_sprites.inc


clean:	
	rm -f *~ *.zx02 enemy_sprites.inc


####

climbing_sprites.zx02:	climbing_sprites
	$(ZX02) -f climbing_sprites climbing_sprites.zx02

climbing_sprites:	climbing_sprites.o
	ld65 -o climbing_sprites climbing_sprites.o -C $(LINKER_SCRIPTS)/apple2_b000.inc

climbing_sprites.o:	climbing_sprites.s \
	climb_flame_sprites.inc \
	climb_sprites.inc
	ca65 -o climbing_sprites.o climbing_sprites.s -l climbing_sprites.lst

####

climb_sprites.inc:     climb_sprites.png
	$(HGR_SPRITE) -l climb_r0_sprite climb_sprites.png 126 129 146 159 > climb_sprites.inc
	$(HGR_SPRITE) -l climb_r0_mask   climb_sprites.png 126 161 146 191 >> climb_sprites.inc
	$(HGR_SPRITE) -l climb_r1_sprite climb_sprites.png 154 129 174 159 >> climb_sprites.inc
	$(HGR_SPRITE) -l climb_r1_mask   climb_sprites.png 154 161 174 191 >> climb_sprites.inc
	$(HGR_SPRITE) -l climb_r2_sprite climb_sprites.png 182 129 202 159 >> climb_sprites.inc
	$(HGR_SPRITE) -l climb_r2_mask   climb_sprites.png 182 161 202 191 >> climb_sprites.inc
	$(HGR_SPRITE) -l climb_r3_sprite climb_sprites.png 210 129 230 159 >> climb_sprites.inc
	$(HGR_SPRITE) -l climb_r3_mask   climb_sprites.png 210 161 230 191 >> climb_sprites.inc
	$(HGR_SPRITE) -l climb_l0_sprite climb_sprites.png 126  33 146  63 >> climb_sprites.inc
	$(HGR_SPRITE) -l climb_l0_mask   climb_sprites.png 126  65 146  95 >> climb_sprites.inc
	$(HGR_SPRITE) -l climb_l1_sprite climb_sprites.png 154  33 174  63 >> climb_sprites.inc
	$(HGR_SPRITE) -l climb_l1_mask   climb_sprites.png 154  65 174  95 >> climb_sprites.inc
	$(HGR_SPRITE) -l climb_l2_sprite climb_sprites.png 182  33 202  63 >> climb_sprites.inc
	$(HGR_SPRITE) -l climb_l2_mask   climb_sprites.png 182  65 202  95 >> climb_sprites.inc
	$(HGR_SPRITE) -l climb_l3_sprite climb_sprites.png 210  33 230  63 >> climb_sprites.inc
	$(HGR_SPRITE) -l climb_l3_mask   climb_sprites.png 210  65 230  95 >> climb_sprites.inc
	$(HGR_SPRITE) -l climb_u0_sprite climb_sprites.png  14  33  34  64 >> climb_sprites.inc
	$(HGR_SPRITE) -l climb_u0_mask   climb_sprites.png  14  66  34  97 >> climb_sprites.inc
	$(HGR_SPRITE) -l climb_u1_sprite climb_sprites.png  42  33  62  64 >> climb_sprites.inc
	$(HGR_SPRITE) -l climb_u1_mask   climb_sprites.png  42  66  62  97 >> climb_sprites.inc
	$(HGR_SPRITE) -l climb_u2_sprite climb_sprites.png  70  33  90  64 >> climb_sprites.inc
	$(HGR_SPRITE) -l climb_u2_mask   climb_sprites.png  70  66  90  97 >> climb_sprites.inc
	$(HGR_SPRITE) -l climb_u3_sprite climb_sprites.png  98  33 118  64 >> climb_sprites.inc
	$(HGR_SPRITE) -l climb_u3_mask   climb_sprites.png  98  66 118  97 >> climb_sprites.inc
	$(HGR_SPRITE) -l climb_f0_sprite climb_sprites.png  14 126  34 147 >> climb_sprites.inc
	$(HGR_SPRITE) -l climb_f0_mask   climb_sprites.png  14 154  34 175 >> climb_sprites.inc
	$(HGR_SPRITE) -l climb_f1_sprite climb_sprites.png  42 126  62 147 >> climb_sprites.inc
	$(HGR_SPRITE) -l climb_f1_mask   climb_sprites.png  42 154  62 175 >> climb_sprites.inc
	$(HGR_SPRITE) -l climb_f2_sprite climb_sprites.png  70 126  90 147 >> climb_sprites.inc
	$(HGR_SPRITE) -l climb_f2_mask   climb_sprites.png  70 154  90 175 >> climb_sprites.inc
	$(HGR_SPRITE) -l climb_f3_sprite climb_sprites.png  98 126 118 147 >> climb_sprites.inc
	$(HGR_SPRITE) -l climb_f3_mask   climb_sprites.png  98 154 118 175 >> climb_sprites.inc
	$(HGR_SPRITE) -l climb_s0_sprite climb_sprites.png 238  25 258  46 >> climb_sprites.inc
	$(HGR_SPRITE) -l climb_s0_mask   climb_sprites.png 238  49 258  70 >> climb_sprites.inc
	$(HGR_SPRITE) -l climb_s1_sprite climb_sprites.png 238 121 258 142 >> climb_sprites.inc
	$(HGR_SPRITE) -l climb_s1_mask   climb_sprites.png 238 145 258 166 >> climb_sprites.inc

climb_flame_sprites.inc:     climb_flame_sprites.png
	$(HGR_SPRITE) -l flame_r0_sprite climb_flame_sprites.png  14  25  27  34 > climb_flame_sprites.inc
	$(HGR_SPRITE) -l flame_r0_mask   climb_flame_sprites.png  14  35  27  44 >> climb_flame_sprites.inc
	$(HGR_SPRITE) -l flame_r1_sprite climb_flame_sprites.png  42  25  55  34 >> climb_flame_sprites.inc
	$(HGR_SPRITE) -l flame_r1_mask   climb_flame_sprites.png  42  35  55  44 >> climb_flame_sprites.inc
	$(HGR_SPRITE) -l flame_r2_sprite climb_flame_sprites.png  70  25  83  34 >> climb_flame_sprites.inc
	$(HGR_SPRITE) -l flame_r2_mask   climb_flame_sprites.png  70  35  83  44 >> climb_flame_sprites.inc
	$(HGR_SPRITE) -l flame_l0_sprite climb_flame_sprites.png  98  25 118  34 >> climb_flame_sprites.inc
	$(HGR_SPRITE) -l flame_l0_mask   climb_flame_sprites.png  98  35 118  44 >> climb_flame_sprites.inc
	$(HGR_SPRITE) -l flame_l1_sprite climb_flame_sprites.png 126  25 146  34 >> climb_flame_sprites.inc
	$(HGR_SPRITE) -l flame_l1_mask   climb_flame_sprites.png 126  35 146  44 >> climb_flame_sprites.inc
	$(HGR_SPRITE) -l flame_l2_sprite climb_flame_sprites.png 154  25 174  34 >> climb_flame_sprites.inc
	$(HGR_SPRITE) -l flame_l2_mask   climb_flame_sprites.png 154  35 174  44 >> climb_flame_sprites.inc
	$(HGR_SPRITE) -l flame_u0_sprite climb_flame_sprites.png  14 147  27 156 >> climb_flame_sprites.inc
	$(HGR_SPRITE) -l flame_u0_mask   climb_flame_sprites.png  14 157  27 166 >> climb_flame_sprites.inc
	$(HGR_SPRITE) -l flame_u1_sprite climb_flame_sprites.png  42 147  55 156 >> climb_flame_sprites.inc
	$(HGR_SPRITE) -l flame_u1_mask   climb_flame_sprites.png  42 157  55 166 >> climb_flame_sprites.inc
	$(HGR_SPRITE) -l flame_u2_sprite climb_flame_sprites.png  70 147  83 156 >> climb_flame_sprites.inc
	$(HGR_SPRITE) -l flame_u2_mask   climb_flame_sprites.png  70 157  83 166 >> climb_flame_sprites.inc
	$(HGR_SPRITE) -l flame_d0_sprite climb_flame_sprites.png  98 147 111 156 >> climb_flame_sprites.inc
	$(HGR_SPRITE) -l flame_d0_mask   climb_flame_sprites.png  98 157 111 166 >> climb_flame_sprites.inc
	$(HGR_SPRITE) -l flame_d1_sprite climb_flame_sprites.png 126 147 139 156 >> climb_flame_sprites.inc
	$(HGR_SPRITE) -l flame_d1_mask   climb_flame_sprites.png 126 157 139 166 >> climb_flame_sprites.inc
	$(HGR_SPRITE) -l flame_d2_sprite climb_flame_sprites.png 154 147 167 156 >> climb_flame_sprites.inc
	$(HGR_SPRITE) -l flame_d2_mask   climb_flame_sprites.png 154 157 167 166 >> climb_flame_sprites.inc



