; Wrapper to load loveduck high
;
; by deater (Vince Weaver) <vince@deater.net>

; the problem is the boot loader loads things to $800 by default
; that's lo-res page 2 which we want to use later

ld_start:

	.byte  	2               ; number of sectors to load
	lda     $C088,X         ; turn off drive motor

	ldy	#0
loop1:
	lda	binary,Y
	sta	$1000,Y
	lda	binary+256,Y
	sta	$1000+256,Y
	dey
	bne	loop1

	jmp	$1000		; jump to entry pint

binary:
	.incbin		"LOVE_DUCK"

