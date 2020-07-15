;=============================
; external routines

; loader.s
opendir_filename	=$1042

; audio.c
play_audio	=$1369

; decompress_fast_v2.s
decompress_lzsa2_fast	=$147a
getsrc_smc	=$1570

; draw_pointer.s
draw_pointer	=$157d

; end_level.s
end_level	=$16e9

; gr_copy.s
gr_copy_to_current	=$170b

; gr_fast_clear.s
clear_bottom	=$1831
clear_all	=$186f
clear_all_color	=$1894

; gr_offsets.s
gr_offsets	=$18b2

; gr_page_flip.s
page_flip	=$18e2

; gr_putsprite_crop.s
put_sprite_crop	=$18fc
psc_smc1	=$191f
psc_smc2	=$19b7

; keyboard.s
handle_keypress	=$1a38
change_location	=$1b19

; text_print.s
move_and_print	=$1bb1
ps_smc1	=$1bde

; page_sprites.inc
blue_page_sprite	=$1cc6
red_page_sprite	=$1cdc
white_page_sprite	=$1cf2
blue_page_small_sprite	=$1d08
red_page_small_sprite	=$1d10

; audio files
linking_noise	= $9000
LINKING_NOISE_LENGTH = 43
