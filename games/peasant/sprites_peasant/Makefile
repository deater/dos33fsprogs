HGR_SPRITE = ../../../utils/hgr-utils/hgr_make_sprite
ZX02 = ~/research/6502_compression/zx02.git/build/zx02
LINKER_SCRIPTS = ../../../linker_scripts

all:	walk_sprites.inc climb_flame_sprites.inc \
	climb_sprites.inc robe_sprites.inc flame_sprites.inc \
	walking_sprites.zx02 \
	climbing_sprites.zx02 \
	robe_sprites.zx02 robe_sprites_orange.zx02 robe_sprites_purple.zx02 \
	robe_shield_sprites.zx02 \
	PEASANT_SPRITES_COMMON


####

PEASANT_SPRITES_COMMON:	peasant_sprite_common.o
	ld65 -o PEASANT_SPRITES_COMMON peasant_sprite_common.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

peasant_sprite_common.o:	peasant_sprite_common.s \
	walking_sprites.zx02 \
	robe_sprites.zx02
	ca65 -o peasant_sprite_common.o peasant_sprite_common.s -l peasant_sprite_common.lst


####

climbing_sprites.zx02:	climbing_sprites
	$(ZX02) -f climbing_sprites climbing_sprites.zx02

climbing_sprites:	climbing_sprites.o
	ld65 -o climbing_sprites climbing_sprites.o -C $(LINKER_SCRIPTS)/apple2_a000.inc

climbing_sprites.o:	climbing_sprites.s \
	climb_flame_sprites.inc \
	climb_sprites.inc
	ca65 -o climbing_sprites.o climbing_sprites.s -l climbing_sprites.lst

####

walking_sprites.zx02:	walking_sprites
	$(ZX02) -f walking_sprites walking_sprites.zx02

walking_sprites:	walking_sprites.o
	ld65 -o walking_sprites walking_sprites.o -C $(LINKER_SCRIPTS)/apple2_a000.inc

walking_sprites.o:	walking_sprites.s \
	flame_sprites.inc walk_sprites.inc
	ca65 -o walking_sprites.o walking_sprites.s -l walking_sprites.lst

####

robe_sprites.zx02:	robe_sprites
	$(ZX02) -f robe_sprites robe_sprites.zx02

robe_sprites:	robe_sprites.o
	ld65 -o robe_sprites robe_sprites.o -C $(LINKER_SCRIPTS)/apple2_a000.inc

robe_sprites.o:	robe_sprites.s \
	flame_sprites.inc robe_sprites.inc
	ca65 -o robe_sprites.o robe_sprites.s -l robe_sprites.lst

####

robe_shield_sprites.zx02:	robe_shield_sprites
	$(ZX02) -f robe_shield_sprites robe_shield_sprites.zx02

robe_shield_sprites:	robe_shield_sprites.o
	ld65 -o robe_shield_sprites robe_shield_sprites.o -C $(LINKER_SCRIPTS)/apple2_a000.inc

robe_shield_sprites.o:	robe_shield_sprites.s \
	flame_sprites.inc robe_shield_sprites.inc
	ca65 -o robe_shield_sprites.o robe_shield_sprites.s -l robe_shield_sprites.lst


####

robe_sprites_purple.zx02:	robe_sprites_purple
	$(ZX02) -f robe_sprites_purple robe_sprites_purple.zx02

robe_sprites_purple:	robe_sprites_purple.o
	ld65 -o robe_sprites_purple robe_sprites_purple.o -C $(LINKER_SCRIPTS)/apple2_a000.inc

robe_sprites_purple.o:	robe_sprites_purple.s \
	flame_sprites.inc robe_sprites_purple.inc
	ca65 -o robe_sprites_purple.o robe_sprites_purple.s -l robe_sprites_purple.lst

####

robe_sprites_orange.zx02:	robe_sprites_orange
	$(ZX02) -f robe_sprites_orange robe_sprites_orange.zx02

robe_sprites_orange:	robe_sprites_orange.o
	ld65 -o robe_sprites_orange robe_sprites_orange.o -C $(LINKER_SCRIPTS)/apple2_a000.inc

robe_sprites_orange.o:	robe_sprites_orange.s \
	flame_sprites.inc robe_sprites_orange.inc
	ca65 -o robe_sprites_orange.o robe_sprites_orange.s -l robe_sprites_orange.lst

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

