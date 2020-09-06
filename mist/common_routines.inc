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
end_level	=$181c

; gr_copy.s
gr_copy_to_current	=$183e

; gr_fast_clear.s
clear_bottom	=$1964
clear_all	=$19a2
clear_all_color	=$19c7

; gr_offsets.s
gr_offsets	=$19e5

; gr_page_flip.s
page_flip	=$1a15

; gr_putsprite_crop.s
put_sprite_crop	=$1a2f
psc_smc1	=$1a52
psc_smc2	=$1ac4

; keyboard.s
handle_keypress	=$1ac4
change_direction	=$1bcf
change_location	=$1c02

; text_print.s
move_and_print	=$1c9a
ps_smc1	=$1cc7

; page_sprites.inc
blue_page_sprite	=$1e16
red_page_sprite	=$1e2c
white_page_sprite	=$1e42
blue_page_small_sprite	=$1e58
red_page_small_sprite	=$1e60

