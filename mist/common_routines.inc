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
end_level	=$16ca

; gr_copy.s
gr_copy_to_current	=$16ec

; gr_fast_clear.s
clear_bottom	=$1812
clear_all	=$1850
clear_all_color	=$1875

; gr_offsets.s
gr_offsets	=$1893

; gr_page_flip.s
page_flip	=$18c3

; gr_putsprite_crop.s
put_sprite_crop	=$18dd
psc_smc1	=$1900
psc_smc2	=$1998

; keyboard.s
handle_keypress	=$1a19
change_location	=$1afa

; text_print.s
move_and_print	=$1b92
ps_smc1	=$1bbf

; page_sprites.inc
blue_page_sprite	=$1ca7
red_page_sprite	=$1cbd
white_page_sprite	=$1cd3
blue_page_small_sprite	=$1ce9
red_page_small_sprite	=$1cf1

; audio files
linking_noise	= $9000
LINKING_NOISE_LENGTH = 43
