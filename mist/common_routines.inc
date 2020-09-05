;=============================
; external routines

; linking_noise.s
play_link_noise	=$158b

; decompress_fast_v2.s
decompress_lzsa2_fast	=$15a7
getsrc_smc	=$169d

; draw_pointer.s
draw_pointer	=$16aa

; end_level.s
end_level	=$1818

; gr_copy.s
gr_copy_to_current	=$183a

; gr_fast_clear.s
clear_bottom	=$1960
clear_all	=$199e
clear_all_color	=$19c3

; gr_offsets.s
gr_offsets	=$19e1

; gr_page_flip.s
page_flip	=$1a11

; gr_putsprite_crop.s
put_sprite_crop	=$1a2b
psc_smc1	=$1a4e
psc_smc2	=$1ae6

; keyboard.s
handle_keypress	=$1b67
change_direction	=$1c2f
change_location	=$1c68

; text_print.s
move_and_print	=$1d00
ps_smc1	=$1d2d

; page_sprites.inc
blue_page_sprite	=$1e4f
red_page_sprite	=$1e65
white_page_sprite	=$1e7b
blue_page_small_sprite	=$1e91
red_page_small_sprite	=$1e99