robe_sprites.inc:     robe_sprites.png
	$(HGR_SPRITE) -l robe_r0_sprite robe_sprites.png  14  32  27  62 > robe_sprites.inc
	$(HGR_SPRITE) -l robe_r0_mask   robe_sprites.png  14  63  27  93 >> robe_sprites.inc
	$(HGR_SPRITE) -l robe_r1_sprite robe_sprites.png  42  32  53  62 >> robe_sprites.inc
	$(HGR_SPRITE) -l robe_r1_mask   robe_sprites.png  42  63  53  93 >> robe_sprites.inc
	$(HGR_SPRITE) -l robe_r2_sprite robe_sprites.png  70  32  83  62 >> robe_sprites.inc
	$(HGR_SPRITE) -l robe_r2_mask   robe_sprites.png  70  63  83  93 >> robe_sprites.inc
	$(HGR_SPRITE) -l robe_r3_sprite robe_sprites.png  98  32 111  62 >> robe_sprites.inc
	$(HGR_SPRITE) -l robe_r3_mask   robe_sprites.png  98  63 111  93 >> robe_sprites.inc
	$(HGR_SPRITE) -l robe_r4_sprite robe_sprites.png 126  32 139  62 >> robe_sprites.inc
	$(HGR_SPRITE) -l robe_r4_mask   robe_sprites.png 126  63 139  93 >> robe_sprites.inc
	$(HGR_SPRITE) -l robe_r5_sprite robe_sprites.png 154  32 167  62 >> robe_sprites.inc
	$(HGR_SPRITE) -l robe_r5_mask   robe_sprites.png 154  63 167  93 >> robe_sprites.inc
	$(HGR_SPRITE) -l robe_l0_sprite robe_sprites.png  14 128  27 158 >> robe_sprites.inc
	$(HGR_SPRITE) -l robe_l0_mask   robe_sprites.png  14 159  27 189 >> robe_sprites.inc
	$(HGR_SPRITE) -l robe_l1_sprite robe_sprites.png  42 128  53 158 >> robe_sprites.inc
	$(HGR_SPRITE) -l robe_l1_mask   robe_sprites.png  42 159  53 189 >> robe_sprites.inc
	$(HGR_SPRITE) -l robe_l2_sprite robe_sprites.png  70 128  83 158 >> robe_sprites.inc
	$(HGR_SPRITE) -l robe_l2_mask   robe_sprites.png  70 159  83 189 >> robe_sprites.inc
	$(HGR_SPRITE) -l robe_l3_sprite robe_sprites.png  98 128 111 158 >> robe_sprites.inc
	$(HGR_SPRITE) -l robe_l3_mask   robe_sprites.png  98 159 111 189 >> robe_sprites.inc
	$(HGR_SPRITE) -l robe_l4_sprite robe_sprites.png 126 128 139 158 >> robe_sprites.inc
	$(HGR_SPRITE) -l robe_l4_mask   robe_sprites.png 126 159 139 189 >> robe_sprites.inc
	$(HGR_SPRITE) -l robe_l5_sprite robe_sprites.png 154 128 167 158 >> robe_sprites.inc
	$(HGR_SPRITE) -l robe_l5_mask   robe_sprites.png 154 159 167 189 >> robe_sprites.inc
	$(HGR_SPRITE) -l robe_u0_sprite robe_sprites.png 182   1 195  31 >> robe_sprites.inc
	$(HGR_SPRITE) -l robe_u0_mask   robe_sprites.png 183  32 195  62 >> robe_sprites.inc
	$(HGR_SPRITE) -l robe_u1_sprite robe_sprites.png 210   1 221  31 >> robe_sprites.inc
	$(HGR_SPRITE) -l robe_u1_mask   robe_sprites.png 210  32 223  62 >> robe_sprites.inc
	$(HGR_SPRITE) -l robe_u2_sprite robe_sprites.png 238   1 251  31 >> robe_sprites.inc
	$(HGR_SPRITE) -l robe_u2_mask   robe_sprites.png 238  32 251  62 >> robe_sprites.inc
	$(HGR_SPRITE) -l robe_u3_sprite robe_sprites.png 266   1 279  31 >> robe_sprites.inc
	$(HGR_SPRITE) -l robe_u3_mask   robe_sprites.png 266  32 279  62 >> robe_sprites.inc
	$(HGR_SPRITE) -l robe_u4_sprite robe_sprites.png 182  63 195  93 >> robe_sprites.inc
	$(HGR_SPRITE) -l robe_u4_mask   robe_sprites.png 182  94 195 124 >> robe_sprites.inc
	$(HGR_SPRITE) -l robe_u5_sprite robe_sprites.png 210  63 223  93 >> robe_sprites.inc
	$(HGR_SPRITE) -l robe_u5_mask   robe_sprites.png 210  94 223 124 >> robe_sprites.inc
	$(HGR_SPRITE) -l robe_d0_sprite robe_sprites.png 238  63 251  93 >> robe_sprites.inc
	$(HGR_SPRITE) -l robe_d0_mask   robe_sprites.png 238  94 251 124 >> robe_sprites.inc
	$(HGR_SPRITE) -l robe_d1_sprite robe_sprites.png 266  63 279  93 >> robe_sprites.inc
	$(HGR_SPRITE) -l robe_d1_mask   robe_sprites.png 266  94 279 124 >> robe_sprites.inc
	$(HGR_SPRITE) -l robe_d2_sprite robe_sprites.png 182 128 195 158 >> robe_sprites.inc
	$(HGR_SPRITE) -l robe_d2_mask   robe_sprites.png 182 159 195 189 >> robe_sprites.inc
	$(HGR_SPRITE) -l robe_d3_sprite robe_sprites.png 210 128 223 158 >> robe_sprites.inc
	$(HGR_SPRITE) -l robe_d3_mask   robe_sprites.png 210 159 223 189 >> robe_sprites.inc
	$(HGR_SPRITE) -l robe_d4_sprite robe_sprites.png 238 128 251 158 >> robe_sprites.inc
	$(HGR_SPRITE) -l robe_d4_mask   robe_sprites.png 238 159 251 189 >> robe_sprites.inc
	$(HGR_SPRITE) -l robe_d5_sprite robe_sprites.png 266 128 279 158 >> robe_sprites.inc
	$(HGR_SPRITE) -l robe_d5_mask   robe_sprites.png 266 159 279 189 >> robe_sprites.inc

