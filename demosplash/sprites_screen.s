; 0
	bit	PAGE0	; 4
smc000:	bit	SET_TEXT ; 4
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$c00,X	; 5

; 1
	bit	PAGE0	; 4
smc001:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$c00,X	; 5

; 2
	bit	PAGE0	; 4
smc002:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$c00,X	; 5

; 3
	bit	PAGE0	; 4
smc003:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$c00,X	; 5

; 4
	bit	PAGE0	; 4
smc004:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$c00,X	; 5

; 5
	bit	PAGE0	; 4
smc005:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$c00,X	; 5

; 6
	bit	PAGE0	; 4
smc006:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$c00,X	; 5

; 7
	bit	PAGE0	; 4
smc007:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$c00,X	; 5

; 8
	bit	PAGE0	; 4
smc008:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$c00,X	; 5

; 9
	bit	PAGE0	; 4
smc009:	bit	SET_GR	; 4
	
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$c00,X	; 5

; 10
	bit	PAGE0	; 4
smc010:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$c00,X	; 5

; 11
	bit	PAGE1	; 4
smc011:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$c00,X	; 5

; 12
	bit	PAGE0	; 4
smc012:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$c00,X	; 5

; 13
	bit	PAGE1	; 4
smc013:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$c00,X	; 5

; 14
	bit	PAGE0	; 4
smc014:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$c00,X	; 5

; 15
	bit	PAGE1	; 4
smc015:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$c00,X	; 5

; 16
	bit	PAGE0	; 4
smc016:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$c00,X	; 5

; 17
	bit	PAGE1	; 4
smc017:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$c00,X	; 5

; 18
	bit	PAGE0	; 4
smc018:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$c00,X	; 5

; 19
	bit	PAGE1	; 4
smc019:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$c00,X	; 5

; 20
	bit	PAGE0	; 4
smc020:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$c00,X	; 5

; 21
	bit	PAGE1	; 4
smc021:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$c00,X	; 5

; 22
	bit	PAGE0	; 4
smc022:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$c00,X	; 5

; 23
	bit	PAGE1	; 4
smc023:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$c00,X	; 5

; 24
	bit	PAGE0	; 4
smc024:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$c00,X	; 5

; 25
	bit	PAGE1	; 4
smc025:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$c00,X	; 5

; 26
	bit	PAGE0	; 4
smc026:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$c00,X	; 5

; 27
	bit	PAGE1	; 4
smc027:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$c00,X	; 5

; 28
	bit	PAGE0	; 4
smc028:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$c00,X	; 5

; 29
	bit	PAGE1	; 4
smc029:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$c00,X	; 5

; 30
	bit	PAGE0	; 4
smc030:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$980,X	; 5
	lda	#$00	; 2
	sta	$981,X	; 5
	lda	#$00	; 2
	sta	$982,X	; 5
	lda	#$00	; 2
	sta	$983,X	; 5
	lda	#$00	; 2
	sta	$984,X	; 5
	lda	#$00	; 2
	sta	$985,X	; 5
	lda	#$00	; 2
	sta	$986,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$980,X	; 5

; 31
	bit	PAGE1	; 4
smc031:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$600,X	; 5
	lda	#$00	; 2
	sta	$601,X	; 5
	lda	#$00	; 2
	sta	$602,X	; 5
	lda	#$00	; 2
	sta	$603,X	; 5
	lda	#$00	; 2
	sta	$604,X	; 5
	lda	#$00	; 2
	sta	$605,X	; 5
	lda	#$00	; 2
	sta	$606,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$600,X	; 5

; 32
	bit	PAGE0	; 4
smc032:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$a00,X	; 5
	lda	#$00	; 2
	sta	$a01,X	; 5
	lda	#$00	; 2
	sta	$a02,X	; 5
	lda	#$00	; 2
	sta	$a03,X	; 5
	lda	#$00	; 2
	sta	$a04,X	; 5
	lda	#$00	; 2
	sta	$a05,X	; 5
	lda	#$00	; 2
	sta	$a06,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$a00,X	; 5

; 33
	bit	PAGE1	; 4
smc033:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$600,X	; 5
	lda	#$00	; 2
	sta	$601,X	; 5
	lda	#$00	; 2
	sta	$602,X	; 5
	lda	#$00	; 2
	sta	$603,X	; 5
	lda	#$00	; 2
	sta	$604,X	; 5
	lda	#$00	; 2
	sta	$605,X	; 5
	lda	#$00	; 2
	sta	$606,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$600,X	; 5

; 34
	bit	PAGE0	; 4
smc034:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$a00,X	; 5
	lda	#$00	; 2
	sta	$a01,X	; 5
	lda	#$00	; 2
	sta	$a02,X	; 5
	lda	#$00	; 2
	sta	$a03,X	; 5
	lda	#$00	; 2
	sta	$a04,X	; 5
	lda	#$00	; 2
	sta	$a05,X	; 5
	lda	#$00	; 2
	sta	$a06,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$a00,X	; 5

; 35
	bit	PAGE1	; 4
smc035:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$600,X	; 5
	lda	#$00	; 2
	sta	$601,X	; 5
	lda	#$00	; 2
	sta	$602,X	; 5
	lda	#$00	; 2
	sta	$603,X	; 5
	lda	#$00	; 2
	sta	$604,X	; 5
	lda	#$00	; 2
	sta	$605,X	; 5
	lda	#$00	; 2
	sta	$606,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$600,X	; 5

; 36
	bit	PAGE0	; 4
smc036:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$a00,X	; 5
	lda	#$00	; 2
	sta	$a01,X	; 5
	lda	#$00	; 2
	sta	$a02,X	; 5
	lda	#$00	; 2
	sta	$a03,X	; 5
	lda	#$00	; 2
	sta	$a04,X	; 5
	lda	#$00	; 2
	sta	$a05,X	; 5
	lda	#$00	; 2
	sta	$a06,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$a00,X	; 5

; 37
	bit	PAGE1	; 4
smc037:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$600,X	; 5
	lda	#$00	; 2
	sta	$601,X	; 5
	lda	#$00	; 2
	sta	$602,X	; 5
	lda	#$00	; 2
	sta	$603,X	; 5
	lda	#$00	; 2
	sta	$604,X	; 5
	lda	#$00	; 2
	sta	$605,X	; 5
	lda	#$00	; 2
	sta	$606,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$600,X	; 5

; 38
	bit	PAGE0	; 4
smc038:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$a00,X	; 5
	lda	#$00	; 2
	sta	$a01,X	; 5
	lda	#$00	; 2
	sta	$a02,X	; 5
	lda	#$00	; 2
	sta	$a03,X	; 5
	lda	#$00	; 2
	sta	$a04,X	; 5
	lda	#$00	; 2
	sta	$a05,X	; 5
	lda	#$00	; 2
	sta	$a06,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$a00,X	; 5

; 39
	bit	PAGE1	; 4
smc039:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$680,X	; 5
	lda	#$00	; 2
	sta	$681,X	; 5
	lda	#$00	; 2
	sta	$682,X	; 5
	lda	#$00	; 2
	sta	$683,X	; 5
	lda	#$00	; 2
	sta	$684,X	; 5
	lda	#$00	; 2
	sta	$685,X	; 5
	lda	#$00	; 2
	sta	$686,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$680,X	; 5

; 40
	bit	PAGE0	; 4
smc040:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$a80,X	; 5
	lda	#$00	; 2
	sta	$a81,X	; 5
	lda	#$00	; 2
	sta	$a82,X	; 5
	lda	#$00	; 2
	sta	$a83,X	; 5
	lda	#$00	; 2
	sta	$a84,X	; 5
	lda	#$00	; 2
	sta	$a85,X	; 5
	lda	#$00	; 2
	sta	$a86,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$a80,X	; 5

; 41
	bit	PAGE1	; 4
smc041:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$680,X	; 5
	lda	#$00	; 2
	sta	$681,X	; 5
	lda	#$00	; 2
	sta	$682,X	; 5
	lda	#$00	; 2
	sta	$683,X	; 5
	lda	#$00	; 2
	sta	$684,X	; 5
	lda	#$00	; 2
	sta	$685,X	; 5
	lda	#$00	; 2
	sta	$686,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$680,X	; 5

; 42
	bit	PAGE0	; 4
