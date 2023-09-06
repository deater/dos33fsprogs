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
; one
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
; one
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

sin3	=	$8000

add_debut:

	lda	#0
	sta	OURX

sin3_loop:
	; 38+24*sin(3x)+16*sin(8x)
	;     ours[i]=round(38.0+
        ;                       24.0*sin(3.0*i*(PI*2.0/256.0))+
        ;                       16.0*sin(8.0*i*(PI*2.0/256.0)));


	lda	OURX
	jsr	float		; FAC = X

	lda	#<three_input
	ldy	#>three_input
	jsr	fmult
	jsr	sin
	lda	#<twenty_four
	ldy	#>twenty_four
	jsr	fmult

	ldx	#<$8100
	ldy	#>$8100
	jsr	movmf			; save FAC to mem

	lda	OURX
	jsr	float		; FAC = X
	lda	#<eight_input
	ldy	#>eight_input
	jsr	fmult
	jsr	sin
	lda	#<sixteen
	ldy	#>sixteen
	jsr	fmult

	; add first sine
	lda	#<$8100
	ldy	#>$8100
	jsr	fadd

	; add 38
	lda	#<thirty_eight
	ldy	#>thirty_eight
	jsr	fadd


	jsr	qint

	lda	FAC+4

	ldx	OURX
	sta	sin3,X

	inc	OURX
	bne	sin3_loop

end:
	jmp	end

sixteen:
	.byte	$85,$00,$00,$00,$00

twenty_four:
	.byte	$85,$40,$00,$00,$00

thirty_eight:
	.byte $86,$18,$00,$00,$00
	; 2^5 = 32, 1.0011 0000 = 1/8+1/16

three_input:
	; 3*2*pi/256 = .0736310778
	.byte $7d,$16,$cb,$e3,$f9

eight_input:
	; 8*2*pi/256 = .196349541
	.byte $7E,$49,$0F,$DA,$9E