robe_shield_sprites.inc:     robe_shield_sprites.png
	$(HGR_SPRITE) -l robe_r0_sprite robe_shield_sprites.png  14  32  27  62 > robe_shield_sprites.inc
	$(HGR_SPRITE) -l robe_r0_mask   robe_shield_sprites.png  14  63  27  93 >> robe_shield_sprites.inc
	$(HGR_SPRITE) -l robe_r1_sprite robe_shield_sprites.png  42  32  53  62 >> robe_shield_sprites.inc
	$(HGR_SPRITE) -l robe_r1_mask   robe_shield_sprites.png  42  63  53  93 >> robe_shield_sprites.inc
	$(HGR_SPRITE) -l robe_r2_sprite robe_shield_sprites.png  70  32  83  62 >> robe_shield_sprites.inc
	$(HGR_SPRITE) -l robe_r2_mask   robe_shield_sprites.png  70  63  83  93 >> robe_shield_sprites.inc
	$(HGR_SPRITE) -l robe_r3_sprite robe_shield_sprites.png  98  32 111  62 >> robe_shield_sprites.inc
	$(HGR_SPRITE) -l robe_r3_mask   robe_shield_sprites.png  98  63 111  93 >> robe_shield_sprites.inc
	$(HGR_SPRITE) -l robe_r4_sprite robe_shield_sprites.png 126  32 139  62 >> robe_shield_sprites.inc
	$(HGR_SPRITE) -l robe_r4_mask   robe_shield_sprites.png 126  63 139  93 >> robe_shield_sprites.inc
	$(HGR_SPRITE) -l robe_r5_sprite robe_shield_sprites.png 154  32 167  62 >> robe_shield_sprites.inc
	$(HGR_SPRITE) -l robe_r5_mask   robe_shield_sprites.png 154  63 167  93 >> robe_shield_sprites.inc
	$(HGR_SPRITE) -l robe_l0_sprite robe_shield_sprites.png  14 128  27 158 >> robe_shield_sprites.inc
	$(HGR_SPRITE) -l robe_l0_mask   robe_shield_sprites.png  14 159  27 189 >> robe_shield_sprites.inc
	$(HGR_SPRITE) -l robe_l1_sprite robe_shield_sprites.png  42 128  53 158 >> robe_shield_sprites.inc
	$(HGR_SPRITE) -l robe_l1_mask   robe_shield_sprites.png  42 159  53 189 >> robe_shield_sprites.inc
	$(HGR_SPRITE) -l robe_l2_sprite robe_shield_sprites.png  70 128  83 158 >> robe_shield_sprites.inc
	$(HGR_SPRITE) -l robe_l2_mask   robe_shield_sprites.png  70 159  83 189 >> robe_shield_sprites.inc
	$(HGR_SPRITE) -l robe_l3_sprite robe_shield_sprites.png  98 128 111 158 >> robe_shield_sprites.inc
	$(HGR_SPRITE) -l robe_l3_mask   robe_shield_sprites.png  98 159 111 189 >> robe_shield_sprites.inc
	$(HGR_SPRITE) -l robe_l4_sprite robe_shield_sprites.png 126 128 139 158 >> robe_shield_sprites.inc
	$(HGR_SPRITE) -l robe_l4_mask   robe_shield_sprites.png 126 159 139 189 >> robe_shield_sprites.inc
	$(HGR_SPRITE) -l robe_l5_sprite robe_shield_sprites.png 154 128 167 158 >> robe_shield_sprites.inc
	$(HGR_SPRITE) -l robe_l5_mask   robe_shield_sprites.png 154 159 167 189 >> robe_shield_sprites.inc
	$(HGR_SPRITE) -l robe_u0_sprite robe_shield_sprites.png 182   1 195  31 >> robe_shield_sprites.inc
	$(HGR_SPRITE) -l robe_u0_mask   robe_shield_sprites.png 183  32 195  62 >> robe_shield_sprites.inc
	$(HGR_SPRITE) -l robe_u1_sprite robe_shield_sprites.png 210   1 221  31 >> robe_shield_sprites.inc
	$(HGR_SPRITE) -l robe_u1_mask   robe_shield_sprites.png 210  32 223  62 >> robe_shield_sprites.inc
	$(HGR_SPRITE) -l robe_u2_sprite robe_shield_sprites.png 238   1 251  31 >> robe_shield_sprites.inc
	$(HGR_SPRITE) -l robe_u2_mask   robe_shield_sprites.png 238  32 251  62 >> robe_shield_sprites.inc
	$(HGR_SPRITE) -l robe_u3_sprite robe_shield_sprites.png 266   1 279  31 >> robe_shield_sprites.inc
	$(HGR_SPRITE) -l robe_u3_mask   robe_shield_sprites.png 266  32 279  62 >> robe_shield_sprites.inc
	$(HGR_SPRITE) -l robe_u4_sprite robe_shield_sprites.png 182  63 195  93 >> robe_shield_sprites.inc
	$(HGR_SPRITE) -l robe_u4_mask   robe_shield_sprites.png 182  94 195 124 >> robe_shield_sprites.inc
	$(HGR_SPRITE) -l robe_u5_sprite robe_shield_sprites.png 210  63 223  93 >> robe_shield_sprites.inc
	$(HGR_SPRITE) -l robe_u5_mask   robe_shield_sprites.png 210  94 223 124 >> robe_shield_sprites.inc
	$(HGR_SPRITE) -l robe_d0_sprite robe_shield_sprites.png 238  63 251  93 >> robe_shield_sprites.inc
	$(HGR_SPRITE) -l robe_d0_mask   robe_shield_sprites.png 238  94 251 124 >> robe_shield_sprites.inc
	$(HGR_SPRITE) -l robe_d1_sprite robe_shield_sprites.png 266  63 279  93 >> robe_shield_sprites.inc
	$(HGR_SPRITE) -l robe_d1_mask   robe_shield_sprites.png 266  94 279 124 >> robe_shield_sprites.inc
	$(HGR_SPRITE) -l robe_d2_sprite robe_shield_sprites.png 182 128 195 158 >> robe_shield_sprites.inc
	$(HGR_SPRITE) -l robe_d2_mask   robe_shield_sprites.png 182 159 195 189 >> robe_shield_sprites.inc
	$(HGR_SPRITE) -l robe_d3_sprite robe_shield_sprites.png 210 128 223 158 >> robe_shield_sprites.inc
	$(HGR_SPRITE) -l robe_d3_mask   robe_shield_sprites.png 210 159 223 189 >> robe_shield_sprites.inc
	$(HGR_SPRITE) -l robe_d4_sprite robe_shield_sprites.png 238 128 251 158 >> robe_shield_sprites.inc
	$(HGR_SPRITE) -l robe_d4_mask   robe_shield_sprites.png 238 159 251 189 >> robe_shield_sprites.inc
	$(HGR_SPRITE) -l robe_d5_sprite robe_shield_sprites.png 266 128 279 158 >> robe_shield_sprites.inc
	$(HGR_SPRITE) -l robe_d5_mask   robe_shield_sprites.png 266 159 279 189 >> robe_shield_sprites.inc


