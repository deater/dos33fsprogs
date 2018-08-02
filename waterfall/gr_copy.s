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

;= y = 22 $5a8 $da8/$9a8 =========================
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

;= y = 24 $628 $e28/$a28 =========================
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

;= y = 26 $6a8 $ea8/$aa8 =========================
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

;= y = 28 $728 $f28/$b28 =========================
	; x=0,y=28
	lda	$f28
	sta	$b28
	lda	$f29
	sta	$b29
	lda	$f2a
	sta	$b2a
	lda	$f2b
	sta	$b2b
	lda	$f2c
	sta	$b2c
	lda	$f2d
	sta	$b2d
	lda	$f2e
	sta	$b2e
	lda	$f2f
	sta	$b2f

	; x=8,y=28
	lda	$f30
	sta	$b30
	lda	$f31
	sta	$b31
	lda	$f32
	sta	$b32
	lda	$f33
	sta	$b33
	lda	$f34
	sta	$b34
	lda	$f35
	sta	$b35
	lda	$f36
	sta	$b36
	lda	$f37
	sta	$b37

	; x=16,y=28
	lda	$f38
	sta	$b38
	lda	$f39
	sta	$b39
	lda	$f3a
	sta	$b3a
	lda	$f3b
	sta	$b3b
	lda	$f3c
	sta	$b3c
	lda	$f3d
	sta	$b3d
	lda	$f3e
	sta	$b3e
	lda	$f3f
	sta	$b3f

	; x=24,y=28
	lda	$f40
	sta	$b40
	lda	$f41
	sta	$b41
	lda	$f42
	sta	$b42
	lda	$f43
	sta	$b43
	lda	$f44
	sta	$b44
	lda	$f45
	sta	$b45
	lda	$f46
	sta	$b46
	lda	$f47
	sta	$b47

	; x=32,y=28
	lda	$f48
	sta	$b48
	lda	$f49
	sta	$b49
	lda	$f4a
	sta	$b4a
	lda	$f4b
	sta	$b4b
	lda	$f4c
	sta	$b4c
	lda	$f4d
	sta	$b4d
	lda	$f4e
	sta	$b4e
	lda	$f4f
	sta	$b4f

;= y = 30 $7a8 $fa8/$ba8 =========================
	; x=0,y=30
	lda	$fa8
	sta	$ba8
	lda	$fa9
	sta	$ba9
	lda	$faa
	sta	$baa
	lda	$fab
	sta	$bab
	lda	$fac
	sta	$bac
	lda	$fad
	sta	$bad
	lda	$fae
	sta	$bae
	lda	$faf
	sta	$baf

	; x=8,y=30
	lda	$fb0
	sta	$bb0
	lda	$fb1
	sta	$bb1
	lda	$fb2
	sta	$bb2
	lda	$fb3
	sta	$bb3
	lda	$fb4
	sta	$bb4
	lda	$fb5
	sta	$bb5
	lda	$fb6
	sta	$bb6
	lda	$fb7
	sta	$bb7

	; x=16,y=30
	lda	$fb8
	sta	$bb8
	lda	$fb9
	sta	$bb9
	lda	$fba
	sta	$bba
	lda	$fbb
	sta	$bbb
	lda	$fbc
	sta	$bbc
	lda	$fbd
	sta	$bbd
	lda	$fbe
	sta	$bbe
	lda	$fbf
	sta	$bbf

	; x=24,y=30
	lda	$fc0
	sta	$bc0
	lda	$fc1
	sta	$bc1
	lda	$fc2
	sta	$bc2
	lda	$fc3
	sta	$bc3
	lda	$fc4
	sta	$bc4
	lda	$fc5
	sta	$bc5
	lda	$fc6
	sta	$bc6
	lda	$fc7
	sta	$bc7

	; x=32,y=30
	lda	$fc8
	sta	$bc8
	lda	$fc9
	sta	$bc9
	lda	$fca
	sta	$bca
	lda	$fcb
	sta	$bcb
	lda	$fcc
	sta	$bcc
	lda	$fcd
	sta	$bcd
	lda	$fce
	sta	$bce
	lda	$fcf
	sta	$bcf

