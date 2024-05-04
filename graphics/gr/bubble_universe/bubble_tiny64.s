; bubble universe tiny -- Apple II Lores

; cosmic fish?

; what if you zoom into a bubble universe and it's full of
; angry bees

; by Vince `deater` Weaver

; this version based on fast c64 code by serato_fig
;	as posted to the sizecoding discord
;	based on his TIC-80 variant

; originally was working off the BASIC code posted on the pouet forum
; original effect by yuruyrau on twitter

; 578 bytes = original color
; 531 bytes = remove keyboard code
; 527 bytes = inline sine gen
; 523 bytes = optimize init a bit
; 301 bytes = generate color lookup table
; 297 bytes = optimize color lookup table
; 282 bytes = optimize color shift
; 266 bytes = reduce resolution of sine table x2
; 260 bytes = shave off some bytes with unneeded compares
; 255 bytes = reoptimize the sine doubler
; 264 bytes = add sound (urgh)
; 265 bytes = fix colors
; 263 bytes = waste a lot of time optimizing color lookup table
; 259 bytes = undo self modifying code
; 247 bytes = remove extra cosine table
; 245 bytes = minor fixes
; 268 bytes = back to 64 byte lookup
; 264 bytes = optimize sine/cosine init
; 262 bytes = optimize var init
; 259 bytes = use sine_base in place
; 262 bytes = add in movement, reduce sound
; 255 bytes = rediculous code that moved table setup to be overwritten
;		and the linear parts and $59 of sine table generated
; 260 bytes = modify panning to be more interesting
; 258 bytes = make assumptions on value of Y

; soft-switches

SPEAKER		= $C030
FULLGR		= $C052

; ROM routines

PLOT    = $F800                 ;; PLOT AT Y,A
SETGR   = $FB40

; zero page

COLOR		= $30

SINES_BASE	= $C0

I		= $D0
J		= $D1
T		= $D7
U		= $D8
V		= $D9
IS		= $DA
IT		= $DB
PAN		= $DC

INL		= $FC
INH		= $FD

sines	= sines_base-$13	; overlaps some code
sines2	= sines+$100		; duplicate so we can index cosine into it
cosines = sines+$c0

color_map = $1000

bubble_gr:

	;=======================
	; init graphics
	;=======================

	jsr	SETGR

	; can't rely on registers after this as different on IIe
	;	with 80 col card

	bit	FULLGR

	;========================
	;========================
	; initialize lookup tables
	;========================
	;========================

	; these moved to the end (at expense of 4 bytes)
	;	so we can over-write part of sine table on top of it

	jsr	init_code_to_be_destroyed



	; X=0 here

	;=========================
	; reconstruct sine base
	;=========================
	; generate the linear $30..$42 part
	; and also string of $59 on end
	;	removes 26 bytes from table
	; 	at expense of 16+4 bytes of code
	;		(4 from jsr/rts of moving over-writable table code)

;sines:
;	.byte $30,$31,$32,$33,$34,$35,$36,$37,$38,$39,$3A,$3B,$3C,$3D,$3E,$3F
;	.byte $40,$41,$42
;
;sines_base:
;	.byte $42,$43,$44,$45,$46,$47,$48,$48,$49,$4A,$4B,$4C,$4C
;	.byte $4D,$4E,$4E,$4F,$50,$50,$51,$52,$52,$53,$53,$54,$54,$55,$55,$55
;	.byte $56,$56,$57,$57,$57,$58,$58,$58,$58,$58
;fifty_nines:
;	.byte $59,$59,$59,$59,$59,$59
;	.byte $59
]

	ldx	#$42		; want to write $42 downto $30
looper:
	txa
	sta	sines-$30,X	; sines+12 .... sines

	lda	#$59
	sta	fifty_nines-$30,X

	dex
	cpx	#$2F
	bne	looper


	;==========================
	; make sine/cosine tables
	;==========================

	; floor(s*sin((x-96)*PI*2/256.0)+48.5);

	;===================================
	;
	;
	; final_sine[i]=quarter_sine[i];          // 0..64
	; final_sine[128-i]=quarter_sine[i];      // 64..128
	; final_sine[128+i]=0x60-quarter_sine[i]; // 128..192
	; final_sine[256-i]=0x60-quarter_sine[i]; // 192..256

setup_sine_table:

	ldx	#64
	ldy	#64
setup_sine_loop:

	lda	sines,X

;	sta	sines,X
	sta	sines,Y

	lda	#$60
	sec
	sbc	sines,X

	sta	sines+128,X
	sta	sines+128,Y

	iny
	dex
	bpl	setup_sine_loop


	; X is $ff here
	; Y is $81?

	;=======================
	; init variables
	;=======================
	; wipe all of zero page but $FF
	;	we only care about one value, the color at $30

	; in theory we only need to clear/copy $00..$C0
	;	but not sure how to use to our advantage

	; X is $FF
	inx		; X=0
	ldy	#0	; Y=0
