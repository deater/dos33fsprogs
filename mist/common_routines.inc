;=============================
; external routines

; linking_noise.s
play_link_noise	=$1463

; decompress_fast_v2.s
decompress_lzsa2_fast	=$147f
getsrc_smc	=$1575

; draw_pointer.s
draw_pointer	=$1582

; end_level.s
end_level	=$16f4

; gr_copy.s
gr_copy_to_current	=$1716

; gr_fast_clear.s
clear_bottom	=$183c
clear_all	=$187a
clear_all_color	=$189f

; gr_offsets.s
gr_offsets	=$18bd

; gr_page_flip.s
page_flip	=$18ed

; gr_putsprite_crop.s
put_sprite_crop	=$1907
psc_smc1	=$192a
psc_smc2	=$199c

; keyboard.s
handle_keypress	=$199c
change_direction	=$1aa7
change_location	=$1ada

; text_print.s
move_and_print	=$1b72
ps_smc1	=$1b9f

; page_sprites.inc
blue_page_sprite	=$1cee
red_page_sprite	=$1d04
white_page_sprite	=$1d1a
blue_page_small_sprite	=$1d30
red_page_small_sprite	=$1d38