robe_sprites_purple.inc:     robe_sprites_purple.png
	$(HGR_SPRITE) -l robe_r0_sprite robe_sprites_purple.png  14  32  27  62 > robe_sprites_purple.inc
	$(HGR_SPRITE) -l robe_r0_mask   robe_sprites_purple.png  14  63  27  93 >> robe_sprites_purple.inc
	$(HGR_SPRITE) -l robe_r1_sprite robe_sprites_purple.png  42  32  53  62 >> robe_sprites_purple.inc
	$(HGR_SPRITE) -l robe_r1_mask   robe_sprites_purple.png  42  63  53  93 >> robe_sprites_purple.inc
	$(HGR_SPRITE) -l robe_r2_sprite robe_sprites_purple.png  70  32  83  62 >> robe_sprites_purple.inc
	$(HGR_SPRITE) -l robe_r2_mask   robe_sprites_purple.png  70  63  83  93 >> robe_sprites_purple.inc
	$(HGR_SPRITE) -l robe_r3_sprite robe_sprites_purple.png  98  32 111  62 >> robe_sprites_purple.inc
	$(HGR_SPRITE) -l robe_r3_mask   robe_sprites_purple.png  98  63 111  93 >> robe_sprites_purple.inc
	$(HGR_SPRITE) -l robe_r4_sprite robe_sprites_purple.png 126  32 139  62 >> robe_sprites_purple.inc
	$(HGR_SPRITE) -l robe_r4_mask   robe_sprites_purple.png 126  63 139  93 >> robe_sprites_purple.inc
	$(HGR_SPRITE) -l robe_r5_sprite robe_sprites_purple.png 154  32 167  62 >> robe_sprites_purple.inc
	$(HGR_SPRITE) -l robe_r5_mask   robe_sprites_purple.png 154  63 167  93 >> robe_sprites_purple.inc
	$(HGR_SPRITE) -l robe_l0_sprite robe_sprites_purple.png  14 128  27 158 >> robe_sprites_purple.inc
	$(HGR_SPRITE) -l robe_l0_mask   robe_sprites_purple.png  14 159  27 189 >> robe_sprites_purple.inc
	$(HGR_SPRITE) -l robe_l1_sprite robe_sprites_purple.png  42 128  53 158 >> robe_sprites_purple.inc
	$(HGR_SPRITE) -l robe_l1_mask   robe_sprites_purple.png  42 159  53 189 >> robe_sprites_purple.inc
	$(HGR_SPRITE) -l robe_l2_sprite robe_sprites_purple.png  70 128  83 158 >> robe_sprites_purple.inc
	$(HGR_SPRITE) -l robe_l2_mask   robe_sprites_purple.png  70 159  83 189 >> robe_sprites_purple.inc
	$(HGR_SPRITE) -l robe_l3_sprite robe_sprites_purple.png  98 128 111 158 >> robe_sprites_purple.inc
	$(HGR_SPRITE) -l robe_l3_mask   robe_sprites_purple.png  98 159 111 189 >> robe_sprites_purple.inc
	$(HGR_SPRITE) -l robe_l4_sprite robe_sprites_purple.png 126 128 139 158 >> robe_sprites_purple.inc
	$(HGR_SPRITE) -l robe_l4_mask   robe_sprites_purple.png 126 159 139 189 >> robe_sprites_purple.inc
	$(HGR_SPRITE) -l robe_l5_sprite robe_sprites_purple.png 154 128 167 158 >> robe_sprites_purple.inc
	$(HGR_SPRITE) -l robe_l5_mask   robe_sprites_purple.png 154 159 167 189 >> robe_sprites_purple.inc
	$(HGR_SPRITE) -l robe_u0_sprite robe_sprites_purple.png 182   1 195  31 >> robe_sprites_purple.inc
	$(HGR_SPRITE) -l robe_u0_mask   robe_sprites_purple.png 183  32 195  62 >> robe_sprites_purple.inc
	$(HGR_SPRITE) -l robe_u1_sprite robe_sprites_purple.png 210   1 221  31 >> robe_sprites_purple.inc
	$(HGR_SPRITE) -l robe_u1_mask   robe_sprites_purple.png 210  32 223  62 >> robe_sprites_purple.inc
	$(HGR_SPRITE) -l robe_u2_sprite robe_sprites_purple.png 238   1 251  31 >> robe_sprites_purple.inc
	$(HGR_SPRITE) -l robe_u2_mask   robe_sprites_purple.png 238  32 251  62 >> robe_sprites_purple.inc
	$(HGR_SPRITE) -l robe_u3_sprite robe_sprites_purple.png 266   1 279  31 >> robe_sprites_purple.inc
	$(HGR_SPRITE) -l robe_u3_mask   robe_sprites_purple.png 266  32 279  62 >> robe_sprites_purple.inc
	$(HGR_SPRITE) -l robe_u4_sprite robe_sprites_purple.png 182  63 195  93 >> robe_sprites_purple.inc
	$(HGR_SPRITE) -l robe_u4_mask   robe_sprites_purple.png 182  94 195 124 >> robe_sprites_purple.inc
	$(HGR_SPRITE) -l robe_u5_sprite robe_sprites_purple.png 210  63 223  93 >> robe_sprites_purple.inc
	$(HGR_SPRITE) -l robe_u5_mask   robe_sprites_purple.png 210  94 223 124 >> robe_sprites_purple.inc
	$(HGR_SPRITE) -l robe_d0_sprite robe_sprites_purple.png 238  63 251  93 >> robe_sprites_purple.inc
	$(HGR_SPRITE) -l robe_d0_mask   robe_sprites_purple.png 238  94 251 124 >> robe_sprites_purple.inc
	$(HGR_SPRITE) -l robe_d1_sprite robe_sprites_purple.png 266  63 279  93 >> robe_sprites_purple.inc
	$(HGR_SPRITE) -l robe_d1_mask   robe_sprites_purple.png 266  94 279 124 >> robe_sprites_purple.inc
	$(HGR_SPRITE) -l robe_d2_sprite robe_sprites_purple.png 182 128 195 158 >> robe_sprites_purple.inc
	$(HGR_SPRITE) -l robe_d2_mask   robe_sprites_purple.png 182 159 195 189 >> robe_sprites_purple.inc
	$(HGR_SPRITE) -l robe_d3_sprite robe_sprites_purple.png 210 128 223 158 >> robe_sprites_purple.inc
	$(HGR_SPRITE) -l robe_d3_mask   robe_sprites_purple.png 210 159 223 189 >> robe_sprites_purple.inc
	$(HGR_SPRITE) -l robe_d4_sprite robe_sprites_purple.png 238 128 251 158 >> robe_sprites_purple.inc
	$(HGR_SPRITE) -l robe_d4_mask   robe_sprites_purple.png 238 159 251 189 >> robe_sprites_purple.inc
	$(HGR_SPRITE) -l robe_d5_sprite robe_sprites_purple.png 266 128 279 158 >> robe_sprites_purple.inc
	$(HGR_SPRITE) -l robe_d5_mask   robe_sprites_purple.png 266 159 279 189 >> robe_sprites_purple.inc

