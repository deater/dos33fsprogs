.include "zp.inc"

	;==========================
	; Setup Graphics
	;==========================

	bit	SET_GR			; graphics mode
	bit	HIRES			; hires mode
        bit	TEXTGR			; mixed text/graphics
        bit	PAGE0			; first graphics page
	jsr	HOME

	jsr	hgr_clear

	lda	#0
	sta	DRAW_PAGE

	lda	#<sprite
	sta	INL
	lda	#>sprite
	sta	INH

	lda	#10
	sta	XPOS
	lda	#10
	sta	YPOS

	jsr	hgr_put_sprite

infinite_loop:
	jmp	infinite_loop


	;=============================================
	; hgr_put_sprite
	;=============================================
	; Sprite to display in INH,INL
	; Location is XPOS,YPOS

hgr_put_sprite:

	ldy	#0		; byte 0 is xsize			; 2
	lda	(INL),Y							; 5
	sta	CH		; xsize is in CH			; 3
	iny								; 2

	lda	(INL),Y         ; byte 1 is ysize			; 5
	sta	CV              ; ysize is in CV			; 3
	iny								; 2

	lda	YPOS		; make a copy of ypos			; 3
	sta	TEMPY		; as we modify it			; 3
								;===========
								;       28

hgr_put_sprite_loop:
        sty	TEMP            ; save sprite pointer                   ; 3

	lda	TEMPY		; load tempy
	lsr
	lsr			; divide by 8 to get proper row
				; but mul by 4 because array is 2byte addr
	tay			; put in Y

	lda	TEMPY
	and	#$7		; bottom 3 bits
	asl
	asl
	sta	SPRITETEMP


        lda	hgr_offsets,Y	; lookup hi-res row address		; 5

	clc
	adc	XPOS		; add in XPOS (FIXME: which is div by 7)
        sta	OUTL		; store out low byte of addy            ; 3

        lda	hgr_offsets+1,Y	; look up high byte                     ; 5
	adc	SPRITETEMP
        adc	DRAW_PAGE       ;                                       ; 3
        sta	OUTH            ; and store it out                      ; 3



        ldy	TEMP            ; restore sprite pointer                ; 3

                                ; OUTH:OUTL now points at right place

        ldx	CH              ; load xsize into x                     ; 3


hgr_put_sprite_pixel:
	lda	(INL),Y                 ; get sprite colors             ; 5
	iny                             ; increment sprite pointer      ; 2

	sty	TEMP                    ; save sprite pointer           ; 3
	ldy	#$0                                                     ; 2

	sta	(OUTL),Y

hgr_put_sprite_done_draw:

	ldy	TEMP                    ; restore sprite pointer        ; 3

	inc	OUTL                    ; increment output pointer      ; 5
	dex                             ; decrement x counter           ; 2
	bne	hgr_put_sprite_pixel        ; if not done, keep looping     ; 2nt/3

	inc	TEMPY                                                   ; 5
	dec	CV                      ; decemenet total y count       ; 5
	bne	hgr_put_sprite_loop	; loop if not done              ; 2nt/3

	rts				; return                        ; 6


	;==========================
	; hgr clear
	;==========================
hgr_clear:
	lda	#$00
	sta	OUTL
	lda	#$20
	sta	OUTH

hgr_clear_loop:
	lda	#$0
	sta	(OUTL),Y
	iny
	bne	hgr_clear_loop

	inc	OUTH
	lda	OUTH
	cmp	#$40
	bne	hgr_clear_loop

	rts


sprite:
	.byte 1,5
	.byte $82,$88,$a0,$88,$82

	;===========================
	; Set Co-ordinate
	;===========================


hgr_offsets:
        .word   $2000,$2080,$2100,$2180,$2200,$2280,$2300,$2380
        .word   $2028,$20a8,$2128,$21a8,$2228,226a8,$2328,$23a8
        .word   $2050,$20d0,$2150,$21d0,$2250,$22d0,$2350,$23d0




.incbin	"GLADOS.HGR"