smc042:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$a80,X	; 5
	lda	#$00	; 2
	sta	$a81,X	; 5
	lda	#$00	; 2
	sta	$a82,X	; 5
	lda	#$00	; 2
	sta	$a83,X	; 5
	lda	#$00	; 2
	sta	$a84,X	; 5
	lda	#$00	; 2
	sta	$a85,X	; 5
	lda	#$00	; 2
	sta	$a86,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$a80,X	; 5

; 43
	bit	PAGE1	; 4
smc043:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$680,X	; 5
	lda	#$00	; 2
	sta	$681,X	; 5
	lda	#$00	; 2
	sta	$682,X	; 5
	lda	#$00	; 2
	sta	$683,X	; 5
	lda	#$00	; 2
	sta	$684,X	; 5
	lda	#$00	; 2
	sta	$685,X	; 5
	lda	#$00	; 2
	sta	$686,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$680,X	; 5

; 44
	bit	PAGE0	; 4
smc044:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$a80,X	; 5
	lda	#$00	; 2
	sta	$a81,X	; 5
	lda	#$00	; 2
	sta	$a82,X	; 5
	lda	#$00	; 2
	sta	$a83,X	; 5
	lda	#$00	; 2
	sta	$a84,X	; 5
	lda	#$00	; 2
	sta	$a85,X	; 5
	lda	#$00	; 2
	sta	$a86,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$a80,X	; 5

; 45
	bit	PAGE1	; 4
smc045:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$680,X	; 5
	lda	#$00	; 2
	sta	$681,X	; 5
	lda	#$00	; 2
	sta	$682,X	; 5
	lda	#$00	; 2
	sta	$683,X	; 5
	lda	#$00	; 2
	sta	$684,X	; 5
	lda	#$00	; 2
	sta	$685,X	; 5
	lda	#$00	; 2
	sta	$686,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$680,X	; 5

; 46
	bit	PAGE0	; 4
smc046:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$a80,X	; 5
	lda	#$00	; 2
	sta	$a81,X	; 5
	lda	#$00	; 2
	sta	$a82,X	; 5
	lda	#$00	; 2
	sta	$a83,X	; 5
	lda	#$00	; 2
	sta	$a84,X	; 5
	lda	#$00	; 2
	sta	$a85,X	; 5
	lda	#$00	; 2
	sta	$a86,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$a80,X	; 5

; 47
	bit	PAGE1	; 4
smc047:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$700,X	; 5
	lda	#$00	; 2
	sta	$701,X	; 5
	lda	#$00	; 2
	sta	$702,X	; 5
	lda	#$00	; 2
	sta	$703,X	; 5
	lda	#$00	; 2
	sta	$704,X	; 5
	lda	#$00	; 2
	sta	$705,X	; 5
	lda	#$00	; 2
	sta	$706,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$700,X	; 5

; 48
	bit	PAGE0	; 4
smc048:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$b00,X	; 5
	lda	#$00	; 2
	sta	$b01,X	; 5
	lda	#$00	; 2
	sta	$b02,X	; 5
	lda	#$00	; 2
	sta	$b03,X	; 5
	lda	#$00	; 2
	sta	$b04,X	; 5
	lda	#$00	; 2
	sta	$b05,X	; 5
	lda	#$00	; 2
	sta	$b06,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$b00,X	; 5

; 49
	bit	PAGE1	; 4
smc049:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$700,X	; 5
	lda	#$00	; 2
	sta	$701,X	; 5
	lda	#$00	; 2
	sta	$702,X	; 5
	lda	#$00	; 2
	sta	$703,X	; 5
	lda	#$00	; 2
	sta	$704,X	; 5
	lda	#$00	; 2
	sta	$705,X	; 5
	lda	#$00	; 2
	sta	$706,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$700,X	; 5

; 50
	bit	PAGE0	; 4
smc050:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$b00,X	; 5
	lda	#$00	; 2
	sta	$b01,X	; 5
	lda	#$00	; 2
	sta	$b02,X	; 5
	lda	#$00	; 2
	sta	$b03,X	; 5
	lda	#$00	; 2
	sta	$b04,X	; 5
	lda	#$00	; 2
	sta	$b05,X	; 5
	lda	#$00	; 2
	sta	$b06,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$b00,X	; 5

; 51
	bit	PAGE1	; 4
smc051:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$700,X	; 5
	lda	#$00	; 2
	sta	$701,X	; 5
	lda	#$00	; 2
	sta	$702,X	; 5
	lda	#$00	; 2
	sta	$703,X	; 5
	lda	#$00	; 2
	sta	$704,X	; 5
	lda	#$00	; 2
	sta	$705,X	; 5
	lda	#$00	; 2
	sta	$706,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$700,X	; 5

; 52
	bit	PAGE0	; 4
smc052:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$b00,X	; 5
	lda	#$00	; 2
	sta	$b01,X	; 5
	lda	#$00	; 2
	sta	$b02,X	; 5
	lda	#$00	; 2
	sta	$b03,X	; 5
	lda	#$00	; 2
	sta	$b04,X	; 5
	lda	#$00	; 2
	sta	$b05,X	; 5
	lda	#$00	; 2
	sta	$b06,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$b00,X	; 5

; 53
	bit	PAGE1	; 4
smc053:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$700,X	; 5
	lda	#$00	; 2
	sta	$701,X	; 5
	lda	#$00	; 2
	sta	$702,X	; 5
	lda	#$00	; 2
	sta	$703,X	; 5
	lda	#$00	; 2
	sta	$704,X	; 5
	lda	#$00	; 2
	sta	$705,X	; 5
	lda	#$00	; 2
	sta	$706,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$700,X	; 5

; 54
	bit	PAGE0	; 4
smc054:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$b00,X	; 5
	lda	#$00	; 2
	sta	$b01,X	; 5
	lda	#$00	; 2
	sta	$b02,X	; 5
	lda	#$00	; 2
	sta	$b03,X	; 5
	lda	#$00	; 2
	sta	$b04,X	; 5
	lda	#$00	; 2
	sta	$b05,X	; 5
	lda	#$00	; 2
	sta	$b06,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$b00,X	; 5

; 55
	bit	PAGE1	; 4
smc055:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$780,X	; 5
	lda	#$00	; 2
	sta	$781,X	; 5
	lda	#$00	; 2
	sta	$782,X	; 5
	lda	#$00	; 2
	sta	$783,X	; 5
	lda	#$00	; 2
	sta	$784,X	; 5
	lda	#$00	; 2
	sta	$785,X	; 5
	lda	#$00	; 2
	sta	$786,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$780,X	; 5

; 56
	bit	PAGE0	; 4
smc056:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$b80,X	; 5
	lda	#$00	; 2
	sta	$b81,X	; 5
	lda	#$00	; 2
	sta	$b82,X	; 5
	lda	#$00	; 2
	sta	$b83,X	; 5
	lda	#$00	; 2
	sta	$b84,X	; 5
	lda	#$00	; 2
	sta	$b85,X	; 5
	lda	#$00	; 2
	sta	$b86,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$b80,X	; 5

; 57
	bit	PAGE1	; 4
smc057:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$780,X	; 5
	lda	#$00	; 2
	sta	$781,X	; 5
	lda	#$00	; 2
	sta	$782,X	; 5
	lda	#$00	; 2
	sta	$783,X	; 5
	lda	#$00	; 2
	sta	$784,X	; 5
	lda	#$00	; 2
	sta	$785,X	; 5
	lda	#$00	; 2
	sta	$786,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$780,X	; 5

; 58
	bit	PAGE0	; 4
smc058:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$b80,X	; 5
	lda	#$00	; 2
	sta	$b81,X	; 5
	lda	#$00	; 2
	sta	$b82,X	; 5
	lda	#$00	; 2
	sta	$b83,X	; 5
	lda	#$00	; 2
	sta	$b84,X	; 5
	lda	#$00	; 2
	sta	$b85,X	; 5
	lda	#$00	; 2
	sta	$b86,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$b80,X	; 5

; 59
	bit	PAGE1	; 4
smc059:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$780,X	; 5
	lda	#$00	; 2
	sta	$781,X	; 5
	lda	#$00	; 2
	sta	$782,X	; 5
	lda	#$00	; 2
	sta	$783,X	; 5
	lda	#$00	; 2
	sta	$784,X	; 5
	lda	#$00	; 2
	sta	$785,X	; 5
	lda	#$00	; 2
	sta	$786,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$780,X	; 5

