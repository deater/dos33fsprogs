
	; Autogenerates code for Type2 (escape)

	; First 9 (?) lines = text mode
	;

	; 22 + 192*(2+(47*18)+38)+15 = 170,149
	; play every 15787 cycles = 10.7 times
	; every 18 times through loop

UPDATE2_START = $9800

;DEFAULT_COLOR	= $0

create_update_type2:
	ldx	#192						; 2
	lda	#<UPDATE2_START					; 2
	sta	OUTL						; 3
	lda	#>UPDATE2_START					; 2
	sta	OUTH						; 3
	lda	#<another_scanline				; 2
	sta	INL						; 3
	lda	#>another_scanline				; 2
	sta	INH						; 3

	lda	#18
	sta	FORCE_MUSIC

								;=====
								; 22
create_update2_outer_loop:
	ldy	#0						; 2
create_update2_inner_loop:
	lda	(INL),Y						; 5
	sta	(OUTL),Y					; 6
	iny							; 2
	cpy	#47						; 2
	bne	create_update2_inner_loop			; 3
							;===========
							;	18

								;-1
	; toggle PAGE0/PAGE1
	txa							; 2
	and	#$1	; ror?					; 2
	clc							; 2
	adc	#$54						; 2
	ldy	#1						; 2
	sta	(OUTL),Y					; 6

	clc							; 2
	lda	#47						; 2
	adc	OUTL						; 3
	sta	OUTL						; 3
	lda	OUTH						; 3
	adc	#0						; 2
	sta	OUTH						; 3


	dec     FORCE_MUSIC                                     ; 5
        bne     no_force_music2                                  ; 3
        lda     #18
        sta     FORCE_MUSIC

        txa
        pha

        jsr     play_frame_compressed

        pla
        tax
no_force_music2:

	dex							; 2
	bne	create_update2_outer_loop			; 3
							;===========
							;	38

								; -1

	ldy	#0						; 2
	lda	#$60				; rts		; 2
	sta	(OUTL),Y					; 6

	rts							; 6
							;=============
							;	15


ESCAPE_START = 30


	;===========================
	;
	; 42+18+42+17+128*(7+(7*73)+5)+54+5 = 67,122
	;	/ 15,787 = 4.25
	;	128/4.25=30

setup_update_type2:

	; add call to TEXT

	lda	#$2c		; bit C051	; 4			; 2
	sta	UPDATE2_START+3			; $9003			; 4
	lda	#$51							; 2
	sta	UPDATE2_START+4			; $9004			; 4
	lda	#$c0							; 2
	sta	UPDATE2_START+5			; $9005			; 4

	lda	#$A5		; lda ZERO	; 3			; 2
	sta	UPDATE2_START+6			; $9006			; 4
	lda	#$FA							; 2
	sta	UPDATE2_START+7			; $9007			; 4

	lda	#$A2		; ldx, 1	; 3			; 2
	sta	UPDATE2_START+8			; $9008			; 4
	lda	#$01							; 2
	sta	UPDATE2_START+9			; $9009			; 4
								;===========
								;	42
	; set first 9 lines to PAGE0

	lda	#$54							; 2
	sta	UPDATE2_START+$30		; $9030			; 4
	sta	UPDATE2_START+$8E		; $908E			; 4
	sta	UPDATE2_START+$EC		; $90EC			; 4
	sta	UPDATE2_START+$14A		; $914A			; 4
								;===========
								;	18


	; add call to GRAPHICS
	; line 9 (91a7)

	lda	#$2c		; bit C051	; 4			; 2
	sta	UPDATE2_START+$1aa		; $91aa			; 4
	lda	#$50							; 2
	sta	UPDATE2_START+$1ab		; $91ab			; 4
	lda	#$c0							; 2
	sta	UPDATE2_START+$1ac		; $91ac			; 4

	lda	#$A5		; lda ZERO	; 3			; 2
	sta	UPDATE2_START+$1ad		; $91ad			; 4
	lda	#$FA							; 2
	sta	UPDATE2_START+$1ae		; $91ae			; 4

	lda	#$A2		; ldx, 1	; 3			; 2
	sta	UPDATE2_START+$1af		; $91af			; 4
	lda	#$01							; 2
	sta	UPDATE2_START+$1b0		; $91b0			; 4
								;===========
								;	42
	;====================
	;====================

	lda	#4		; which page				; 2
	sta	RASTER_PAGE						; 3

	ldx	#ESCAPE_START						; 2
	lda	#<(UPDATE_START+(ESCAPE_START*47))			; 2
	sta	OUTL							; 3
	lda	#>(UPDATE_START+(ESCAPE_START*47))			; 2
	sta	OUTH							; 3

	lda	#30
	sta	FORCE_MUSIC

								;===========
								;	17