robe_sprites_orange.inc:     robe_sprites_orange.png
	$(HGR_SPRITE) -l robe_r0_sprite robe_sprites_orange.png  14  32  27  62 > robe_sprites_orange.inc
	$(HGR_SPRITE) -l robe_r0_mask   robe_sprites_orange.png  14  63  27  93 >> robe_sprites_orange.inc
	$(HGR_SPRITE) -l robe_r1_sprite robe_sprites_orange.png  42  32  53  62 >> robe_sprites_orange.inc
	$(HGR_SPRITE) -l robe_r1_mask   robe_sprites_orange.png  42  63  53  93 >> robe_sprites_orange.inc
	$(HGR_SPRITE) -l robe_r2_sprite robe_sprites_orange.png  70  32  83  62 >> robe_sprites_orange.inc
	$(HGR_SPRITE) -l robe_r2_mask   robe_sprites_orange.png  70  63  83  93 >> robe_sprites_orange.inc
	$(HGR_SPRITE) -l robe_r3_sprite robe_sprites_orange.png  98  32 111  62 >> robe_sprites_orange.inc
	$(HGR_SPRITE) -l robe_r3_mask   robe_sprites_orange.png  98  63 111  93 >> robe_sprites_orange.inc
	$(HGR_SPRITE) -l robe_r4_sprite robe_sprites_orange.png 126  32 139  62 >> robe_sprites_orange.inc
	$(HGR_SPRITE) -l robe_r4_mask   robe_sprites_orange.png 126  63 139  93 >> robe_sprites_orange.inc
	$(HGR_SPRITE) -l robe_r5_sprite robe_sprites_orange.png 154  32 167  62 >> robe_sprites_orange.inc
	$(HGR_SPRITE) -l robe_r5_mask   robe_sprites_orange.png 154  63 167  93 >> robe_sprites_orange.inc
	$(HGR_SPRITE) -l robe_l0_sprite robe_sprites_orange.png  14 128  27 158 >> robe_sprites_orange.inc
	$(HGR_SPRITE) -l robe_l0_mask   robe_sprites_orange.png  14 159  27 189 >> robe_sprites_orange.inc
	$(HGR_SPRITE) -l robe_l1_sprite robe_sprites_orange.png  42 128  53 158 >> robe_sprites_orange.inc
	$(HGR_SPRITE) -l robe_l1_mask   robe_sprites_orange.png  42 159  53 189 >> robe_sprites_orange.inc
	$(HGR_SPRITE) -l robe_l2_sprite robe_sprites_orange.png  70 128  83 158 >> robe_sprites_orange.inc
	$(HGR_SPRITE) -l robe_l2_mask   robe_sprites_orange.png  70 159  83 189 >> robe_sprites_orange.inc
	$(HGR_SPRITE) -l robe_l3_sprite robe_sprites_orange.png  98 128 111 158 >> robe_sprites_orange.inc
	$(HGR_SPRITE) -l robe_l3_mask   robe_sprites_orange.png  98 159 111 189 >> robe_sprites_orange.inc
	$(HGR_SPRITE) -l robe_l4_sprite robe_sprites_orange.png 126 128 139 158 >> robe_sprites_orange.inc
	$(HGR_SPRITE) -l robe_l4_mask   robe_sprites_orange.png 126 159 139 189 >> robe_sprites_orange.inc
	$(HGR_SPRITE) -l robe_l5_sprite robe_sprites_orange.png 154 128 167 158 >> robe_sprites_orange.inc
	$(HGR_SPRITE) -l robe_l5_mask   robe_sprites_orange.png 154 159 167 189 >> robe_sprites_orange.inc
	$(HGR_SPRITE) -l robe_u0_sprite robe_sprites_orange.png 182   1 195  31 >> robe_sprites_orange.inc
	$(HGR_SPRITE) -l robe_u0_mask   robe_sprites_orange.png 183  32 195  62 >> robe_sprites_orange.inc
	$(HGR_SPRITE) -l robe_u1_sprite robe_sprites_orange.png 210   1 221  31 >> robe_sprites_orange.inc
	$(HGR_SPRITE) -l robe_u1_mask   robe_sprites_orange.png 210  32 223  62 >> robe_sprites_orange.inc
	$(HGR_SPRITE) -l robe_u2_sprite robe_sprites_orange.png 238   1 251  31 >> robe_sprites_orange.inc
	$(HGR_SPRITE) -l robe_u2_mask   robe_sprites_orange.png 238  32 251  62 >> robe_sprites_orange.inc
	$(HGR_SPRITE) -l robe_u3_sprite robe_sprites_orange.png 266   1 279  31 >> robe_sprites_orange.inc
	$(HGR_SPRITE) -l robe_u3_mask   robe_sprites_orange.png 266  32 279  62 >> robe_sprites_orange.inc
	$(HGR_SPRITE) -l robe_u4_sprite robe_sprites_orange.png 182  63 195  93 >> robe_sprites_orange.inc
	$(HGR_SPRITE) -l robe_u4_mask   robe_sprites_orange.png 182  94 195 124 >> robe_sprites_orange.inc
	$(HGR_SPRITE) -l robe_u5_sprite robe_sprites_orange.png 210  63 223  93 >> robe_sprites_orange.inc
	$(HGR_SPRITE) -l robe_u5_mask   robe_sprites_orange.png 210  94 223 124 >> robe_sprites_orange.inc
	$(HGR_SPRITE) -l robe_d0_sprite robe_sprites_orange.png 238  63 251  93 >> robe_sprites_orange.inc
	$(HGR_SPRITE) -l robe_d0_mask   robe_sprites_orange.png 238  94 251 124 >> robe_sprites_orange.inc
	$(HGR_SPRITE) -l robe_d1_sprite robe_sprites_orange.png 266  63 279  93 >> robe_sprites_orange.inc
	$(HGR_SPRITE) -l robe_d1_mask   robe_sprites_orange.png 266  94 279 124 >> robe_sprites_orange.inc
	$(HGR_SPRITE) -l robe_d2_sprite robe_sprites_orange.png 182 128 195 158 >> robe_sprites_orange.inc
	$(HGR_SPRITE) -l robe_d2_mask   robe_sprites_orange.png 182 159 195 189 >> robe_sprites_orange.inc
	$(HGR_SPRITE) -l robe_d3_sprite robe_sprites_orange.png 210 128 223 158 >> robe_sprites_orange.inc
	$(HGR_SPRITE) -l robe_d3_mask   robe_sprites_orange.png 210 159 223 189 >> robe_sprites_orange.inc
	$(HGR_SPRITE) -l robe_d4_sprite robe_sprites_orange.png 238 128 251 158 >> robe_sprites_orange.inc
	$(HGR_SPRITE) -l robe_d4_mask   robe_sprites_orange.png 238 159 251 189 >> robe_sprites_orange.inc
	$(HGR_SPRITE) -l robe_d5_sprite robe_sprites_orange.png 266 128 279 158 >> robe_sprites_orange.inc
	$(HGR_SPRITE) -l robe_d5_mask   robe_sprites_orange.png 266 159 279 189 >> robe_sprites_orange.inc