; 60
	bit	PAGE0	; 4
smc060:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$b80,X	; 5
	lda	#$00	; 2
	sta	$b81,X	; 5
	lda	#$00	; 2
	sta	$b82,X	; 5
	lda	#$00	; 2
	sta	$b83,X	; 5
	lda	#$00	; 2
	sta	$b84,X	; 5
	lda	#$00	; 2
	sta	$b85,X	; 5
	lda	#$00	; 2
	sta	$b86,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$b80,X	; 5

; 61
	bit	PAGE1	; 4
smc061:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$780,X	; 5
	lda	#$00	; 2
	sta	$781,X	; 5
	lda	#$00	; 2
	sta	$782,X	; 5
	lda	#$00	; 2
	sta	$783,X	; 5
	lda	#$00	; 2
	sta	$784,X	; 5
	lda	#$00	; 2
	sta	$785,X	; 5
	lda	#$00	; 2
	sta	$786,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$780,X	; 5

; 62
	bit	PAGE0	; 4
smc062:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$b80,X	; 5
	lda	#$00	; 2
	sta	$b81,X	; 5
	lda	#$00	; 2
	sta	$b82,X	; 5
	lda	#$00	; 2
	sta	$b83,X	; 5
	lda	#$00	; 2
	sta	$b84,X	; 5
	lda	#$00	; 2
	sta	$b85,X	; 5
	lda	#$00	; 2
	sta	$b86,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$b80,X	; 5

; 63
	bit	PAGE1	; 4
smc063:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$428,X	; 5
	lda	#$00	; 2
	sta	$429,X	; 5
	lda	#$00	; 2
	sta	$42a,X	; 5
	lda	#$00	; 2
	sta	$42b,X	; 5
	lda	#$00	; 2
	sta	$42c,X	; 5
	lda	#$00	; 2
	sta	$42d,X	; 5
	lda	#$00	; 2
	sta	$42e,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$428,X	; 5

; 64
	bit	PAGE0	; 4
smc064:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$828,X	; 5
	lda	#$00	; 2
	sta	$829,X	; 5
	lda	#$00	; 2
	sta	$82a,X	; 5
	lda	#$00	; 2
	sta	$82b,X	; 5
	lda	#$00	; 2
	sta	$82c,X	; 5
	lda	#$00	; 2
	sta	$82d,X	; 5
	lda	#$00	; 2
	sta	$82e,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$828,X	; 5

; 65
	bit	PAGE1	; 4
smc065:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$428,X	; 5
	lda	#$00	; 2
	sta	$429,X	; 5
	lda	#$00	; 2
	sta	$42a,X	; 5
	lda	#$00	; 2
	sta	$42b,X	; 5
	lda	#$00	; 2
	sta	$42c,X	; 5
	lda	#$00	; 2
	sta	$42d,X	; 5
	lda	#$00	; 2
	sta	$42e,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$428,X	; 5

; 66
	bit	PAGE0	; 4
smc066:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$828,X	; 5
	lda	#$00	; 2
	sta	$829,X	; 5
	lda	#$00	; 2
	sta	$82a,X	; 5
	lda	#$00	; 2
	sta	$82b,X	; 5
	lda	#$00	; 2
	sta	$82c,X	; 5
	lda	#$00	; 2
	sta	$82d,X	; 5
	lda	#$00	; 2
	sta	$82e,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$828,X	; 5

; 67
	bit	PAGE1	; 4
smc067:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$428,X	; 5
	lda	#$00	; 2
	sta	$429,X	; 5
	lda	#$00	; 2
	sta	$42a,X	; 5
	lda	#$00	; 2
	sta	$42b,X	; 5
	lda	#$00	; 2
	sta	$42c,X	; 5
	lda	#$00	; 2
	sta	$42d,X	; 5
	lda	#$00	; 2
	sta	$42e,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$428,X	; 5

; 68
	bit	PAGE0	; 4
smc068:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$828,X	; 5
	lda	#$00	; 2
	sta	$829,X	; 5
	lda	#$00	; 2
	sta	$82a,X	; 5
	lda	#$00	; 2
	sta	$82b,X	; 5
	lda	#$00	; 2
	sta	$82c,X	; 5
	lda	#$00	; 2
	sta	$82d,X	; 5
	lda	#$00	; 2
	sta	$82e,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$828,X	; 5

; 69
	bit	PAGE1	; 4
smc069:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$428,X	; 5
	lda	#$00	; 2
	sta	$429,X	; 5
	lda	#$00	; 2
	sta	$42a,X	; 5
	lda	#$00	; 2
	sta	$42b,X	; 5
	lda	#$00	; 2
	sta	$42c,X	; 5
	lda	#$00	; 2
	sta	$42d,X	; 5
	lda	#$00	; 2
	sta	$42e,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$428,X	; 5

; 70
	bit	PAGE0	; 4
smc070:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$828,X	; 5
	lda	#$00	; 2
	sta	$829,X	; 5
	lda	#$00	; 2
	sta	$82a,X	; 5
	lda	#$00	; 2
	sta	$82b,X	; 5
	lda	#$00	; 2
	sta	$82c,X	; 5
	lda	#$00	; 2
	sta	$82d,X	; 5
	lda	#$00	; 2
	sta	$82e,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$828,X	; 5

; 71
	bit	PAGE1	; 4
smc071:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$4a8,X	; 5
	lda	#$00	; 2
	sta	$4a9,X	; 5
	lda	#$00	; 2
	sta	$4aa,X	; 5
	lda	#$00	; 2
	sta	$4ab,X	; 5
	lda	#$00	; 2
	sta	$4ac,X	; 5
	lda	#$00	; 2
	sta	$4ad,X	; 5
	lda	#$00	; 2
	sta	$4ae,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$4a8,X	; 5

; 72
	bit	PAGE0	; 4
smc072:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$8a8,X	; 5
	lda	#$00	; 2
	sta	$8a9,X	; 5
	lda	#$00	; 2
	sta	$8aa,X	; 5
	lda	#$00	; 2
	sta	$8ab,X	; 5
	lda	#$00	; 2
	sta	$8ac,X	; 5
	lda	#$00	; 2
	sta	$8ad,X	; 5
	lda	#$00	; 2
	sta	$8ae,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$8a8,X	; 5

; 73
	bit	PAGE1	; 4
smc073:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$4a8,X	; 5
	lda	#$00	; 2
	sta	$4a9,X	; 5
	lda	#$00	; 2
	sta	$4aa,X	; 5
	lda	#$00	; 2
	sta	$4ab,X	; 5
	lda	#$00	; 2
	sta	$4ac,X	; 5
	lda	#$00	; 2
	sta	$4ad,X	; 5
	lda	#$00	; 2
	sta	$4ae,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$4a8,X	; 5

; 74
	bit	PAGE0	; 4
smc074:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$8a8,X	; 5
	lda	#$00	; 2
	sta	$8a9,X	; 5
	lda	#$00	; 2
	sta	$8aa,X	; 5
	lda	#$00	; 2
	sta	$8ab,X	; 5
	lda	#$00	; 2
	sta	$8ac,X	; 5
	lda	#$00	; 2
	sta	$8ad,X	; 5
	lda	#$00	; 2
	sta	$8ae,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$8a8,X	; 5

; 75
	bit	PAGE1	; 4
smc075:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$4a8,X	; 5
	lda	#$00	; 2
	sta	$4a9,X	; 5
	lda	#$00	; 2
	sta	$4aa,X	; 5
	lda	#$00	; 2
	sta	$4ab,X	; 5
	lda	#$00	; 2
	sta	$4ac,X	; 5
	lda	#$00	; 2
	sta	$4ad,X	; 5
	lda	#$00	; 2
	sta	$4ae,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$4a8,X	; 5

; 76
	bit	PAGE0	; 4
smc076:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$8a8,X	; 5
	lda	#$00	; 2
	sta	$8a9,X	; 5
	lda	#$00	; 2
	sta	$8aa,X	; 5
	lda	#$00	; 2
	sta	$8ab,X	; 5
	lda	#$00	; 2
	sta	$8ac,X	; 5
	lda	#$00	; 2
	sta	$8ad,X	; 5
	lda	#$00	; 2
	sta	$8ae,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$8a8,X	; 5

