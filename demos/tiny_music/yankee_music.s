
	; 0 1  2 3  4 5 6  7 8  9 10 11
	; C C# D D# E F F# G G# A A# B

	; CCOONNNN -- c=channel, o=octave, n=note
	; 11LLLLLL -- L=length	1/32=1, 1/16=2, 1/8=4, 1/4=8 1/2=16 1=32

yankee_doodle_song:
	.byte	$17	;00 01 0111	G3 1/4
	.byte	$4B	;01 00 1011	B2 1
	.byte	$87	;10 00 0111	G2 1
	.byte	$C8	;11 00 1000	wait 1/4

	.byte	$17	;00 01 0111	G3
	.byte	$C8	;11 00 1000	wait 1/4

	.byte	$19	;00 01 1001	A3
	.byte	$C8	;11 00 1000	wait 1/4

	.byte	$1B	;00 01 1011	B3
	.byte	$C8	;11 00 1000	wait 1/4

;
	.byte	$17	;00 01 0111	G3
	.byte	$4B	;01 00 1011	B2 1/2
	.byte	$87	;10 00 0111	G2 1/2
	.byte	$C8	;11 00 1000	wait 1/4

	.byte	$1B	;00 01 1011	B3
	.byte	$C8	;11 00 1000	wait 1/4

	.byte	$19	;00 01 1001	A3
	.byte	$58	;01 01 1000	C3 1/2
	.byte	$82	;10 00 0010	D2 1/2
	.byte	$C8	;11 00 1000	wait 1/4

	.byte	$12	;00 01 0010	D3
	.byte	$C8	;11 00 1000	wait 1/4
;
	.byte	$17	;00 01 0111	G3
	.byte	$4B	;01 00 1011	B2 1
	.byte	$87	;10 00 0111	G2 1
	.byte	$C8	;11 00 1000	wait 1/4

	.byte	$17	;00 01 0111	G3
	.byte	$C8	;11 00 1000	wait 1/4

	.byte	$19	;00 01 1001	A3
	.byte	$C8	;11 00 1000	wait 1/4

	.byte	$1B	;00 01 1011	B3
	.byte	$C8	;11 00 1000	wait 1/4
;
	.byte	$17	;00 01 0111	G3
	.byte	$4B	;01 00 1011	B2 1/2
	.byte	$87	;10 00 0111	G2 1/2
	.byte	$D0	;11 01 0000	wait 1/2

	.byte	$16	;00 01 0110	F#3
	.byte	$42	;01 00 0010	D2 1
	.byte	$90	;10 01 0000	C3 1
	.byte	$C8	;11 00 1000	wait 1/4

	.byte	$12	;00 01 0010	D3
	.byte	$C8	;11 00 1000	wait 1/4
;
	.byte	$17	;00 01 0111	G3
	.byte	$4B	;01 00 1011	B2 1/2
	.byte	$87	;10 00 0111	G2 1/2
	.byte	$C8	;11 00 1000	wait 1/4

	.byte	$17	;00 01 0111	G3
	.byte	$C8	;11 00 1000	wait 1/4

	.byte	$19	;00 01 1001	A3
	.byte	$46	;01 00 0110	F#2 1/2
	.byte	$86	;10 00 0110	F#2 1/2
	.byte	$C8	;11 00 1000	wait 1/4

	.byte	$1B	;00 01 1011	B3
	.byte	$C8	;11 00 1000	wait 1/4
;
	.byte	$20	;00 10 0000	C4
	.byte	$44	;01 00 0100	E2 1/2
	.byte	$84	;10 00 0100	E2 1/2
	.byte	$C8	;11 00 1000	wait 1/4

	.byte	$1B	;00 01 1011	B3
	.byte	$C8	;11 00 1000	wait 1/4

	.byte	$19	;00 01 1001	A3
	.byte	$41	;01 00 0001	C#2 1/2
	.byte	$81	;10 00 0001	C#2 1/2
	.byte	$C8	;11 00 1000	wait 1/4

	.byte	$17	;00 01 0111	G3
	.byte	$C8	;11 00 1000	wait 1/4
;
	.byte	$16	;00 01 0110	F#3
	.byte	$42	;01 00 0020	D2 1
	.byte	$82	;10 00 0020	D2 1
	.byte	$C8	;11 00 1000	wait 1/4

	.byte	$12	;00 01 0010	D3
	.byte	$C8	;11 00 1000	wait 1/4

	.byte	$14	;00 01 0100	E3
	.byte	$C8	;11 00 1000	wait 1/4

	.byte	$16	;00 01 0110	F#3
	.byte	$C8	;11 00 1000	wait 1/4
;
	.byte	$17	;00 01 0111	G3
	.byte	$47	;01 00 0111	G2 1/2
	.byte	$87	;10 00 0111	G2 1/2
	.byte	$D0	;11 01 0000	wait 1/2

	.byte	$17	;00 01 0111	G3
	.byte	$4B	;01 00 1011	B1 1/2
	.byte	$8B	;10 00 1011	B1 1/2
	.byte	$D0	;11 01 0000	wait 1/2

	.byte	$FF

