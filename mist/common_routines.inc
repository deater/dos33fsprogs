;=============================
; external routines

; loader.s
opendir_filename	=$1039

; audio.c
play_audio	=$1350

; decompress_fast_v2.s
decompress_lzsa2_fast	=$1461
getsrc_smc	=$1557

; draw_pointer.s
draw_pointer	=$1564

; end_level.s
end_level	=$16a7

; gr_copy.s
gr_copy_to_current	=$16c9

; gr_fast_clear.s
clear_bottom	=$17ef
clear_all	=$182d
clear_all_color	=$1852

; gr_offsets.s
gr_offsets	=$1870

; gr_page_flip.s
page_flip	=$18a0

; gr_putsprite_crop.s
put_sprite_crop	=$18ba
psc_smc1	=$18dd
psc_smc2	=$1975

; keyboard.s
handle_keypress	=$19f6
change_location	=$1ad7

; text_print.s
move_and_print	=$1b6f
ps_smc1	=$1b9c

; page_sprites.inc
blue_page_sprite	=$1c84
red_page_sprite	=$1c9a
white_page_sprite	=$1cb0
blue_page_small_sprite	=$1cc6
red_page_small_sprite	=$1cce

; audio files
linking_noise	= $9000
LINKING_NOISE_LENGTH = 43
