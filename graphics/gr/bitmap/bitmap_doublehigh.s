; Bitmap test

; by Vince `deater` Weaver <vince@deater.net>

; eye image by (TODO) from lovebyte 16x16 compo

; 291 -- initial code
; 183 -- draw top/bottom nibble
; 182 -- end loop branch not jmp
; 179 -- make YPOS in memory
; 178 -- move end handling around
; 175 -- use SCRN2
; 171 -- alternate carry
; 168 -- realize SETCOL leaves result in A

.include "zp.inc"
.include "hardware.inc"


	;================================
	; Clear screen and setup graphics
	;================================
eye:

	jsr	SETGR		; set lo-res 40x40 mode
				; A=$D0 afterward

	ldx	#$ff		; beginning of data

draw_eye_yloop:

ypos_smc:
	lda	#4		; YPOS

	; take Y-coord/2 in A, put address in GBASL/H ( a trashed, C clear)
	jsr	GBASCALC

	ldy	#12
draw_eye_xloop:

	; draw bottom nibble first

	tya
	ror			; get odd or even in carry
	bcs	plot_it		; only increment X every other
	inx

end:
	bmi	end		; if X hits 128, done

plot_it:
	lda	eye_data,X	; get color
	jsr	SCRN2		; put top or bottom nibble in A based on C
	jsr	SETCOL		; duplicate color in top/bottom
	sta	(GBASL),Y	; plot double high color

	iny
	cpy	#28
	bne	draw_eye_xloop

	inc	ypos_smc+1
	bne	draw_eye_yloop	; branch always

eye_data:
	.byte	$BB,$88,$BB,$0B,$08,$88,$80,$B0
	.byte	$8B,$B8,$0B,$08,$00,$00,$00,$00
	.byte	$88,$0B,$08,$00,$00,$00,$00,$00
	.byte	$B8,$08,$00,$00,$44,$04,$00,$00
	.byte	$8B,$00,$40,$44,$F7,$7F,$04,$00
	.byte	$08,$40,$4C,$00,$75,$FF,$47,$70
	.byte	$00,$C4,$04,$00,$50,$F7,$4F,$70
	.byte	$00,$44,$0C,$00,$00,$F7,$4F,$F0
	.byte	$07,$C4,$04,$00,$00,$75,$47,$F0
	.byte	$0F,$44,$0C,$00,$00,$40,$44,$F0
	.byte	$7F,$40,$4C,$00,$00,$C4,$04,$F7
	.byte	$FF,$40,$C4,$4C,$4C,$4C,$04,$FF
	.byte	$F7,$07,$44,$C4,$C4,$44,$70,$FF
	.byte	$78,$7F,$00,$44,$44,$00,$F7,$7F
	.byte	$8B,$87,$7F,$00,$00,$F7,$7F,$88
	.byte	$BB,$8B,$88,$88,$88,$88,$88,$BB

