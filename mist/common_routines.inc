;=============================
; external routines

; loader.s
opendir_filename	=$1039

; audio.c
play_audio	=$133e

; decompress_fast_v2.s
decompress_lzsa2_fast	=$144f
getsrc_smc	=$1545

; draw_pointer.s
draw_pointer	=$1552

; end_level.s
end_level	=$1695

; gr_copy.s
gr_copy_to_current	=$16b7

; gr_fast_clear.s
clear_all	=$181b
clear_all_color	=$1840

; gr_offsets.s
gr_offsets	=$185e

; gr_page_flip.s
page_flip	=$188e

; gr_putsprite_crop.s
put_sprite_crop	=$18a8

; keyboard.s
handle_keypress	=$19e4
change_location	=$1ab1

; text_print.s
move_and_print	=$1b49

; page_sprites.inc
blue_page_sprite	=$1c44
red_page_sprite	=$1c90
white_page_sprite	=$1ca6
blue_page_small_sprite	=$1cbc
red_page_small_sprite	=$1cc4

; audio files
linking_noise	= $9000
LINKING_NOISE_LENGTH = 43
