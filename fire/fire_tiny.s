; Lo-res fire animation, size-optimized

; by deater (Vince Weaver) <vince@deater.net>

; based on code described here http://fabiensanglard.net/doom_fire_psx/

; 611 bytes at first
; 601 bytes -- strip out some unused code6
; 592 bytes -- don't init screen
; 443 bytes -- remove more dead code
; 206 bytes -- no need to clear screen
; 193 bytes -- un-cycle exact the random16 code

; Zero Page
SEEDL		= $4E
SEEDH		= $4F
TEMP		= $FA
TEMPY		= $FB

XOR_MAGIC = $7657	; "vW"

; Soft Switches
SET_GR	= $C050 ; Enable graphics
FULLGR	= $C052	; Full screen, no text
LORES	= $C056	; Enable LORES graphics


fire_demo:

	; GR part
	bit	LORES							; 4
	bit	SET_GR							; 4
	bit	FULLGR							; 4


	; Setup white line on bottom

	lda	#$ff
	ldx	#39
white_loop:
	sta	$7d0,X			; hline 24 (46+47)
	dex
	bpl	white_loop


fire_loop:

	ldy	#44			; 22 * 2

yloop:

	lda	gr_offsets,Y
	sta	smc2+1
	lda	gr_offsets+1,Y
	sta	smc2+2
	lda	gr_offsets+2,Y
	sta	smc1+1
	lda	gr_offsets+3,Y
	sta	smc1+2

	sty	TEMPY

	ldx	#39
xloop:
smc1:
	lda	$7d0,X
	sta	TEMP
	and	#$f		; mask off
	tay

	jsr	random16
	lda	SEEDL
	and	#$1
	beq	no_change

decrement:
	lda	color_progression,Y
	jmp	done_change
no_change:
	lda	TEMP
done_change:

smc2:
	sta	$750,X
	dex
	bpl	xloop

	ldy	TEMPY

	dey
	dey
	bpl	yloop


	jmp	fire_loop


color_progression:
	.byte	0	; 0->0
	.byte	$88	; 1->8
	.byte	0	; 2->0
	.byte	0	; 3->0
	.byte	0	; 4->0
	.byte	0	; 5->0
	.byte	0	; 6->0
	.byte	0	; 7->0
	.byte	$55	; 8->5
	.byte	$11	; 9->1
	.byte	0	; 10->0
	.byte	0	; 11->0
	.byte	0	; 12->0
	.byte	$99	; 13->9
	.byte	0	; 14->0
	.byte	$dd	; 15->13


; 16-bit 6502 Random Number Generator
; Linear feedback shift register PRNG by White Flame
; http://codebase64.org/doku.php?id=base:small_fast_16-bit_prng

	;=============================
	; random16
	;=============================
random16:

	lda	SEEDL							; 3
	beq	low_zero	; $0000 and $8000 are special values	; 3
								;==========
								;	  6
lownz:
									; -1
	asl	SEEDL		; Do a normal shift			; 5
	lda	SEEDH							; 3
	rol								; 2
	bcs	do_eor							; 3
	bcc	no_eor							; 3
do_eor:
				; high byte is in A
	eor	#>XOR_MAGIC						; 2
	sta	SEEDH							; 3
	lda	SEEDL							; 3
	eor	#<XOR_MAGIC						; 2
	sta	SEEDL							; 3
eor_rts:
	rts								; 6

no_eor:
	sta	SEEDH							; 3
	jmp	eor_rts							; 3+6
								;===========
								;	 20
low_zero:
	lda	SEEDH							; 3
	beq	do_eor			; High byte is also zero	; 3
					; so apply the EOR

ceo:									; -1
				; wasn't zero, check for $8000
	asl								; 2
	beq	no_eor			; if $00 is left after the shift; 3
					; then it was $80

		; else, do the EOR based on the carry
cep:
	bcc	no_eor
	bcs	do_eor






gr_offsets:
	.word	$400,$480,$500,$580,$600,$680,$700,$780
	.word	$428,$4a8,$528,$5a8,$628,$6a8,$728,$7a8
	.word	$450,$4d0,$550,$5d0,$650,$6d0,$750,$7d0


