; code to use the FAC (floating point accumulator)

chkcom	=	$DEBE		; check for comma
ptrget	=	$DFE3
frmnum	=	$DD67		; evaluate expression, make sure is number
FACEXP	=	$9D
movmf	=	$EB2B		; move fac to mem: round FAC and store at Y:X
movfm	=	$EAF9		; move mem to fac: unpack (Y:A) to FAC
conupk	=	$E9E3
fadd	=	$E7BE		; FAC = (Y:A)+FAC
faddt	=	$E7C1		; FAC = ARG + FAC
fadd_half =	$E7A0		; add 0.5 to FAC
fsub	=	$E7A7		; FAC = (Y:A)-FAC
fsubt	=	$E7AA		; FAC = ARG - FAC
fzero	=	$E84E		; FAC = 0 (sets fac.sign and fac.exp)
fcomplement =	$E89E		; twos complement of FAC
fmult	=	$E97F		; FAC = (Y:A) * FAC
fmultt	=	$E982		; FAC = ARG*FAC (!!! Z must be properly set)
load_arg=	$E9E3		; unpack (Y:A) into ARG
mul10	=	$EA39		; FAC=FAC*10
div10	=	$EA55		; FAC=FAC/10
div	=	$EA5E		; FAC=ARG/(Y:A)
fdiv	=	$EA66		; FAC=(Y:A)/FAC
fdivt	=	$EA69		; FAC=ARG/FAC (!!! Z must be properly set)
; various round and store fac
fac2arg	=	$EB63		; ARG = FAC
sign	=	$EB82		; SGN(FAC) 1/0/-1
float	=	$EB93		; signed value in A to FAC
fcomp	=	$EBB2		; compare
qint	=	$EBF2		; convert FAC to 32-bit int?
int	=	$EC23		; INT(FAC) (clear fractional part)
addafac	=	$ECD5		; add A to FAC (signed?)
printfac=	$ED2E
sqr	=	$EE8D		; FAC=sqrt(FAC) [actually does FAC^0.5
fpwrt	=	$EE97		; FAC=ARG^FAC
negop	=	$EED0		; FAC=-FAC
exp	=	$EF09		; FAC = e^FAC
; polynomial?
rnd	=	$EFAE		; RAC = RND() random number
cos	=	$EFEA
sin	=	$EFF1
tan	=	$F03A
atn	=	$F09E

; constants
const_one	=	$E926	; one
; poly coefficients?
; sqrt(.5)
; sqrt(2)
; 0.5
; -0.5
; log(2)
const_10=	$EA50	; 10
; billion
; 999,999,999
; 99,999,999.9
; log(e) to base(2)
; polynomials for log
; one again
; table of 32-bit powers of 10 +/- for some reason
; pi/2
pi_doub	=	$F06E	; 2*pi
; 0.25 (quarter)


ARG = $A5
FAC = $9D

; code uses: 5E/5F "index" in load arg from Y:A
;	uses ARG (A5-AA) for argument
;	uses FAC (9D-A2)


; in memory, 5 bytes "packed"
;	exponent, mantissa MSB, mantissa, mantissa, mantissa l.s.b
;	top bit of exponent is sign (0 negative)
;	so $84/$20/$00/$00/$00
;	$84 = positive $4, subtract 1, so 2^3 = 8
;	mantissa = 1.XX XX XX XX, in this case 1. (Sign)010 0000 = 1.25
;	1.25*8 = 10

; FAC also has sign byte at $A2


; to make constants
;	NEW
;	A=10
;	804L, should be 41 00 - 84 20 00 00 00
;                        A    - 5-bytes for 10

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

	;	sin1[i]=round(47.0+
	;		32.0*sin(i*(PI*2.0/256.0))+
	;		16.0*sin(2.0*i*(PI*2.0/256.0)));

	; already set up for this one

	jsr	make_sin_table

	;	sin2[i]=round(47.0+
	;		32.0*sin(4.0*i*(PI*2.0/256.0))+
	;		16.0*sin(3.0*i*(PI*2.0/256.0)));

	lda	#<sin2
	sta	sin_table_dest_smc+1
	lda	#>sin2
	sta	sin_table_dest_smc+2

	; 47 is same
	; 32 is same
	; 16 is same

	lda	#<four_input
	sta	sin_table_input1_smc+1
	lda	#>four_input
	sta	sin_table_input2_smc+1

	lda	#<three_input
	sta	sin_table_input3_smc+1
	lda	#>three_input
	sta	sin_table_input4_smc+1

	jsr	make_sin_table

	;	sin3[i]=round(38.0+
        ;		24.0*sin(3.0*i*(PI*2.0/256.0))+
        ;		16.0*sin(8.0*i*(PI*2.0/256.0)));

	lda	#<sin3
	sta	sin_table_dest_smc+1
	lda	#>sin3
	sta	sin_table_dest_smc+2

	lda	#<thirty_eight
	sta	sin_table_add_smc1+1
	lda	#>thirty_eight
	sta	sin_table_add_smc2+1

	lda	#<twenty_four
	sta	sin_table_scale1_smc+1
	lda	#>twenty_four
	sta	sin_table_scale2_smc+1

	lda	#<three_input
	sta	sin_table_input1_smc+1
	lda	#>three_input
	sta	sin_table_input2_smc+1

	lda	#<eight_input
	sta	sin_table_input3_smc+1
	lda	#>eight_input
	sta	sin_table_input4_smc+1



	jsr	make_sin_table

end:
	jmp	end


	;===============================
	;===============================
	;===============================
	;===============================
	;===============================

make_sin_table:

	lda	#0
	sta	OURX

sin_loop:

	lda	OURX
	jsr	float		; FAC = X

sin_table_input1_smc:
	lda	#<one_input
sin_table_input2_smc:
	ldy	#>one_input
	jsr	fmult
	jsr	sin
sin_table_scale1_smc:
	lda	#<thirty_two
sin_table_scale2_smc:
	ldy	#>thirty_two
	jsr	fmult

	ldx	#<save
	ldy	#>save
	jsr	movmf			; save FAC to mem

	lda	OURX
	jsr	float		; FAC = X
sin_table_input3_smc:
	lda	#<two_input
sin_table_input4_smc:
	ldy	#>two_input
	jsr	fmult
	jsr	sin

	lda	#<sixteen
	ldy	#>sixteen
	jsr	fmult

	; add first sine
	lda	#<save
	ldy	#>save
	jsr	fadd

	; add 38
sin_table_add_smc1:
	lda	#<forty_seven
sin_table_add_smc2:
	ldy	#>forty_seven
	jsr	fadd

	jsr	qint

	lda	FAC+4

	ldx	OURX

sin_table_dest_smc:
	sta	sin1,X

	inc	OURX
	bne	sin_loop

	rts


sixteen:
	.byte	$85,$00,$00,$00,$00

twenty_four:
	.byte	$85,$40,$00,$00,$00

thirty_two:
	.byte	$86,$00,$00,$00,$00

thirty_eight:
	.byte	$86,$18,$00,$00,$00
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

four_input:
	; 4*2*pi/256 = .0736310778
	.byte $7d,$49,$0F,$da,$a2

eight_input:
	; 8*2*pi/256 = .196349541
	.byte $7E,$49,$0F,$da,$a2

