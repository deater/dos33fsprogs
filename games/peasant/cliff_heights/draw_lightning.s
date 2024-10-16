	;=====================
	; draw lightning
	;=====================

draw_lightning:

	;=====================
	; check big

	lda	big_lightning_out
	bne	draw_big_lightning

	;==========================
	; see if need to start
	jsr	random8

	and	#$3f			; 1/64 chance
	bne	done_big_lightning

	;=====================
	; draw big
draw_big_lightning:

	;

	inc	big_lightning_out

	ldx	big_lightning_out
	lda	big_lightning_pattern,X
	bpl	keep_drawing_big_lightning

	;===============
	; done drawing

	lda	#0
	sta	big_lightning_out
	beq	done_big_lightning	; bra


keep_drawing_big_lightning:

	pha
	cmp	#3
	bne	no_boom
        ; boom sound

        lda     #8
        sta     speaker_duration
        lda     #NOTE_G3
        sta     speaker_frequency
        jsr     speaker_tone
no_boom:
	pla
	tax

	lda	big_lightning_l,X
	sta	INL
	lda	big_lightning_h,X
	sta	INH

	lda	big_lightning_x,X
	sta	CURSOR_X
	lda	big_lightning_y,X
	sta	CURSOR_Y

	jsr	hgr_draw_sprite

done_big_lightning:

	;==========================
	; check small

	lda	small_lightning_out
	bne	draw_small_lightning

	;==========================
	; see if need to start
	jsr	random8

	and	#$3f			; 1/64 chance
	bne	done_small_lightning

	;=====================
	; draw small
draw_small_lightning:

	inc	small_lightning_out

	ldx	small_lightning_out
	lda	small_lightning_pattern,X
	bpl	keep_drawing_small_lightning

	;===============
	; done drawing

	lda	#0
	sta	small_lightning_out
	beq	done_small_lightning	; bra


keep_drawing_small_lightning:

	pha
	cmp	#3
	bne	no_little_boom
        ; boom sound

        lda     #8
        sta     speaker_duration
        lda     #NOTE_G3
        sta     speaker_frequency
        jsr     speaker_tone
no_little_boom:
	pla

	tax
	lda	small_lightning_l,X
	sta	INL
	lda	small_lightning_h,X
	sta	INH

	lda	small_lightning_x,X
	sta	CURSOR_X
	lda	small_lightning_y,X
	sta	CURSOR_Y

	jsr	hgr_draw_sprite

done_small_lightning:

	rts

.include "sprites_heights/lightning_sprites.inc"

big_lightning_l:
	.byte <big_lightning0,<big_lightning1,<big_lightning2,<big_lightning3
small_lightning_l:
	.byte <small_lightning0,<small_lightning1,<small_lightning2,<small_lightning3

big_lightning_h:
	.byte >big_lightning0,>big_lightning1,>big_lightning2,>big_lightning3
small_lightning_h:
	.byte >small_lightning0,>small_lightning1,>small_lightning2,>small_lightning3

big_lightning_x:
	.byte 10,12,10,10
small_lightning_x:
	.byte 2,2,2,2

big_lightning_y:
	.byte 26,26,26,26
small_lightning_y:
	.byte 39,39,39,39


; patterns				; assume 1/4 the frame rate?
;	big lightning:	1 (8)		2
;			2 (7)		2
;			3 (11)		3
;			0 (4)		1
;			3 (7)		2
;			0 (6)		2
;			3 (6)		2
;			0,done		1,ff

big_lightning_pattern:
	.byte 1,1,2,2,3,3,3,0,3,3,0,0,3,3,0,$FF

;	small lightning:	
;			1 (5)		2
;			2 (6)		2
;			3 (10)		3
;			0 (5)		1
;			3 (7)		2
;			0 (4)		2
;			3 (6)		2
;			0 done		1,ff

small_lightning_pattern:
	.byte	1,1,2,2,3,3,3,0,3,3,0,0,3,3,0,$ff

big_lightning_out:
	.byte	$00

small_lightning_out:
	.byte	$00

