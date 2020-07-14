finger_point_sprite:
	.byte 5,5
	.byte $AA,$BB,$AA,$AA,$AA
	.byte $AA,$BB,$AA,$AA,$AA
	.byte $BA,$BB,$BB,$BB,$BB
	.byte $AB,$BB,$BB,$BB,$BB
	.byte $AA,$BB,$BB,$BB,$AA

finger_grab_sprite:
	.byte 5,5
	.byte $AA,$AA,$BB,$AA,$AA
	.byte $BB,$AA,$BB,$AA,$BB
	.byte $BB,$BA,$BB,$BA,$BB
	.byte $AB,$BB,$BB,$BB,$BB
	.byte $AA,$BB,$BB,$BB,$AA

finger_left_sprite:
	.byte 6,4
	.byte $AA,$AA,$AA,$AB,$BA,$AA
	.byte $BB,$BB,$BB,$BB,$BB,$BB
	.byte $AA,$AA,$BB,$BB,$BB,$BB
	.byte $AA,$AA,$AB,$BB,$BB,$AB

finger_right_sprite:
	.byte 6,4
	.byte $AA,$BA,$AB,$AA,$AA,$AA
	.byte $BB,$BB,$BB,$BB,$BB,$BB
	.byte $BB,$BB,$BB,$BB,$AA,$AA
	.byte $AB,$BB,$BB,$AB,$AA,$AA

finger_turn_left_sprite:
	.byte 6,4
	.byte $aa,$aa,$ba,$bb,$aa,$aa
	.byte $ba,$bb,$bb,$bb,$bb,$ba
	.byte $aa,$ab,$bb,$bb,$ab,$bb
	.byte $aa,$aa,$aa,$ab,$aa,$ab

finger_turn_right_sprite:
	.byte 6,4
	.byte $aa,$aa,$bb,$ba,$aa,$aa
	.byte $ba,$bb,$bb,$bb,$bb,$ba
	.byte $bb,$ab,$bb,$bb,$ab,$aa
	.byte $ab,$aa,$ab,$aa,$aa,$aa

finger_match_sprite:
	.byte 6,4
	.byte $aa,$aa,$aa,$aa,$ba,$ba
	.byte $1a,$da,$da,$db,$db,$db
	.byte $a1,$ad,$ad,$bd,$bd,$ad
	.byte $aa,$aa,$aa,$aa,$ab,$bb

finger_match_lit_sprite:
	.byte 6,4
	.byte $9a,$a9,$aa,$aa,$ba,$ba
	.byte $19,$da,$da,$db,$db,$db
	.byte $a9,$ad,$ad,$bd,$bd,$ad
	.byte $aa,$aa,$aa,$aa,$ab,$bb

finger_key_sprite:
	.byte 6,4
	.byte $aa,$aa,$aa,$aa,$aa,$ba
	.byte $dd,$dd,$dd,$dd,$db,$bb
	.byte $aa,$ad,$aa,$ab,$bd,$bb
	.byte $aa,$aa,$aa,$aa,$ab,$ab

finger_red_page_sprite:
	.byte 5,5
	.byte $3a,$33,$33,$aa,$aa
	.byte $33,$33,$33,$ba,$aa
	.byte $33,$b3,$33,$bb,$ba
	.byte $33,$3b,$bb,$bb,$bb
	.byte $a3,$a3,$bb,$bb,$bb

finger_blue_page_sprite:
	.byte 5,5
	.byte $6a,$66,$66,$aa,$aa
	.byte $66,$66,$66,$ba,$aa
	.byte $66,$b6,$66,$bb,$ba
	.byte $66,$6b,$bb,$bb,$bb
	.byte $a6,$a6,$bb,$bb,$bb

finger_white_page_sprite:
	.byte 5,5
	.byte $fa,$ff,$ff,$aa,$aa
	.byte $ff,$ff,$ff,$ba,$aa
	.byte $ff,$bf,$ff,$bb,$ba
	.byte $ff,$fb,$bb,$bb,$bb
	.byte $af,$af,$bb,$bb,$bb