walk_sprites.inc:     walk_sprites.png
	$(HGR_SPRITE) -l walk_r0_sprite walk_sprites.png  14  32  27  62 > walk_sprites.inc
	$(HGR_SPRITE) -l walk_r0_mask   walk_sprites.png  14  63  27  93 >> walk_sprites.inc
	$(HGR_SPRITE) -l walk_r1_sprite walk_sprites.png  42  32  53  62 >> walk_sprites.inc
	$(HGR_SPRITE) -l walk_r1_mask   walk_sprites.png  42  63  53  93 >> walk_sprites.inc
	$(HGR_SPRITE) -l walk_r2_sprite walk_sprites.png  70  32  83  62 >> walk_sprites.inc
	$(HGR_SPRITE) -l walk_r2_mask   walk_sprites.png  70  63  83  93 >> walk_sprites.inc
	$(HGR_SPRITE) -l walk_r3_sprite walk_sprites.png  98  32 111  62 >> walk_sprites.inc
	$(HGR_SPRITE) -l walk_r3_mask   walk_sprites.png  98  63 111  93 >> walk_sprites.inc
	$(HGR_SPRITE) -l walk_r4_sprite walk_sprites.png 126  32 139  62 >> walk_sprites.inc
	$(HGR_SPRITE) -l walk_r4_mask   walk_sprites.png 126  63 139  93 >> walk_sprites.inc
	$(HGR_SPRITE) -l walk_r5_sprite walk_sprites.png 154  32 167  62 >> walk_sprites.inc
	$(HGR_SPRITE) -l walk_r5_mask   walk_sprites.png 154  63 167  93 >> walk_sprites.inc
	$(HGR_SPRITE) -l walk_l0_sprite walk_sprites.png  14 128  27 158 >> walk_sprites.inc
	$(HGR_SPRITE) -l walk_l0_mask   walk_sprites.png  14 159  27 189 >> walk_sprites.inc
	$(HGR_SPRITE) -l walk_l1_sprite walk_sprites.png  42 128  53 158 >> walk_sprites.inc
	$(HGR_SPRITE) -l walk_l1_mask   walk_sprites.png  42 159  53 189 >> walk_sprites.inc
	$(HGR_SPRITE) -l walk_l2_sprite walk_sprites.png  70 128  83 158 >> walk_sprites.inc
	$(HGR_SPRITE) -l walk_l2_mask   walk_sprites.png  70 159  83 189 >> walk_sprites.inc
	$(HGR_SPRITE) -l walk_l3_sprite walk_sprites.png  98 128 111 158 >> walk_sprites.inc
	$(HGR_SPRITE) -l walk_l3_mask   walk_sprites.png  98 159 111 189 >> walk_sprites.inc
	$(HGR_SPRITE) -l walk_l4_sprite walk_sprites.png 126 128 139 158 >> walk_sprites.inc
	$(HGR_SPRITE) -l walk_l4_mask   walk_sprites.png 126 159 139 189 >> walk_sprites.inc
	$(HGR_SPRITE) -l walk_l5_sprite walk_sprites.png 154 128 167 158 >> walk_sprites.inc
	$(HGR_SPRITE) -l walk_l5_mask   walk_sprites.png 154 159 167 189 >> walk_sprites.inc
	$(HGR_SPRITE) -l walk_u0_sprite walk_sprites.png 182   1 195  31 >> walk_sprites.inc
	$(HGR_SPRITE) -l walk_u0_mask   walk_sprites.png 183  32 195  62 >> walk_sprites.inc
	$(HGR_SPRITE) -l walk_u1_sprite walk_sprites.png 210   1 221  31 >> walk_sprites.inc
	$(HGR_SPRITE) -l walk_u1_mask   walk_sprites.png 210  32 223  62 >> walk_sprites.inc
	$(HGR_SPRITE) -l walk_u2_sprite walk_sprites.png 238   1 251  31 >> walk_sprites.inc
	$(HGR_SPRITE) -l walk_u2_mask   walk_sprites.png 238  32 251  62 >> walk_sprites.inc
	$(HGR_SPRITE) -l walk_u3_sprite walk_sprites.png 266   1 279  31 >> walk_sprites.inc
	$(HGR_SPRITE) -l walk_u3_mask   walk_sprites.png 266  32 279  62 >> walk_sprites.inc
	$(HGR_SPRITE) -l walk_u4_sprite walk_sprites.png 182  63 195  93 >> walk_sprites.inc
	$(HGR_SPRITE) -l walk_u4_mask   walk_sprites.png 182  94 195 124 >> walk_sprites.inc
	$(HGR_SPRITE) -l walk_u5_sprite walk_sprites.png 210  63 223  93 >> walk_sprites.inc
	$(HGR_SPRITE) -l walk_u5_mask   walk_sprites.png 210  94 223 124 >> walk_sprites.inc
	$(HGR_SPRITE) -l walk_d0_sprite walk_sprites.png 238  63 251  93 >> walk_sprites.inc
	$(HGR_SPRITE) -l walk_d0_mask   walk_sprites.png 238  94 251 124 >> walk_sprites.inc
	$(HGR_SPRITE) -l walk_d1_sprite walk_sprites.png 266  63 279  93 >> walk_sprites.inc
	$(HGR_SPRITE) -l walk_d1_mask   walk_sprites.png 266  94 279 124 >> walk_sprites.inc
	$(HGR_SPRITE) -l walk_d2_sprite walk_sprites.png 182 128 195 158 >> walk_sprites.inc
	$(HGR_SPRITE) -l walk_d2_mask   walk_sprites.png 182 159 195 189 >> walk_sprites.inc
	$(HGR_SPRITE) -l walk_d3_sprite walk_sprites.png 210 128 223 158 >> walk_sprites.inc
	$(HGR_SPRITE) -l walk_d3_mask   walk_sprites.png 210 159 223 189 >> walk_sprites.inc
	$(HGR_SPRITE) -l walk_d4_sprite walk_sprites.png 238 128 251 158 >> walk_sprites.inc
	$(HGR_SPRITE) -l walk_d4_mask   walk_sprites.png 238 159 251 189 >> walk_sprites.inc
	$(HGR_SPRITE) -l walk_d5_sprite walk_sprites.png 266 128 279 158 >> walk_sprites.inc
	$(HGR_SPRITE) -l walk_d5_mask   walk_sprites.png 266 159 279 189 >> walk_sprites.inc


