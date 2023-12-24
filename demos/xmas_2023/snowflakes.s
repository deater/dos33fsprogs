do_snow:
	bit	HIRES
	bit	PAGE1

	lda	#0
	sta	FRAMEL
	sta	FRAMEH
	sta	DRAW_PAGE

	lda	#8
	sta	XPOS
	lda	#100
	sta	YPOS

do_snow_loop:
	;======================
	; update frame count

	inc	FRAMEL                                                  ; 5
	lda	FRAMEL                                                  ; 3
	and	#$3f                                                    ; 2
	sta	FRAMEL                                                  ; 3
	bne	frame_noflo8                                            ; 2/3
	inc	FRAMEH                                                  ; 5
frame_noflo8:

	lda	KEYPRESS
	bmi	done_do_snow

	; wait for_pattern / end

	lda	SOUND_STATUS
	and	#SOUND_MOCKINGBOARD
	beq	no_music8

;       lda     #1
;       cmp     current_pattern_smc+1
;       bcc     totally_done_fireplace
;       beq     totally_done_fireplace
;       jmp     done_music4

no_music8:
	lda	FRAMEH
	cmp	#6
	beq	done_do_snow

done_music8:

	jsr	hgr_clear_screen

; 0123456789012345678901234567890123456789
;   XXXXXX         XXXXXX         XXXXXX

	lda	#2
        sta	SPRITE_X
	ldy	YPOS
        lda	sin2,Y
        sta	SPRITE_Y
	lda     #<snow_sprite
	sta     INL
	lda     #>snow_sprite
	sta     INH
	jsr	hgr_draw_sprite_big

	lda	#17
        sta	SPRITE_X
	ldy	YPOS
        lda	sin1,Y
        sta	SPRITE_Y
	lda     #<snow_sprite
	sta     INL
	lda     #>snow_sprite
	sta     INH
	jsr	hgr_draw_sprite_big

	lda	#32
        sta	SPRITE_X
	ldy	YPOS
        lda	sin2,Y
        sta	SPRITE_Y
	lda     #<snow_sprite
	sta     INL
	lda     #>snow_sprite
	sta     INH
	jsr	hgr_draw_sprite_big



	jsr	hgr_page_flip

;	lda	#128
;	jsr	wait

	inc	YPOS
;	lda	YPOS
;	cmp	#150
;	bcc	ypos_ok

;	lda	#100
;	sta	YPOS

;ypos_ok:


	jmp	do_snow_loop

done_do_snow:
	rts

.include "hgr_sprite_big.s"
.include "hgr_clear_screen.s"
.include "hgr_page_flip.s"

.include "graphics/snow.inc"

