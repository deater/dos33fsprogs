;=====================================
; XMAS2018 -- Ball Reflections
;=====================================

;======================================
; First two = (54+47+47+47)*2 = 390
; Next four = (54+47+42+42)*4 = 740
; Next two =  (49+42+42+42)*4 = 700
; return		          6
;======================================
;                              1836

do_reflection:

	;19========================
	;==========================
	;==========================

	;=============
	; LORES 19x40 -> HIRES 119x156
	ldx	#$d5							; 2
	stx	MASK							; 3
	ldy	#(119/7)						; 2
	lda	$663							; 4
	jsr	reflection11						; 6+37
								;===========
								;	54

	;=============
	; LORES 19x42 -> HIRES 119x152
	lda	$6E3							; 4
	jsr	reflection12						; 6+37
								;=============
								;       47

	;=============
	; LORES 19x44 -> HIRES 119x148
	lda	$763							; 4
	jsr	reflection13						; 6+37
								;=============
								;       47
	;=============
	; LORES 19x46 -> HIRES 119x144
	lda	$7E3							; 4
	jsr	reflection14						; 6+37
								;=============
								;       47


	;20========================
	;==========================
	;==========================

	;=============
	; LORES 20x40 -> HIRES 126x156
	ldx	#$aa							; 2
	stx	MASK							; 3
	ldy	#(126/7)						; 2
	lda	$664							; 4
	jsr	reflection11						;6+37
								;============
								;	49
	;=============
	; LORES 20x42 -> HIRES 126x152
	lda	$6E4							; 4
	jsr	reflection12						; 6+37
								;=============
								;	47
	;=============
	; LORES 20x44 -> HIRES 126x148
	lda	$764							; 4
	jsr	reflection13						; 6+37
								;=============
								;       47
	;=============
	; LORES 20x46 -> HIRES 126x144
	lda	$7E4							; 4
	jsr	reflection14						; 6+37
								;=============
								;	47


	;18========================
	;==========================
	;==========================

	;=============
	; LORES 18x40 -> HIRES 112x153x4
	ldx	#$aa							; 2
	stx	MASK							; 3
	ldy	#(112/7)						; 2
	lda	$662							; 4
	jsr	reflection21						; 6+37
								;=============
								;	49

	;=============
	; LORES 18x42 -> HIRES 112x149x4
	lda	$6E2							; 4
	jsr	reflection22						; 6+37
								;=============
								;	47

	;=============
	; LORES 18x44 -> HIRES 112x146x3
	lda	$762							; 4
	jsr	reflection23						; 6+32
								;=============
								;	42

	;=============
	; LORES 18x46 -> HIRES 112x143x3
	lda	$7E2							; 4
	jsr	reflection24						; 6+32
								;=============
								;       42




	;21========================
	;==========================
	;==========================

	;=============
	; LORES 21x40 -> HIRES 133x153x4
	ldx	#$d5							; 2
	stx	MASK							; 3
	ldy	#(133/7)						; 2
	lda	$665							; 4
	jsr	reflection21						; 6+37
								;=============
								;	49
	;=============
	; LORES 21x42 -> HIRES 133x149x4
	lda	$6E5							; 4
	jsr	reflection22						; 6+37
								;=============
								;	47

	;=============
	; LORES 21x44 -> HIRES 133x146x3
	lda	$765							; 4
	jsr	reflection23						; 6+32
								;=============
								;	42

	;=============
	; LORES 21x46 -> HIRES 133x143x3
	lda	$7E5							; 4
	jsr	reflection24						; 6+32
								;=============
								;	42

	;16========================
	;==========================
	;==========================

	;=============
	; LORES 16x40 -> HIRES 105x151x4
	ldx	#$d5							; 2
	stx	MASK							; 3
	ldy	#(105/7)						; 2
	lda	$660							; 4
	jsr	reflection31						; 6+37
								;=============
								;	49

	;=============
	; LORES 16x42 -> HIRES 105x147x4
	lda	$6E0							; 4
	jsr	reflection32						; 6+37
								;=============
								;       47
	;=============
	; LORES 16x44 -> HIRES 105x144x3
	lda	$760							; 4
	jsr	reflection33						; 6+32
								;=============
								;	42
	;=============
	; LORES 16x46 -> HIRES 105x141x3
	lda	$7E0							; 4
	jsr	reflection34						; 6+32
								;=============
								;	42


	;23========================
	;==========================
	;==========================

	;=============
	; LORES 23x40 -> HIRES 140x151x4
	ldx	#$aa							; 2
	stx	MASK							; 3
	ldy	#(140/7)						; 2
	lda	$667							; 4
	jsr	reflection31						; 6+37

	;=============
	; LORES 23x42 -> HIRES 140x147x4
	lda	$6E7							; 4
	jsr	reflection32						; 6+37

	;=============
	; LORES 23x44 -> HIRES 140x144x3
	lda	$767							; 4
	jsr	reflection33						; 6+32

	;=============
	; LORES 23x46 -> HIRES 140x141x3
	lda	$7E7							; 4
	jsr	reflection34						; 6+32

	;13========================
	;==========================
	;==========================

	;=============
	; LORES 13x40 -> HIRES 98x149x3
	ldx	#$aa							; 2
	stx	MASK							; 3
	ldy	#(98/7)							; 2
	lda	$65d							; 4
	jsr	reflection41						; 6+32
								;============
								;	44
	;=============
	; LORES 13x42 -> HIRES 98x145x3
	lda	$6dd							; 4
	jsr	reflection42						; 6+32
								;=============
								;       42
	;=============
	; LORES 13x44 -> HIRES 98x142x3
	lda	$75d							; 4
	jsr	reflection43						; 6+32
								;=============
								;	42

	;=============
	; LORES 13x46 -> HIRES 98x139x3
	lda	$7dd							; 4
	jsr	reflection44						; 6+32
								;=============
								;	42



	;26========================
	;==========================
	;==========================

	;=============
	; LORES 26x40 -> HIRES 147x149x3
	ldx	#$d5							; 2
	stx	MASK							; 3
	ldy	#(147/7)						; 2
	lda	$66a							; 4
	jsr	reflection41						; 6+32

	;=============
	; LORES 26x42 -> HIRES 147x145x3
	lda	$6ea							; 4
	jsr	reflection42						; 6+32

	;=============
	; LORES 26x44 -> HIRES 147x142x3
	lda	$76a							; 4
	jsr	reflection43						; 6+32

	;=============
	; LORES 26x46 -> HIRES 147x139x3
	lda	$7ea							; 4
	jsr	reflection44						; 6+32



	;10========================
	;==========================
	;==========================

	;=============
	; LORES 10x40 -> HIRES 91x145x3
	ldx	#$d5							; 2
	stx	MASK							; 3
	ldy	#(91/7)							; 2
	lda	$65a							; 4
	jsr	reflection51						; 6+32
								;=============
								;	44


	;=============
	; LORES 10x42 -> HIRES 91x142x4
	lda	$6da							; 4
	jsr	reflection52						; 6+32
								;=============
								;	42
	;=============
	; LORES 10x44 -> HIRES 91x139x3
	lda	$75a							; 4
	jsr	reflection53						; 6+32
								;=============
								;	42
	;=============
	; LORES 10x46 -> HIRES 91x136x3
	lda	$7da							; 4
	jsr	reflection54						; 6+32
								;=============
								;	42

	;29========================
	;==========================
	;==========================

	;=============
	; LORES 29x40 -> HIRES 154x145x3
	ldx	#$aa							; 2
	stx	MASK							; 3
	ldy	#(154/7)
	lda	$66d							; 4
	jsr	reflection51

	;=============
	; LORES 29x42 -> HIRES 154x142x4
	lda	$6ed							; 4
	jsr	reflection52

	;=============
	; LORES 29x44 -> HIRES 154x139x3
	lda	$76d							; 4
	jsr	reflection53

	;=============
	; LORES 29x46 -> HIRES 154x136x3
	lda	$7ed							; 4
	jsr	reflection54



	rts								; 6


