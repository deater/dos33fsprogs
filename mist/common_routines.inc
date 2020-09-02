;=============================
; external routines

; linking_noise.s
play_link_noise	=$141e

; decompress_fast_v2.s
decompress_lzsa2_fast	=$143a
getsrc_smc	=$1530

; draw_pointer.s
draw_pointer	=$153d

; end_level.s
end_level	=$16ab

; gr_copy.s
gr_copy_to_current	=$16cd

; gr_fast_clear.s
clear_bottom	=$17f3
clear_all	=$1831
clear_all_color	=$1856

; gr_offsets.s
gr_offsets	=$1874

; gr_page_flip.s
page_flip	=$18a4

; gr_putsprite_crop.s
put_sprite_crop	=$18be
psc_smc1	=$18e1
psc_smc2	=$1979

; keyboard.s
handle_keypress	=$19fa
change_direction	=$1abe
change_location	=$1af7

; text_print.s
move_and_print	=$1b8f
ps_smc1	=$1bbc

; page_sprites.inc
blue_page_sprite	=$1cd8
red_page_sprite	=$1cee
white_page_sprite	=$1d04
blue_page_small_sprite	=$1d1a
red_page_small_sprite	=$1d22

