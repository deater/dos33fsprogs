PLOT    = $F800 ; plot, horiz=y, vert=A (A trashed, XY Saved)
SETCOL  = $F864
TEXT    = $FB36                         ;; Set text mode
TABV	= $FB5B
BASCALC = $FBC1
SETGR   = $FB40
STORADV	= $FBF0
HOME    = $FC58                         ;; Clear the text screen
WAIT    = $FCA8                         ;; delay 1/2(26+27A+5A^2) us
HLINE   = $F819
CH	= $24
CV	= $25
COLOR	= $30
TEMPY	= $FF

graphic:
.byte	$F0,$25,$1C,$F0,$26,$1C,$F0,$24,$6C,$A0,$1F,$F0,$16,$6D,$B0,$2F
.byte	$F0,$15,$69,$B0,$3F,$F0,$14,$71,$A0,$4F,$F0,$13,$72,$A0,$5F,$F0
.byte	$13,$56,$B0,$67,$F0,$20,$12,$10,$BF,$52,$F0,$12,$4D,$22,$1F,$31
.byte	$42,$3F,$62,$F0,$0F,$6D,$22,$2F,$11,$34,$12,$4F,$72,$D0,$4D,$39
.byte	$22,$BF,$82,$E0,$5D,$22,$BF,$92,$F0,$0F,$3D,$22,$A7,$BF,$F0,$11
.byte	$12,$10,$9F,$17,$CF,$00

rle:
	jsr	SETGR
rerun:
	lda	#1
	sta	CH
	jsr	TABV

	ldy	#0
decode_loop:
	lda	graphic,Y
	pha
	jsr	SETCOL		; puts (color&0xf)*17 in $30
	pla
	lsr
	lsr
	lsr
	lsr
	beq	rerun		; if stride=0 then done
	cmp	#$f
	bne	ready
	iny
	lda	graphic,Y
ready:
	tax
	sty	TEMPY
final_loop:
	lda	COLOR
	jsr	STORADV		; destroys A and Y
	dex
	bne	final_loop
	ldy	TEMPY
	iny
	jmp	decode_loop
start:
	jmp	rle		; ampersand jumps to $3f5
				; 140 is 8c in hex
				; so want to load at $3f5-$8c+3 = $36C


