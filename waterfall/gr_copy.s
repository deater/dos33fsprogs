	;=========================================================
	; gr_copy_to_current, 40x48 version
	;=========================================================
	; copy 0xc00 to DRAW_PAGE
	;
	; 45 + 2 + 120*(8*9 + 5) -1 + 6 = 9292

gr_copy_to_current:

	lda	DRAW_PAGE					; 3
	clc							; 2
	adc	#$4						; 2
	sta	gr_copy_line+5					; 4
	sta	gr_copy_line+11					; 4
	adc	#$1						; 2
	sta	gr_copy_line+17					; 4
	sta	gr_copy_line+23					; 4
	adc	#$1						; 2
	sta	gr_copy_line+29					; 4
	sta	gr_copy_line+35					; 4
	adc	#$1						; 2
	sta	gr_copy_line+41					; 4
	sta	gr_copy_line+47					; 4
							;===========
							;	45

	ldy	#119		; for early ones, copy 120 bytes	; 2

gr_copy_line:
	lda	$C00,Y		; load a byte (self modified)		; 4
	sta	$400,Y		; store a byte (self modified)		; 5

	lda	$C80,Y		; load a byte (self modified)		; 4
	sta	$480,Y		; store a byte (self modified)		; 5

	lda	$D00,Y		; load a byte (self modified)		; 4
	sta	$500,Y		; store a byte (self modified)		; 5

	lda	$D80,Y		; load a byte (self modified)		; 4
	sta	$580,Y		; store a byte (self modified)		; 5

	lda	$E00,Y		; load a byte (self modified)		; 4
	sta	$600,Y		; store a byte (self modified)		; 5

	lda	$E80,Y		; load a byte (self modified)		; 4
	sta	$680,Y		; store a byte (self modified)		; 5

	lda	$F00,Y		; load a byte (self modified)		; 4
	sta	$700,Y		; store a byte (self modified)		; 5

	lda	$F80,Y		; load a byte (self modified)		; 4
	sta	$780,Y		; store a byte (self modified)		; 5

	dey			; decrement pointer			; 2
	bpl	gr_copy_line	;					; 2nt/3

	rts								; 6





	;=========================================================
	; fast copy rows 22-36 from $C00 to $800
	;=========================================================
	;
	; 6 + 7*8*40 = 2246 cycles
	; 			6*7*40 = 1680 bytes of code?

gr_copy_row22:

;= y = 22 $5a8 =========================
	; x=0,y=22
	lda	$da8
	sta	$9a8
	lda	$da9
	sta	$9a9
	lda	$daa
	sta	$9aa
	lda	$dab
	sta	$9ab
	lda	$dac
	sta	$9ac
	lda	$dad
	sta	$9ad
	lda	$dae
	sta	$9ae
	lda	$daf
	sta	$9af

	; x=8,y=22
	lda	$db0
	sta	$9b0
	lda	$db1
	sta	$9b1
	lda	$db2
	sta	$9b2
	lda	$db3
	sta	$9b3
	lda	$db4
	sta	$9b4
	lda	$db5
	sta	$9b5
	lda	$db6
	sta	$9b6
	lda	$db7
	sta	$9b7

	; x=16,y=22
	lda	$db8
	sta	$9b8
	lda	$db9
	sta	$9b9
	lda	$dba
	sta	$9ba
	lda	$dbb
	sta	$9bb
	lda	$dbc
	sta	$9bc
	lda	$dbd
	sta	$9bd
	lda	$dbe
	sta	$9be
	lda	$dbf
	sta	$9bf

	; x=24,y=22
	lda	$dc0
	sta	$9c0
	lda	$dc1
	sta	$9c1
	lda	$dc2
	sta	$9c2
	lda	$dc3
	sta	$9c3
	lda	$dc4
	sta	$9c4
	lda	$dc5
	sta	$9c5
	lda	$dc6
	sta	$9c6
	lda	$dc7
	sta	$9c7

	; x=32,y=22
	lda	$dc8
	sta	$9c8
	lda	$dc9
	sta	$9c9
	lda	$dca
	sta	$9ca
	lda	$dcb
	sta	$9cb
	lda	$dcc
	sta	$9cc
	lda	$dcd
	sta	$9cd
	lda	$dce
	sta	$9ce
	lda	$dcf
	sta	$9cf