flame_sprites.inc:     flame_sprites.png
	$(HGR_SPRITE) -l flame_r0_sprite flame_sprites.png  14  25  27  34 > flame_sprites.inc
	$(HGR_SPRITE) -l flame_r0_mask   flame_sprites.png  14  35  27  44 >> flame_sprites.inc
	$(HGR_SPRITE) -l flame_r1_sprite flame_sprites.png  42  25  55  34 >> flame_sprites.inc
	$(HGR_SPRITE) -l flame_r1_mask   flame_sprites.png  42  35  55  44 >> flame_sprites.inc
	$(HGR_SPRITE) -l flame_r2_sprite flame_sprites.png  70  25  83  34 >> flame_sprites.inc
	$(HGR_SPRITE) -l flame_r2_mask   flame_sprites.png  70  35  83  44 >> flame_sprites.inc
	$(HGR_SPRITE) -l flame_l0_sprite flame_sprites.png  98  25 111  34 >> flame_sprites.inc
	$(HGR_SPRITE) -l flame_l0_mask   flame_sprites.png  98  35 111  44 >> flame_sprites.inc
	$(HGR_SPRITE) -l flame_l1_sprite flame_sprites.png 126  25 139  34 >> flame_sprites.inc
	$(HGR_SPRITE) -l flame_l1_mask   flame_sprites.png 126  35 139  44 >> flame_sprites.inc
	$(HGR_SPRITE) -l flame_l2_sprite flame_sprites.png 154  25 167  34 >> flame_sprites.inc
	$(HGR_SPRITE) -l flame_l2_mask   flame_sprites.png 154  35 167  44 >> flame_sprites.inc
	$(HGR_SPRITE) -l flame_u0_sprite flame_sprites.png  14 147  27 156 >> flame_sprites.inc
	$(HGR_SPRITE) -l flame_u0_mask   flame_sprites.png  14 157  27 166 >> flame_sprites.inc
	$(HGR_SPRITE) -l flame_u1_sprite flame_sprites.png  42 147  55 156 >> flame_sprites.inc
	$(HGR_SPRITE) -l flame_u1_mask   flame_sprites.png  42 157  55 166 >> flame_sprites.inc
	$(HGR_SPRITE) -l flame_u2_sprite flame_sprites.png  70 147  83 156 >> flame_sprites.inc
	$(HGR_SPRITE) -l flame_u2_mask   flame_sprites.png  70 157  83 166 >> flame_sprites.inc
	$(HGR_SPRITE) -l flame_d0_sprite flame_sprites.png  98 147 111 156 >> flame_sprites.inc
	$(HGR_SPRITE) -l flame_d0_mask   flame_sprites.png  98 157 111 166 >> flame_sprites.inc
	$(HGR_SPRITE) -l flame_d1_sprite flame_sprites.png 126 147 139 156 >> flame_sprites.inc
	$(HGR_SPRITE) -l flame_d1_mask   flame_sprites.png 126 157 139 166 >> flame_sprites.inc
	$(HGR_SPRITE) -l flame_d2_sprite flame_sprites.png 154 147 167 156 >> flame_sprites.inc
	$(HGR_SPRITE) -l flame_d2_mask   flame_sprites.png 154 157 167 166 >> flame_sprites.inc

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


clean:	
	rm -f *~ *.zx02 enemy_sprites.inc \
		robe_sprites.inc robe_sprites_purple.inc robe_sprites_orange.inc \
		flame_sprites.inc \
		walk_sprites.inc climb_sprites.inc climb_flame_sprites.inc \
		PEASANT_SPRITES_COMMON

