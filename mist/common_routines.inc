;=============================
; external routines

; linking_noise.s
play_link_noise	=$1428

; decompress_fast_v2.s
decompress_lzsa2_fast	=$1444
getsrc_smc	=$153a

; draw_pointer.s
draw_pointer	=$1547

; end_level.s
end_level	=$16b5

; gr_copy.s
gr_copy_to_current	=$16d7

; gr_fast_clear.s
clear_bottom	=$17fd
clear_all	=$183b
clear_all_color	=$1860

; gr_offsets.s
gr_offsets	=$187e

; gr_page_flip.s
page_flip	=$18ae

; gr_putsprite_crop.s
put_sprite_crop	=$18c8
psc_smc1	=$18eb
psc_smc2	=$1983

; keyboard.s
handle_keypress	=$1a04
change_direction	=$1ac8
change_location	=$1b01

; text_print.s
move_and_print	=$1b99
ps_smc1	=$1bc6

; page_sprites.inc
blue_page_sprite	=$1ce2
red_page_sprite	=$1cf8
white_page_sprite	=$1d0e
blue_page_small_sprite	=$1d24
red_page_small_sprite	=$1d2c

