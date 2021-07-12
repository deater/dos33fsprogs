; move a ball

; very slowly

; 133 bytes	-- first attempt
; 130 bytes	-- convert jmp to branches
; 132 bytes	-- don't start at 0,0
; 128 bytes	-- bit trick
; 126 bytes	-- remove old code
; 145 bytes	-- rounded edges
; 143 bytes	-- optimize rounded edges
; 137 bytes	-- move XX into X
; 136 bytes	-- jmp back to loop
; 130 bytes	-- paramaterize wall collision
; 125 bytes	-- turn wall collision into loop
; 148 bytes	-- add purple line
; 144 bytes	-- move line to #$55 (same as purple)
; 142 bytes	-- HCLR has Y at 0 at end
; 141 bytes	-- hopefully useless CLC?


HGR_BITS	= $1C
GBASL		= $26
GBASH		= $27
HGR_X		= $E0
HGR_Y		= $E2
HGR_COLOR	= $E4
HGRPAGE		= $E6

MX		= $F7
MY		= $F8
XDIR		= $F9
YDIR		= $FA

XC		= $FB
YC		= $FC
;XX		= $FE
YY		= $FF

PAGE0	= $C054
PAGE1	= $C055

HGR	= $F3E2
HGR2	= $F3D8
HCLR	= $F3F2
BKGND	= $F3F6
HPOSN	= $F411			;; (Y,X) = X, A = Y
				;; line addr in GBASL/GBASH
				;; 	with offset in HGR.HORIZ, Y

HPLOT0	= $F457			;; plot at (Y,X), (A)
HGLIN	= $F53A			;; line to (A,X), (Y)

	;===============================
	;===============================
	;===============================
	;===============================

ball:
	jsr	HGR2		; clear page1
				; HGRPAGE now $40
				; A is 0
	; A is 0
	sta	MX
	lda	#$40
	sta	MY

	; xdir and ydir start at 2?

	ldy	#$2
	sty	YDIR
	sty	XDIR

	;=====================================
	; loop
	;=====================================

move_ball_loop:

	;====================
	; flip pages
	;   16 bytes, can't seem to do better
	;====================

	bit	HGRPAGE		; V set if $40          ; 2
	bvc	show_page1                              ; 2

show_page2:
	bit	PAGE1                                   ; 3
	lsr	HGRPAGE                                 ; 2
	bne	done_page				; 2

show_page1:
	bit	PAGE0                                   ; 3
	asl	HGRPAGE                                 ; 2
done_page:


clear_screen:
	;=======================
	; clear screen to black
	;=======================

	jsr	HCLR		; clear screen
				; X untouched
				; A and Y are 0?

	;=======================
	; draw purple line
	;=======================

purple_line:

	; draw purple line



;	ldy	#0
	inx
;	ldx	#0		; can we assume X is FF?

	lda	#$55		; purple
	sta	HGR_COLOR
;	lda	#100		; also line location

	jsr	HPLOT0	;; (Y,X) = X, (A) = Y

	lda	#150
	ldx	#0
	ldy	#$55
	jsr	HGLIN	;; (A,X), (Y)

	;===========================
	; draw ball
	;===========================

draw_ball:

	lda	MY		; actual Y
	sta	YY		; current Y

	lda	#13		; 13 lines tall
	sta	YC		; count

ball_loop_y:

	ldx	MX		; load actual X
	lda	#14		; 14 pixels wide

	; check if rounded corders

	ldy	YC
	cpy	#13
	beq	make_round
	cpy	#1
	bne	write_xc

make_round:
	inx			; start indented
	inx
	lda	#10		; and shorter
write_xc:
	sta	XC		; update xcount


ball_loop_x:


set_color:
	txa			; XX more interesting than XC?
	eor	YC
	and	#$4
	beq	set_orange
set_white:
	lda	#$FF		; white2
	.byte	$2C		; bit trick
set_orange:
	lda	#$AA		; orange
set_hgr_color:
	sta	HGR_COLOR


hplot_time:

	; hplot


	ldy	#0
	;		; XX already in X
	lda	YY	; put YY into A



	jsr	HPLOT0	;; (Y,X) = X, A = Y
			;; destroys X, Y, A
			;; but, X is in HGR.X and Y is in HGR.X+1
			;; AA is in HGR.Y

	ldx	HGR_X	; restore XX into X

	inx		; inc XX
	dec	XC
	bne	ball_loop_x

	inc	YY
	dec	YC
	bne	ball_loop_y

	;===========================
	; move sprite
	;===========================

	ldx	#1
handle_wall_loop:

	;=================================
	; handle wall
	;=================================

handle_wall:
	lda	MX,X		; load X location
;	clc
	adc	XDIR,X		; add in our direction/speed
	bmi	switch_xdir	; if <0 or > 127 then switch direction

	sta	MX,X
	bpl	noswitch_xdir	; otherwise store and skip

switch_xdir:
	lda	XDIR,X		; get direction and inverse
	eor	#$FF
	sta	XDIR,X
	inc	XDIR,X		; two's complement

noswitch_xdir:

	dex
	bpl	handle_wall_loop
	bmi	move_ball_loop




;==============
; so we can call from basic

	jmp	ball
