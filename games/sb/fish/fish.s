; Fishing Challenge '91
;
; "Are you asking for some sort of early-90s fishing challenge????"
;
; Yet Another HR project
;
; by deater (Vince Weaver) <vince@deater.net>

.include "zp.inc"
.include "hardware.inc"

; NOTES FROM WIKI
; green fish 50 or 100
; grey fish 100 points
; red fish 400 or 500
; bubbles easier to catch?
; grey = lures, red green = jigs


; NOTES
;	page1= $2000-$5fff
;	code = $6000-$bfff


div7_table     = $400
mod7_table     = $500
hposn_high     = $600
hposn_low      = $700


fish_start:

	;===================
	; set graphics mode
	;===================
	jsr	HOME

	bit	HIRES
	bit	FULLGR
	bit	SET_GR
	bit	PAGE1

	;====================
	; set up tables
	;====================

	lda	#$20
	sta	HGR_PAGE
	jsr	hgr_make_tables

	;==========================
	; Load Sound
	;===========================

	lda	SOUND_STATUS
	and	#SOUND_IN_LC
	beq	done_load_sound

	; read/write RAM, use $d000 bank1
	bit	$C083
	bit	$C083

	; fish = 4225 bytes  load at $D000 - $E0FF
	; boat = 4966 bytes  load at $E100 - $F4FF

	lda	#<sound_data_fish
	sta	ZX0_src
	lda	#>sound_data_fish
	sta	ZX0_src+1

	lda	#$D0

	jsr	full_decomp

	lda	#<sound_data_boat
	sta	ZX0_src
	lda	#>sound_data_boat
	sta	ZX0_src+1

	lda	#$E1

	jsr	full_decomp

	; read ROM/no-write
	bit	$C082

done_load_sound:

	;==========================
	; Load Title
	;===========================

load_title:
	lda	#<title_data
	sta	ZX0_src
	lda	#>title_data
	sta	ZX0_src+1

	lda	#$20

	jsr	full_decomp


wait_at_tile:
	lda	KEYPRESS
	bpl	wait_at_tile

	bit	KEYRESET

	;===================
	; print directions
	;===================
	; in the actual game this is overlay ontop of the faded gameplay
	; that would be a pain so we're not going to do it

	lda	#$0
	sta	DRAW_PAGE

	jsr	clear_all

	bit	LORES
	bit	FULLGR
	bit	SET_TEXT
	bit	PAGE1

	lda	#<help_text
	sta	OUTL
	lda	#>help_text
	sta	OUTH

	jsr	set_normal		; normal text

	ldx	#9
print_help:
	jsr	move_and_print
	dex
	bne	print_help

wait_at_directions:
	lda	KEYPRESS
	bpl	wait_at_directions

	bit	KEYRESET

	;===================
	; setup game
	;===================

;	lda	#0
;	sta	DRAW_PAGE


	jmp	skip_ahead


help_text:
	.byte 0,0,"INSTRUCTIONS:",0
	.byte 5,3,"- PRESS 'J' TO JIG",0
	.byte 5,4,"- PRESS 'L' TO LURE",0
	.byte 5,7,"SOME FISH RESPOND TO LURES,",0
	.byte 5,8,"OTHERS TO JIGS.",0
	.byte 5,11,"CATCH MORE FISH FOR MAXIMUM",0
	.byte 5,12,"FUNTIME!",0
	.byte 13,20,"PRESS SPACEBAR!",0		; note, flash?

sound_data_fish:
	.incbin "sounds/fish.btc.zx02"
sound_data_boat:
	.incbin "sounds/get_in_boat.btc.zx02"

title_data:
	.incbin "graphics/fish_title.hgr.zx02"


skip_ahead:

	;==========================
	; Load Background
	;===========================

load_background:

	lda	#<bg_data
	sta	ZX0_src
	lda	#>bg_data
	sta	ZX0_src+1

	lda	#$20

	jsr	full_decomp

	lda	#<bg_data
	sta	ZX0_src
	lda	#>bg_data
	sta	ZX0_src+1

	lda	#$40

	;===================
	; set up variables


	bit	HIRES
	bit	FULLGR
	bit	SET_GR
	bit	PAGE1

	; re-set up hgr tables

	lda	#$20
	sta	HGR_PAGE
	jsr	hgr_make_tables



	; start at least 8k in?

	;==========================
	; main loop
	;===========================
main_loop:



	jsr	flip_page

.if 0

	;========================
	; copy over background
	;========================
reset_loop:

	lda	FRAME
	and	#$2
	beq	odd_bg
even_bg:
	lda	#$A0
	bne	do_bg
odd_bg:
	lda	#$80
do_bg:
	jsr	hgr_copy
.endif

	lda	#<bg_data
	sta	ZX0_src
	lda	#>bg_data
	sta	ZX0_src+1

	clc
	lda	DRAW_PAGE
	adc	#$20

	jsr	full_decomp

	inc	FRAME

	;==========================
	; copy over proper boat
	;==========================

	lda	FRAME
;	lsr
;	lsr
	and	#$3
	tax

	lda	boat_offsets,X
	sta	BOAT_OFFSET


	lda	boat_sprites_l,X
	sta	INL
	lda	boat_sprites_h,X
	sta	INH
	lda	#8
	sta	SPRITE_X
	lda	#94
	sta	SPRITE_Y
	jsr	hgr_draw_sprite_big

	;===========================
	; draw strong bad
	;===========================

draw_strong_bad:

	lda	ANIMATION_TYPE
	cmp	#ANIMATION_LURE
	beq	draw_lure_animation
	cmp	#ANIMATION_JIG
	beq	draw_jig_animation

