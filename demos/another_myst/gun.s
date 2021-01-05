;
; Gun behavior
;
; When 'L' pressed gun is charging
; we handle that here


	;===================================
	; handle/draw all gun related stuff
	;===================================
handle_gun:

	;===================
	; check_gun_firing
	;===================
	jsr	check_gun_firing

	;=======================
	; draw gun charge effect
	;=======================

	jsr	draw_gun_charging

	;================
	; move laser
	;================

	jsr	move_laser

	;================
	; draw laser
	;================

	jsr	draw_laser

	;================
	; move blast
	;================

	jsr	move_blast

	;================
	; draw blast
	;================

	jsr	draw_blast

	;================
	; draw shields
	;================

	jmp	draw_shields

;	rts


	;====================
	;====================
	; check gun firing
	;====================
	;====================

check_gun_firing:

	lda	HAVE_GUN		; no gun, do nothing
	beq	no_have_gun

	;================
	; fire laser
	;================

	lda     LASER_OUT
	beq     no_fire_laser
	jsr     fire_laser
no_fire_laser:
	lda     #0
	sta     LASER_OUT


	lda	GUN_STATE		; gun not charging, do nothing
	beq	done_gun

	lda	GUN_FIRE		; if fired, fire it
	bne	fire_gun

	; increment gun state

	lda	FRAMEL			; slow down
	and	#$7
	bne	done_inc_gun_state

	inc	GUN_STATE

	; saturate

	lda	GUN_STATE
	cmp	#24
	bne	done_inc_gun_state

	lda	#21			; wrap at end
	sta	GUN_STATE

done_inc_gun_state:


	jmp	done_gun

fire_gun:
	; fire here

	lda	GUN_STATE
	cmp	#5
	bcc	done_gun		; too short, do nothing

	cmp	#21
	bcs	do_blast		; too long, blast

	; shield

	jsr	activate_shield
	jmp	done_firing
do_blast:
	jsr	fire_blast

done_firing:
	lda	#0
	sta	GUN_STATE
done_gun:
no_have_gun:
	lda	#0
	sta	GUN_FIRE

	rts


	;============================
	; draw gun charging effect
	;============================
draw_gun_charging:

	lda	HAVE_GUN		; no gun, do nothing
	beq	done_draw_gun_charging

	lda	GUN_STATE		; gun not charging, do nothing
	beq	done_draw_gun_charging


	; set direction

	lda	DIRECTION
	bne	zap_right

zap_left:

	ldx	PHYSICIST_X
	dex
	dex
	stx	XPOS

	jmp	done_zap

zap_right:

	lda	PHYSICIST_X
	clc
	adc	#5
	sta	XPOS
done_zap:

	lda	PHYSICIST_Y
	clc
	adc	#4

	ldy	PHYSICIST_STATE
	cpy	#P_CROUCH_SHOOTING
	bne	done_zap_ypos
	clc
	adc	#4

done_zap_ypos:
	sta	YPOS

	ldy	GUN_STATE
	lda	gun_charge_progression,Y
	tay

	lda	gun_charge_table_lo,Y
	sta	INL

	lda	gun_charge_table_hi,Y
	sta	INH

	jsr	put_sprite

done_draw_gun_charging:
	rts

; progression

gun_charge_progression:
	.byte	0,0,0,1,2,3
	.byte	4,5,6,4,5,6,4,5,6,4,5,6,4,5,6	; 20
	.byte	7,8,9

gun_charge_table_lo:
	.byte <gun_charge_sprite0
	.byte <gun_charge_sprite1
	.byte <gun_charge_sprite2
	.byte <gun_charge_sprite3
	.byte <gun_charge_sprite4
	.byte <gun_charge_sprite5
	.byte <gun_charge_sprite6
	.byte <gun_charge_sprite7
	.byte <gun_charge_sprite8
	.byte <gun_charge_sprite9

gun_charge_table_hi:
	.byte >gun_charge_sprite0
	.byte >gun_charge_sprite1
	.byte >gun_charge_sprite2
	.byte >gun_charge_sprite3
	.byte >gun_charge_sprite4
	.byte >gun_charge_sprite5
	.byte >gun_charge_sprite6
	.byte >gun_charge_sprite7
	.byte >gun_charge_sprite8
	.byte >gun_charge_sprite9



; startup

gun_charge_sprite0:
	.byte	2,2
	.byte	$AA,$AA
	.byte	$AA,$AA

gun_charge_sprite1:
	.byte	2,2
	.byte	$fA,$AA
	.byte	$AA,$AA

gun_charge_sprite2:
	.byte	2,2
	.byte	$22,$AA
	.byte	$AA,$AA

gun_charge_sprite3:
	.byte	2,2
	.byte	$ef,$eA
	.byte	$fe,$Ae

; medium

gun_charge_sprite4:
	.byte	2,2
	.byte	$ff,$AA
	.byte	$Ae,$AA

gun_charge_sprite5:
	.byte	2,2
	.byte	$ef,$AA
	.byte	$Ae,$AA

gun_charge_sprite6:
	.byte	2,2
	.byte	$ef,$AA
	.byte	$Af,$AA

; large

gun_charge_sprite7:
	.byte	2,2
	.byte	$fe,$fe
	.byte	$Ae,$Ae

gun_charge_sprite8:
	.byte	2,2
	.byte	$fe,$fe
	.byte	$ef,$ef

gun_charge_sprite9:
	.byte	2,2
	.byte	$ff,$ff
	.byte	$Ae,$Ae


