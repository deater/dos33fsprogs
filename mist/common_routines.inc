;=============================
; external routines

; loader.s
opendir_filename	=$120e

; linking_noise.s
play_link_noise	=$140e

; decompress_fast_v2.s
decompress_lzsa2_fast	=$142a
getsrc_smc	=$1520

; draw_pointer.s
draw_pointer	=$152d

; end_level.s
end_level	=$169b

; gr_copy.s
gr_copy_to_current	=$16bd

; gr_fast_clear.s
clear_bottom	=$17e3
clear_all	=$1821
clear_all_color	=$1846

; gr_offsets.s
gr_offsets	=$1864

; gr_page_flip.s
page_flip	=$1894

; gr_putsprite_crop.s
put_sprite_crop	=$18ae
psc_smc1	=$18d1
psc_smc2	=$1969

; keyboard.s
handle_keypress	=$19ea
change_direction	=$1aae
change_location	=$1ae7

; text_print.s
move_and_print	=$1b7f
ps_smc1	=$1bac

; page_sprites.inc
blue_page_sprite	=$1c94
red_page_sprite	=$1caa
white_page_sprite	=$1cc0
blue_page_small_sprite	=$1cd6
red_page_small_sprite	=$1cde