setup_escape_outer_loop:
	ldy	#8							; 2
	lda	#0							; 2
	sta	RASTER_X						; 3
								;===========
								;         7
setup_escape_inner_loop:
	txa								; 2
	pha								; 3
	inx								; 2
	txa				; start one earlier		; 2
	lsr								; 2
	lsr								; 2
	and	#$fe							; 2
	tax								; 2
	clc								; 2
	lda	gr_offsets,X						; 4+
	adc	RASTER_X						; 3
	inc	RASTER_X						; 5
	sta	(OUTL),Y						; 6
	iny								; 2
	clc								; 2
	lda	gr_offsets+1,X						; 4+
	adc	RASTER_PAGE						; 3
	sta	(OUTL),Y						; 6
	iny								; 2

	iny								; 2
	iny								; 2
	iny								; 2

	pla								; 4
	tax								; 2

	cpy	#43							; 2
	bne	no_fixup						; 3
								;===========
								;	73

									; -1

	iny			; special case last one			; 2
	iny								; 2

no_fixup:
	cpy	#50							; 2
	bne	setup_escape_inner_loop					; 3
								;===========
								;         5

									;-1
	; fix the one at the end
	dey								; 2
	dey								; 2
	dey								; 2
	dey								; 2
	dey								; 2
	lda	(OUTL),Y						; 5
	and	#$f8							; 2
	sta	(OUTL),Y						; 5

	clc								; 2
	lda	#47							; 2
	adc	OUTL							; 3
	sta	OUTL							; 3
	lda	OUTH							; 3
	adc	#0							; 2
	sta	OUTH							; 3

	dec     FORCE_MUSIC                                     ; 5
        bne     no_force_music3                                  ; 3
        lda     #30
        sta     FORCE_MUSIC

        txa
        pha

        jsr     play_frame_compressed

        pla
        tax
no_force_music3:


	lda	RASTER_PAGE						; 3
	eor	#$04							; 2
	sta	RASTER_PAGE						; 3

	inx								; 2
	cpx	#(128+ESCAPE_START)					; 2
	bne	setup_escape_outer_loop					; 3
								;===========
								;        54

									; -1
	rts								; 6


another_scanline:
.byte	$2C,$54,$C0		; bit	PAGE0   ; 4
.byte	$A2,$01		;smc018:  ldx	#$01    ; 2
.byte	$A9,$00			; lda	#$00    ; 2
.byte	$9D,$00,$02		; sta	$c00,X  ; 5
.byte	$A9,$00			; lda	#$00    ; 2
.byte	$9D,$00,$02		; sta	$c00,X  ; 5
.byte	$A9,$00			; lda	#$00    ; 2
.byte	$9D,$00,$02		; sta	$c00,X  ; 5
.byte	$A9,$00			; lda	#$00    ; 2
.byte	$9D,$00,$02		; sta	$c00,X  ; 5
.byte	$A9,$00			; lda	#$00    ; 2
.byte	$9D,$00,$02		; sta	$c00,X  ; 5
.byte	$A9,$00			; lda	#$00    ; 2
.byte	$9D,$00,$02		; sta	$c00,X  ; 5
.byte	$A9,$00			; lda	#$00    ; 2
.byte	$9D,$00,$02		; sta	$c00,X  ; 5
.byte	$A2,$00			; ldx	#$00    ; 2
.byte	$A5,$C5			; lda	ZERO    ; 3
.byte	$9D,$00,$02		; sta	$c00,X  ; 5
	;==========				;===
	; 47???					; 65