; 77
	bit	PAGE1	; 4
smc077:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$4a8,X	; 5
	lda	#$00	; 2
	sta	$4a9,X	; 5
	lda	#$00	; 2
	sta	$4aa,X	; 5
	lda	#$00	; 2
	sta	$4ab,X	; 5
	lda	#$00	; 2
	sta	$4ac,X	; 5
	lda	#$00	; 2
	sta	$4ad,X	; 5
	lda	#$00	; 2
	sta	$4ae,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$4a8,X	; 5

; 78
	bit	PAGE0	; 4
smc078:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$8a8,X	; 5
	lda	#$00	; 2
	sta	$8a9,X	; 5
	lda	#$00	; 2
	sta	$8aa,X	; 5
	lda	#$00	; 2
	sta	$8ab,X	; 5
	lda	#$00	; 2
	sta	$8ac,X	; 5
	lda	#$00	; 2
	sta	$8ad,X	; 5
	lda	#$00	; 2
	sta	$8ae,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$8a8,X	; 5

; 79
	bit	PAGE1	; 4
smc079:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$528,X	; 5
	lda	#$00	; 2
	sta	$529,X	; 5
	lda	#$00	; 2
	sta	$52a,X	; 5
	lda	#$00	; 2
	sta	$52b,X	; 5
	lda	#$00	; 2
	sta	$52c,X	; 5
	lda	#$00	; 2
	sta	$52d,X	; 5
	lda	#$00	; 2
	sta	$52e,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$528,X	; 5

; 80
	bit	PAGE0	; 4
smc080:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$928,X	; 5
	lda	#$00	; 2
	sta	$929,X	; 5
	lda	#$00	; 2
	sta	$92a,X	; 5
	lda	#$00	; 2
	sta	$92b,X	; 5
	lda	#$00	; 2
	sta	$92c,X	; 5
	lda	#$00	; 2
	sta	$92d,X	; 5
	lda	#$00	; 2
	sta	$92e,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$928,X	; 5

; 81
	bit	PAGE1	; 4
smc081:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$528,X	; 5
	lda	#$00	; 2
	sta	$529,X	; 5
	lda	#$00	; 2
	sta	$52a,X	; 5
	lda	#$00	; 2
	sta	$52b,X	; 5
	lda	#$00	; 2
	sta	$52c,X	; 5
	lda	#$00	; 2
	sta	$52d,X	; 5
	lda	#$00	; 2
	sta	$52e,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$528,X	; 5

; 82
	bit	PAGE0	; 4
smc082:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$928,X	; 5
	lda	#$00	; 2
	sta	$929,X	; 5
	lda	#$00	; 2
	sta	$92a,X	; 5
	lda	#$00	; 2
	sta	$92b,X	; 5
	lda	#$00	; 2
	sta	$92c,X	; 5
	lda	#$00	; 2
	sta	$92d,X	; 5
	lda	#$00	; 2
	sta	$92e,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$928,X	; 5

; 83
	bit	PAGE1	; 4
smc083:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$528,X	; 5
	lda	#$00	; 2
	sta	$529,X	; 5
	lda	#$00	; 2
	sta	$52a,X	; 5
	lda	#$00	; 2
	sta	$52b,X	; 5
	lda	#$00	; 2
	sta	$52c,X	; 5
	lda	#$00	; 2
	sta	$52d,X	; 5
	lda	#$00	; 2
	sta	$52e,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$528,X	; 5

; 84
	bit	PAGE0	; 4
smc084:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$928,X	; 5
	lda	#$00	; 2
	sta	$929,X	; 5
	lda	#$00	; 2
	sta	$92a,X	; 5
	lda	#$00	; 2
	sta	$92b,X	; 5
	lda	#$00	; 2
	sta	$92c,X	; 5
	lda	#$00	; 2
	sta	$92d,X	; 5
	lda	#$00	; 2
	sta	$92e,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$928,X	; 5

; 85
	bit	PAGE1	; 4
smc085:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$528,X	; 5
	lda	#$00	; 2
	sta	$529,X	; 5
	lda	#$00	; 2
	sta	$52a,X	; 5
	lda	#$00	; 2
	sta	$52b,X	; 5
	lda	#$00	; 2
	sta	$52c,X	; 5
	lda	#$00	; 2
	sta	$52d,X	; 5
	lda	#$00	; 2
	sta	$52e,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$528,X	; 5

; 86
	bit	PAGE0	; 4
smc086:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$928,X	; 5
	lda	#$00	; 2
	sta	$929,X	; 5
	lda	#$00	; 2
	sta	$92a,X	; 5
	lda	#$00	; 2
	sta	$92b,X	; 5
	lda	#$00	; 2
	sta	$92c,X	; 5
	lda	#$00	; 2
	sta	$92d,X	; 5
	lda	#$00	; 2
	sta	$92e,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$928,X	; 5

; 87
	bit	PAGE1	; 4
smc087:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$5a8,X	; 5
	lda	#$00	; 2
	sta	$5a9,X	; 5
	lda	#$00	; 2
	sta	$5aa,X	; 5
	lda	#$00	; 2
	sta	$5ab,X	; 5
	lda	#$00	; 2
	sta	$5ac,X	; 5
	lda	#$00	; 2
	sta	$5ad,X	; 5
	lda	#$00	; 2
	sta	$5ae,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$5a8,X	; 5

; 88
	bit	PAGE0	; 4
smc088:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$9a8,X	; 5
	lda	#$00	; 2
	sta	$9a9,X	; 5
	lda	#$00	; 2
	sta	$9aa,X	; 5
	lda	#$00	; 2
	sta	$9ab,X	; 5
	lda	#$00	; 2
	sta	$9ac,X	; 5
	lda	#$00	; 2
	sta	$9ad,X	; 5
	lda	#$00	; 2
	sta	$9ae,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$9a8,X	; 5

; 89
	bit	PAGE1	; 4
smc089:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$5a8,X	; 5
	lda	#$00	; 2
	sta	$5a9,X	; 5
	lda	#$00	; 2
	sta	$5aa,X	; 5
	lda	#$00	; 2
	sta	$5ab,X	; 5
	lda	#$00	; 2
	sta	$5ac,X	; 5
	lda	#$00	; 2
	sta	$5ad,X	; 5
	lda	#$00	; 2
	sta	$5ae,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$5a8,X	; 5

; 90
	bit	PAGE0	; 4
smc090:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$9a8,X	; 5
	lda	#$00	; 2
	sta	$9a9,X	; 5
	lda	#$00	; 2
	sta	$9aa,X	; 5
	lda	#$00	; 2
	sta	$9ab,X	; 5
	lda	#$00	; 2
	sta	$9ac,X	; 5
	lda	#$00	; 2
	sta	$9ad,X	; 5
	lda	#$00	; 2
	sta	$9ae,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$9a8,X	; 5

; 91
	bit	PAGE1	; 4
smc091:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$5a8,X	; 5
	lda	#$00	; 2
	sta	$5a9,X	; 5
	lda	#$00	; 2
	sta	$5aa,X	; 5
	lda	#$00	; 2
	sta	$5ab,X	; 5
	lda	#$00	; 2
	sta	$5ac,X	; 5
	lda	#$00	; 2
	sta	$5ad,X	; 5
	lda	#$00	; 2
	sta	$5ae,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$5a8,X	; 5

; 92
	bit	PAGE0	; 4
smc092:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$9a8,X	; 5
	lda	#$00	; 2
	sta	$9a9,X	; 5
	lda	#$00	; 2
	sta	$9aa,X	; 5
	lda	#$00	; 2
	sta	$9ab,X	; 5
	lda	#$00	; 2
	sta	$9ac,X	; 5
	lda	#$00	; 2
	sta	$9ad,X	; 5
	lda	#$00	; 2
	sta	$9ae,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$9a8,X	; 5

; 93
	bit	PAGE1	; 4
smc093:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$5a8,X	; 5
	lda	#$00	; 2
	sta	$5a9,X	; 5
	lda	#$00	; 2
	sta	$5aa,X	; 5
	lda	#$00	; 2
	sta	$5ab,X	; 5
	lda	#$00	; 2
	sta	$5ac,X	; 5
	lda	#$00	; 2
	sta	$5ad,X	; 5
	lda	#$00	; 2
	sta	$5ae,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$5a8,X	; 5

