; particle effect? -- Apple II Lores

; by Vince `deater` Weaver

PARTICLES = 64
SCALE = 2

HGR_BITS	= $1C
COLOR		= $30
SEEDLO		= $43
SEEDHI		= $44
HGR_COLOR	= $E4

QUOTIENT	= $FA
DIVISOR		= $FB
DIVIDEND	= $FC
XX		= $FD
YY		= $FE
FRAME		= $FF

FULLGR		= $C052
LORES		= $C056		; Enable LORES graphics

HGR2		= $F3D8
HGR		= $F3E2
HPLOT0		= $F457		; plot at (Y,X), (A)
PLOT		= $F800		; PLOT AT Y,A (A colors output, Y preserved)
SETGR		= $FB40
WAIT		= $FCA8		; delay 1/2(26+27A+5A^2) us

particle_x	= $2000
particle_y	= $2100
particle_life	= $2200
particle_vx	= $2300
particle_vy	= $2400


particle:
	jsr	HGR		; clear $2000 for data struct
	jsr	HGR2		; clear/display HGR2

	; init

	ldx	#PARTICLES
init_particles_loop:
	jsr	init_particle
	dex
	bpl	init_particles_loop



main_loop:

	lda	#100
	jsr	WAIT

	lda	#0
	sta	HGR_COLOR

	ldx	#PARTICLES
clear_loop:

	txa
	pha
	tay

	ldx	particle_x,Y
	lda	particle_y,Y
	ldy	#0
	jsr	HPLOT0			; plot at (Y,X), (A)

	pla
	tax

	dex
	bpl	clear_loop



	; move particles
	; draw particles
	ldx	#PARTICLES
draw_particles_loop:

	; adjust x

	lda	particle_x,X
	clc
	adc	particle_vx,X
	sta	particle_x,X
;	bmi	redo_particle
;	cmp	#40*SCALE
;	bcs	redo_particle

	; adjust y

	; first adjust for gravity
	inc	particle_vy,X
;	inc	particle_vy,X

	lda	particle_y,X
	clc
	adc	particle_vy,X
	sta	particle_y,X
;	bmi	redo_particle
	cmp	#191
	bcc	y_good

redo_particle:
	jsr	init_particle

y_good:
	dec	particle_life,X
	beq	redo_particle

	lda	#$ff
	sta	HGR_COLOR

;	lda	particle_life,X
;	sta	HGR_COLOR
;	sec
;	sbc	#$11
;	sta	particle_life,X
;	cmp	#$ef
;	beq	redo_particle

	txa
	pha
	tay

	ldx	particle_x,Y
	lda	particle_y,Y
	ldy	#0
	jsr	HPLOT0			; plot at (Y,X), (A)

	pla
	tax

	dex
	bpl	draw_particles_loop

	jmp	main_loop




	; init particle
	; particle in X
init_particle:

	; source

	lda	#128			; init x
	sta	particle_x,X
	lda	#100			; init y
	sta	particle_y,X

	; color
	lda	#$ff
	sta	particle_life,X

	; velocities
	; -8 to 8?

	jsr	random
	cmp	#$80
	ror

	sta	particle_vx,X

	jsr	random
	ora	#$f0
	sta	particle_vy,X

	rts


	; -8 to 8
	; batari RNG

random:
	lda	SEEDHI
	lsr
	rol	SEEDLO
	bcc	noeor
	eor	#$B4
noeor:
	sta	SEEDHI
	eor	SEEDLO

	and	#$f
	sec
	sbc	#$8

	rts





	; need this to be at $3F5

	jmp	particle
