	;FIXME -- this doesn't actuall work yet


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

