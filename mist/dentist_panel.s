; See the constellations, right across the sky
; No cigar no lady on his arm, just a guy made of dots and lines

; Power up, blinks switches yellow
; Change state, change button blinks
; animates to screen
; remembers light switch and date settings even when leave room

; day of month is 1-31 (even on months w/o 31 days)
; year 0-9999, leading 0 suppression
; time 1200AM - 1159PM, leading 0 suppression

; slider lights up when you adjust

; the actual constellation does seem to be based on a massive background,
; and a fore-shortened version appears on the panel when up

; but in original myst code?  lower panel while light blinking (change)
; and come back, not blinking, but press button and nothing happens
; and light sticks on?

draw_date:
	;=================
	; draw the bars

	jsr	draw_month_bar
	jsr	draw_date_bar
	jsr	draw_year_bar
	jsr	draw_time_bar
	jsr	draw_button
	jsr	draw_stars

	;=================
	; month

	lda	DENTIST_MONTH		; get month
	asl
	asl
	tay

	sty	saved_month_ptr

	; first letter

	lda	months,Y		; look up in month table

	and	#$3f			; get char from font
	asl
	tay
	lda	big_font,Y
	sta	INL
	lda	big_font+1,Y
	sta	INH

	lda	#$0
	sta	XPOS
	lda	#40
	sta	YPOS

	jsr	put_sprite_raw

	; second letter

	ldy	saved_month_ptr

	lda	months+1,Y		; look up in month table

	and	#$3f			; get char from font
	asl
	tay
	lda	big_font,Y
	sta	INL
	lda	big_font+1,Y
	sta	INH

	lda	#$4
	sta	XPOS
	lda	#40
	sta	YPOS

	jsr	put_sprite_raw

	; third letter

	ldy	saved_month_ptr

	lda	months+2,Y		; look up in month table

	and	#$3f			; get char from font
	asl
	tay
	lda	big_font,Y
	sta	INL
	lda	big_font+1,Y
	sta	INH

	lda	#$8
	sta	XPOS
	lda	#40
	sta	YPOS

	jsr	put_sprite_raw


	;=================
	; day

	; tens

	lda	DENTIST_DAY	; note, starts with 0 so add 1

	sed
	clc
	adc	#1
	cld

	lsr
	lsr
	lsr
	and	#$1E
	beq	skip_tens		; skip tens if zero

	tay
	lda	big_font_num,Y
	sta	INL
	lda	big_font_num+1,Y
	sta	INH

	lda	#16
	sta	XPOS
	lda	#40
	sta	YPOS

	jsr	put_sprite_raw

skip_tens:

	lda	DENTIST_DAY	; note, starts with 0 so add 1

	sed
	clc
	adc	#1
	cld

	and	#$f
	asl

	tay
	lda	big_font_num,Y
	sta	INL
	lda	big_font_num+1,Y
	sta	INH

	lda	#20
	sta	XPOS
	lda	#40
	sta	YPOS

	jsr	put_sprite_raw

	;=================
	; year

	lda	#$ff		; draw in normal text
	sta	ps_smc1+1

	ldx	#0		; nonzero (for leading zero suppression)

	lda	DENTIST_CENTURY
	lsr
	lsr
	lsr
	lsr
	and	#$f
	bne	century_top_not_zero
	lda	#$a0
	bne	store_century_top
century_top_not_zero:
	inx
	ora	#$B0
store_century_top:
	sta	year_string+2

	lda	DENTIST_CENTURY
	and	#$f
	bne	century_bottom_not_zero

	cpx	#0
	bne	century_bottom_not_zero

	lda	#$a0
	bne	store_century_bottom

century_bottom_not_zero:
	inx
	ora	#$B0
store_century_bottom:
	sta	year_string+3

	lda	DENTIST_YEAR
	lsr
	lsr
	lsr
	lsr
	and	#$f
	bne	year_top_not_zero

	cpx	#0
	bne	year_top_not_zero

	lda	#$a0
	bne	store_year_top

year_top_not_zero:
	ora	#$B0
store_year_top:
	sta	year_string+4

	lda	DENTIST_YEAR
	and	#$f
	ora	#$B0
	sta	year_string+5

	lda	#<year_string
	sta	OUTL
	lda	#>year_string
	sta	OUTH

	jsr	move_and_print


	;=================
	; time
	;=================

	lda	DENTIST_HOURS
	beq	is_0dark30

	cmp	#$13
	bcc	update_hour

	sed
	sec
	sbc	#$12
	cld
	jmp	update_hour

