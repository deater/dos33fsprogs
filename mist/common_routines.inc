;=============================
; external routines

; loader.s
opendir_filename = $1039

; audio.c
play_audio	= $131b

; decompress_fast_v2.s
decompress_lzsa2_fast = $142c
getsrc_smc	= $1522

; draw_pointer.s
draw_pointer	= $152f

; end_level.s
end_level	= $1672

; gr_copy.s
gr_copy_to_current = $1694

; gr_fast_clear.s
clear_all	= $17f8
clear_all_color	= $181d

; gr_offsets.s
gr_offsets	= $183b

; gr_page_flip.s
page_flip	= $186b

; gr_putsprite_crop.s
put_sprite_crop	= $1885

; keyboard.s
handle_keypress	= $19c1
change_location	= $1a8e

; text_print.s
move_and_print	= $1b26

; common_sprites.inc

; page_sprites.inc
blue_page_sprite	= $1c57
red_page_sprite		= $1c6d
white_page_sprite	= $1c83
blue_page_small_sprite	= $1c99
red_page_small_sprite	= $1ca1

; audio files

linking_noise	= $9000
LINKING_NOISE_LENGTH = 43