draw_regular_animation:
	lda	#<sb_sprite
	sta	INL
	lda	#>sb_sprite
	sta	INH

	lda	#23
	sta	SPRITE_X
	lda	#42
	sta	SPRITE_Y

	jmp	draw_common_animation

draw_lure_animation:
	ldx	ANIMATION_COUNT
	lda	lure_sprites_l,X
	sta	INL
	lda	lure_sprites_h,X
	sta	INH

	lda	#23
	sta	SPRITE_X
	lda	#42
	sta	SPRITE_Y
	jmp	draw_common_animation

draw_jig_animation:
	ldx	ANIMATION_COUNT
	lda	jig_sprites_l,X
	sta	INL
	lda	jig_sprites_h,X
	sta	INH

	lda	#22
	sta	SPRITE_X
	lda	#27
	sta	SPRITE_Y

update_animation:
	dec	ANIMATION_COUNT
	bpl	draw_common_animation

	; done

	lda	#ANIMATION_NONE
	sta	ANIMATION_TYPE

draw_common_animation:
	lda	SPRITE_Y
	clc
	adc	BOAT_OFFSET
	sta	SPRITE_Y

	jsr	hgr_draw_sprite_big

	;==========================
	; update score?
	;===========================


	;============================
	; draw fish
	;============================

	;============================
	; play sound
	;============================

;	ldy	#5
;	jsr	play_asplode


	;===========================
	; check keypress
	;===========================

check_keypress:
	lda     KEYPRESS
	bpl	done_keyboard_check

	bit     KEYRESET		; clear the keyboard strobe

	; clear high bit
	and	#$7f

	and	#$df			; convert lowercase to upper

	cmp	#27		; escape
	beq	done_game

	cmp	#'J'		; jig
	beq	do_jig
	cmp	#'L'		; lure
	beq	do_lure

done_keyboard_check:
	jmp	main_loop


do_jig:
	jsr	play_boat		; `come on and get in the boat'
	lda	#ANIMATION_JIG
	sta	ANIMATION_TYPE
	lda	#10
	sta	ANIMATION_COUNT

	jmp	main_loop

do_lure:
	jsr	play_fish		; 'fish'
	lda	#ANIMATION_LURE
	sta	ANIMATION_TYPE
	lda	#10
	sta	ANIMATION_COUNT
	jmp	main_loop

	;==========================
	; done game
	;==========================

done_game:
	lda	#0
really_done_game:
	sta	WHICH_LOAD
	rts


.if 0

wait_until_keypress:
	lda	KEYPRESS				; 4
	bpl	wait_until_keypress			; 3
	bit	KEYRESET	; clear the keyboard buffer
	rts

.endif
	;==========
	; flip page
	;==========
flip_page:
	lda	DRAW_PAGE
	beq	draw_page2
draw_page1:
	bit	PAGE2
	lda	#0

	beq	done_flip

draw_page2:
	bit	PAGE1
	lda	#$20

done_flip:
	sta	DRAW_PAGE

	rts

boat_sprites_l:
	.byte <boat2_sprite,<boat1_sprite,<boat3_sprite,<boat1_sprite

boat_sprites_h:
	.byte >boat2_sprite,>boat1_sprite,>boat3_sprite,>boat1_sprite

	; add to Y to account for boat moving
	; 1   2   3
	; 18, 15, 19
boat_offsets:
	.byte 0,3,4,3

	; 2 3 2 1 2 3 2 1 2 3 2
	; c r c l c r c l c r c
jig_sprites_l:
	.byte <sb_boat2_sprite,<sb_boat3_sprite
	.byte <sb_boat2_sprite,<sb_boat1_sprite
	.byte <sb_boat2_sprite,<sb_boat3_sprite
	.byte <sb_boat2_sprite,<sb_boat1_sprite
	.byte <sb_boat2_sprite,<sb_boat3_sprite
	.byte <sb_boat2_sprite
jig_sprites_h:
	.byte >sb_boat2_sprite,>sb_boat3_sprite
	.byte >sb_boat2_sprite,>sb_boat1_sprite
	.byte >sb_boat2_sprite,>sb_boat3_sprite
	.byte >sb_boat2_sprite,>sb_boat1_sprite
	.byte >sb_boat2_sprite,>sb_boat3_sprite
	.byte >sb_boat2_sprite

	; 0 1 0 2 0 1 0 2 0 1 0
	; m u m d m u m d m u m
lure_sprites_l:
	.byte <sb_sprite,<sb_fish1_sprite
	.byte <sb_sprite,<sb_fish2_sprite
	.byte <sb_sprite,<sb_fish1_sprite
	.byte <sb_sprite,<sb_fish2_sprite
	.byte <sb_sprite,<sb_fish1_sprite
	.byte <sb_sprite
lure_sprites_h:
	.byte >sb_sprite,>sb_fish1_sprite
	.byte >sb_sprite,>sb_fish2_sprite
	.byte >sb_sprite,>sb_fish1_sprite
	.byte >sb_sprite,>sb_fish2_sprite
	.byte >sb_sprite,>sb_fish1_sprite
	.byte >sb_sprite


bg_data:
	.incbin "graphics/fish_bg.hgr.zx02"


	.include	"zx02_optim.s"
	.include	"gr_fast_clear.s"

	.include	"hgr_tables.s"
	.include	"hgr_sprite_big.s"
;	.include	"hgr_copy_fast.s"
	.include	"audio.s"
	.include	"play_sounds.s"
	.include	"text_print.s"
	.include	"gr_offsets.s"

	.include	"graphics/boat_sprites.inc"
	.include	"graphics/strongbad_sprites.inc"
	.include	"graphics/fish_sprites.inc"

