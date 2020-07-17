;=============================
; external routines

; loader.s
opendir_filename	=$1042

; linking_noise.s
play_link_noise	=$147a

; decompress_fast_v2.s
decompress_lzsa2_fast	=$1496
getsrc_smc	=$158c

; draw_pointer.s
draw_pointer	=$1599

; end_level.s
end_level	=$1705

; gr_copy.s
gr_copy_to_current	=$1727

; gr_fast_clear.s
clear_bottom	=$184d
clear_all	=$188b
clear_all_color	=$18b0

; gr_offsets.s
gr_offsets	=$18ce

; gr_page_flip.s
page_flip	=$18fe

; gr_putsprite_crop.s
put_sprite_crop	=$1918
psc_smc1	=$193b
psc_smc2	=$19d3

; keyboard.s
handle_keypress	=$1a54
change_direction	=$1b16
change_location	=$1b4f

; text_print.s
move_and_print	=$1be7
ps_smc1	=$1c14

; page_sprites.inc
blue_page_sprite	=$1cfc
red_page_sprite	=$1d12
white_page_sprite	=$1d28
blue_page_small_sprite	=$1d3e
red_page_small_sprite	=$1d46

