; won't you take me to...

; right side of downtown village

	;=======================
	; check exit
	;=======================
	;

town_check_exit:
	jsr	update_feet_location

	lda	GUYBRUSH_X
	cmp	#2
	bcc	town_to_church

	cmp	#9
	beq	town_to_voodoo

	cmp	#32
	bcc	town_no_exit

town_to_bar:
	lda	GUYBRUSH_FEET
	cmp	#26
	bcs	town_no_exit

	lda	GUYBRUSH_DIRECTION
	cmp	#DIR_UP
	bne	town_no_exit

	lda	#MONKEY_BAR
	sta	LOCATION
	lda	#34
	sta	GUYBRUSH_X
	sta	DESTINATION_X
	lda	#20
	sta	GUYBRUSH_Y
	sta	DESTINATION_Y

	lda	#GUYBRUSH_BIG
	sta	GUYBRUSH_SIZE

	lda	#DIR_LEFT
	sta	GUYBRUSH_DIRECTION
	jsr	change_location
	jmp	town_no_exit

town_to_voodoo:
	lda	GUYBRUSH_FEET
	cmp	#22
	bne	town_no_exit

	lda	#MONKEY_VOODOO1
	sta	LOCATION
	lda	#11
	sta	GUYBRUSH_X
	sta	DESTINATION_X
	lda	#20
	sta	GUYBRUSH_Y
	sta	DESTINATION_Y

	lda	#GUYBRUSH_BIG
	sta	GUYBRUSH_SIZE

	lda	#DIR_RIGHT
	sta	GUYBRUSH_DIRECTION
	jsr	change_location
	jmp	town_no_exit


town_to_church:
	lda	GUYBRUSH_FEET
	cmp	#20
	bcs	town_no_exit

	lda	#MONKEY_CHURCH
	sta	LOCATION
	lda	#34
	sta	GUYBRUSH_X
	sta	DESTINATION_X
	lda	#30
	sta	GUYBRUSH_Y
	sta	DESTINATION_Y

	lda	#GUYBRUSH_SMALL
	sta	GUYBRUSH_SIZE

	lda	#DIR_LEFT
	sta	GUYBRUSH_DIRECTION
	jsr	change_location

town_no_exit:
	rts

	;=======================
	; adjust destination
	;=======================

town_adjust_destination:

	; blah

done_tn_adjust:
	rts


	;=======================
	; adjust bounds
	;=======================
town_check_bounds:

	; if x<2, y unrestricted
	; if 7<x<13, y must be >20
	; if 14<x<32 y must be > 22
	; if 32<x<40, y must be  > 16
	; x can't go past 25

	jsr	update_feet_location

tn_check_x:
	lda	GUYBRUSH_X
	cmp	#2
	bcc	tn_x_gateway

	cmp	#7
	bcc	tn_x_road

	cmp	#12
	bcc	tn_x_voodoo

	cmp	#15
	bcc	tn_x_sidewalk

	cmp	#32
	bcs	tn_x_right
	bcc	tn_x_left

tn_x_gateway:
	jmp	town_adjust_height

tn_x_road:
	lda	GUYBRUSH_FEET
	cmp	#20
	bcs	town_adjust_height
	lda	#(20-2)			; assume tiny
	sta	GUYBRUSH_Y
	sta	DESTINATION_Y
	lda	#GUYBRUSH_TINY
	sta	GUYBRUSH_SIZE
	jmp	town_adjust_height

tn_x_voodoo:
	lda	GUYBRUSH_FEET
	cmp	#22
	bcs	town_adjust_height
	lda	#(22-4)			;  assume small
	sta	GUYBRUSH_Y
	sta	DESTINATION_Y
	lda	#GUYBRUSH_SMALL
	sta	GUYBRUSH_SIZE
	jmp	town_adjust_height

tn_x_sidewalk:
	lda	GUYBRUSH_FEET
	cmp	#26
	bcs	town_adjust_height
	lda	#(26-8)			;  assume medium
	sta	GUYBRUSH_Y
	sta	DESTINATION_Y
	lda	#GUYBRUSH_MEDIUM
	sta	GUYBRUSH_SIZE
	jmp	town_adjust_height

