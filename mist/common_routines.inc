;=============================
; external routines

; loader.s
opendir_filename	=$1042

; linking_noise.s
play_link_noise	=$1590

; decompress_fast_v2.s
decompress_lzsa2_fast	=$15ac
getsrc_smc	=$16a2

; draw_pointer.s
draw_pointer	=$16af

; end_level.s
end_level	=$181d

; gr_copy.s
gr_copy_to_current	=$183f

; gr_fast_clear.s
clear_bottom	=$1965
clear_all	=$19a3
clear_all_color	=$19c8

; gr_offsets.s
gr_offsets	=$19e6

; gr_page_flip.s
page_flip	=$1a16

; gr_putsprite_crop.s
put_sprite_crop	=$1a30
psc_smc1	=$1a53
psc_smc2	=$1aeb

; keyboard.s
handle_keypress	=$1b6c
change_direction	=$1c30
change_location	=$1c69

; text_print.s
move_and_print	=$1d01
ps_smc1	=$1d2e

; page_sprites.inc
blue_page_sprite	=$1e16
red_page_sprite	=$1e2c
white_page_sprite	=$1e42
blue_page_small_sprite	=$1e58
red_page_small_sprite	=$1e60