is_0dark30:
	lda	#$12
	bne	update_hour

update_hour:
	sta	TEMP


	lda	TEMP

	lsr
	lsr
	lsr
	lsr
	and	#$f
	bne	hour_top_not_zero
	lda	#$a0
	bne	store_hours_top
hour_top_not_zero:
	ora	#$B0
store_hours_top:
	sta	time_string+2

	lda	TEMP
	and	#$f
	ora	#$B0
store_hours_bottom:
	sta	time_string+3

	lda	DENTIST_MINUTES
	lsr
	lsr
	lsr
	lsr
	and	#$f

	ora	#$B0
store_minutes_top:
	sta	time_string+4

	lda	DENTIST_MINUTES
	and	#$f
	ora	#$B0
	sta	time_string+5

	; calculate AM/PM
	; AM if 0..11

	lda	DENTIST_HOURS
	cmp	#$12
	bcc	time_am

time_pm:
	lda	#'P'+$80
	jmp	write_am_pm

time_am:
	lda	#'A'+$80

write_am_pm:
	sta	time_string+6

	lda	#<time_string
	sta	OUTL
	lda	#>time_string
	sta	OUTH

	jsr	move_and_print

	lda	#$3f			; restore to drawing inverse text
	sta	ps_smc1+1

	rts

year_string:
	.byte 28,21,'0'+$80,'0'+$80,'0'+$80,'0'+$80,0

time_string:
	.byte 28,23,'1'+$80,'2'+$80,'0'+$80,'0'+$80,'A'+$80,'M'+$80,0

saved_month_ptr:
	.byte	$00

months:
	.byte "JAN",0
	.byte "FEB",0
	.byte "MAR",0
	.byte "APR",0
	.byte "MAY",0
	.byte "JUN",0
	.byte "JUL",0
	.byte "AUG",0
	.byte "SEP",0
	.byte "OCT",0
	.byte "NOV",0
	.byte "DEC",0


; A B C D E F G H I J K L M N O P Q R S T U V W X Y Z
; 5 1 2 1 3 1 1     3   1 2 3 2 2   2 1 1 3 1     1


big_font:
	.word big_font_space	; @
	.word big_font_a	; A
	.word big_font_b	; B
	.word big_font_c	; C
	.word big_font_d	; D
	.word big_font_e	; E
	.word big_font_f	; F
	.word big_font_g	; G
	.word big_font_space	; H
	.word big_font_space	; I
	.word big_font_j	; J
	.word big_font_space	; K
	.word big_font_l	; L
	.word big_font_m	; M
	.word big_font_n	; N
	.word big_font_o	; O
	.word big_font_p	; P
	.word big_font_space	; Q
	.word big_font_r	; R
	.word big_font_s	; S
	.word big_font_t	; T
	.word big_font_u	; U
	.word big_font_v	; V
	.word big_font_space	; W
	.word big_font_space	; X
	.word big_font_y	; Y
	.word big_font_space	; Z

big_font_space:
	.byte 3,4
	.byte $a0,$a0,$a0
	.byte $a0,$a0,$a0
	.byte $a0,$a0,$a0
	.byte $a0,$a0,$a0

big_font_a:
	.byte 3,4
	.byte $a0,$DF,$a0	;  _
	.byte $BA,$a0,$BA	; : :
	.byte $BA,$AD,$BA	; :-:
	.byte $BA,$a0,$BA	; : :

big_font_b:
	.byte 3,4
	.byte $a0,$DF,$DF	;  __
	.byte $BA,$a0,$AF	; : /
	.byte $BA,$AD,$a0	; :-
	.byte $BA,$DF,$AF	; :_/

big_font_c:
	.byte 3,4
	.byte $a0,$DF,$DF	;  __
	.byte $BA,$a0,$a0	; :
	.byte $BA,$A0,$a0	; :
	.byte $BA,$DF,$DF	; :__

big_font_d:
	.byte 3,4
	.byte $a0,$DF,$a0	;  _
	.byte $BA,$a0,$DC	; : \
	.byte $BA,$a0,$BA	; : :
	.byte $BA,$DF,$AD	; :_/