; 94
	bit	PAGE0	; 4
smc094:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$9a8,X	; 5
	lda	#$00	; 2
	sta	$9a9,X	; 5
	lda	#$00	; 2
	sta	$9aa,X	; 5
	lda	#$00	; 2
	sta	$9ab,X	; 5
	lda	#$00	; 2
	sta	$9ac,X	; 5
	lda	#$00	; 2
	sta	$9ad,X	; 5
	lda	#$00	; 2
	sta	$9ae,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$9a8,X	; 5

; 95
	bit	PAGE1	; 4
smc095:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$628,X	; 5
	lda	#$00	; 2
	sta	$629,X	; 5
	lda	#$00	; 2
	sta	$62a,X	; 5
	lda	#$00	; 2
	sta	$62b,X	; 5
	lda	#$00	; 2
	sta	$62c,X	; 5
	lda	#$00	; 2
	sta	$62d,X	; 5
	lda	#$00	; 2
	sta	$62e,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$628,X	; 5

; 96
	bit	PAGE0	; 4
smc096:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$a28,X	; 5
	lda	#$00	; 2
	sta	$a29,X	; 5
	lda	#$00	; 2
	sta	$a2a,X	; 5
	lda	#$00	; 2
	sta	$a2b,X	; 5
	lda	#$00	; 2
	sta	$a2c,X	; 5
	lda	#$00	; 2
	sta	$a2d,X	; 5
	lda	#$00	; 2
	sta	$a2e,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$a28,X	; 5

; 97
	bit	PAGE1	; 4
smc097:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$628,X	; 5
	lda	#$00	; 2
	sta	$629,X	; 5
	lda	#$00	; 2
	sta	$62a,X	; 5
	lda	#$00	; 2
	sta	$62b,X	; 5
	lda	#$00	; 2
	sta	$62c,X	; 5
	lda	#$00	; 2
	sta	$62d,X	; 5
	lda	#$00	; 2
	sta	$62e,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$628,X	; 5

; 98
	bit	PAGE0	; 4
smc098:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$a28,X	; 5
	lda	#$00	; 2
	sta	$a29,X	; 5
	lda	#$00	; 2
	sta	$a2a,X	; 5
	lda	#$00	; 2
	sta	$a2b,X	; 5
	lda	#$00	; 2
	sta	$a2c,X	; 5
	lda	#$00	; 2
	sta	$a2d,X	; 5
	lda	#$00	; 2
	sta	$a2e,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$a28,X	; 5

; 99
	bit	PAGE1	; 4
smc099:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$628,X	; 5
	lda	#$00	; 2
	sta	$629,X	; 5
	lda	#$00	; 2
	sta	$62a,X	; 5
	lda	#$00	; 2
	sta	$62b,X	; 5
	lda	#$00	; 2
	sta	$62c,X	; 5
	lda	#$00	; 2
	sta	$62d,X	; 5
	lda	#$00	; 2
	sta	$62e,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$628,X	; 5

; 100
	bit	PAGE0	; 4
smc100:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$a28,X	; 5
	lda	#$00	; 2
	sta	$a29,X	; 5
	lda	#$00	; 2
	sta	$a2a,X	; 5
	lda	#$00	; 2
	sta	$a2b,X	; 5
	lda	#$00	; 2
	sta	$a2c,X	; 5
	lda	#$00	; 2
	sta	$a2d,X	; 5
	lda	#$00	; 2
	sta	$a2e,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$a28,X	; 5

; 101
	bit	PAGE1	; 4
smc101:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$628,X	; 5
	lda	#$00	; 2
	sta	$629,X	; 5
	lda	#$00	; 2
	sta	$62a,X	; 5
	lda	#$00	; 2
	sta	$62b,X	; 5
	lda	#$00	; 2
	sta	$62c,X	; 5
	lda	#$00	; 2
	sta	$62d,X	; 5
	lda	#$00	; 2
	sta	$62e,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$628,X	; 5

; 102
	bit	PAGE0	; 4
smc102:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$a28,X	; 5
	lda	#$00	; 2
	sta	$a29,X	; 5
	lda	#$00	; 2
	sta	$a2a,X	; 5
	lda	#$00	; 2
	sta	$a2b,X	; 5
	lda	#$00	; 2
	sta	$a2c,X	; 5
	lda	#$00	; 2
	sta	$a2d,X	; 5
	lda	#$00	; 2
	sta	$a2e,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$a28,X	; 5

; 103
	bit	PAGE1	; 4
smc103:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$6a8,X	; 5
	lda	#$00	; 2
	sta	$6a9,X	; 5
	lda	#$00	; 2
	sta	$6aa,X	; 5
	lda	#$00	; 2
	sta	$6ab,X	; 5
	lda	#$00	; 2
	sta	$6ac,X	; 5
	lda	#$00	; 2
	sta	$6ad,X	; 5
	lda	#$00	; 2
	sta	$6ae,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$6a8,X	; 5

; 104
	bit	PAGE0	; 4
smc104:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$aa8,X	; 5
	lda	#$00	; 2
	sta	$aa9,X	; 5
	lda	#$00	; 2
	sta	$aaa,X	; 5
	lda	#$00	; 2
	sta	$aab,X	; 5
	lda	#$00	; 2
	sta	$aac,X	; 5
	lda	#$00	; 2
	sta	$aad,X	; 5
	lda	#$00	; 2
	sta	$aae,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$aa8,X	; 5

; 105
	bit	PAGE1	; 4
smc105:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$6a8,X	; 5
	lda	#$00	; 2
	sta	$6a9,X	; 5
	lda	#$00	; 2
	sta	$6aa,X	; 5
	lda	#$00	; 2
	sta	$6ab,X	; 5
	lda	#$00	; 2
	sta	$6ac,X	; 5
	lda	#$00	; 2
	sta	$6ad,X	; 5
	lda	#$00	; 2
	sta	$6ae,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$6a8,X	; 5

; 106
	bit	PAGE0	; 4
smc106:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$aa8,X	; 5
	lda	#$00	; 2
	sta	$aa9,X	; 5
	lda	#$00	; 2
	sta	$aaa,X	; 5
	lda	#$00	; 2
	sta	$aab,X	; 5
	lda	#$00	; 2
	sta	$aac,X	; 5
	lda	#$00	; 2
	sta	$aad,X	; 5
	lda	#$00	; 2
	sta	$aae,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$aa8,X	; 5

; 107
	bit	PAGE1	; 4
smc107:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$6a8,X	; 5
	lda	#$00	; 2
	sta	$6a9,X	; 5
	lda	#$00	; 2
	sta	$6aa,X	; 5
	lda	#$00	; 2
	sta	$6ab,X	; 5
	lda	#$00	; 2
	sta	$6ac,X	; 5
	lda	#$00	; 2
	sta	$6ad,X	; 5
	lda	#$00	; 2
	sta	$6ae,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$6a8,X	; 5

; 108
	bit	PAGE0	; 4
smc108:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$aa8,X	; 5
	lda	#$00	; 2
	sta	$aa9,X	; 5
	lda	#$00	; 2
	sta	$aaa,X	; 5
	lda	#$00	; 2
	sta	$aab,X	; 5
	lda	#$00	; 2
	sta	$aac,X	; 5
	lda	#$00	; 2
	sta	$aad,X	; 5
	lda	#$00	; 2
	sta	$aae,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$aa8,X	; 5

; 109
	bit	PAGE1	; 4
smc109:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$6a8,X	; 5
	lda	#$00	; 2
	sta	$6a9,X	; 5
	lda	#$00	; 2
	sta	$6aa,X	; 5
	lda	#$00	; 2
	sta	$6ab,X	; 5
	lda	#$00	; 2
	sta	$6ac,X	; 5
	lda	#$00	; 2
	sta	$6ad,X	; 5
	lda	#$00	; 2
	sta	$6ae,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$6a8,X	; 5

; 110
	bit	PAGE0	; 4
smc110:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$aa8,X	; 5
	lda	#$00	; 2
	sta	$aa9,X	; 5
	lda	#$00	; 2
	sta	$aaa,X	; 5
	lda	#$00	; 2
	sta	$aab,X	; 5
	lda	#$00	; 2
	sta	$aac,X	; 5
	lda	#$00	; 2
	sta	$aad,X	; 5
	lda	#$00	; 2
	sta	$aae,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$aa8,X	; 5

