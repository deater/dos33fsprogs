;=============================
; external routines

; loader.s
opendir_filename	=$1039

; audio.c
play_audio	=$134e

; decompress_fast_v2.s
decompress_lzsa2_fast	=$145f
getsrc_smc	=$1555

; draw_pointer.s
draw_pointer	=$1562

; end_level.s
end_level	=$16a5

; gr_copy.s
gr_copy_to_current	=$16c7

; gr_fast_clear.s
clear_bottom	=$17ed
clear_all	=$182b
clear_all_color	=$1850

; gr_offsets.s
gr_offsets	=$186e

; gr_page_flip.s
page_flip	=$189e

; gr_putsprite_crop.s
put_sprite_crop	=$18b8
psc_smc1	=$18db
psc_smc2	=$1973

; keyboard.s
handle_keypress	=$19f4
change_location	=$1ad5

; text_print.s
move_and_print	=$1b6d
ps_smc1	=$1b9a

; page_sprites.inc
blue_page_sprite	=$1c82
red_page_sprite	=$1c98
white_page_sprite	=$1cae
blue_page_small_sprite	=$1cc4
red_page_small_sprite	=$1ccc

; audio files
linking_noise	= $9000
LINKING_NOISE_LENGTH = 43