;= y = 24 $628 =========================
	; x=0,y=24
	lda	$e28
	sta	$a28
	lda	$e29
	sta	$a29
	lda	$e2a
	sta	$a2a
	lda	$e2b
	sta	$a2b
	lda	$e2c
	sta	$a2c
	lda	$e2d
	sta	$a2d
	lda	$e2e
	sta	$a2e
	lda	$e2f
	sta	$a2f

	; x=8,y=24
	lda	$e30
	sta	$a30
	lda	$e31
	sta	$a31
	lda	$e32
	sta	$a32
	lda	$e33
	sta	$a33
	lda	$e34
	sta	$a34
	lda	$e35
	sta	$a35
	lda	$e36
	sta	$a36
	lda	$e37
	sta	$a37

	; x=16,y=24
	lda	$e38
	sta	$a38
	lda	$e39
	sta	$a39
	lda	$e3a
	sta	$a3a
	lda	$e3b
	sta	$a3b
	lda	$e3c
	sta	$a3c
	lda	$e3d
	sta	$a3d
	lda	$e3e
	sta	$a3e
	lda	$e3f
	sta	$a3f

	; x=24,y=24
	lda	$e40
	sta	$a40
	lda	$e41
	sta	$a41
	lda	$e42
	sta	$a42
	lda	$e43
	sta	$a43
	lda	$e44
	sta	$a44
	lda	$e45
	sta	$a45
	lda	$e46
	sta	$a46
	lda	$e47
	sta	$a47

	; x=32,y=24
	lda	$e48
	sta	$a48
	lda	$e49
	sta	$a49
	lda	$e4a
	sta	$a4a
	lda	$e4b
	sta	$a4b
	lda	$e4c
	sta	$a4c
	lda	$e4d
	sta	$a4d
	lda	$e4e
	sta	$a4e
	lda	$e4f
	sta	$a4f

;= y = 26 $6a8 =========================
	; x=0,y=26
	lda	$ea8
	sta	$aa8
	lda	$ea9
	sta	$aa9
	lda	$eaa
	sta	$aaa
	lda	$eab
	sta	$aab
	lda	$eac
	sta	$aac
	lda	$ead
	sta	$aad
	lda	$eae
	sta	$aae
	lda	$eaf
	sta	$aaf

	; x=8,y=26
	lda	$eb0
	sta	$ab0
	lda	$eb1
	sta	$ab1
	lda	$eb2
	sta	$ab2
	lda	$eb3
	sta	$ab3
	lda	$eb4
	sta	$ab4
	lda	$eb5
	sta	$ab5
	lda	$eb6
	sta	$ab6
	lda	$eb7
	sta	$ab7

	; x=16,y=26
	lda	$eb8
	sta	$ab8
	lda	$eb9
	sta	$ab9
	lda	$eba
	sta	$aba
	lda	$ebb
	sta	$abb
	lda	$ebc
	sta	$abc
	lda	$ebd
	sta	$abd
	lda	$ebe
	sta	$abe
	lda	$ebf
	sta	$abf

	; x=24,y=26
	lda	$ec0
	sta	$ac0
	lda	$ec1
	sta	$ac1
	lda	$ec2
	sta	$ac2
	lda	$ec3
	sta	$ac3
	lda	$ec4
	sta	$ac4
	lda	$ec5
	sta	$ac5
	lda	$ec6
	sta	$ac6
	lda	$ec7
	sta	$ac7

	; x=32,y=26
	lda	$ec8
	sta	$ac8
	lda	$ec9
	sta	$ac9
	lda	$eca
	sta	$aca
	lda	$ecb
	sta	$acb
	lda	$ecc
	sta	$acc
	lda	$ecd
	sta	$acd
	lda	$ece
	sta	$ace
	lda	$ecf
	sta	$acf

