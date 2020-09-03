;=============================
; external routines

; linking_noise.s
play_link_noise	=$145e

; decompress_fast_v2.s
decompress_lzsa2_fast	=$147a
getsrc_smc	=$1570

; draw_pointer.s
draw_pointer	=$157d

; end_level.s
end_level	=$16eb

; gr_copy.s
gr_copy_to_current	=$170d

; gr_fast_clear.s
clear_bottom	=$1833
clear_all	=$1871
clear_all_color	=$1896

; gr_offsets.s
gr_offsets	=$18b4

; gr_page_flip.s
page_flip	=$18e4

; gr_putsprite_crop.s
put_sprite_crop	=$18fe
psc_smc1	=$1921
psc_smc2	=$19b9

; keyboard.s
handle_keypress	=$1a3a
change_direction	=$1afe
change_location	=$1b37

; text_print.s
move_and_print	=$1bcf
ps_smc1	=$1bfc

; page_sprites.inc
blue_page_sprite	=$1d18
red_page_sprite	=$1d2e
white_page_sprite	=$1d44
blue_page_small_sprite	=$1d5a
red_page_small_sprite	=$1d62