big_font_e:
	.byte 3,4
	.byte $a0,$DF,$DF	;  __
	.byte $BA,$a0,$a0	; :
	.byte $BA,$AD,$a0	; :-
	.byte $BA,$DF,$DF	; :__

big_font_f:
	.byte 3,4
	.byte $a0,$DF,$DF	;  __
	.byte $BA,$a0,$a0	; :
	.byte $BA,$AD,$a0	; :-
	.byte $BA,$a0,$a0	; :

big_font_g:
	.byte 3,4
	.byte $a0,$DF,$DF	;  __
	.byte $BA,$a0,$a0	; :
	.byte $BA,$a0,$AD	; : -
	.byte $BA,$DF,$BA	; :_:

big_font_j:
	.byte 3,4
	.byte $a0,$a0,$a0	;
	.byte $a0,$a0,$BA	;   :
	.byte $a0,$a0,$BA	;   :
	.byte $BA,$DF,$BA	; :_:

big_font_l:
	.byte 3,4
	.byte $a0,$a0,$a0	;
	.byte $BA,$a0,$a0	; :
	.byte $BA,$a0,$a0	; :
	.byte $BA,$DF,$DF	; :__

big_font_m:
	.byte 3,4
	.byte $a0,$a0,$a0	;
	.byte $BA,$a0,$BA	; : :
	.byte $BA,$D6,$BA	; :V:
	.byte $BA,$a0,$BA	; : :

big_font_n:
	.byte 3,4
	.byte $a0,$a0,$a0	;
	.byte $BA,$a0,$BA	; : :
	.byte $BA,$DC,$BA	; :\:
	.byte $BA,$a0,$BA	; : :

big_font_o:
	.byte 3,4
	.byte $a0,$DF,$a0	;  _
	.byte $BA,$a0,$BA	; : :
	.byte $BA,$a0,$BA	; : :
	.byte $BA,$DF,$BA	; :_:

big_font_p:
	.byte 3,4
	.byte $a0,$DF,$a0	;  _
	.byte $BA,$a0,$BA	; : :
	.byte $BA,$AD,$A7	; :-'
	.byte $BA,$a0,$a0	; :

big_font_r:
	.byte 3,4
	.byte $a0,$DF,$a0	;  _
	.byte $BA,$a0,$BA	; : :
	.byte $BA,$AD,$A7	; :-'
	.byte $BA,$DC,$a0	; :\

big_font_s:
	.byte 3,4
	.byte $a0,$DF,$DF	;  __
	.byte $BA,$a0,$a0	; :
	.byte $a0,$AD,$a0	;  -
	.byte $DF,$DF,$BA	; __:

big_font_t:
	.byte 3,4
	.byte $DF,$DF,$DF	; ___
	.byte $a0,$BA,$a0	;  :
	.byte $a0,$BA,$a0	;  :
	.byte $a0,$BA,$a0	;  :

big_font_u:
	.byte 3,4
	.byte $a0,$a0,$a0	;
	.byte $BA,$a0,$BA	; : :
	.byte $BA,$a0,$BA	; : :
	.byte $BA,$DF,$BA	; :_:

big_font_v:
	.byte 3,4
	.byte $a0,$a0,$a0	;
	.byte $BA,$a0,$BA	; : :
	.byte $BA,$a0,$AF	; : /
	.byte $BA,$AF,$a0	; :/

big_font_y:
	.byte 3,4
	.byte $a0,$a0,$a0	;
	.byte $BA,$a0,$BA	; : :
	.byte $A7,$AE,$A7	; '.'
	.byte $a0,$BA,$a0	;  :

big_font_num:
	.word big_font_0	; 0
	.word big_font_1	; 1
	.word big_font_2	; 2
	.word big_font_3	; 3
	.word big_font_4	; 4
	.word big_font_5	; 5
	.word big_font_6	; 6
	.word big_font_7	; 7
	.word big_font_8	; 8
	.word big_font_9	; 9

big_font_0:
	.byte 3,4
	.byte $a0,$DF,$a0	;  _
	.byte $BA,$a0,$BA	; : :
	.byte $BA,$a0,$BA	; : :
	.byte $BA,$DF,$BA	; :_:

