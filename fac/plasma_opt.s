; code to use the FAC (floating point accumulator)
; to generate plasmagoria sine tables

; 232 bytes = initial implementation
; 218 bytes = increment high byte of destination instead of loading
; 208 bytes = modify 1->4 on the fly
; 205 bytes = make page increment common code
; 198 bytes = convert thirty-two to twenty-four on fly
; 188 bytes = convert forty-seven to thirty-eight with one byte
; 173 bytes = assume constants on same page
; 171 bytes = optimize save/load of loop index
; 169 bytes = optimize multiply by 8
; 166 bytes = separate common sin code

qint	=	$EBF2		; convert FAC to 32-bit int?
fadd	=	$E7BE		; FAC = (Y:A)+FAC
movmf	=	$EB2B		; move fac to mem: round FAC and store at Y:X
fmult	=	$E97F		; FAC = (Y:A) * FAC
float	=	$EB93		; signed value in A to FAC
sin	=	$EFF1

ARG = $A5	; A5-AA
FAC = $9D	; 9D-A2

; code uses: 5E/5F "index" in load arg from Y:A
;	uses ARG (A5-AA) for argument
;	uses FAC (9D-A2)


OURX	=	$FF

sin1	=	$2000
sin2	=	$2100
sin3	=	$2200
save	=	$2300

HGR	=	$F3E2
FULLGR	=	$C052

add_debut:
	jsr	HGR
	bit	FULLGR

	;====================================================
	;	sin1[i]=round(47.0+
	;		32.0*sin(i*(PI*2.0/256.0))+
	;		16.0*sin(2.0*i*(PI*2.0/256.0)));

	;	sin1[i]=round(47.0+
	;		16*(2.0*sin(i*(PI*2.0/256.0))+
	;		    sin(2.0*i*(PI*2.0/256.0)));


	; already set up for this one

	jsr	make_sin_table

	;===================================================
	;	sin2[i]=round(47.0+
	;		32.0*sin(4.0*i*(PI*2.0/256.0))+
	;		16.0*sin(3.0*i*(PI*2.0/256.0)));

	; 47 is same, 32 is same, 16 is same

	; convert one to four
	lda	#$7d		; only one byte different
	sta	one_input

	; load 3 instead of 2 (assume on same page)
	lda	#<three_input
	sta	sin_table_input3_smc+1

	jsr	make_sin_table

	;======================================================
	;	sin3[i]=round(38.0+
        ;		24.0*sin(3.0*i*(PI*2.0/256.0))+
        ;		16.0*sin(8.0*i*(PI*2.0/256.0)));

	; convert 47 to 38
	lda	#$18
	sta	forty_seven+1

	; convert 32 to 24
	dec	thirty_two
	lda	#$40
	sta	thirty_two+1

	; ideally, convert 4->3
	; load 3 input (assume on same page)
	lda	#<three_input
	sta	sin_table_input1_smc+1

	; convert four to eight
	inc	one_input		; increment power of two
	; load 8 input (assume on same page)
	lda	#<one_input
	sta	sin_table_input3_smc+1

	jsr	make_sin_table

end:
	jmp	end


	;===============================
	;===============================
	;===============================
	;===============================
	;===============================

make_sin_table:

	ldx	#0
sin_loop:
	stx	OURX
	txa

	jsr	float			; FAC = float(OURX)

sin_table_input1_smc:
	lda	#<one_input

	jsr	sin_common

	; thirtytwo or twentyfour
	lda	#<thirty_two
	jsr	fmult			; FAC=constant*FAC


	ldx	#<save
	ldy	#>save
	jsr	movmf			; save FAC to mem

	lda	OURX
	jsr	float			; FAC = float(OURX)	(again)

sin_table_input3_smc:
	lda	#<two_input

	jsr	sin_common

	; always 16
	lda	#<sixteen
	jsr	fmult			; FAC=constant*FAC

	; add first sine
	lda	#<save
	ldy	#>save
	jsr	fadd			; FAC=FAC+(previous result)

	; add constant 47 or 38
	lda	#<forty_seven
	ldy	#>forty_seven
	jsr	fadd			; FAC=FAC+constant

	jsr	qint			; convert to integer

	lda	FAC+4			; get bottom byte

	ldx	OURX

sin_table_dest_smc:
	sta	sin1,X			; save to memory

	inx				; move to next

	bne	sin_loop		; loop until done

	inc	sin_table_dest_smc+2	; point to next location

	rts


	;==============================
	; sin_common
	;==============================
	; A = low byte for input multiplier
sin_common:

	ldy	#>one_input
	jsr	fmult			; FAC=FAC*(constant from RAM)

	jsr	sin			; FAC=sin(FAC)

	; 32 or 24
	ldy	#>thirty_two

	rts


sixteen:
	.byte	$85,$00,$00,$00,$00

;twenty_four:
;	.byte	$85,$40,$00,$00,$00

thirty_two:
	.byte	$86,$00,$00,$00,$00

;thirty_eight:
;	.byte	$86,$18,$00,$00,$00
	; 2^5 = 32, 1.0011 0000 = 1/8+1/16

forty_seven:
	.byte	$86,$3C,$00,$00,$00
	; 32 * 1.0111 10000 = 1/4+1/8+1/16+1/32

one_input:
	; 1*2*pi/256 = .0736310778
	.byte $7b,$49,$0F,$da,$a2

two_input:
	; 2*2*pi/256 = .0736310778
	.byte $7c,$49,$0F,$da,$a2

three_input:
	; 3*2*pi/256 = .0736310778
	.byte $7d,$16,$cb,$e3,$f9

;four_input:
;	; 4*2*pi/256 = .0736310778
;	.byte $7d,$49,$0F,$da,$a2

;eight_input:
;	; 8*2*pi/256 = .196349541
;	.byte $7E,$49,$0F,$da,$a2