; 111
	bit	PAGE1	; 4
smc111:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$728,X	; 5
	lda	#$00	; 2
	sta	$729,X	; 5
	lda	#$00	; 2
	sta	$72a,X	; 5
	lda	#$00	; 2
	sta	$72b,X	; 5
	lda	#$00	; 2
	sta	$72c,X	; 5
	lda	#$00	; 2
	sta	$72d,X	; 5
	lda	#$00	; 2
	sta	$72e,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$728,X	; 5

; 112
	bit	PAGE0	; 4
smc112:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$b28,X	; 5
	lda	#$00	; 2
	sta	$b29,X	; 5
	lda	#$00	; 2
	sta	$b2a,X	; 5
	lda	#$00	; 2
	sta	$b2b,X	; 5
	lda	#$00	; 2
	sta	$b2c,X	; 5
	lda	#$00	; 2
	sta	$b2d,X	; 5
	lda	#$00	; 2
	sta	$b2e,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$b28,X	; 5

; 113
	bit	PAGE1	; 4
smc113:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$728,X	; 5
	lda	#$00	; 2
	sta	$729,X	; 5
	lda	#$00	; 2
	sta	$72a,X	; 5
	lda	#$00	; 2
	sta	$72b,X	; 5
	lda	#$00	; 2
	sta	$72c,X	; 5
	lda	#$00	; 2
	sta	$72d,X	; 5
	lda	#$00	; 2
	sta	$72e,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$728,X	; 5

; 114
	bit	PAGE0	; 4
smc114:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$b28,X	; 5
	lda	#$00	; 2
	sta	$b29,X	; 5
	lda	#$00	; 2
	sta	$b2a,X	; 5
	lda	#$00	; 2
	sta	$b2b,X	; 5
	lda	#$00	; 2
	sta	$b2c,X	; 5
	lda	#$00	; 2
	sta	$b2d,X	; 5
	lda	#$00	; 2
	sta	$b2e,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$b28,X	; 5

; 115
	bit	PAGE1	; 4
smc115:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$728,X	; 5
	lda	#$00	; 2
	sta	$729,X	; 5
	lda	#$00	; 2
	sta	$72a,X	; 5
	lda	#$00	; 2
	sta	$72b,X	; 5
	lda	#$00	; 2
	sta	$72c,X	; 5
	lda	#$00	; 2
	sta	$72d,X	; 5
	lda	#$00	; 2
	sta	$72e,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$728,X	; 5

; 116
	bit	PAGE0	; 4
smc116:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$b28,X	; 5
	lda	#$00	; 2
	sta	$b29,X	; 5
	lda	#$00	; 2
	sta	$b2a,X	; 5
	lda	#$00	; 2
	sta	$b2b,X	; 5
	lda	#$00	; 2
	sta	$b2c,X	; 5
	lda	#$00	; 2
	sta	$b2d,X	; 5
	lda	#$00	; 2
	sta	$b2e,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$b28,X	; 5

; 117
	bit	PAGE1	; 4
smc117:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$728,X	; 5
	lda	#$00	; 2
	sta	$729,X	; 5
	lda	#$00	; 2
	sta	$72a,X	; 5
	lda	#$00	; 2
	sta	$72b,X	; 5
	lda	#$00	; 2
	sta	$72c,X	; 5
	lda	#$00	; 2
	sta	$72d,X	; 5
	lda	#$00	; 2
	sta	$72e,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$728,X	; 5

; 118
	bit	PAGE0	; 4
smc118:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$b28,X	; 5
	lda	#$00	; 2
	sta	$b29,X	; 5
	lda	#$00	; 2
	sta	$b2a,X	; 5
	lda	#$00	; 2
	sta	$b2b,X	; 5
	lda	#$00	; 2
	sta	$b2c,X	; 5
	lda	#$00	; 2
	sta	$b2d,X	; 5
	lda	#$00	; 2
	sta	$b2e,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$b28,X	; 5

; 119
	bit	PAGE1	; 4
smc119:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$7a8,X	; 5
	lda	#$00	; 2
	sta	$7a9,X	; 5
	lda	#$00	; 2
	sta	$7aa,X	; 5
	lda	#$00	; 2
	sta	$7ab,X	; 5
	lda	#$00	; 2
	sta	$7ac,X	; 5
	lda	#$00	; 2
	sta	$7ad,X	; 5
	lda	#$00	; 2
	sta	$7ae,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$7a8,X	; 5

; 120
	bit	PAGE0	; 4
smc120:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$ba8,X	; 5
	lda	#$00	; 2
	sta	$ba9,X	; 5
	lda	#$00	; 2
	sta	$baa,X	; 5
	lda	#$00	; 2
	sta	$bab,X	; 5
	lda	#$00	; 2
	sta	$bac,X	; 5
	lda	#$00	; 2
	sta	$bad,X	; 5
	lda	#$00	; 2
	sta	$bae,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$ba8,X	; 5

; 121
	bit	PAGE1	; 4
smc121:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$7a8,X	; 5
	lda	#$00	; 2
	sta	$7a9,X	; 5
	lda	#$00	; 2
	sta	$7aa,X	; 5
	lda	#$00	; 2
	sta	$7ab,X	; 5
	lda	#$00	; 2
	sta	$7ac,X	; 5
	lda	#$00	; 2
	sta	$7ad,X	; 5
	lda	#$00	; 2
	sta	$7ae,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$7a8,X	; 5

; 122
	bit	PAGE0	; 4
smc122:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$ba8,X	; 5
	lda	#$00	; 2
	sta	$ba9,X	; 5
	lda	#$00	; 2
	sta	$baa,X	; 5
	lda	#$00	; 2
	sta	$bab,X	; 5
	lda	#$00	; 2
	sta	$bac,X	; 5
	lda	#$00	; 2
	sta	$bad,X	; 5
	lda	#$00	; 2
	sta	$bae,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$ba8,X	; 5

; 123
	bit	PAGE1	; 4
smc123:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$7a8,X	; 5
	lda	#$00	; 2
	sta	$7a9,X	; 5
	lda	#$00	; 2
	sta	$7aa,X	; 5
	lda	#$00	; 2
	sta	$7ab,X	; 5
	lda	#$00	; 2
	sta	$7ac,X	; 5
	lda	#$00	; 2
	sta	$7ad,X	; 5
	lda	#$00	; 2
	sta	$7ae,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$7a8,X	; 5

; 124
	bit	PAGE0	; 4
smc124:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$ba8,X	; 5
	lda	#$00	; 2
	sta	$ba9,X	; 5
	lda	#$00	; 2
	sta	$baa,X	; 5
	lda	#$00	; 2
	sta	$bab,X	; 5
	lda	#$00	; 2
	sta	$bac,X	; 5
	lda	#$00	; 2
	sta	$bad,X	; 5
	lda	#$00	; 2
	sta	$bae,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$ba8,X	; 5

; 125
	bit	PAGE1	; 4
smc125:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$7a8,X	; 5
	lda	#$00	; 2
	sta	$7a9,X	; 5
	lda	#$00	; 2
	sta	$7aa,X	; 5
	lda	#$00	; 2
	sta	$7ab,X	; 5
	lda	#$00	; 2
	sta	$7ac,X	; 5
	lda	#$00	; 2
	sta	$7ad,X	; 5
	lda	#$00	; 2
	sta	$7ae,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$7a8,X	; 5

; 126
	bit	PAGE0	; 4
smc126:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$ba8,X	; 5
	lda	#$00	; 2
	sta	$ba9,X	; 5
	lda	#$00	; 2
	sta	$baa,X	; 5
	lda	#$00	; 2
	sta	$bab,X	; 5
	lda	#$00	; 2
	sta	$bac,X	; 5
	lda	#$00	; 2
	sta	$bad,X	; 5
	lda	#$00	; 2
	sta	$bae,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$ba8,X	; 5

; 127
	bit	PAGE1	; 4
smc127:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$450,X	; 5
	lda	#$00	; 2
	sta	$451,X	; 5
	lda	#$00	; 2
	sta	$452,X	; 5
	lda	#$00	; 2
	sta	$453,X	; 5
	lda	#$00	; 2
	sta	$454,X	; 5
	lda	#$00	; 2
	sta	$455,X	; 5
	lda	#$00	; 2
	sta	$456,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$450,X	; 5