tn_x_left:
	lda	GUYBRUSH_FEET
	cmp	#32
	bcs	town_adjust_height
	lda	#(32-14)		; assume large
	sta	GUYBRUSH_Y
	sta	DESTINATION_Y
	lda	#GUYBRUSH_BIG
	sta	GUYBRUSH_SIZE
	jmp	town_adjust_height

tn_x_right:
	lda	GUYBRUSH_FEET
	cmp	#18
	bcs	town_adjust_height
	lda	#(18-2)			; assume tiny
	sta	GUYBRUSH_Y
	sta	DESTINATION_Y
	jmp	town_adjust_height

	;====================
	; adjust tallness

	; this is based on where your feet are

town_adjust_height:
;	jsr	update_feet_location

	lda	GUYBRUSH_FEET
	cmp	#32
	bcs	town_big	; > 30, big
	cmp	#26		; > 24, medium
	bcs	town_medium
	cmp	#20		; > 20, small
	bcs	town_small
				; else, tiny
towntiny:
	lda	#GUYBRUSH_TINY
	jmp	town_done_set_height
town_big:
	lda	#GUYBRUSH_BIG
	jmp	town_done_set_height
town_medium:
	lda	#GUYBRUSH_MEDIUM
	jmp	town_done_set_height
town_small:
	lda	#GUYBRUSH_SMALL
town_done_set_height:
	jmp	set_height


	;==========================
	;==========================
	; set height
	;==========================
	;==========================
	; we have to adjust destination because it's at feet
	; and that changes when we get small

	; A=new height
set_height:
	cmp	#GUYBRUSH_BIG
	bne	set_height_check_medium
	jmp	set_height_new_big
set_height_check_medium:
	cmp	#GUYBRUSH_MEDIUM
	bne	set_height_check_small
	jmp	set_height_new_medium
set_height_check_small:
	cmp	#GUYBRUSH_SMALL
	bne	set_height_check_tiny
	jmp	set_height_new_small
set_height_check_tiny:
	; fallthrough

	;=================================
set_height_new_tiny:
	lda	GUYBRUSH_SIZE
	cmp	#GUYBRUSH_TINY
	beq	done_set_new_height_tiny
	cmp	#GUYBRUSH_SMALL
	beq	set_height_new_tiny_old_small
	cmp	#GUYBRUSH_MEDIUM
	beq	set_height_new_tiny_old_medium
	; fallthrough
set_height_new_tiny_old_big:
	lda	DESTINATION_Y
	clc
	adc	#12
	sta	DESTINATION_Y
	lda	GUYBRUSH_Y
	clc
	adc	#12
	sta	GUYBRUSH_Y
	lda	#GUYBRUSH_TINY
	jmp	set_new_height_tiny

set_height_new_tiny_old_medium:
	lda	DESTINATION_Y
	clc
	adc	#6
	sta	DESTINATION_Y
	lda	GUYBRUSH_Y
	clc
	adc	#6
	sta	GUYBRUSH_Y
	lda	#GUYBRUSH_TINY
	jmp	set_new_height_tiny

set_height_new_tiny_old_small:
	lda	DESTINATION_Y
	clc
	adc	#2
	sta	DESTINATION_Y

	lda	GUYBRUSH_Y
	clc
	adc	#2
	sta	GUYBRUSH_Y

	lda	#GUYBRUSH_TINY
set_new_height_tiny:
	sta	GUYBRUSH_SIZE
done_set_new_height_tiny:
	rts


	;======================================
set_height_new_small:
	lda	GUYBRUSH_SIZE
	cmp	#GUYBRUSH_SMALL
	beq	done_set_new_height_small
	cmp	#GUYBRUSH_TINY
	beq	set_height_new_small_old_tiny
	cmp	#GUYBRUSH_MEDIUM
	beq	set_height_new_small_old_medium
	; fallthrough
set_height_new_small_old_big:
	lda	DESTINATION_Y
	clc
	adc	#10
	sta	DESTINATION_Y
	lda	GUYBRUSH_Y
	clc
	adc	#10
	sta	GUYBRUSH_Y
	lda	#GUYBRUSH_SMALL
	jmp	set_new_height_small
set_height_new_small_old_medium:
	lda	DESTINATION_Y
	clc
	adc	#4
	sta	DESTINATION_Y
	lda	GUYBRUSH_Y
	clc
	adc	#4
	sta	GUYBRUSH_Y
	lda	#GUYBRUSH_SMALL
	jmp	set_new_height_small
