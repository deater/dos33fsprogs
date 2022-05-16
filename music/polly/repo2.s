; Soft Switches
KEYPRESS= $C000
KEYRESET= $C010
SPEAKER	= $C030


WAIT            = $FCA8         ; delay 1/2(26+27A+5A^2) us
				;  MAX=35968 = 35ms or so

; 121755 (121ms)
; 243510000 = 26+27A+5A2



COUNT	= $FF

repo2:

	lda	KEYPRESS
	bpl	done
	bit	KEYRESET

check1:
	cmp	#'1'+$80
	bne	check2
	jsr	pattern1
	jmp	repo2

check2:
	cmp	#'2'+$80
	bne	check3
	jsr	pattern2
	jmp	repo2

check3:
	cmp	#'3'+$80
	bne	check4
	jsr	drum1
	jmp	repo2

check4:
	cmp	#'4'+$80
	bne	check5
	jsr	drum2
	jmp	repo2

check5:
	cmp	#'5'+$80
	bne	check6
	jsr	drum3
	jmp	repo2

check6:

	cmp	#'6'+$80
	bne	check7
;	jsr	drum4
	jmp	repo2

check7:


done:


	jmp	repo2



pattern1:

	lda	#35
	sta	COUNT

pattern1_loop:


; for cycles
;	5466 to draw
;	current delay=200 = 19135

; total cycles = 2458*35= 86030

;1203    //35 times (halfway a 1259)
;1254

;1200


	bit	SPEAKER							;4

	; want 1203-4 = 1199
	; Try X=8 Y=26 cycles=1197

	nop	; 2

	ldy	#26							; 2
loop3:
	ldx	#8							; 2
loop4:
	dex								; 2
	bne	loop4							; 2nt/3

	dey								; 2
	bne	loop3							; 2nt/3


	; want 1254-4 = 1250

	bit	SPEAKER							; 4

	; Try X=248 Y=1 cycles=1247
	lda	$0		; 3

	ldy	#1							; 2
loop5:
	ldx	#248							; 2
loop6:
	dex								; 2
	bne	loop6							; 2nt/3

	dey								; 2
	bne	loop5							; 2nt/3


	dec	COUNT
	bne	pattern1_loop


	rts




pattern2:	; bip

	lda	#35
	sta	COUNT

pattern2_loop:


;812    //35 times
;772
;873


	bit	SPEAKER							;4

	; want 812-4 = 808
	; Try X=1 Y=73 cycles=804

	nop	; 2
	nop	; 2

	ldy	#73							; 2
loop7:
	ldx	#1							; 2
loop8:
	dex								; 2
	bne	loop8							; 2nt/3

	dey								; 2
	bne	loop7							; 2nt/3


	; want 772-4 = 768

	bit	SPEAKER							; 4

	; Try X=9 Y=15 cycles=766

	nop		; 2

	ldy	#15							; 2
loop9:
	ldx	#9							; 2
loop10:
	dex								; 2
	bne	loop10							; 2nt/3

	dey								; 2
	bne	loop9							; 2nt/3


	; want 873-4 = 869

	bit	SPEAKER							; 4

	; Try X=42 Y=4 cycles=865

	nop		; 2
	nop		; 2

	ldy	#4							; 2
loop11:
	ldx	#42							; 2
loop12:
	dex								; 2
	bne	loop12							; 2nt/3

	dey								; 2
	bne	loop11							; 2nt/3


	dec	COUNT
	bne	pattern2_loop


	rts



	;=============================
	;

drum1:
	bit	$C030
	jsr	delay_1600
	jsr	delay_800
	jsr	delay_200

	bit	$C030
	jsr	delay_800
	jsr	delay_400

	bit	$C030
	jsr	delay_800

	bit	$C030
	jsr	delay_800
	jsr	delay_400

	bit	$C030
	jsr	delay_1600
	jsr	delay_800
	jsr	delay_400

	bit	$C030
	jsr	delay_200

	bit	$C030
	jsr	delay_400

	bit	$C030
	jsr	delay_1600
	jsr	delay_800

	bit	$C030
	jsr	delay_3200
	jsr	delay_800
	jsr	delay_400

	bit	$C030
	jsr	delay_800
	jsr	delay_200

	bit	$C030
	jsr	delay_200

	bit	$C030
	rts


	;=============================
	;

drum2:
	bit	$C030
	jsr	delay_800

	bit	$C030
	jsr	delay_400

	bit	$C030
	jsr	delay_800
	jsr	delay_400

	bit	$C030
	jsr	delay_800
	jsr	delay_200

	bit	$C030
	jsr	delay_800
	jsr	delay_400

	bit	$C030
	jsr	delay_1600
	jsr	delay_200

	bit	$C030
	jsr	delay_200

	bit	$C030
	jsr	delay_400
	jsr	delay_200

	bit	$C030
	jsr	delay_1600
	jsr	delay_800

	bit	$C030
	jsr	delay_1600
	jsr	delay_800

	bit	$C030
	rts


	;=============================
	;

drum3:
	bit	$C030
	jsr	delay_1600
	jsr	delay_800

	bit	$C030
	jsr	delay_400

	bit	$C030
	jsr	delay_200

	bit	$C030
	jsr	delay_200

	bit	$C030
	jsr	delay_200
	jsr	delay_400

	bit	$C030
	jsr	delay_400
	jsr	delay_800

	bit	$C030
	jsr	delay_800

	bit	$C030
	rts



	; subtract 6(jsr)6(rts)11(below)
	; want 177
	; Try X=2 Y=11 cycles=177
delay_200:
	ldy	#11			; 2
	ldx	#2			; 2
	stx	xdelay_smc+1		; 4
	jmp	do_custom_delay		; 3


	; subtract 6(jsr)6(rts)11(below)
	; want 377
	; Try X=74 Y=1 cycles=377
delay_400:
	ldy	#1			; 2
	ldx	#74			; 2
	stx	xdelay_smc+1		; 4
	jmp	do_custom_delay		; 3


	; subtract 6(jsr)6(rts)11(below)
	; want 777
	; Try X=154 Y=1 cycles=777
delay_800:
	ldy	#1			; 2
	ldx	#154			; 2
	stx	xdelay_smc+1		; 4
	jmp	do_custom_delay		; 3


	; subtract 6(jsr)6(rts)11(below)
	; want 1577
	; Try X=3 Y=75 cycles=1576
delay_1600:
	ldy	#75			; 2
	ldx	#3			; 2
	stx	xdelay_smc+1		; 4
	jmp	do_custom_delay		; 3

	; subtract 6(jsr)6(rts)11(below)
	; want 3177
	; Try X=8 Y=69 cycles=3175
delay_3200:
	ldy	#69			; 2
	ldx	#8			; 2
	stx	xdelay_smc+1		; 4
	jmp	do_custom_delay		; 3

do_custom_delay:
	ldy	#15							; 2
dcd_outer:
xdelay_smc:
	ldx	#9							; 2
dcd_inner:
	dex								; 2
	bne	dcd_inner						; 2nt/3

	dey								; 2
	bne	dcd_outer						; 2nt/3

	rts


