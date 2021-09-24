; Danger: if you mess with MUSIC you'll have to update these

MUSIC_LOC=$D000
pt3_init_song=MUSIC_LOC+$8E8
clear_ay_both=MUSIC_LOC+$B71
reset_ay_both=MUSIC_LOC+$B2F
mockingboard_setup_interrupt=MUSIC_LOC+$B7E
mockingboard_disable_interrupt=MUSIC_LOC+$BA6
mockingboard_init=MUSIC_LOC+$B20
mockingboard_patch=MUSIC_LOC+$BB2
mockingboard_detect=MUSIC_LOC+$C5D

PT3_LOC=MUSIC_LOC+$D00