;==================================
;==================================


reflection11:
	; if 0 make 0, otherwise make FF
	cmp	#1							; 2
	lda	#$00							; 2
	adc	#$ff							; 2
	eor	#$ff							; 2

	; 156x4
	and	MASK							; 3
	sta	$51d0,Y							; 5
	sta	$55d0,Y							; 5
	sta	$59d0,Y							; 5
	sta	$5dd0,Y							; 5
	rts								; 6
								;===========
								;	37


reflection12:
	; if 0 make 0, otherwise make FF
	cmp	#1							; 2
	lda	#$00							; 2
	adc	#$ff							; 2
	eor	#$ff							; 2

	; 152x4
	and	MASK							; 3
	sta	$41d0,Y							; 5
	sta	$45d0,Y							; 5
	sta	$49d0,Y							; 5
	sta	$4dd0,Y							; 5
	rts								; 6
								;===========
								;	37
reflection13:
	; if 0 make 0, otherwise make FF
	cmp	#1							; 2
	lda	#$00							; 2
	adc	#$ff							; 2
	eor	#$ff							; 2

	; 148x3
	and	MASK							; 3
	sta	$5150,Y							; 5
	sta	$5550,Y							; 5
	sta	$5950,Y							; 5
	sta	$5d50,Y							; 5
	rts								; 6
								;===========
								;	37

