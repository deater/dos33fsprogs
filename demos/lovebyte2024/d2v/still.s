
; still...

still:
	jsr	HOME
	bit	SET_TEXT

;	HLINE   = $F819                 ; HLINE Y,$2C at A
;	VLINE   = $F828                 ; VLINE A,$2D at Y

	lda	#'*'|$80
	sta	COLOR

	lda	#39
	sta	H2
	lda	#0
	tay
	jsr	HLINE

	; x=0, Y=39 after?
	sty	H2
	ldy	#0
	lda	#46
	jsr	HLINE
	; x=0, y=39 after

	lda	#46
	sta	V2
	lda	#0
	tay
	jsr	VLINE
	; x=0,y=0
	lda	#46
	sta	V2
	lda	#1
	ldy	#18
	jsr	VLINE
	lda	#46
	sta	V2
	lda	#1
	ldy	#39
	jsr	VLINE

	lda	#20
	sta	$20
	sta	$21
	lda	#2
	sta	$22

	lda	#<opening
	sta	INL
	lda	#>opening
	sta	INH

	ldy	#0
opening_loop:
	lda	(INL),Y
	beq	done_still
	ora	#$80
	jsr	COUT1
	iny
	bne	opening_loop	; bra

done_still:
	jmp	done_still

opening:
.byte	13
.byte "       ,:/;=",13
.byte "   ,X M@@M  HM@/",13
.byte "  @@M MX. XXXH@@#/",13
.byte " @@@X.       .    ;",13
.byte "@  M/          +M@M",13
.byte "@@M .          H @@",13
.byte "/MMMH.         MM =",13
.byte " .    .     -H @@M ",13
.byte "  =MMM@MH +M@+ MX",13
.byte "    ,++ .MMMM= ",0

.if 0
.byte	13
.byte "       ,:/;=",13
.byte "   ,X M@@M=-HM@/",13
.byte "  @@M MX.-XXXH@@#/",13
.byte " @@@X.       -H$%%;",13
.byte "X/-M/          +M@M",13
.byte "@@M,.          H @@",13
.byte "/MMMH.         MM;=",13
.byte " .----.     -H,@@M,",13
.byte "  =MMM@MH.+M@+/MX",13
.byte "    ,++,HMMMM==",0
.endif