set_height_new_small_old_tiny:
	lda	DESTINATION_Y
	sec
	sbc	#2
	sta	DESTINATION_Y
	lda	GUYBRUSH_Y
	sec
	sbc	#2
	sta	GUYBRUSH_Y
	lda	#GUYBRUSH_SMALL
set_new_height_small:
	sta	GUYBRUSH_SIZE
done_set_new_height_small:
	rts


	;==============================
set_height_new_medium:
	lda	GUYBRUSH_SIZE
	cmp	#GUYBRUSH_MEDIUM
	beq	done_set_new_height_medium
	cmp	#GUYBRUSH_BIG
	beq	set_height_new_medium_old_big
	cmp	#GUYBRUSH_TINY
	beq	set_height_new_medium_old_tiny
	; fallthrough
set_height_new_medium_old_small:
	lda	DESTINATION_Y
	sec
	sbc	#4
	sta	DESTINATION_Y
	lda	GUYBRUSH_Y
	sec
	sbc	#4
	sta	GUYBRUSH_Y
	lda	#GUYBRUSH_MEDIUM
	jmp	set_new_height_medium
set_height_new_medium_old_big:
	lda	DESTINATION_Y
	clc
	adc	#6
	sta	DESTINATION_Y
	lda	GUYBRUSH_Y
	clc
	adc	#6
	sta	GUYBRUSH_Y
	lda	#GUYBRUSH_MEDIUM
	jmp	set_new_height_medium
set_height_new_medium_old_tiny:
	lda	DESTINATION_Y
	sec
	sbc	#6
	sta	DESTINATION_Y
	lda	GUYBRUSH_Y
	sec
	sbc	#6
	sta	GUYBRUSH_Y
	lda	#GUYBRUSH_MEDIUM
set_new_height_medium:
	sta	GUYBRUSH_SIZE
done_set_new_height_medium:
	rts


	;===========================
set_height_new_big:
	lda	GUYBRUSH_SIZE
	cmp	#GUYBRUSH_BIG
	beq	done_set_new_height_big
	cmp	#GUYBRUSH_TINY
	beq	set_height_new_big_old_tiny
	cmp	#GUYBRUSH_MEDIUM
	beq	set_height_new_big_old_medium
set_height_new_big_old_small:
	lda	DESTINATION_Y
	sec
	sbc	#10
	sta	DESTINATION_Y
	lda	GUYBRUSH_Y
	sec
	sbc	#10
	sta	GUYBRUSH_Y
	lda	#GUYBRUSH_BIG
	jmp	set_new_height_big
set_height_new_big_old_medium:
	lda	DESTINATION_Y
	sec
	sbc	#6
	sta	DESTINATION_Y
	lda	GUYBRUSH_Y
	sec
	sbc	#6
	sta	GUYBRUSH_Y
	lda	#GUYBRUSH_BIG
	jmp	set_new_height_big
set_height_new_big_old_tiny:
	lda	DESTINATION_Y
	sec
	sbc	#12
	sta	DESTINATION_Y
	lda	GUYBRUSH_Y
	sec
	sbc	#12
	sta	GUYBRUSH_Y
	lda	#GUYBRUSH_BIG
	jmp	set_new_height_big

set_new_height_big:
	sta	GUYBRUSH_SIZE
done_set_new_height_big:
	rts


	;=====================
	;=====================
	; update feet
	;=====================
	;=====================
update_feet_location:

	lda	GUYBRUSH_SIZE
	cmp	#GUYBRUSH_TINY
	beq	adjust_feet_tiny
	cmp	#GUYBRUSH_SMALL
	beq	adjust_feet_small
	cmp	#GUYBRUSH_MEDIUM
	beq	adjust_feet_medium

adjust_feet_large:
	lda	GUYBRUSH_Y
	clc
	adc	#14
	jmp	done_adjust_feet

adjust_feet_medium:
	lda	GUYBRUSH_Y
	clc
	adc	#8
	jmp	done_adjust_feet

adjust_feet_small:
	lda	GUYBRUSH_Y
	clc
	adc	#4
	jmp	done_adjust_feet
adjust_feet_tiny:
	lda	GUYBRUSH_Y
	clc
	adc	#2
done_adjust_feet:
	sta	GUYBRUSH_FEET
	rts
