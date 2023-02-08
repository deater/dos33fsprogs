; dsr rotate lores

; by deater (Vince Weaver) <vince@deater.net>



dsr_rotate:

	;===================
	; init screen

	jsr	HGR			; clear PAGE1
					; A,Y are 0?

	sta	FRAME
	sta	FRAMEH

	bit	FULLGR			; full screen

	bit	LORES			; switch to Lo-res

	;===================
	; init vars

	ldx	#4
	stx	HGR_SCALE		; scale of drawings

	;===================
        ; int tables
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

	lda	gr_offsets_l,X
	sta	GBASL

	lda	gr_offsets_h,X
	clc
draw_page_smc:
	adc	#$0
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

	;=================
	; page flip

	ldx	#0
	lda     draw_page_smc+1 ; DRAW_PAGE
        beq     done_page
        inx
done_page:
        ldy     PAGE1,X         ; set display page to PAGE1 or PAGE2

        eor     #$4             ; flip draw page between $400/$800
        sta     draw_page_smc+1 ; DRAW_PAGE




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

;	lda	FRAMEH
;	cmp	#2

	lda	FRAME
;	bpl	big_loop
	cmp	#66

	beq	done_this
	jmp	big_loop

done_this:
	rts

shape_dsr:
.byte   $2d,$36,$ff,$3f
.byte   $24,$ad,$22,$24,$94,$21,$2c,$4d
.byte   $91,$3f,$36,$00

.include "gr_offsets.s"
