; attempt at rotate-by-shear

; zero-page
GBASL	=	$26
GBASH	=	$27

; soft-switches
FULLGR  =       $C052

; ROM routines
PLOT	=	$F800   ;; PLOT AT Y,A
SETGR	=	$FB40


rotate:
	jsr	SETGR
	bit	FULLGR

	ldx	#8
box_loop:
	ldy	#12
	txa
	jsr	PLOT

	lda	#$ff
draw_line:
	sta	(GBASL),Y
	iny
	cpy	#28
	bne	draw_line

	inx
	inx
	cpx	#40
	bne	box_loop


shear_right:

	ldx	#0
shear_right_loop:
	ldy	#0		; set GBASL/GBASL
	txa
	jsr	PLOT

	lda	GBASL
	sta	rlin_smc+1
	lda	GBASH
	sta	rlin_smc+2


	clc
	lda	x_shift,X
	adc	GBASL
	sta	rlout_smc+1
	lda	#0
	adc	GBASH
	sta	rlout_smc+2

	ldy	#39
rlinner_loop:

rlin_smc:
	lda	$400,Y
rlout_smc:
	sta	$400,Y
	dey
	bpl	rlinner_loop

	inx
	inx
	cpx	#48
	bne	shear_right_loop



done:
	jmp	done


.if 0
5 GR
10 FOR Y=5 TO 43:COLOR=Y:HLIN5,35ATY:NEXT
15 INPUT R
20 A=(R*3.14)/180:T=TAN(A/2):S=SIN(A)
30 GOSUB 1000
130 FOR X=0 TO 39:O=(X-20)*S:IF O<0 GOTO 160
150 FOR Y=0 TO 47:C=0:IF ((Y+O)>0) AND ((Y+O)<47) THEN C=SCRN(X,Y+O)
155 GOTO 170
160 FOR Y=47 TO 0 STEP -1:C=0:IF ((Y+O)>0) AND ((Y+O)<47) THEN C=SCRN(X,Y+O)
170 COLOR=C:PLOT X,Y:NEXT Y,X
200 GOSUB 1000
300 END
1000 FOR Y=0 TO 47:O=-(Y-24)*T:IF O<0 GOTO 1030
1010 FOR X=0 TO 39:C=0:IF ((X+O)>0) AND ((X+O)<39) THEN C=SCRN(X+O,Y)
1020 GOTO 1040
1030 FOR X=39 TO 0 STEP -1:C=0:IF ((X+O)>0) AND ((X+O)<39) THEN C=SCRN(X+O,Y)
1040 COLOR=C:PLOT X,Y:NEXT X,Y:RETURN
.endif

x_shift:
.byte $F9 ; 0 -7.653669
.byte $F9 ; 1 -7.270985
.byte $FA ; 2 -6.888302
.byte $FA ; 3 -6.505618
.byte $FA ; 4 -6.122935
.byte $FB ; 5 -5.740251
.byte $FB ; 6 -5.357568
.byte $FC ; 7 -4.974885
.byte $FC ; 8 -4.592201
.byte $FC ; 9 -4.209518
.byte $FD ; 10 -3.826834
.byte $FD ; 11 -3.444151
.byte $FD ; 12 -3.061467
.byte $FE ; 13 -2.678784
.byte $FE ; 14 -2.296101
.byte $FF ; 15 -1.913417
.byte $FF ; 16 -1.530734
.byte $FF ; 17 -1.148050
.byte $00 ; 18 -0.765367
.byte $00 ; 19 -0.382683
.byte $00 ; 20 0.000000
.byte $00 ; 21 0.382683
.byte $00 ; 22 0.765367
.byte $01 ; 23 1.148050
.byte $01 ; 24 1.530734
.byte $01 ; 25 1.913417
.byte $02 ; 26 2.296101
.byte $02 ; 27 2.678784
.byte $03 ; 28 3.061467
.byte $03 ; 29 3.444151
.byte $03 ; 30 3.826834
.byte $04 ; 31 4.209518
.byte $04 ; 32 4.592201
.byte $04 ; 33 4.974885
.byte $05 ; 34 5.357568
.byte $05 ; 35 5.740251
.byte $06 ; 36 6.122935
.byte $06 ; 37 6.505618
.byte $06 ; 38 6.888302
.byte $07 ; 39 7.270985
y_shift:
.byte $04 ; 0 4.773897
.byte $04 ; 1 4.574984
.byte $04 ; 2 4.376072
.byte $04 ; 3 4.177160
.byte $03 ; 4 3.978247
.byte $03 ; 5 3.779335
.byte $03 ; 6 3.580423
.byte $03 ; 7 3.381510
.byte $03 ; 8 3.182598
.byte $02 ; 9 2.983686
.byte $02 ; 10 2.784773
.byte $02 ; 11 2.585861
.byte $02 ; 12 2.386948
.byte $02 ; 13 2.188036
.byte $01 ; 14 1.989124
.byte $01 ; 15 1.790211
.byte $01 ; 16 1.591299
.byte $01 ; 17 1.392387
.byte $01 ; 18 1.193474
.byte $00 ; 19 0.994562
.byte $00 ; 20 0.795649
.byte $00 ; 21 0.596737
.byte $00 ; 22 0.397825
.byte $00 ; 23 0.198912
.byte $00 ; 24 0.000000
.byte $00 ; 25 -0.198912
.byte $00 ; 26 -0.397825
.byte $00 ; 27 -0.596737
.byte $00 ; 28 -0.795649
.byte $00 ; 29 -0.994562
.byte $FF ; 30 -1.193474
.byte $FF ; 31 -1.392387
.byte $FF ; 32 -1.591299
.byte $FF ; 33 -1.790211
.byte $FF ; 34 -1.989124
.byte $FE ; 35 -2.188036
.byte $FE ; 36 -2.386948
.byte $FE ; 37 -2.585861
.byte $FE ; 38 -2.784773
.byte $FE ; 39 -2.983686
.byte $FD ; 40 -3.182598
.byte $FD ; 41 -3.381510
.byte $FD ; 42 -3.580423
.byte $FD ; 43 -3.779335
.byte $FD ; 44 -3.978247
.byte $FC ; 45 -4.177160
.byte $FC ; 46 -4.376072
.byte $FC ; 47 -4.574984
