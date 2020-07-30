;=============================
; external routines

; loader.s
opendir_filename	=$1042

; linking_noise.s
play_link_noise	=$1598

; decompress_fast_v2.s
decompress_lzsa2_fast	=$15b4
getsrc_smc	=$16aa

; draw_pointer.s
draw_pointer	=$16b7

; end_level.s
end_level	=$1825

; gr_copy.s
gr_copy_to_current	=$1847

; gr_fast_clear.s
clear_bottom	=$196d
clear_all	=$19ab
clear_all_color	=$19d0

; gr_offsets.s
gr_offsets	=$19ee

; gr_page_flip.s
page_flip	=$1a1e

; gr_putsprite_crop.s
put_sprite_crop	=$1a38
psc_smc1	=$1a5b
psc_smc2	=$1af3

; keyboard.s
handle_keypress	=$1b74
change_direction	=$1c38
change_location	=$1c71

; text_print.s
move_and_print	=$1d09
ps_smc1	=$1d36

; page_sprites.inc
blue_page_sprite	=$1e1e
red_page_sprite	=$1e34
white_page_sprite	=$1e4a
blue_page_small_sprite	=$1e60
red_page_small_sprite	=$1e68

