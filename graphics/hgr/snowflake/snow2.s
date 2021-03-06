; a snowflake

; 216 bytes
; 209 -- remove extraneous call to HGR
; 207 -- use bvc to check page
; 203 -- hardcode x coords
; 199 -- line in ZP
; 192 -- ybase in ZP
; 171 -- remove self-modifying code
; 167 -- remove YBASE ininitialization
; 161 -- only fall to 128 then recycle
; 156 -- use lookup table
; 145 -- drop page flipping
; 142 -- only need one row of zeros

GBASL	= $26
GBASH	= $27
HGRPAGE	= $E6

YLO	= $FC
XIDX	= $FD
YBASE	= $FE
LINE	= $FF

PAGE0	= $C054
PAGE1	= $C055

HGR	= $F3E2
HGR2	= $F3D8
HCLR	= $F3F2
HPOSN	= $F411


snow:
;	jsr	HGR
	jsr	HGR2					; 3

move_snow:

	; 17 bytes to set page

;	bit	HGRPAGE		; V set if $40		; 3
;	bvc	show_page1				; 2

show_page2:
;	bit	PAGE1					; 3
;	lsr	HGRPAGE					; 2
;	bne	doit					; 2

show_page1:
;	bit	PAGE0					; 3
;	asl	HGRPAGE					; 2

doit:
;	jsr	HCLR

	lda	#24
	sta	LINE

	lda	YBASE	; be sure gets init at start
	and	#$7f	; wrap at 128
	sta	YBASE
	inc	YBASE
	sta	YLO


snow_loop:
	ldy	#$0		; xhi
	ldx	#130		; xlo -- (mult of 16)+2 for code to work
	lda	YLO		; ylo
	jsr	HPOSN

	; y is xlo div 7

	ldx	LINE
	lda	offsets,X
	tax
line_loop:

	lda	flake,X
	sta	(GBASL),Y

	inx
	iny
	cpy	#$18
;	tya
;	and	#$8
	bne	line_loop

	inc	YLO
inc_smc:
	dec	LINE
	bmi	move_snow
	bpl	snow_loop


; 6*12 = 72 bytes
;flake:
;	.byte	$00,$00,$40,$01,$00,$00
;	.byte	$00,$00,$0C,$18,$00,$00
;	.byte	$00,$00,$70,$07,$00,$00
;	.byte	$00,$00,$43,$61,$00,$00
;	.byte	$00,$00,$4C,$19,$00,$00
;	.byte	$33,$00,$70,$07,$00,$66
;	.byte	$30,$06,$40,$01,$30,$06
;	.byte	$3f,$06,$40,$01,$30,$7e
;	.byte	$40,$07,$30,$06,$70,$01
;	.byte	$7c,$07,$30,$06,$70,$1f
;	.byte	$00,$18,$0F,$78,$0C,$00
;	.byte	$00,$60,$40,$01,$03,$00

flake:
	.byte	$00,$00,$00,$00		; 0
	.byte	$00,$00,$40,$01,$00,$00	; 4,8
	.byte	$0C,$18,$00,$00		;
	.byte	$70,$07,$00,$00		;
	.byte	$43,$61,$00,$00		;
	.byte	$4C,$19,$00,$00		;
	.byte	$33,$00,$70,$07,$00,$66	; 26
	.byte	$30,$06,$40,$01,$30,$06 ; 32
	.byte	$3f,$06,$40,$01,$30,$7e ; 38
	.byte	$40,$07,$30,$06,$70,$01 ; 44
	.byte	$7c,$07,$30,$06,$70,$1f ; 50
	.byte	$00,$18,$0F,$78,$0C,$00 ; 56
	.byte	$60,$40,$01,$03		; 61

offsets:
	.byte 0,4,8,12,16,20,26,32,38,44,50,56,61
	.byte 56,50,44,38,32,26,20,16,12,8,4,0

;floke:
;	.byte	$0,$0,$1,$2,$0,$0
;	.byte	$0,$0,$3,$4,$0,$0
;	.byte	$0,$0,$5,$6,$0,$0
;	.byte	$0,$0,$7,$8,$0,$0
;	.byte	$0,$0,$9,$A,$0,$0
;	.byte	$B,$0,$5,$6,$0,$C
;	.byte	$D,$E,$1,$2,$d,$E
;	.byte	$F,$E,$1,$2,$d,$7e
;	.byte	$1,$6,$d,$e,$5,$01
;	.byte	$7c,$6,$d,$e,$5,$1f
;	.byte	$0,$4,$0F,$78,$3,$0
;	.byte	$0,$60,$1,$2,$03,$0


;tokens:
;	.byte	$00,$40,$01,$0C
;	.byte	$18,$70,$07,$43
;	.byte	$61,$4C,$19,$33
;	.byte	$66,$30,$06,$3F

	; 00 000000 -> 0 0 00 00 00 - 0 00 00 00 0
	; 08 000100 -> 0 1 00 00 00 - 0 00 00 00 1

;	lda	flake2,X
;	asl
;	php
;	ror	out
;	plp
;	ror	out

;flake2:
;	.byte	$00,$08,$00
;	.byte	$00,$22,$00
;	.byte	$00,$1C,$00
;	.byte	$00,$49,$00
;	.byte	$00,$2A,$00
;	.byte	$60,$1C,$05
;	.byte	$14,$08,$14
;	.byte	$74,$08,$17
;	.byte	$0C,$14,$18
;	.byte	$3C,$14,$1E
;	.byte	$02,$63,$20
;	.byte	$01,$08,$40


