;=============================
; external routines

; loader.s
opendir_filename	=$1039

; audio.c
play_audio	=$1346

; decompress_fast_v2.s
decompress_lzsa2_fast	=$1457
getsrc_smc	=$154d

; draw_pointer.s
draw_pointer	=$155a

; end_level.s
end_level	=$169d

; gr_copy.s
gr_copy_to_current	=$16bf

; gr_fast_clear.s
clear_all	=$1823
clear_all_color	=$1848

; gr_offsets.s
gr_offsets	=$1866

; gr_page_flip.s
page_flip	=$1896

; gr_putsprite_crop.s
put_sprite_crop	=$18b0

; keyboard.s
handle_keypress	=$19ec
change_location	=$1acd

; text_print.s
move_and_print	=$1b65

; page_sprites.inc
blue_page_sprite	=$1c7a
red_page_sprite	=$1c90
white_page_sprite	=$1ca6
blue_page_small_sprite	=$1cbc
red_page_small_sprite	=$1cc4

; audio files
linking_noise	= $9000
LINKING_NOISE_LENGTH = 43
