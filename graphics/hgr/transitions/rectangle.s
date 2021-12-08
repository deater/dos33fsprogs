; Rectangle Transition
;   "night fell like a power point"

; 167 bytes -- original
; 166 bytes -- make end loop beq not jmp
; 156 bytes -- use GBASL/GBASH rather than self-modifying code
; 154 bytes -- countdown X in inner loop
; 153 bytes -- remove unnecessary clc
; 151 bytes -- was setting Y twice
; 147 bytes -- lookup table for XADD/YADD
; 145 bytes -- stop on YY value
; 150 bytes -- have it cycle colors
; 147 bytes -- init zp to 0 in loop
; 144 bytes -- put lookup table in zero page

; zero page
GBASL	= $26
GBASH	= $27

HGR_X           = $E0
HGR_XH          = $E1
HGR_Y           = $E2
HGR_COLOR       = $E4
HGR_PAGE        = $E6

GBASH_SAVED = $F5

TABLE	= $F0	; should be 0
TABLE2  = $F1	; should be 1
TABLE3	= $F2	; should be 0
TABLE4  = $F3	; should be -1
TABLE5	= $F4	; should be 0

XX	= $F6
YY	= $F7
XADD	= $F8
YADD	= $F9
XMIN	= $FA
XMAX	= $FB
YMIN	= $FC
YMAX	= $FD
FRAME	= $FE
LINE	= $FF

; soft-switches
FULLGR	= $C052
PAGE1	= $C054

; ROM routines

HGR2	= $F3D8
HPOSN	= $F411		; (Y,X),(A)  (values stores in HGRX,XH,Y)

WAIT    = $FCA8                 ;; delay 1/2(26+27A+5A^2) us

	;================================
	; Clear screen and setup graphics
	;================================
rectangle:

	jsr	HGR2		; set hi-res 140x192, page2, fullscreen
				; A and Y both 0 at end

over:
	; clear our zp things to 0

	ldx	#15
clear_loop:
	sta	$EF,X
	dex
	bne	clear_loop

	dec	XMIN		; xmin = -1

	inc	TABLE2
	dec	TABLE4

	ldy	#39
	sty	XMAX		; xmax=39
	ldy	#24
	sty	YMAX		; ymax=24


main_loop:
	; left to right horizontal

	dec	YMAX
	; XADD=1,YADD=0
	jsr	draw_line

	; top to bottom vertical
	inc	XMIN
	; XADD=0,YADD=1
	jsr	draw_line

	; right to left horizontal
	inc	YMIN
	; XADD=-1,YADD=0
	jsr	draw_line

	; bottom to top vertical
	dec	XMAX
	; XADD=0,YADD=-1
	jsr	draw_line

	; YY is in A here
	; X is zero here

	cmp	#12
	bne	main_loop

end:
	txa			; put zero into A
	inc	color_smc+1
	bne	over


	;=================================
	; draw a horizontal/vertical line
	;	8 rows high
draw_line:

get_next:
	lda	FRAME
	and	#$3
	tax
	lda	TABLE2,X
	sta	XADD
	lda	TABLE,X
	sta	YADD
	inc	FRAME

repeat_line:
	lda	YY		; YY * 8
	asl
	asl
	asl

	jsr	HPOSN		; (Y,X),(A)  (values stores in HGRX,XH,Y)
	lda	GBASH
	sta	GBASH_SAVED	; reset top of box

out_loop:
	ldx	#8
	lda	GBASH_SAVED
	sta	GBASH
	ldy	XX
in_loop:

color_smc:
	lda	#$7F		; draw white box
output_smc:
	sta	(GBASL),Y

	lda	GBASH		; move to next line
	clc
	adc	#$4
	sta	GBASH

	dex
	bne	in_loop

	lda	#25		; wait a bit
	jsr	WAIT

check_x:
	clc
	lda	XADD
	beq	check_y
	adc	XX
	sta	XX
	cmp	XMIN
	beq	done_line
	cmp	XMAX
	beq	done_line

	bne	out_loop

check_y:
	; c should already be clear
	lda	YY
	adc	YADD
	sta	YY

	cmp	YMIN
	beq	done_line
	cmp	YMAX
	beq	done_line

	bne	repeat_line

done_line:
	rts