;= y = 28 $728 =========================
	; x=0,y=28
	lda	$e28
	sta	$a28
	lda	$e29
	sta	$a29
	lda	$e2a
	sta	$a2a
	lda	$e2b
	sta	$a2b
	lda	$e2c
	sta	$a2c
	lda	$e2d
	sta	$a2d
	lda	$e2e
	sta	$a2e
	lda	$e2f
	sta	$a2f

	; x=8,y=28
	lda	$e30
	sta	$a30
	lda	$e31
	sta	$a31
	lda	$e32
	sta	$a32
	lda	$e33
	sta	$a33
	lda	$e34
	sta	$a34
	lda	$e35
	sta	$a35
	lda	$e36
	sta	$a36
	lda	$e37
	sta	$a37

	; x=16,y=28
	lda	$e38
	sta	$a38
	lda	$e39
	sta	$a39
	lda	$e3a
	sta	$a3a
	lda	$e3b
	sta	$a3b
	lda	$e3c
	sta	$a3c
	lda	$e3d
	sta	$a3d
	lda	$e3e
	sta	$a3e
	lda	$e3f
	sta	$a3f

	; x=24,y=28
	lda	$e40
	sta	$a40
	lda	$e41
	sta	$a41
	lda	$e42
	sta	$a42
	lda	$e43
	sta	$a43
	lda	$e44
	sta	$a44
	lda	$e45
	sta	$a45
	lda	$e46
	sta	$a46
	lda	$e47
	sta	$a47

	; x=32,y=28
	lda	$e48
	sta	$a48
	lda	$e49
	sta	$a49
	lda	$e4a
	sta	$a4a
	lda	$e4b
	sta	$a4b
	lda	$e4c
	sta	$a4c
	lda	$e4d
	sta	$a4d
	lda	$e4e
	sta	$a4e
	lda	$e4f
	sta	$a4f

;= y = 30 $7a8 =========================
	; x=0,y=30
	lda	$ea8
	sta	$aa8
	lda	$ea9
	sta	$aa9
	lda	$eaa
	sta	$aaa
	lda	$eab
	sta	$aab
	lda	$eac
	sta	$aac
	lda	$ead
	sta	$aad
	lda	$eae
	sta	$aae
	lda	$eaf
	sta	$aaf

	; x=8,y=30
	lda	$eb0
	sta	$ab0
	lda	$eb1
	sta	$ab1
	lda	$eb2
	sta	$ab2
	lda	$eb3
	sta	$ab3
	lda	$eb4
	sta	$ab4
	lda	$eb5
	sta	$ab5
	lda	$eb6
	sta	$ab6
	lda	$eb7
	sta	$ab7

	; x=16,y=30
	lda	$eb8
	sta	$ab8
	lda	$eb9
	sta	$ab9
	lda	$eba
	sta	$aba
	lda	$ebb
	sta	$abb
	lda	$ebc
	sta	$abc
	lda	$ebd
	sta	$abd
	lda	$ebe
	sta	$abe
	lda	$ebf
	sta	$abf

	; x=24,y=30
	lda	$ec0
	sta	$ac0
	lda	$ec1
	sta	$ac1
	lda	$ec2
	sta	$ac2
	lda	$ec3
	sta	$ac3
	lda	$ec4
	sta	$ac4
	lda	$ec5
	sta	$ac5
	lda	$ec6
	sta	$ac6
	lda	$ec7
	sta	$ac7

	; x=32,y=30
	lda	$ec8
	sta	$ac8
	lda	$ec9
	sta	$ac9
	lda	$eca
	sta	$aca
	lda	$ecb
	sta	$acb
	lda	$ecc
	sta	$acc
	lda	$ecd
	sta	$acd
	lda	$ece
	sta	$ace
	lda	$ecf
	sta	$acf

