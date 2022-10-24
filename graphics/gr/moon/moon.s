; Moon

; by deater (Vince Weaver) <vince@deater.net>


; Zero Page
GBASL		= $26
GBASH		= $27

COLOR		= $30

SEEDL		= $43
SEEDH		= $44

FRAME		= $EA
FRAME2		= $EB
FRAME4		= $EC

TEMP		= $FC
PAGE		= $FD
COUNT		= $FE
WHICH		= $FF

; Soft Switches
SET_GR	= $C050 ; Enable graphics
FULLGR	= $C052	; Full screen, no text
PAGE1	= $C054 ; Page1
PAGE2	= $C055 ; Page2
LORES	= $C056	; Enable LORES graphics

; ROM routines

GBASCALC= $F847         ; take Y-coord/2 in A, put address in GBASL/H ( a trashed, C clear)

SETGR	= $FB40
WAIT	= $FCA8				;; delay 1/2(26+27A+5A^2) us
PLOT    = $F800                 ;; PLOT AT Y,A
SETCOL  = $F864                 ;; COLOR=A


moon:

	;===================
	; init screen
	jsr	SETGR				; lores graphics
	bit	FULLGR				; full screen

	lda	#$0				; start on page1
	sta	PAGE

;parallax_forever:

;	inc	FRAME				; increment frame
;
;	lda	FRAME				; also have frame/2 and frame/4
;	lsr
;	sta	FRAME2
;	lsr
;	sta	FRAME4

	;==========================
	; flip page

;	lda	PAGE				; get current page
;	pha					; save for later

;	lsr					; switch visible page
;	lsr
;	tay
;	lda	PAGE1,Y

;	pla					; save old draw page

;	eor	#$4				; toggle to other draw page
;	sta	PAGE


big_loop:
	lda	#$66
	sta	COLOR

	ldx	#24
	stx	COUNT
water:
	ldx	COUNT
	jsr	get_z
	sta	TEMP
	asl
	asl
	asl
	tax

water_line:

	jsr	random

;	adc	FRAME
	adc	COUNT

	and	#$1F

	tay
	lda	COUNT
	clc
	adc	#23
	jsr	PLOT		; plot at Y,A
skip:
	dex
	bne	water_line

	dec	COUNT
	bne	water

over:
	lda	#1
	sta	SEEDL
	lda	#1
	sta	SEEDH

	inc	FRAME
	lda	#100
	jsr	WAIT
	jsr	clear_bottom
	jmp	big_loop


; from batari basic (?)

random:
	lda	SEEDH
	lsr
	rol	SEEDL
	bcc	noeor
	eor	#$B4
noeor:
	sta	SEEDH
	eor	SEEDL
	rts


get_z:
	lda	#1
	cpx	#10
	bcs	done_z
	lda	Z_lookup,X
done_z:
	rts


HLIN  = $F819                 ; HLINE Y,$2C at A
clear_bottom:
	lda	#0
	sta	COLOR
	lda	#24
	sta	WHICH
clear_bottom_loop:
	ldy	#0
	lda	#39
	sta	$2C
	lda	WHICH
	cmp	#48
	beq	done_clear
	jsr	HLIN
	inc	WHICH
	bne	clear_bottom_loop
done_clear:
	rts


Z_lookup:
	.byte 24, 12, 8, 6, 5, 4, 3, 3
	.byte  2,  2


;20 FOR Y=0 TO 24
;30 Z=24/(Y+1)
;40 FOR I=0 TO Z*4
;50 X=INT(RND(1)*39)+T*150/Z
;'60 W=COS(RND(1)+T)*12/Z
;65 C=SCRN(X,20-Y/2):IF C=0 THEN C=6
;70 COLOR=C:PLOT X,Y+20
;80 NEXT:NEXT:GOTO 20

