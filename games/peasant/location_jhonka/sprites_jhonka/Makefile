HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite

all:	sprites_jhonka.inc sprites_riches.inc sprites_beat.inc


sprites_jhonka.inc:	sprites_jhonka.png
	$(HGR_SPRITE) -s -l note_sprite sprites_jhonka.png 217 105 230 116 > sprites_jhonka.inc
	$(HGR_SPRITE) -l jhonka0_sprite sprites_jhonka.png  14  33  48  57 >> sprites_jhonka.inc
	$(HGR_SPRITE) -l jhonka1_sprite sprites_jhonka.png  56  31  90  57 >> sprites_jhonka.inc
	$(HGR_SPRITE) -l jhonka2_sprite sprites_jhonka.png  98  31 139  57 >> sprites_jhonka.inc
	$(HGR_SPRITE) -l jhonka3_sprite sprites_jhonka.png 154  34 195  57 >> sprites_jhonka.inc
	$(HGR_SPRITE) -l jhonka8_sprite sprites_jhonka.png  14 121  48 152 >> sprites_jhonka.inc
	$(HGR_SPRITE) -l jhonka9_sprite sprites_jhonka.png  49 128  90 152 >> sprites_jhonka.inc
	$(HGR_SPRITE) -l jhonka0_mask   sprites_jhonka.png  14  62  48  86 >> sprites_jhonka.inc
	$(HGR_SPRITE) -l jhonka1_mask   sprites_jhonka.png  56  60  90  86 >> sprites_jhonka.inc
	$(HGR_SPRITE) -l jhonka2_mask   sprites_jhonka.png  98  60 139  86 >> sprites_jhonka.inc
	$(HGR_SPRITE) -l jhonka3_mask   sprites_jhonka.png 154  63 195  86 >> sprites_jhonka.inc
	$(HGR_SPRITE) -l jhonka8_mask   sprites_jhonka.png  14 154  48 185 >> sprites_jhonka.inc
	$(HGR_SPRITE) -l jhonka9_mask   sprites_jhonka.png  49 161  90 185 >> sprites_jhonka.inc

sprites_riches.inc:	sprites_riches.png
	$(HGR_SPRITE) -s -l nostack_sprite sprites_riches.png 154  55 181  72 > sprites_riches.inc
	$(HGR_SPRITE) -s -l riches_sprite sprites_riches.png   91 100 139 126 >> sprites_riches.inc

sprites_beat.inc:	sprites_beaten.png
	$(HGR_SPRITE) -s -l smash1_sprite sprites_beaten.png  98  88 111 119 > sprites_beat.inc
	$(HGR_SPRITE) -s -l smash2_sprite sprites_beaten.png 126  91 139 119 >> sprites_beat.inc
	$(HGR_SPRITE) -s -l smash3_sprite sprites_beaten.png 154  93 167 119 >> sprites_beat.inc
	$(HGR_SPRITE) -s -l smash4_sprite sprites_beaten.png 182  98 195 119 >> sprites_beat.inc
	$(HGR_SPRITE) -s -l smash5_sprite sprites_beaten.png 203 106 223 119 >> sprites_beat.inc
	$(HGR_SPRITE) -l jhonka4_sprite sprites_beaten.png  14  33  48  57 >> sprites_beat.inc
	$(HGR_SPRITE) -l jhonka5_sprite sprites_beaten.png  56  31  90  57 >> sprites_beat.inc
	$(HGR_SPRITE) -l jhonka6_sprite sprites_beaten.png  98  31 139  57 >> sprites_beat.inc
	$(HGR_SPRITE) -l jhonka7_sprite sprites_beaten.png 154  34 195  57 >> sprites_beat.inc
	$(HGR_SPRITE) -l jhonka4_mask   sprites_beaten.png  14  62  48  86 >> sprites_beat.inc
	$(HGR_SPRITE) -l jhonka5_mask   sprites_beaten.png  56  60  90  86 >> sprites_beat.inc
	$(HGR_SPRITE) -l jhonka6_mask   sprites_beaten.png  98  60 139  86 >> sprites_beat.inc
	$(HGR_SPRITE) -l jhonka7_mask   sprites_beaten.png 154  63 195  86 >> sprites_beat.inc



clean:
	rm -f *~ sprites_jhonka.inc sprites_riches.inc sprites_beat.inc