big_font_1:
	.byte 3,4
	.byte $a0,$a0,$a0	;
	.byte $a0,$a0,$BA	;   :
	.byte $a0,$a0,$BA	;   :
	.byte $a0,$a0,$BA	;   :

big_font_2:
	.byte 3,4
	.byte $a0,$DF,$a0	;  _
	.byte $a0,$a0,$BA	;   :
	.byte $a0,$AD,$a0	;  -
	.byte $BA,$DF,$DF	; :__

big_font_3:
	.byte 3,4
	.byte $a0,$DF,$a0	;  _
	.byte $a0,$a0,$BA	;   :
	.byte $a0,$AD,$BA	;  -:
	.byte $a0,$DF,$BA	;  _:

big_font_4:
	.byte 3,4
	.byte $a0,$a0,$a0	;
	.byte $BA,$a0,$BA	; : :
	.byte $A7,$AD,$BA	; '-:
	.byte $A0,$A0,$BA	;   :

big_font_5:
	.byte 3,4
	.byte $a0,$DF,$DF	;  __
	.byte $BA,$a0,$a0	; :
	.byte $a0,$AD,$a0	;  -
	.byte $DF,$DF,$BA	; __:

big_font_6:
	.byte 3,4
	.byte $a0,$DF,$DF	;  __
	.byte $BA,$a0,$a0	; :
	.byte $BA,$AD,$AE	; :-.
	.byte $BA,$DF,$BA	; :_:

big_font_7:
	.byte 3,4
	.byte $DF,$DF,$a0	; __
	.byte $a0,$a0,$BA	;   :
	.byte $a0,$a0,$BA	;   :
	.byte $a0,$a0,$BA	;   :

big_font_8:
	.byte 3,4
	.byte $a0,$DF,$a0	;  _
	.byte $BA,$a0,$BA	; : :
	.byte $BA,$AD,$BA	; :-:
	.byte $BA,$DF,$BA	; :_:
big_font_9:
	.byte 3,4
	.byte $a0,$DF,$a0	;  _
	.byte $BA,$a0,$BA	; : :
	.byte $A7,$AD,$BA	; '-:
	.byte $a0,$DF,$BA	;  _:



; 012345678901234567890
;     _
;  : : : : :
;  : :-: :\:
;:_: : : : :
; __  _  __
;:   :   : /
;:-- :-  :-
;:   :_  :_/
;     _   _
;: : : : : :
;:V: :-: :_/
;: : : : : \

;          1         2         3
;012345678901234567890123456789013456789
; _   __ ___     __  __
;: : :    :        :   :     1984
;: : :    :      --  --
;:_: :__  :  .   :__ :__     10 04 AM
;     _   _ __             _   _
;    | | |  :    :  :   | | | | | | |
;    | | |  :    :  :   |  -| |-| |_|
;     -   - : .  :  :   |  _| |_|   |


; sliders
;  8 -> 25 (18)
; if 16
;							24*60=1440
;    0*12/8 = 0		0*31/8=0	0*9999/8=0	0
;    1*12/8 = 1.5	1*31/8=3.9	1250		180 3:00
;    2*12/8 = 3		2*31/8=7.8	2500		360 6:00
;    3*12/8 = 4.5	11.6		3750		540 9:00
;    4*12/8 = 6		15.5		5000		720 12:00
;    5*12/8 = 7.5	19.4		6250		900 15:00
;    6*12/8 = 9		23.25		7500		1080 18:00
;    7*12/8 = 10.5	27.12		8750		1260 21:00
;    8*12/8 = 12	31		9999		1440 24:00

month_limits:
	.byte 0,1,3,4,6,7,9,10,12
date_limits:
	.byte $00,$04,$08,$12,$16,$20,$24,$28,$31
century_limits:
	.byte $00,$12,$25,$37,$50,$62,$75,$87,$99
hour_limits:
	.byte $00,$03,$06,$09,$12,$15,$18,$21,$23


	;===============================
	;===============================
	; draw the slider bars
	;===============================
	;===============================


draw_month_bar:
	lda	DENTIST_MONTH
	ldx	#0
find_month_yval:
	cmp	month_limits,X
	beq	found_month_yval
	bcc	found_month_yval
	inx
	cpx	#8
	bne	find_month_yval
found_month_yval:
	lda	#22
