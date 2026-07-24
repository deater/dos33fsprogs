.include "../zp.inc"
.include "../hardware.inc"


test_sound:
	lda	#0
	sta	SOUND_STATUS
	sta	DRAW_PAGE

	jsr	HOME

	lda	#<text_list
	sta	OUTL
	lda	#>text_list
	sta	OUTH

	ldx	#19
print_loop:
	jsr	move_and_print
	dex
	bne	print_loop

test_sound_loop:

keypress_loop:
        lda     KEYPRESS
        bpl     keypress_loop
        bit     KEYRESET

	and	#$7f
	sec
	sbc	#$41

	cmp	#20
	bcs	test_sound_loop

	tax

	lda	effect_table_h,X
	sta	call_smc+2
	lda	effect_table_l,X
	sta	call_smc+1

call_smc:
	jsr	$d000

	jmp	test_sound_loop


wait_until_keypress:
        lda     KEYPRESS
        bpl     wait_until_keypress
        bit     KEYRESET

	rts

.include "redbook_sound.s"
.include "../wait.s"
.include "../wait_a_bit.s"
.include "../text_print.s"
.include "../gr_offsets.s"

.include "arrow_shoot.s"
.include "baby_lady.s"
.include "bullseye.s"
.include "burninate.s"
.include "earthquake.s"
.include "falling.s"
.include "gary_neigh.s"
.include "get_point.s"
.include "guitar.s"
.include "kerrek_appear.s"
.include "mud_slip.s"
.include "mud_splat.s"
.include "raise_up.s"
.include "rumble.s"
.include "thunder.s"
.include "trogdor_appear.s"
.include "twinkle.s"
.include "videlectrix.s"
.include "game_over.s"

text_list:
.byte 0,0,"A: ARROW_SHOOT",0
.byte 0,1,"B: BABY_LADY",0
.byte 0,2,"C: BULLSEYE",0
.byte 0,3,"D: BURNINATE",0
.byte 0,4,"E: EARTHQUAKE",0
.byte 0,5,"F: FALLING",0
.byte 0,6,"G: GARY_NEIGH",0
.byte 0,7,"H: GET_POINT",0
.byte 0,8,"I: GUITAR",0
.byte 0,9,"J: KERREK_APPEAR",0
.byte 0,10,"K: MUD_SLIP",0
.byte 0,11,"L: MUD_SPLAT",0
.byte 0,12,"M: RAISE_UP",0
.byte 0,13,"N: RUMBLE",0
.byte 0,14,"O: THUNDER",0
.byte 0,15,"P: TROGDOR_APPEAR",0
.byte 0,16,"Q: TWINKLE",0
.byte 0,17,"R: VIDELECTRIX",0
.byte 0,18,"S: GAME_OVER",0
.byte $ff

effect_table_l:
	.byte <(arrow_shoot_sound),<(baby_lady_gone_sound)
	.byte <(bullseye_sound),<(burninate_sound)
	.byte <(earthquake_sound),<(falling_sound)
	.byte <(gary_neigh_sound),<(get_point_sound)
	.byte <(guitar_sound),<(kerrek_warning_music)
	.byte <(mud_slip_sound),<(mud_splat_sound)
	.byte <(raise_up_sound),<(rumble_sound)
	.byte <(thunder_sound),<(trogdor_appear_sound)
	.byte <(twinkle_sound),<(videlectrix_theme)
	.byte <(game_over_music)

effect_table_h:

	.byte >(arrow_shoot_sound),>(baby_lady_gone_sound)
	.byte >(bullseye_sound),>(burninate_sound)
	.byte >(earthquake_sound),>(falling_sound)
	.byte >(gary_neigh_sound),>(get_point_sound)
	.byte >(guitar_sound),>(kerrek_warning_music)
	.byte >(mud_slip_sound),>(mud_splat_sound)
	.byte >(raise_up_sound),>(rumble_sound)
	.byte >(thunder_sound),>(trogdor_appear_sound)
	.byte >(twinkle_sound),>(videlectrix_theme)
	.byte >(game_over_music)
