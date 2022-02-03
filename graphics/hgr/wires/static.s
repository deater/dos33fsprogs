	; shimmery blue pattern

INDEXL          = $F6
INDEXH          = $F7

HGR2            = $F3D8         ; set hires page2 and clear $4000-$5fff
WAIT            = $FCA8         ; delay 1/2(26+27A+5A^2) us


even_lookup=$f000
odd_lookup=$f100


staggered:
	jsr	HGR2				; after, A=0, Y=0

	tax					; init X to 0
	stx	INDEXL				; set INDEXL to 0

	; pulse loop horizontal
outer_loop:
	lda	#$40				; reset INDEXH to begin page2
	sta	INDEXH

inner_loop:
	lda	even_lookup,X			; get even color
	sta	(INDEXL),Y			; store it to memory
	iny

	lda	odd_lookup,X			; get odd color
	sta	(INDEXL),Y			; store it to memory
	iny

	bne	inner_loop			; repeat for 256

	inc	INDEXH				; point to next page

	inx					; point to next lookup

;	txa					; wrap to 0..7
;	and	#$7
;	tax

	lda	#$60				; see if done
	cmp	INDEXH
	bne	inner_loop

;	lda	#100				; A is $60 here
	jsr	WAIT				; pause a bit

	; A is 0 here

	inx					; offset next FRAME

	jmp	outer_loop


;even_lookup:
;.byte	$D7,$DD,$F5,$D5, $D5,$D5,$D5,$D5
;odd_lookup:
;.byte	$AA,$AA,$AA,$AB, $AB,$AE,$BA,$EA
