;=============================
; external routines

; loader.s
opendir_filename	=$1263

; linking_noise.s
play_link_noise	=$13e2

; decompress_fast_v2.s
decompress_lzsa2_fast	=$13fe
getsrc_smc	=$14f4

; draw_pointer.s
draw_pointer	=$1501

; end_level.s
end_level	=$166f

; gr_copy.s
gr_copy_to_current	=$1691

; gr_fast_clear.s
clear_bottom	=$17b7
clear_all	=$17f5
clear_all_color	=$181a

; gr_offsets.s
gr_offsets	=$1838

; gr_page_flip.s
page_flip	=$1868

; gr_putsprite_crop.s
put_sprite_crop	=$1882
psc_smc1	=$18a5
psc_smc2	=$193d

; keyboard.s
handle_keypress	=$19be
change_direction	=$1a82
change_location	=$1abb

; text_print.s
move_and_print	=$1b53
ps_smc1	=$1b80

; page_sprites.inc
blue_page_sprite	=$1c68
red_page_sprite	=$1c7e
white_page_sprite	=$1c94
blue_page_small_sprite	=$1caa
red_page_small_sprite	=$1cb2

