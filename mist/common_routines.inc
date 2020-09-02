;=============================
; external routines

; loader.s
opendir_filename	=$120e

; linking_noise.s
play_link_noise	=$13e7

; decompress_fast_v2.s
decompress_lzsa2_fast	=$1403
getsrc_smc	=$14f9

; draw_pointer.s
draw_pointer	=$1506

; end_level.s
end_level	=$1674

; gr_copy.s
gr_copy_to_current	=$1696

; gr_fast_clear.s
clear_bottom	=$17bc
clear_all	=$17fa
clear_all_color	=$181f

; gr_offsets.s
gr_offsets	=$183d

; gr_page_flip.s
page_flip	=$186d

; gr_putsprite_crop.s
put_sprite_crop	=$1887
psc_smc1	=$18aa
psc_smc2	=$1942

; keyboard.s
handle_keypress	=$19c3
change_direction	=$1a87
change_location	=$1ac0

; text_print.s
move_and_print	=$1b58
ps_smc1	=$1b85

; page_sprites.inc
blue_page_sprite	=$1c6d
red_page_sprite	=$1c83
white_page_sprite	=$1c99
blue_page_small_sprite	=$1caf
red_page_small_sprite	=$1cb7