;= y = 32 $450 $c50/$850 =========================
	; x=0,y=32
	lda	$c50
	sta	$850
	lda	$c51
	sta	$851
	lda	$c52
	sta	$852
	lda	$c53
	sta	$853
	lda	$c54
	sta	$854
	lda	$c55
	sta	$855
	lda	$c56
	sta	$856
	lda	$c57
	sta	$857

	; x=8,y=32
	lda	$c58
	sta	$858
	lda	$c59
	sta	$859
	lda	$c5a
	sta	$85a
	lda	$c5b
	sta	$85b
	lda	$c5c
	sta	$85c
	lda	$c5d
	sta	$85d
	lda	$c5e
	sta	$85e
	lda	$c5f
	sta	$85f

	; x=16,y=32
	lda	$c60
	sta	$860
	lda	$c61
	sta	$861
	lda	$c62
	sta	$862
	lda	$c63
	sta	$863
	lda	$c64
	sta	$864
	lda	$c65
	sta	$865
	lda	$c66
	sta	$866
	lda	$c67
	sta	$867

	; x=24,y=32
	lda	$c68
	sta	$868
	lda	$c69
	sta	$869
	lda	$c6a
	sta	$86a
	lda	$c6b
	sta	$86b
	lda	$c6c
	sta	$86c
	lda	$c6d
	sta	$86d
	lda	$c6e
	sta	$86e
	lda	$c6f
	sta	$86f

	; x=32,y=32
	lda	$c70
	sta	$870
	lda	$c71
	sta	$871
	lda	$c72
	sta	$872
	lda	$c73
	sta	$873
	lda	$c74
	sta	$874
	lda	$c75
	sta	$875
	lda	$c76
	sta	$876
	lda	$c77
	sta	$877

;= y = 34 $4d0 $cd0/$8d0 =========================
	; x=0,y=34
	lda	$cd0
	sta	$8d0
	lda	$cd1
	sta	$8d1
	lda	$cd2
	sta	$8d2
	lda	$cd3
	sta	$8d3
	lda	$cd4
	sta	$8d4
	lda	$cd5
	sta	$8d5
	lda	$cd6
	sta	$8d6
	lda	$cd7
	sta	$8d7

	; x=8,y=34
	lda	$cd8
	sta	$8d8
	lda	$cd9
	sta	$8d9
	lda	$cda
	sta	$8da
	lda	$cdb
	sta	$8db
	lda	$cdc
	sta	$8dc
	lda	$cdd
	sta	$8dd
	lda	$cde
	sta	$8de
	lda	$cdf
	sta	$8df

	; x=16,y=34
	lda	$ce0
	sta	$8e0
	lda	$ce1
	sta	$8e1
	lda	$ce2
	sta	$8e2
	lda	$ce3
	sta	$8e3
	lda	$ce4
	sta	$8e4
	lda	$ce5
	sta	$8e5
	lda	$ce6
	sta	$8e6
	lda	$ce7
	sta	$8e7

	; x=24,y=34
	lda	$ce8
	sta	$8e8
	lda	$ce9
	sta	$8e9
	lda	$cea
	sta	$8ea
	lda	$ceb
	sta	$8eb
	lda	$cec
	sta	$8ec
	lda	$ced
	sta	$8ed
	lda	$cee
	sta	$8ee
	lda	$cef
	sta	$8ef

	; x=32,y=34
	lda	$cf0
	sta	$8f0
	lda	$cf1
	sta	$8f1
	lda	$cf2
	sta	$8f2
	lda	$cf3
	sta	$8f3
	lda	$cf4
	sta	$8f4
	lda	$cf5
	sta	$8f5
	lda	$cf6
	sta	$8f6
	lda	$cf7
	sta	$8f7

	rts								; 6

