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
end_level	=$1707

; gr_copy.s
gr_copy_to_current	=$1729

; gr_fast_clear.s
clear_bottom	=$184f
clear_all	=$188d
clear_all_color	=$18b2

; gr_offsets.s
gr_offsets	=$18d0

; gr_page_flip.s
page_flip	=$1900

; gr_putsprite_crop.s
put_sprite_crop	=$191a
psc_smc1	=$193d
psc_smc2	=$19d5

; keyboard.s
handle_keypress	=$1a56
change_direction	=$1b1a
change_location	=$1b53

; text_print.s
move_and_print	=$1beb
ps_smc1	=$1c18

; page_sprites.inc
blue_page_sprite	=$1d00
red_page_sprite	=$1d16
white_page_sprite	=$1d2c
blue_page_small_sprite	=$1d42
red_page_small_sprite	=$1d4a