month_lit_smc:
	ldy	#0
	beq	draw_bar
	dec	month_lit_smc+1
	jmp	draw_lit_bar

draw_date_bar:
	lda	DENTIST_DAY
	ldx	#0
find_date_yval:
	cmp	date_limits,X
	beq	found_date_yval
	bcc	found_date_yval
	inx
	cpx	#8
	bne	find_date_yval
found_date_yval:
	lda	#26
date_lit_smc:
	ldy	#0
	beq	draw_bar
	dec	date_lit_smc+1
	jmp	draw_lit_bar

draw_year_bar:
	lda	DENTIST_CENTURY
	ldx	#0
find_year_yval:
	cmp	century_limits,X
	beq	found_year_yval
	bcc	found_year_yval
	inx
	cpx	#8
	bne	find_year_yval
found_year_yval:
	lda	#30
year_lit_smc:
	ldy	#0
	beq	draw_bar
	dec	year_lit_smc+1
	jmp	draw_lit_bar

draw_time_bar:
	lda	DENTIST_HOURS
	ldx	#0
find_time_yval:
	cmp	hour_limits,X
	beq	found_time_yval
	bcc	found_time_yval
	inx
	cpx	#8
	bne	find_time_yval
found_time_yval:
	lda	#34

time_lit_smc:
	ldy	#0
	beq	draw_bar
	dec	time_lit_smc+1
	jmp	draw_lit_bar

draw_bar:
	sta	XPOS
	txa
	asl
	clc
	adc	#8
	sta	YPOS

	lda	#<panel_bar_sprite
	sta	INL
	lda	#>panel_bar_sprite
	sta	INH

	jsr	put_sprite_crop

	rts

draw_lit_bar:
	sta	XPOS
	txa
	asl
	clc
	adc	#8
	sta	YPOS

	lda	#<panel_bar_lit_sprite
	sta	INL
	lda	#>panel_bar_lit_sprite
	sta	INH

	jsr	put_sprite_crop

	rts

	;==============================
	;==============================
	; draw the button
	;==============================
	;==============================

draw_button:

button_smc:
	lda	#0
	beq	done_button

	lda	FRAMEL
	and	#$20
	beq	done_button

	lda	#<button_on_sprite
	sta	INL
	lda	#>button_on_sprite
	sta	INH

	lda	#20
	sta	XPOS

	lda	#16
	sta	YPOS

	jsr	put_sprite_crop

done_button:
	rts

panel_bar_sprite:
	.byte 3,1
	.byte $00,$00,$00

panel_bar_lit_sprite:
	.byte 3,1
	.byte $00,$dd,$00

button_on_sprite:
	.byte 1,1
	.byte $dd



panel_pressed:

	lda	CURSOR_X
	cmp	#32
	bcs	panel_time
	cmp	#28
	bcs	panel_year
	cmp	#24
	bcs	panel_day
	cmp	#20
	bcs	panel_month
panel_button:

	lda	CURSOR_Y
	cmp	#12
	bcc	done_panel_button
	cmp	#24
	bcs	done_panel_button

	lda	#0
	sta	button_smc+1
	lda	DENTIST_MONTH
	sta	saved_month
	lda	DENTIST_DAY
	sta	saved_day
	lda	DENTIST_CENTURY
	sta	saved_century
	lda	DENTIST_YEAR
	sta	saved_year
	lda	DENTIST_HOURS
	sta	saved_hour
	lda	DENTIST_MINUTES
	sta	saved_minutes

done_panel_button:
	rts

panel_month:
	lda	#5
	sta	month_lit_smc+1

	lda	CURSOR_Y
check_month_dec:
	cmp	#8
	bcs	check_month_inc
	jmp	dec_dentist_month
check_month_inc:
	cmp	#26
	bcc	check_month_bar
	jmp	inc_dentist_month
check_month_bar:
	rts

panel_day:

	lda	#5
	sta	date_lit_smc+1

	lda	CURSOR_Y
check_day_dec:
	cmp	#8
	bcs	check_day_inc
	jmp	dec_dentist_day
check_day_inc:
	cmp	#26
	bcc	check_day_bar
	jmp	inc_dentist_day
check_day_bar:

	rts

