;=============================
; external routines

; loader.s
opendir_filename	=$1042

; linking_noise.s
play_link_noise	=$1591

; decompress_fast_v2.s
decompress_lzsa2_fast	=$15ad
getsrc_smc	=$16a3

; draw_pointer.s
draw_pointer	=$16b0

; end_level.s
end_level	=$181e

; gr_copy.s
gr_copy_to_current	=$1840

; gr_fast_clear.s
clear_bottom	=$1966
clear_all	=$19a4
clear_all_color	=$19c9

; gr_offsets.s
gr_offsets	=$19e7

; gr_page_flip.s
page_flip	=$1a17

; gr_putsprite_crop.s
put_sprite_crop	=$1a31
psc_smc1	=$1a54
psc_smc2	=$1aec

; keyboard.s
handle_keypress	=$1b6d
change_direction	=$1c31
change_location	=$1c6a

; text_print.s
move_and_print	=$1d02
ps_smc1	=$1d2f

; page_sprites.inc
blue_page_sprite	=$1e17
red_page_sprite	=$1e2d
white_page_sprite	=$1e43
blue_page_small_sprite	=$1e59
red_page_small_sprite	=$1e61