;= y = 28 $728 =========================
	; x=0,y=28
	lda	$e28
	sta	$a28
	lda	$e29
	sta	$a29
	lda	$e2a
	sta	$a2a
	lda	$e2b
	sta	$a2b
	lda	$e2c
	sta	$a2c
	lda	$e2d
	sta	$a2d
	lda	$e2e
	sta	$a2e
	lda	$e2f
	sta	$a2f

	; x=8,y=28
	lda	$e30
	sta	$a30
	lda	$e31
	sta	$a31
	lda	$e32
	sta	$a32
	lda	$e33
	sta	$a33
	lda	$e34
	sta	$a34
	lda	$e35
	sta	$a35
	lda	$e36
	sta	$a36
	lda	$e37
	sta	$a37

	; x=16,y=28
	lda	$e38
	sta	$a38
	lda	$e39
	sta	$a39
	lda	$e3a
	sta	$a3a
	lda	$e3b
	sta	$a3b
	lda	$e3c
	sta	$a3c
	lda	$e3d
	sta	$a3d
	lda	$e3e
	sta	$a3e
	lda	$e3f
	sta	$a3f

	; x=24,y=28
	lda	$e40
	sta	$a40
	lda	$e41
	sta	$a41
	lda	$e42
	sta	$a42
	lda	$e43
	sta	$a43
	lda	$e44
	sta	$a44
	lda	$e45
	sta	$a45
	lda	$e46
	sta	$a46
	lda	$e47
	sta	$a47

	; x=32,y=28
	lda	$e48
	sta	$a48
	lda	$e49
	sta	$a49
	lda	$e4a
	sta	$a4a
	lda	$e4b
	sta	$a4b
	lda	$e4c
	sta	$a4c
	lda	$e4d
	sta	$a4d
	lda	$e4e
	sta	$a4e
	lda	$e4f
	sta	$a4f

;= y = 30 $7a8 =========================
	; x=0,y=30
	lda	$ea8
	sta	$aa8
	lda	$ea9
	sta	$aa9
	lda	$eaa
	sta	$aaa
	lda	$eab
	sta	$aab
	lda	$eac
	sta	$aac
	lda	$ead
	sta	$aad
	lda	$eae
	sta	$aae
	lda	$eaf
	sta	$aaf

	; x=8,y=30
	lda	$eb0
	sta	$ab0
	lda	$eb1
	sta	$ab1
	lda	$eb2
	sta	$ab2
	lda	$eb3
	sta	$ab3
	lda	$eb4
	sta	$ab4
	lda	$eb5
	sta	$ab5
	lda	$eb6
	sta	$ab6
	lda	$eb7
	sta	$ab7

	; x=16,y=30
	lda	$eb8
	sta	$ab8
	lda	$eb9
	sta	$ab9
	lda	$eba
	sta	$aba
	lda	$ebb
	sta	$abb
	lda	$ebc
	sta	$abc
	lda	$ebd
	sta	$abd
	lda	$ebe
	sta	$abe
	lda	$ebf
	sta	$abf

	; x=24,y=30
	lda	$ec0
	sta	$ac0
	lda	$ec1
	sta	$ac1
	lda	$ec2
	sta	$ac2
	lda	$ec3
	sta	$ac3
	lda	$ec4
	sta	$ac4
	lda	$ec5
	sta	$ac5
	lda	$ec6
	sta	$ac6
	lda	$ec7
	sta	$ac7

	; x=32,y=30
	lda	$ec8
	sta	$ac8
	lda	$ec9
	sta	$ac9
	lda	$eca
	sta	$aca
	lda	$ecb
	sta	$acb
	lda	$ecc
	sta	$acc
	lda	$ecd
	sta	$acd
	lda	$ece
	sta	$ace
	lda	$ecf
	sta	$acf

	rts								; 6