panel_year:

	lda	#5
	sta	year_lit_smc+1

	lda	CURSOR_Y
	cmp	#8
	bcc	dec_dentist_year
	cmp	#26
	bcs	inc_dentist_year

	rts


panel_time:

	lda	#5
	sta	time_lit_smc+1

	lda	CURSOR_Y
	cmp	#8
	bcc	dec_dentist_time
	cmp	#26
	bcs	inc_dentist_time

	rts

inc_dentist_time:

	lda	DENTIST_HOURS
	cmp	#$23
	bne	actually_inc_time

	lda	DENTIST_MINUTES
	cmp	#$59
	beq	done_pressed2

actually_inc_time:
	sed
	clc
	lda	DENTIST_MINUTES
	adc	#1
	sta	DENTIST_MINUTES

	cmp	#$60
	bne	done_pressed2

	lda	#$00
	sta	DENTIST_MINUTES
	clc
	lda	DENTIST_HOURS
	adc	#1
	sta	DENTIST_HOURS
	jmp	done_pressed_changed


dec_dentist_time:

	lda	DENTIST_HOURS
	bne	actually_dec_time

	lda	DENTIST_MINUTES
	beq	done_pressed2

actually_dec_time:
	sed
	sec
	lda	DENTIST_MINUTES
	sbc	#1
	sta	DENTIST_MINUTES

	cmp	#$99
	bne	done_pressed2

	lda	#$59
	sta	DENTIST_MINUTES

	lda	DENTIST_HOURS
	sec
	sbc	#1
	sta	DENTIST_HOURS
	jmp	done_pressed_changed

done_pressed2:
	cld
	rts

inc_dentist_year:

	lda	DENTIST_CENTURY
	cmp	#$99
	bne	actually_inc_year

	lda	DENTIST_YEAR
	cmp	#$99
	beq	done_pressed

actually_inc_year:
	sed
	clc
	lda	DENTIST_YEAR
	adc	#1
	sta	DENTIST_YEAR
	lda	DENTIST_CENTURY
	adc	#0
	sta	DENTIST_CENTURY
	jmp	done_pressed_changed

dec_dentist_year:

	lda	DENTIST_CENTURY
	bne	actually_dec_year

	lda	DENTIST_YEAR
	beq	done_pressed

actually_dec_year:
	sed
	sec
	lda	DENTIST_YEAR
	sbc	#1
	sta	DENTIST_YEAR
	lda	DENTIST_CENTURY
	sbc	#0
	sta	DENTIST_CENTURY
	jmp	done_pressed_changed

inc_dentist_month:

	lda	DENTIST_MONTH
	cmp	#11
	beq	done_pressed
	inc	DENTIST_MONTH
	jmp	done_pressed_changed

dec_dentist_month:

	lda	DENTIST_MONTH
	cmp	#0
	beq	done_pressed
	dec	DENTIST_MONTH
	jmp	done_pressed_changed

inc_dentist_day:

	lda	DENTIST_DAY
	cmp	#$30
	beq	done_pressed

	sed
	clc
	adc	#1
	sta	DENTIST_DAY
	jmp	done_pressed_changed

dec_dentist_day:

	lda	DENTIST_DAY
	cmp	#0
	beq	done_pressed
	sed
	sec
	sbc	#1
	sta	DENTIST_DAY
	jmp	done_pressed_changed

done_pressed:
	cld
	rts

done_pressed_changed:
	cld
	lda	#1
	sta	button_smc+1
	rts


	;===========================
	;===========================
	; draw stars
	;===========================
	;===========================
draw_stars:

	jmp	stars_lights_off

	; if lights on
	lda	#6
	sta	XPOS
	lda	#6
	sta	YPOS
	lda	#<lights_on_sprite
	sta	INL
	lda	#>lights_on_sprite
	sta	INH
	jmp	put_sprite_crop

stars_lights_off:

	lda	saved_month
	cmp	#9		; OCTOBER
	beq	draw_leaf
	cmp	#0
	beq	draw_snake
	cmp	#10
	beq	draw_bug
	bne	not_special

; OCT 11 1984 10:04AM (leaf)
draw_leaf:
	lda	saved_day
	cmp	#$11
	bne	not_special
	lda	saved_century
	cmp	#$19
	bne	not_special
	lda	saved_hour
	cmp	#$10
	bne	not_special

	lda	#7
	sta	XPOS
	lda	#8
	sta	YPOS
	lda	#<october_sprite
	sta	INL
	lda	#>october_sprite
	sta	INH
	jmp	put_sprite_crop