reflection14:
	; if 0 make 0, otherwise make FF
	cmp	#1							; 2
	lda	#$00							; 2
	adc	#$ff							; 2
	eor	#$ff							; 2

	; 144x4
	and	MASK							; 3
	sta	$4150,Y							; 5
	sta	$4550,Y							; 5
	sta	$4950,Y							; 5
	sta	$4d50,Y							; 5
	rts								; 6
								;===========
								;	37

reflection21:

	; if 0 make 0, otherwise make FF
	cmp	#1							; 2
	lda	#$00							; 2
	adc	#$ff							; 2
	eor	#$ff							; 2

	; 153x4
	and	MASK							; 3
	sta	$45d0,Y							; 5
	sta	$49d0,Y							; 5
	sta	$4dd0,Y							; 5
	sta	$51d0,Y							; 5
	rts								; 6
								;===========
								;	37

reflection22:
	; if 0 make 0, otherwise make FF
	cmp	#1							; 2
	lda	#$00							; 2
	adc	#$ff							; 2
	eor	#$ff							; 2

	; 149x4
	and	MASK							; 3
	sta	$5550,Y							; 5
	sta	$5950,Y							; 5
	sta	$5d50,Y							; 5
	sta	$41d0,Y							; 5
	rts								; 6
								;===========
								;	37

reflection23:
	; if 0 make 0, otherwise make FF
	cmp	#1							; 2
	lda	#$00							; 2
	adc	#$ff							; 2
	eor	#$ff							; 2

	; 146x3
	and	MASK							; 3
	sta	$4950,Y							; 5
	sta	$4d50,Y							; 5
	sta	$5150,Y							; 5
	rts								; 6
								;===========
								;	32

reflection24:
	; if 0 make 0, otherwise make FF
	cmp	#1							; 2
	lda	#$00							; 2
	adc	#$ff							; 2
	eor	#$ff							; 2

	; 143x3
	and	MASK							; 3
	sta	$5cd0,Y							; 5
	sta	$4150,Y							; 5
	sta	$4550,Y							; 5
	rts								; 6
								;===========
								;	32


reflection31:
	; if 0 make 0, otherwise make FF
	cmp	#1							; 2
	lda	#$00							; 2
	adc	#$ff							; 2
	eor	#$ff							; 2

	; 151x4
	and	MASK							; 3
	sta	$5d50,Y							; 5
	sta	$41d0,Y							; 5
	sta	$45d0,Y							; 5
	sta	$49d0,Y							; 5
	rts								; 6
								;===========
								;	37


reflection32:
	; if 0 make 0, otherwise make FF
	cmp	#1							; 2
	lda	#$00							; 2
	adc	#$ff							; 2
	eor	#$ff							; 2

	; 147x4
	and	MASK							; 3
	sta	$4d50,Y							; 5
	sta	$5150,Y							; 5
	sta	$5550,Y							; 5
	sta	$5950,Y							; 5
	rts								; 6
								;===========
								;	37


