	;==========================
	; check for earthquake

earthquake_handler:
	lda     FRAMEH
	and	#3
	bne	earth_mover
	lda	FRAMEL
	cmp	#$ff
	bne	earth_mover
earthquake_init:
	lda	#200
	sta	EQUAKE_PROGRESS

	lda	#0
	sta	BOULDER_Y
	jsr	random16
	lda	SEEDL
	and	#$1f
	clc
	adc	#4
	sta	BOULDER_X


earth_mover:
	lda	EQUAKE_PROGRESS
	beq	earth_still

	and	#$8
	bne	earth_calm

	lda	#2
	bne	earth_decrement

earth_calm:
	lda	#0
earth_decrement:
	sta	EARTH_OFFSET
	dec	EQUAKE_PROGRESS
	jmp	earth_done


earth_still:
	lda	#0
	sta	EARTH_OFFSET

earth_done:

	;================================
	; copy background to current page

	lda	EARTH_OFFSET
	bne	shake_shake
no_shake:
	jsr	gr_copy_to_current
	jmp	done_shake
shake_shake:
	jsr	gr_copy_to_current_BC00
done_shake:

	rts


	;======================
	; draw falling boulders
draw_boulder:
	lda	BOULDER_Y
	cmp	#38
	bpl	no_boulder

	lda	#<boulder
	sta	INL
	lda	#>boulder
	sta	INH

	lda	BOULDER_X
	sta	XPOS
	lda	BOULDER_Y
	sta	YPOS
        jsr	put_sprite

	lda	FRAMEL
	and	#$3
	bne	no_boulder
	inc	BOULDER_Y
	inc	BOULDER_Y

no_boulder:

	rts


	;=========================================================
	; gr_copy_to_current, 40x48 version
	;=========================================================
	; copy $BC00 to DRAW_PAGE

gr_copy_to_current_BC00:

	lda	DRAW_PAGE					; 3
	clc							; 2
	adc	#$4						; 2
	sta	gr_copy_line_BC+5				; 4
	sta	gr_copy_line_BC+11				; 4
	adc	#$1						; 2
	sta	gr_copy_line_BC+17				; 4
	sta	gr_copy_line_BC+23				; 4
	adc	#$1						; 2
	sta	gr_copy_line_BC+29				; 4
	sta	gr_copy_line_BC+35				; 4
	adc	#$1						; 2
	sta	gr_copy_line_BC+41				; 4
	sta	gr_copy_line_BC+47				; 4
							;===========
							;	45

	ldy	#119		; for early ones, copy 120 bytes	; 2

gr_copy_line_BC:
	lda	$BC00,Y		; load a byte (self modified)		; 4
	sta	$400,Y		; store a byte (self modified)		; 5

	lda	$BC80,Y		; load a byte (self modified)		; 4
	sta	$480,Y		; store a byte (self modified)		; 5

	lda	$BD00,Y		; load a byte (self modified)		; 4
	sta	$500,Y		; store a byte (self modified)		; 5

	lda	$BD80,Y		; load a byte (self modified)		; 4
	sta	$580,Y		; store a byte (self modified)		; 5

	lda	$BE00,Y		; load a byte (self modified)		; 4
	sta	$600,Y		; store a byte (self modified)		; 5

	lda	$BE80,Y		; load a byte (self modified)		; 4
	sta	$680,Y		; store a byte (self modified)		; 5

	lda	$BF00,Y		; load a byte (self modified)		; 4
	sta	$700,Y		; store a byte (self modified)		; 5

	lda	$BF80,Y		; load a byte (self modified)		; 4
	sta	$780,Y		; store a byte (self modified)		; 5

	dey			; decrement pointer			; 2
	bpl	gr_copy_line_BC	;					; 2nt/3

	rts								; 6