; JAN 17 1207 5:46AM (snake)
draw_snake:
	lda	saved_day
	cmp	#$17
	bne	not_special
	lda	saved_century
	cmp	#$12
	bne	not_special
	lda	saved_hour
	cmp	#$5
	bne	not_special

	lda	#7
	sta	XPOS
	lda	#8
	sta	YPOS
	lda	#<january_sprite
	sta	INL
	lda	#>january_sprite
	sta	INH
	jmp	put_sprite_crop

; NOV 23 9791 6:57PM (bug)
draw_bug:
	lda	saved_day
	cmp	#$23
	bne	not_special
	lda	saved_century
	cmp	#$97
	bne	not_special
	lda	saved_hour
	cmp	#$18
	bne	not_special
	lda	#7
	sta	XPOS
	lda	#8
	sta	YPOS
	lda	#<november_sprite
	sta	INL
	lda	#>november_sprite
	sta	INH
	jmp	put_sprite_crop

not_special:
	; plot 4 stars, somewhat randomly based on settings

	; plot 1st
	lda	#$0f
	sta	plot_color+1
	lda	saved_year
	eor	saved_month
	tax
	ldy	saved_minutes
	jsr	special_plot_point

	; plot 2nd
	lda	#$ff
	sta	plot_color+1
	lda	saved_month
	eor	saved_year
	tax
	lda	saved_hour
	sbc	saved_minutes
	tay
	jsr	special_plot_point

	; plot 3rd
	lda	#$f0
	sta	plot_color+1
	lda	saved_hour
	adc	saved_minutes
	tax
	lda	saved_year
	sbc	saved_day
	tay
	jsr	special_plot_point

	; plot 4th
	lda	#$50
	sta	plot_color+1
	lda	saved_minutes
	eor	saved_day
	tax
	lda	saved_year
	adc	saved_day
	tay

	jsr	special_plot_point

	rts

special_plot_point:

	txa
	and	#$7
	clc
	adc	#$7
	sta	CH

	tya
	and	#$7
	clc
	adc	#$4
	sta	CV

	jmp	plot_point

saved_month:
	.byte $00

saved_day:
	.byte $00

saved_century:
	.byte $00

saved_year:
	.byte $00

saved_hour:
	.byte $00

saved_minutes:
	.byte $00


; constellations

; 6x6
lights_on_sprite:
	.byte 9,10
	.byte $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
	.byte $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
	.byte $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
	.byte $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
	.byte $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
	.byte $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
	.byte $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
	.byte $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
	.byte $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
	.byte $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff

; OCT 11 1984 10:04AM (leaf)
october_sprite:
	.byte 7,7
	.byte $00,$00,$00,$00,$00,$f0,$00
	.byte $00,$f0,$00,$00,$00,$0f,$00
	.byte $00,$0f,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00
	.byte $00,$f0,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$ff
	.byte $f0,$0f,$00,$0f,$00,$00,$00

; JAN 17 1207 5:46AM (snake)
january_sprite:
	.byte 7,7
	.byte $00,$0f,$00,$00,$00,$ff,$00
	.byte $00,$ff,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$0f
	.byte $00,$00,$00,$f0,$00,$00,$0f
	.byte $00,$00,$ff,$00,$00,$00,$00

; NOV 23 9791 6:57PM (bug)
november_sprite:
	.byte 7,7
	.byte $f0,$00,$00,$ff,$00,$00,$f0
	.byte $00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$ff,$00,$00,$0f,$00
	.byte $00,$00,$00,$00,$00,$00,$00
	.byte $00,$f0,$00,$00,$00,$f0,$00
	.byte $00,$00,$00,$00,$00,$0f,$00
	.byte $00,$00,$00,$0f,$00,$00,$00



	; turn on double high point at CH,CV
plot_point:
	lda	CV		; y
	asl
	tax
	lda	gr_offsets,X
	sta	OUTL

	lda	gr_offsets+1,X
	clc
	adc	DRAW_PAGE
	sta	OUTH

	lda	CH		; x
	tay

plot_color:
	lda	#$77
	sta	(OUTL),Y

	rts