; 128
	bit	PAGE0	; 4
smc128:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$850,X	; 5
	lda	#$00	; 2
	sta	$851,X	; 5
	lda	#$00	; 2
	sta	$852,X	; 5
	lda	#$00	; 2
	sta	$853,X	; 5
	lda	#$00	; 2
	sta	$854,X	; 5
	lda	#$00	; 2
	sta	$855,X	; 5
	lda	#$00	; 2
	sta	$856,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$850,X	; 5

; 129
	bit	PAGE1	; 4
smc129:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$450,X	; 5
	lda	#$00	; 2
	sta	$451,X	; 5
	lda	#$00	; 2
	sta	$452,X	; 5
	lda	#$00	; 2
	sta	$453,X	; 5
	lda	#$00	; 2
	sta	$454,X	; 5
	lda	#$00	; 2
	sta	$455,X	; 5
	lda	#$00	; 2
	sta	$456,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$450,X	; 5

; 130
	bit	PAGE0	; 4
smc130:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$850,X	; 5
	lda	#$00	; 2
	sta	$851,X	; 5
	lda	#$00	; 2
	sta	$852,X	; 5
	lda	#$00	; 2
	sta	$853,X	; 5
	lda	#$00	; 2
	sta	$854,X	; 5
	lda	#$00	; 2
	sta	$855,X	; 5
	lda	#$00	; 2
	sta	$856,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$850,X	; 5

; 131
	bit	PAGE1	; 4
smc131:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$450,X	; 5
	lda	#$00	; 2
	sta	$451,X	; 5
	lda	#$00	; 2
	sta	$452,X	; 5
	lda	#$00	; 2
	sta	$453,X	; 5
	lda	#$00	; 2
	sta	$454,X	; 5
	lda	#$00	; 2
	sta	$455,X	; 5
	lda	#$00	; 2
	sta	$456,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$450,X	; 5

; 132
	bit	PAGE0	; 4
smc132:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$850,X	; 5
	lda	#$00	; 2
	sta	$851,X	; 5
	lda	#$00	; 2
	sta	$852,X	; 5
	lda	#$00	; 2
	sta	$853,X	; 5
	lda	#$00	; 2
	sta	$854,X	; 5
	lda	#$00	; 2
	sta	$855,X	; 5
	lda	#$00	; 2
	sta	$856,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$850,X	; 5

; 133
	bit	PAGE1	; 4
smc133:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$450,X	; 5
	lda	#$00	; 2
	sta	$451,X	; 5
	lda	#$00	; 2
	sta	$452,X	; 5
	lda	#$00	; 2
	sta	$453,X	; 5
	lda	#$00	; 2
	sta	$454,X	; 5
	lda	#$00	; 2
	sta	$455,X	; 5
	lda	#$00	; 2
	sta	$456,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$450,X	; 5

; 134
	bit	PAGE0	; 4
smc134:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$850,X	; 5
	lda	#$00	; 2
	sta	$851,X	; 5
	lda	#$00	; 2
	sta	$852,X	; 5
	lda	#$00	; 2
	sta	$853,X	; 5
	lda	#$00	; 2
	sta	$854,X	; 5
	lda	#$00	; 2
	sta	$855,X	; 5
	lda	#$00	; 2
	sta	$856,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$850,X	; 5

; 135
	bit	PAGE1	; 4
smc135:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$4d0,X	; 5
	lda	#$00	; 2
	sta	$4d1,X	; 5
	lda	#$00	; 2
	sta	$4d2,X	; 5
	lda	#$00	; 2
	sta	$4d3,X	; 5
	lda	#$00	; 2
	sta	$4d4,X	; 5
	lda	#$00	; 2
	sta	$4d5,X	; 5
	lda	#$00	; 2
	sta	$4d6,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$4d0,X	; 5

; 136
	bit	PAGE0	; 4
smc136:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$8d0,X	; 5
	lda	#$00	; 2
	sta	$8d1,X	; 5
	lda	#$00	; 2
	sta	$8d2,X	; 5
	lda	#$00	; 2
	sta	$8d3,X	; 5
	lda	#$00	; 2
	sta	$8d4,X	; 5
	lda	#$00	; 2
	sta	$8d5,X	; 5
	lda	#$00	; 2
	sta	$8d6,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$8d0,X	; 5

; 137
	bit	PAGE1	; 4
smc137:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$4d0,X	; 5
	lda	#$00	; 2
	sta	$4d1,X	; 5
	lda	#$00	; 2
	sta	$4d2,X	; 5
	lda	#$00	; 2
	sta	$4d3,X	; 5
	lda	#$00	; 2
	sta	$4d4,X	; 5
	lda	#$00	; 2
	sta	$4d5,X	; 5
	lda	#$00	; 2
	sta	$4d6,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$4d0,X	; 5

; 138
	bit	PAGE0	; 4
smc138:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$8d0,X	; 5
	lda	#$00	; 2
	sta	$8d1,X	; 5
	lda	#$00	; 2
	sta	$8d2,X	; 5
	lda	#$00	; 2
	sta	$8d3,X	; 5
	lda	#$00	; 2
	sta	$8d4,X	; 5
	lda	#$00	; 2
	sta	$8d5,X	; 5
	lda	#$00	; 2
	sta	$8d6,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$8d0,X	; 5

; 139
	bit	PAGE1	; 4
smc139:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$4d0,X	; 5
	lda	#$00	; 2
	sta	$4d1,X	; 5
	lda	#$00	; 2
	sta	$4d2,X	; 5
	lda	#$00	; 2
	sta	$4d3,X	; 5
	lda	#$00	; 2
	sta	$4d4,X	; 5
	lda	#$00	; 2
	sta	$4d5,X	; 5
	lda	#$00	; 2
	sta	$4d6,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$4d0,X	; 5

; 140
	bit	PAGE0	; 4
smc140:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$8d0,X	; 5
	lda	#$00	; 2
	sta	$8d1,X	; 5
	lda	#$00	; 2
	sta	$8d2,X	; 5
	lda	#$00	; 2
	sta	$8d3,X	; 5
	lda	#$00	; 2
	sta	$8d4,X	; 5
	lda	#$00	; 2
	sta	$8d5,X	; 5
	lda	#$00	; 2
	sta	$8d6,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$8d0,X	; 5

; 141
	bit	PAGE1	; 4
smc141:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$4d0,X	; 5
	lda	#$00	; 2
	sta	$4d1,X	; 5
	lda	#$00	; 2
	sta	$4d2,X	; 5
	lda	#$00	; 2
	sta	$4d3,X	; 5
	lda	#$00	; 2
	sta	$4d4,X	; 5
	lda	#$00	; 2
	sta	$4d5,X	; 5
	lda	#$00	; 2
	sta	$4d6,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$4d0,X	; 5

; 142
	bit	PAGE0	; 4
smc142:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$8d0,X	; 5
	lda	#$00	; 2
	sta	$8d1,X	; 5
	lda	#$00	; 2
	sta	$8d2,X	; 5
	lda	#$00	; 2
	sta	$8d3,X	; 5
	lda	#$00	; 2
	sta	$8d4,X	; 5
	lda	#$00	; 2
	sta	$8d5,X	; 5
	lda	#$00	; 2
	sta	$8d6,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$8d0,X	; 5

; 143
	bit	PAGE1	; 4
smc143:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$550,X	; 5
	lda	#$00	; 2
	sta	$551,X	; 5
	lda	#$00	; 2
	sta	$552,X	; 5
	lda	#$00	; 2
	sta	$553,X	; 5
	lda	#$00	; 2
	sta	$554,X	; 5
	lda	#$00	; 2
	sta	$555,X	; 5
	lda	#$00	; 2
	sta	$556,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$550,X	; 5

; 144
	bit	PAGE0	; 4
smc144:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$950,X	; 5
	lda	#$00	; 2
	sta	$951,X	; 5
	lda	#$00	; 2
	sta	$952,X	; 5
	lda	#$00	; 2
	sta	$953,X	; 5
	lda	#$00	; 2
	sta	$954,X	; 5
	lda	#$00	; 2
	sta	$955,X	; 5
	lda	#$00	; 2
	sta	$956,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$950,X	; 5

; 145
	bit	PAGE1	; 4