reflection33:
	; if 0 make 0, otherwise make FF
	cmp	#1							; 2
	lda	#$00							; 2
	adc	#$ff							; 2
	eor	#$ff							; 2

	; 144x3
	and	MASK							; 3
	sta	$4150,Y							; 5
	sta	$4550,Y							; 5
	sta	$4950,Y							; 5
	rts								; 6
								;===========
								;	32

reflection34:
	; if 0 make 0, otherwise make FF
	cmp	#1							; 2
	lda	#$00							; 2
	adc	#$ff							; 2
	eor	#$ff							; 2

	; 141x3
	and	MASK							; 3
	sta	$54d0,Y							; 5
	sta	$58d0,Y							; 5
	sta	$5cd0,Y							; 5
	rts								; 6
								;===========
								;	32

reflection41:
	; if 0 make 0, otherwise make FF
	cmp	#1							; 2
	lda	#$00							; 2
	adc	#$ff							; 2
	eor	#$ff							; 2

	; 149x3
	and	MASK							; 3
	sta	$5550,Y							; 5
	sta	$5950,Y							; 5
	sta	$5d50,Y							; 5
	rts								; 6
								;===========
								;	32

reflection42:
	; if 0 make 0, otherwise make FF
	cmp	#1							; 2
	lda	#$00							; 2
	adc	#$ff							; 2
	eor	#$ff							; 2

	; 145x3
	and	MASK							; 3
	sta	$4550,Y							; 5
	sta	$4950,Y							; 5
	sta	$4d50,Y							; 5
	rts								; 6
								;===========
								;	32


reflection43:
	; if 0 make 0, otherwise make FF
	cmp	#1							; 2
	lda	#$00							; 2
	adc	#$ff							; 2
	eor	#$ff							; 2

	; 142x3
	and	MASK							; 3
	sta	$58d0,Y							; 5
	sta	$5cd0,Y							; 5
	sta	$4150,Y							; 5
	rts								; 6
								;===========
								;	32


reflection44:
	; if 0 make 0, otherwise make FF
	cmp	#1							; 2
	lda	#$00							; 2
	adc	#$ff							; 2
	eor	#$ff							; 2

	; 139x3
	and	MASK							; 3
	sta	$4c90,Y							; 5
	sta	$50d0,Y							; 5
	sta	$54d0,Y							; 5
	rts								; 6
								;===========
								;	32


reflection51:
	; if 0 make 0, otherwise make FF
	cmp	#1							; 2
	lda	#$00							; 2
	adc	#$ff							; 2
	eor	#$ff							; 2

	; 145x3
	and	MASK							; 3
	sta	$4550,Y							; 5
	sta	$4950,Y							; 5
	sta	$4d50,Y							; 5
	rts								; 6
								;===========
								;	32


reflection52:
	; if 0 make 0, otherwise make FF
	cmp	#1							; 2
	lda	#$00							; 2
	adc	#$ff							; 2
	eor	#$ff							; 2

	; 142x3
	and	MASK							; 3
	sta	$58d0,Y							; 5
	sta	$5cd0,Y							; 5
	sta	$4150,Y							; 5
	rts								; 6
								;===========
								;	32


reflection53:
	; if 0 make 0, otherwise make FF
	cmp	#1							; 2
	lda	#$00							; 2
	adc	#$ff							; 2
	eor	#$ff							; 2

	; 139x3
	and	MASK							; 3
	sta	$4cd0,Y							; 5
	sta	$50d0,Y							; 5
	sta	$54d0,Y							; 5
	rts								; 6
								;===========
								;	32

reflection54:
	; if 0 make 0, otherwise make FF
	cmp	#1							; 2
	lda	#$00							; 2
	adc	#$ff							; 2
	eor	#$ff							; 2

	; 136x3
	and	MASK							; 3
	sta	$40d0,Y							; 5
	sta	$44d0,Y							; 5
	sta	$48d0,Y							; 5
	rts								; 6
								;===========
								;	32
