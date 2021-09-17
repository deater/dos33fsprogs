; Danger: if you mess with QLOAD you'll have to update these

QLOAD_LOC=$B00
pt3_init_song=QLOAD_LOC+$BF9
clear_ay_both=QLOAD_LOC+$E82
reset_ay_both=QLOAD_LOC+$E40
mockingboard_setup_interrupt=QLOAD_LOC+$E8F
mockingboard_disable_interrupt=QLOAD_LOC+$EB7
mockingboard_init=QLOAD_LOC+$E31
mockingboard_patch=QLOAD_LOC+$F73
mockingboard_detect=QLOAD_LOC+$F44

PT3_LOC=QLOAD_LOC+$1000

