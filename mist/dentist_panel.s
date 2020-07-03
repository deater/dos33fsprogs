; Power up, blinks switches yellow
; Change state, change button blinks
; animates to screen
; remembers light switch and date settings even when leave room

; day of month is 1-31 (even on months w/o)
; year 0-9999, leading 0 suppression
; time 1200AM - 1159PM


draw_date:

	;=================
	; month

	lda	#10
	sta	DENTIST_MONTH
	lda	#4
	sta	DENTIST_DAY

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

	lda	#$ff
	sta	ps_smc1+1

	lda	#<year_string
	sta	OUTL
	lda	#>year_string
	sta	OUTH

	jsr	move_and_print


	;=================
	; time

	lda	#<time_string
	sta	OUTL
	lda	#>time_string
	sta	OUTH

	jsr	move_and_print

	lda	#$3f
	sta	ps_smc1+1

	rts

year_string:
	.byte 28,21,'1'+$80,'9'+$80,'5'+$80,'5'+$80,0

time_string:
	.byte 28,23,' '+$80,'6'+$80,'0'+$80,'0'+$80,'A'+$80,'M'+$80,0

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
	.word big_font_space	; C
	.word big_font_space	; D
	.word big_font_e	; E
	.word big_font_f	; F
	.word big_font_space	; G
	.word big_font_space	; H
	.word big_font_space	; I
	.word big_font_j	; J
	.word big_font_space	; K
	.word big_font_space	; L
	.word big_font_space	; M
	.word big_font_n	; N
	.word big_font_o	; O
	.word big_font_space	; P
	.word big_font_space	; Q
	.word big_font_space	; R
	.word big_font_space	; S
	.word big_font_space	; T
	.word big_font_space	; U
	.word big_font_v	; V
	.word big_font_space	; W
	.word big_font_space	; X
	.word big_font_space	; Y
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

big_font_j:
	.byte 3,4
	.byte $a0,$a0,$a0	;
	.byte $a0,$a0,$BA	;   :
	.byte $a0,$a0,$BA	;   :
	.byte $BA,$DF,$BA	; :_:

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

big_font_v:
	.byte 3,4
	.byte $a0,$a0,$a0	;
	.byte $BA,$a0,$BA	; : :
	.byte $BA,$a0,$AF	; : /
	.byte $BA,$AF,$a0	; :/



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
	.byte $BA,$AD,$BA	; :-:
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


