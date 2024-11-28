; Snake Boxer 5

; more Videlectrix nonsense
;
; by deater (Vince Weaver) <vince@deater.net>


.include "../zp.inc"
.include "../hardware.inc"


sundae_driver:

	;===================
	; set graphics mode
	;===================
	jsr	HOME

	bit	LORES
	bit	FULLGR
	bit	SET_GR
	bit	PAGE1

	lda	#$4
	sta	DRAW_PAGE

	lda	#$0
	sta	FRAME
	sta	FRAMEH
	sta	DISP_PAGE

	;===================
	; Intro
	;===================
	; TODO: animation

intro:

	lda	#<videlectrix_data
	sta	ZX0_src
	lda	#>videlectrix_data
	sta	ZX0_src+1

	lda	#$4			; load at $400

	jsr	full_decomp

	jsr	wait_until_keypress


	;===================
	; TITLE SCREEN
	;===================

title_screen:

	lda	#<title_hgr_data
	sta	ZX0_src
	lda	#>title_hgr_data
	sta	ZX0_src+1

	lda	#$20			; load at $2000

	jsr	full_decomp

	bit	HIRES

	jsr	wait_until_keypress


	;===================
	; DHGR TITLE SCREEN
	;===================

dhgr_title_screen:

	bit	SET_GR
	bit	HIRES
	bit	FULLGR
	sta	AN3             ; set double hires
	sta	EIGHTYCOLON     ; 80 column
	sta	SET80COL        ; 80 store

	bit	PAGE1   ; start in page1

	lda	#<title_dhgr_bin_data
	sta	ZX0_src
	lda	#>title_dhgr_bin_data
	sta	ZX0_src+1

	lda	#$20			; load at $2000

	jsr	full_decomp

	bit	PAGE2			; store in AUX $2000

	lda	#<title_dhgr_aux_data
	sta	ZX0_src
	lda	#>title_dhgr_aux_data
	sta	ZX0_src+1

	lda	#$20

	jsr	full_decomp

	jsr	wait_until_keypress

	; disable 80column mode
        sta     SETAN3
        sta     CLR80COL
        sta     EIGHTYCOLOFF
        bit     PAGE1


	;===================
	; GAMEPLAY SCREEN
	;===================

gameplay_screen:
	bit	LORES


	lda	#<gameplay_data
	sta	ZX0_src
	lda	#>gameplay_data
	sta	ZX0_src+1

	lda	#$4			; load at $400

	jsr	full_decomp

	jsr	wait_until_keypress
.if 0
	;===================
	; Setup Gameplay
	;===================

	lda	#17
	sta	CHERRY_X
	lda	#8
	sta	CHERRY_Y

	lda	#4
	sta	TREE1_X
	lda	#0
	sta	TREE1_Y

	lda	#32
	sta	TREE2_X
	lda	#10
	sta	TREE2_Y

	lda	#13
	sta	SUNDAE_X
	lda	#24
	sta	SUNDAE_Y




	; load graphic to $c00

	lda	#<bg_data
	sta	ZX0_src
	lda	#>bg_data
	sta	ZX0_src+1

	lda	#$c			; load at $c00

	jsr	full_decomp

game_loop:
	;=======================
	; copy over background

	jsr	gr_copy_to_current

	;========================
	; draw things

	jsr	draw_cherry
	jsr	draw_tree1
	jsr	draw_tree2
	jsr	draw_sundae


	;========================
	; move

	inc	SUNDAE_X
	inc	TREE1_Y
	inc	TREE1_Y
	inc	TREE2_Y
	inc	TREE2_Y
	inc	CHERRY_Y
	inc	CHERRY_Y

	;========================
	; page flip

	jsr	page_flip

	jsr	wait_until_keypress

	jmp	game_loop



	;======================
	; game over
	;======================

james_screen:

	lda	#<james_data
	sta	ZX0_src
	lda	#>james_data
	sta	ZX0_src+1

	lda	#$4			; load at $400

	jsr	full_decomp


	jsr	wait_until_keypress
.endif

done:
	jmp	done




wait_until_keypress:
	lda	KEYPRESS				; 4
	bpl	wait_until_keypress			; 3
	bit	KEYRESET	; clear the keyboard buffer

	rts

.include "../zx02_optim.s"

.include "../gr_offsets.s"
.include "../gr_pageflip.s"
.include "../gr_copy.s"
.include "../gr_putsprite_mask.s"

.if 0
	;====================
	; draw cherry
draw_cherry:
	lda	CHERRY_X
	sta	XPOS
	lda	CHERRY_Y
	sta	YPOS

	lda	#<cherry_mask
	sta	MASKL
	lda	#>cherry_mask
	sta	MASKH

	lda	#<cherry_sprite
	sta	INL
	lda	#>cherry_sprite
	sta	INH
	jsr	gr_put_sprite_mask
        rts

	;====================
	; draw tree1
draw_tree1:
	lda	TREE1_X
	sta	XPOS
	lda	TREE1_Y
	sta	YPOS

	lda	#<tree1_mask
	sta	MASKL
	lda	#>tree1_mask
	sta	MASKH

	lda	#<tree1_sprite
	sta	INL
	lda	#>tree1_sprite
	sta	INH
	jsr	gr_put_sprite_mask
        rts

	;====================
	; draw tree2
draw_tree2:
	lda	TREE2_X
	sta	XPOS
	lda	TREE2_Y
	sta	YPOS

	lda	#<tree2_mask
	sta	MASKL
	lda	#>tree2_mask
	sta	MASKH

	lda	#<tree2_sprite
	sta	INL
	lda	#>tree2_sprite
	sta	INH
	jsr	gr_put_sprite_mask
        rts

	;====================
	; draw sundae
draw_sundae:
	lda	SUNDAE_X
	sta	XPOS
	lda	SUNDAE_Y
	sta	YPOS

	lda	#<sundae1_mask
	sta	MASKL
	lda	#>sundae1_mask
	sta	MASKH

	lda	#<sundae1_sprite
	sta	INL
	lda	#>sundae1_sprite
	sta	INH
	jsr	gr_put_sprite_mask
        rts

.endif


videlectrix_data:
	.incbin "graphics/videlectrix.gr.zx02"

gameplay_data:
	.incbin "graphics/gameplay.gr.zx02"

title_hgr_data:
	.incbin "graphics/title.hgr.zx02"

title_dhgr_aux_data:
	.incbin "graphics/title.dhgr.aux.zx02"

title_dhgr_bin_data:
	.incbin "graphics/title.dhgr.bin.zx02"