smc145:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$550,X	; 5
	lda	#$00	; 2
	sta	$551,X	; 5
	lda	#$00	; 2
	sta	$552,X	; 5
	lda	#$00	; 2
	sta	$553,X	; 5
	lda	#$00	; 2
	sta	$554,X	; 5
	lda	#$00	; 2
	sta	$555,X	; 5
	lda	#$00	; 2
	sta	$556,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$550,X	; 5

; 146
	bit	PAGE0	; 4
smc146:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$950,X	; 5
	lda	#$00	; 2
	sta	$951,X	; 5
	lda	#$00	; 2
	sta	$952,X	; 5
	lda	#$00	; 2
	sta	$953,X	; 5
	lda	#$00	; 2
	sta	$954,X	; 5
	lda	#$00	; 2
	sta	$955,X	; 5
	lda	#$00	; 2
	sta	$956,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$950,X	; 5

; 147
	bit	PAGE1	; 4
smc147:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$550,X	; 5
	lda	#$00	; 2
	sta	$551,X	; 5
	lda	#$00	; 2
	sta	$552,X	; 5
	lda	#$00	; 2
	sta	$553,X	; 5
	lda	#$00	; 2
	sta	$554,X	; 5
	lda	#$00	; 2
	sta	$555,X	; 5
	lda	#$00	; 2
	sta	$556,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$550,X	; 5

; 148
	bit	PAGE0	; 4
smc148:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$950,X	; 5
	lda	#$00	; 2
	sta	$951,X	; 5
	lda	#$00	; 2
	sta	$952,X	; 5
	lda	#$00	; 2
	sta	$953,X	; 5
	lda	#$00	; 2
	sta	$954,X	; 5
	lda	#$00	; 2
	sta	$955,X	; 5
	lda	#$00	; 2
	sta	$956,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$950,X	; 5

; 149
	bit	PAGE1	; 4
smc149:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$550,X	; 5
	lda	#$00	; 2
	sta	$551,X	; 5
	lda	#$00	; 2
	sta	$552,X	; 5
	lda	#$00	; 2
	sta	$553,X	; 5
	lda	#$00	; 2
	sta	$554,X	; 5
	lda	#$00	; 2
	sta	$555,X	; 5
	lda	#$00	; 2
	sta	$556,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$550,X	; 5

; 150
	bit	PAGE0	; 4
smc150:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$950,X	; 5
	lda	#$00	; 2
	sta	$951,X	; 5
	lda	#$00	; 2
	sta	$952,X	; 5
	lda	#$00	; 2
	sta	$953,X	; 5
	lda	#$00	; 2
	sta	$954,X	; 5
	lda	#$00	; 2
	sta	$955,X	; 5
	lda	#$00	; 2
	sta	$956,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$950,X	; 5

; 151
	bit	PAGE1	; 4
smc151:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$5d0,X	; 5
	lda	#$00	; 2
	sta	$5d1,X	; 5
	lda	#$00	; 2
	sta	$5d2,X	; 5
	lda	#$00	; 2
	sta	$5d3,X	; 5
	lda	#$00	; 2
	sta	$5d4,X	; 5
	lda	#$00	; 2
	sta	$5d5,X	; 5
	lda	#$00	; 2
	sta	$5d6,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$5d0,X	; 5

; 152
	bit	PAGE0	; 4
smc152:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$9d0,X	; 5
	lda	#$00	; 2
	sta	$9d1,X	; 5
	lda	#$00	; 2
	sta	$9d2,X	; 5
	lda	#$00	; 2
	sta	$9d3,X	; 5
	lda	#$00	; 2
	sta	$9d4,X	; 5
	lda	#$00	; 2
	sta	$9d5,X	; 5
	lda	#$00	; 2
	sta	$9d6,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$9d0,X	; 5

; 153
	bit	PAGE1	; 4
smc153:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$5d0,X	; 5
	lda	#$00	; 2
	sta	$5d1,X	; 5
	lda	#$00	; 2
	sta	$5d2,X	; 5
	lda	#$00	; 2
	sta	$5d3,X	; 5
	lda	#$00	; 2
	sta	$5d4,X	; 5
	lda	#$00	; 2
	sta	$5d5,X	; 5
	lda	#$00	; 2
	sta	$5d6,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$5d0,X	; 5

; 154
	bit	PAGE0	; 4
smc154:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$9d0,X	; 5
	lda	#$00	; 2
	sta	$9d1,X	; 5
	lda	#$00	; 2
	sta	$9d2,X	; 5
	lda	#$00	; 2
	sta	$9d3,X	; 5
	lda	#$00	; 2
	sta	$9d4,X	; 5
	lda	#$00	; 2
	sta	$9d5,X	; 5
	lda	#$00	; 2
	sta	$9d6,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$9d0,X	; 5

; 155
	bit	PAGE1	; 4
smc155:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$5d0,X	; 5
	lda	#$00	; 2
	sta	$5d1,X	; 5
	lda	#$00	; 2
	sta	$5d2,X	; 5
	lda	#$00	; 2
	sta	$5d3,X	; 5
	lda	#$00	; 2
	sta	$5d4,X	; 5
	lda	#$00	; 2
	sta	$5d5,X	; 5
	lda	#$00	; 2
	sta	$5d6,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$5d0,X	; 5

; 156
	bit	PAGE0	; 4
smc156:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$c00,X	; 5

; 157
	bit	PAGE1	; 4
smc157:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$c00,X	; 5

; 158
	bit	PAGE0	; 4
smc158:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$c00,X	; 5

; 159
	bit	PAGE1	; 4
smc159:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$c00,X	; 5

; 160
	bit	PAGE0	; 4
smc160:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$c00,X	; 5

; 161
	bit	PAGE1	; 4
smc161:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$c00,X	; 5

; 162
	bit	PAGE0	; 4
smc162:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$c00,X	; 5

; 163
	bit	PAGE1	; 4
smc163:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$c00,X	; 5

; 164
	bit	PAGE0	; 4
smc164:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$c00,X	; 5

; 165
	bit	PAGE1	; 4
smc165:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$c00,X	; 5

; 166
	bit	PAGE0	; 4
smc166:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$c00,X	; 5

; 167
	bit	PAGE1	; 4
smc167:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$c00,X	; 5

; 168
	bit	PAGE0	; 4
smc168:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$c00,X	; 5

; 169
	bit	PAGE1	; 4
smc169:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$c00,X	; 5

; 170
	bit	PAGE0	; 4
smc170:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$c00,X	; 5

; 171
	bit	PAGE1	; 4
smc171:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$c00,X	; 5

; 172
	bit	PAGE0	; 4
smc172:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$c00,X	; 5

; 173
	bit	PAGE1	; 4
smc173:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$c00,X	; 5

; 174
	bit	PAGE0	; 4
smc174:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$c00,X	; 5

; 175
	bit	PAGE1	; 4
smc175:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$c00,X	; 5

; 176
	bit	PAGE0	; 4
smc176:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$c00,X	; 5

; 177
	bit	PAGE1	; 4
smc177:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$c00,X	; 5

; 178
	bit	PAGE0	; 4
smc178:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$c00,X	; 5

; 179
	bit	PAGE1	; 4
smc179:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$c00,X	; 5

; 180
	bit	PAGE0	; 4
smc180:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$c00,X	; 5

; 181
	bit	PAGE1	; 4
smc181:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$c00,X	; 5

; 182
	bit	PAGE0	; 4
smc182:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$c00,X	; 5

; 183
	bit	PAGE1	; 4
smc183:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$c00,X	; 5

; 184
	bit	PAGE0	; 4
smc184:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$c00,X	; 5

; 185
	bit	PAGE1	; 4
smc185:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$c00,X	; 5

; 186
	bit	PAGE0	; 4
smc186:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$c00,X	; 5

; 187
	bit	PAGE1	; 4
smc187:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$c00,X	; 5

; 188
	bit	PAGE0	; 4
smc188:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$c00,X	; 5

; 189
	bit	PAGE1	; 4
smc189:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$c00,X	; 5

; 190
	bit	PAGE0	; 4
smc190:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$c00,X	; 5

; 191
	bit	PAGE1	; 4
smc191:	ldx	#$01	; 2
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	lda	#$00	; 2
	sta	$c00,X	; 5
	ldx	#$00	; 2
	lda	ZERO	; 3
	sta	$c00,X	; 5

