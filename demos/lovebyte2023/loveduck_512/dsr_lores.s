; dsr rotate lores

; by deater (Vince Weaver) <vince@deater.net>

; 510h


dsr_rotate:

	;===================
	; init screen

	jsr	HGR			; clear PAGE1
					; A,Y are 0?

	bit	FULLGR			; full screen

	bit	LORES			; switch to Lo-res

	;===================
	; init vars

	ldx	#4
	stx	HGR_SCALE		; scale of drawings

	;===================
	; init hgr tables
	;	lookup for HGR lines 0..47 stored in zero page

	ldx	#47
init_loop:
        txa
        jsr	HPOSN			; important part is A=ycoord
	ldx	HGR_Y			; A value stored in HGR_Y
	lda	GBASL
	sta     hgr_lookup_l,X
	lda	GBASH
	sta	hgr_lookup_h,X
	dex
	bpl	init_loop

	;===================
	; init gr tables
	;	lookup for GR lines 0..23 stored in zero page

	ldx	#23
init_gr_loop:
        txa
        jsr	GBASCALC
	lda	GBASL
	sta     gr_lookup_l,X
	lda	GBASH
	sta	gr_lookup_h,X
	lda	#0
	sta	$F0,X		; clear vars to 0

	dex
	bpl	init_gr_loop


big_loop:

;=====================================
; draw dsr
draw_dsr:

	ldy	#0		; set hi-res position to 20,24
	ldx	#20
	lda	#24
	jsr     HPOSN           ; set screen position to X= (y,x) Y=(a)
                                ; saves X,Y,A to zero page
                                ; after Y= orig X/7
                                ; A and X are ??

	ldx	#<shape_dsr	; point to bottom byte of shape address
	ldy	#>shape_dsr	; point to top byte of shape address

        ; ROT in A
        lda     ROTATION	; rotation
        jsr	XDRAW0		; XDRAW 1 AT X,Y
                                ; Both A and X are 0 at exit
                                ; Z flag set on exit

;===============================
; copy to lores
; X654 3210 X654 3210



	ldy	#47
	sty	YY			; set y-coord to 47
lsier_outer:
	ldx	YY			; a bit of a wash
	lda	hgr_lookup_l,X
	sta	hgr_scrn_smc+1
	lda	hgr_lookup_h,X
	sta	hgr_scrn_smc+2

	txa
	lsr
	tax

	lda	gr_lookup_l,X
	sta	GBASL

	lda	gr_lookup_h,X

	clc
	adc	DRAW_PAGE
	sta	GBASH

	lda	YY
	lsr
	lda	#$0f
	bcc	mask_hi
	eor	#$ff
mask_hi:
	sta	MASK


;	jsr	PLOT			; plot at Y,A
					; this sets up GBASL for us
					; 	does create slight glitch
					; 	on left side of screen


	ldy	#0			; COUNT
	ldx	#0			; X = hires x-coord


lsier_inner:

	lda	#6
	sta	BB

lsier_inner_inner:

hgr_scrn_smc:
	lsr	$2000,X			; note this also clears screen
	lda	#0

	; bcc = $90, bcs = $b0
	;	1001        1011
flip_smc:
	bcs	no_color

	lda	YY			; use Y-coord for color
	adc	ROTATION		; rotate colors
no_color:
	jsr	SETCOL

					; x-coord already in Y
	; inline PLOT1
	; jsr	PLOT1			; plot at (GBASL),Y

	lda     (GBASL),y
	eor     COLOR
	and     MASK
	eor     (GBASL),y
	sta     (GBASL),y

					; GBASL/H set earlier with PLOT

	iny				; increment count
	cpy	#40			; if hit 40, done
	beq	done_line

	dec	BB			; decrement byte count
	bpl	lsier_inner_inner	; if <7 then keep shifting

	inx				; increment hires-x value
	bne	lsier_inner		; bra

done_line:
	dec	YY			; decrement y-coord
	bpl	lsier_outer		; until less than 0

end:

	jsr	flip_page




	inc	ROTATION
	inc	ROTATION


	lda	ROTATION

	and	#$20
	clc
	adc	#$90			; flip bcs/bcc
	sta	flip_smc

	inc	FRAME
;	bne	no_frame_oflo
;	inc	FRAMEH
;no_frame_oflo:


	lda	FRAME
	cmp	#66

	beq	done_this
	jmp	big_loop

done_this:

end_it:

