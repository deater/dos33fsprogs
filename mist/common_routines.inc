;=============================
; external routines

; linking_noise.s
play_link_noise	=$141b

; decompress_fast_v2.s
decompress_lzsa2_fast	=$1437
getsrc_smc	=$152d

; draw_pointer.s
draw_pointer	=$153a

; end_level.s
end_level	=$16a8

; gr_copy.s
gr_copy_to_current	=$16ca

; gr_fast_clear.s
clear_bottom	=$17f0
clear_all	=$182e
clear_all_color	=$1853

; gr_offsets.s
gr_offsets	=$1871

; gr_page_flip.s
page_flip	=$18a1

; gr_putsprite_crop.s
put_sprite_crop	=$18bb
psc_smc1	=$18de
psc_smc2	=$1976

; keyboard.s
handle_keypress	=$19f7
change_direction	=$1abb
change_location	=$1af4

; text_print.s
move_and_print	=$1b8c
ps_smc1	=$1bb9

; page_sprites.inc
blue_page_sprite	=$1c97
red_page_sprite	=$1cad
white_page_sprite	=$1cc3
blue_page_small_sprite	=$1cd9
red_page_small_sprite	=$1ce1