init_loop:
;	sta	a:$D0,X		; force 16-bit so doesn't wrap
				; because I guess it's bad to wipe zero page?
				; maybe it isn't?

	sty	$D0,X		; clear zero page

	lda	sines,X		; duplicate sine table for cosine use
	sta	sines2,X

	dex
	bne	init_loop

;	lda	#0
;	stx	U
;	stx	V
;	stx	T
;	stx	INL

	; X = 0 here
	; Y = 0 here

	dex
	stx	COLOR			; $FF (color white)


	;=========================
	;=========================
	; main loop
	;=========================
	;=========================

	; in theory Y=0 from previous loop, and also from init?

next_frame:

	; reset I*T

	lda	T
	sta	IT

	; reset I*S

	; Y should always be 0 at this point...
;	lda	#0
	sty	IS

i_smc:
	lda	#13	; 13
	sta	I

i_loop:

j_smc:
	lda	#$18	; 24
	sta	J
j_loop:

;	bit	SPEAKER		; click speaker

	; where S=41 (approximately 1/6.28)
	; calc:	a=i*s+v;
	; calc:	b=i+t+u;
	; 	u=sines[a]+sines[b];
	; 	v=cosines[a]+cosines[b];

	clc			; 2
	lda	IS
	adc	V
	tay

	clc
	lda	IT
	adc	U
	tax

	clc
	lda	cosines,Y	; 4+
	adc	cosines,X	; 4+
	sta	V

	; max value for both is $60 so never sets carry

	lda	sines,Y		; 4+
	adc	sines,X		; 4+
	sta	U		; 3

;	bit	SPEAKER		; click speaker

	;===========================================================
	; original code is centered at 96,96 (on hypothetical 192x192 screen)

	; we adjust to be 40x48 window centered at 48,48

	; PLOT U-48,V-48

	; U already in A
;	sec

u_smc:
	sbc	#48
	tay								; 2
	cpy	#40
	bcs	no_plot

	; calculate Ypos
	lda	V
;	sec
vsmc:
	sbc	#48
	cmp	#48
	bcs	no_plot


	bit	SPEAKER		; click speaker

	jsr	PLOT		; PLOT AT Y,A

no_plot:
	dec	J
	bne	j_loop

done_j:
	clc
	lda	IS
	adc	#41		; 1/6.28 = 0.16 =  0 0    1   0       1 0 0 0 = 0x28
	sta	IS
	dec	I
	bne	i_loop
done_i:
	inc	T

	; no panning first 256 times

	bne	ook

	inc	PAN

ook:
	clc
	lda	u_smc+1
	adc	PAN
	sta	u_smc+1



	;=================
	; cycle colors
	;=================

cycle_colors:

	ldy	#$0				; 2
	lda	#4				; 2
	sta	INH				; 2
cycle_color_loop:
	lda	(INL),Y				; 2
	tax					; 1
	lda	color_map,X			; 3
	sta	(INL),Y				; 2

	iny					; 1
	bne	cycle_color_loop		; 2

	; need to do this for pages 4-7

	inc	INH				; 2
	lda	INH				; 2g
	cmp	#$8				; 2
	bne	cycle_color_loop		; 2

	beq	next_frame	; bra		; 2





init_code_to_be_destroyed:


	;========================
	; color lookup
	;========================
	; 34 original
	; 30 updated
	; 31 fixed
	; 29 improved

setup_color_lookup:
	;================
	; current best

	ldx	#0	; init output pointer		; 2
first_loop:
	ldy	#$ff	; reset current value		; 2
loop1:
yloop:
	iny		; current output value		; 1
yloop2:
	tya						; 1
	sta	color_map,X	; values[y]=a;		; 3

	iny						; 1
	inx						; 1
	beq	done					; 2
	cpx	#16					; 2
	beq	first_loop				; 2

	txa						; 1
	and	#$f					; 2

	beq	yloop	; if nextcol==0, skip f->0	; 2

	lsr						; 1

	bne	yloop2	; if nextcol!=1, y=y+1		; 2

	dey		; if nextcol==1, repeat y	; 1
	jmp	yloop2					; 3

done:

	rts


;	.byte $30,$31,$32,$33,$34,$35,$36,$37,$38,$39,$3A,$3B,$3C,$3D,$3E,$3F
;	.byte $40,$41,$42
sines_base:
	.byte $42,$43,$44,$45,$46,$47,$48,$48,$49,$4A,$4B,$4C,$4C
	.byte $4D,$4E,$4E,$4F,$50,$50,$51,$52,$52,$53,$53,$54,$54,$55,$55,$55
	.byte $56,$56,$57,$57,$57,$58,$58,$58,$58,$58
fifty_nines:
;	.byte $59,$59,$59,$59,$59,$59
;	.byte $59

; floor(s*cos((x-96)*PI*2/256.0)+48.5);

