; Moving
;   moving, orange and green


; zero page
GBASL	= $26
GBASH	= $27
YY	= $69
ROW_SUM = $70

HGR_X           = $E0
HGR_XH          = $E1
HGR_Y           = $E2
HGR_COLOR       = $E4
HGR_PAGE        = $E6

FRAME	= $FC
SUM	= $FD
SAVEX	= $FE
SAVEY	= $FF

; soft-switches
FULLGR	= $C052
PAGE1	= $C054

; ROM routines

HGR2	= $F3D8
HPOSN	= $F411		; (Y,X),(A)  (values stores in HGRX,XH,Y)

	;================================
	; Clear screen and setup graphics
	;================================
oval:

	jsr	HGR2		; set hi-res 140x192, page2, fullscreen
				; A and Y both 0 at end
	;==================
	; create sinetable

	;ldy	#0		; Y is 0
sinetable_loop:
	tya							; 2
	and	#$3f	; wrap sine at 63 entries		; 2

	cmp	#$20
	php		; save pos/negative for later

	and	#$1f

	cmp	#$10
	bcc	sin_left		; blt

sin_right:
	; sec	carry should be set here
	eor	#$FF
	adc	#$20			; 32-X
sin_left:
	tax
	lda	sinetable_base,X				; 4+

	plp
	bcc	sin_done

sin_negate:
	; carry set here
	eor	#$ff
;	adc	#0		; FIXME: this makes things off by 1

sin_done:
	sta	sinetable,Y

	iny
	bne	sinetable_loop


	; NOTE: making gbash/gbasl table wasn't worth it

	;============================
	; main loop
	;============================

draw_oval:
	inc	FRAME

	lda	#191		; YY

create_yloop:
	; HGR_Y (YY) is in A here

;	ldx	#39		; X is don't care?
;	ldy	#0		; Y is also don't care?

	jsr	HPOSN		; (Y,X),(A)  (values stores in HGRX,XH,Y)

	; restore values

	lda	HGR_Y		; YY

calcsine_div4:
	lsr
	lsr							; 2
	sec
	sbc	FRAME
	tax
	lda	sinetable,X
	sta	row_sum_smc+1

	ldx	HGR_Y		; YY

	ldy	#39		; XX
create_xloop:

	;=====================
	; critical inner loop
	;   every cycle here is 40x192 cycles
	;=====================

	clc
	tya
	adc	FRAME
	tax
	lda	sinetable,X

	adc	sinetable,Y					; 4+
row_sum_smc:
	adc	#$dd			; row base value	; 2

	lsr				; double colors		; 2
					; also puts bit in carry
					; which helps proper color gen
	and	#$7						; 2
	tax							; 2
	lda	colorlookup,X		; lookup in table	; 5

ror_nop_smc:
	ror				; $6A/$EA		; 2
	sta	(GBASL),Y					; 6

	lda	ror_nop_smc		; toggle ror/nop	; 4
	eor	#$80						; 2
	sta	ror_nop_smc					; 4

	dey							; 2
	bpl	create_xloop					; 2/3

	dec	HGR_Y
	lda	HGR_Y
	cmp	#$ff		; blah want to draw line 0
	bne	create_yloop

flip_pages:

	; Y should be $FF here

	lda	HGR_PAGE	; will be $20/$40
	cmp	#$20
	bne	done_page
	dey
done_page:
	ldx	PAGE1-$FE,Y	; set display page to PAGE1 or PAGE2

	eor	#$60		; flip draw page between $2000/$4000
	sta	HGR_PAGE

	bne	draw_oval	; bra


colorlookup:
.byte $22,$aa,$ba,$ff,$ba,$aa,$22	; use 00 from sinetable
;.byte $00

;.byte $11,$55,$5d,$7f,$5d,$55,$11	; use 00 from sinetable
;.byte $00


;sinetable_base = $F5BA

sinetable_base:
; this is actually (32*sin(x))
.byte $00,$03,$06,$09,$0C,$0F,$11,$14
.byte $16,$18,$1A,$1C,$1D,$1E,$1F,$1F
.byte $20

	; for bot
	; 3F5 - 7d = 378
;	jmp	oval

sinetable=$6000


