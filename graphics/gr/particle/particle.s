; particle effect? -- Apple II Lores

; by Vince `deater` Weaver

PARTICLES = 128
SCALE = 2

COLOR		= $30

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
PLOT		= $F800		; PLOT AT Y,A (A colors output, Y preserved)
SETGR		= $FB40
WAIT		= $FCA8		; delay 1/2(26+27A+5A^2) us


particle_x	= $2000
particle_y	= $2100
particle_life	= $2200
particle_vx	= $2300
particle_vy	= $2400
particle_decay	= $2600

particle:

	jsr	SETGR
	bit	FULLGR

	; init

	ldx	#PARTICLES
init_particles_loop:
	jsr	init_particle
	dex
	bpl	init_particles_loop



main_loop:

	lda	#200
	jsr	WAIT

	; clear screen
	ldx	#0
	lda	#$8
	sta	clear_loop_smc+2
	lda	#0

clear_loop:

clear_loop_smc:
	sta	$400,X
	dex
	bne	clear_loop
	dec	clear_loop_smc+2
	ldy	clear_loop_smc+2
	cpy	#3
	bne	clear_loop

	; move particles
	; draw particles
	ldx	#PARTICLES
draw_particles_loop:

	; adjust x

	lda	particle_x,X
	clc
	adc	particle_vx,X
	sta	particle_x,X
	bmi	redo_particle
	cmp	#40*SCALE
	bcs	redo_particle

	; adjust y

	; first adjust for gravity
	inc	particle_vy,X
;	inc	particle_vy,X

	lda	particle_y,X
	clc
	adc	particle_vy,X
	sta	particle_y,X
	bmi	redo_particle
	cmp	#48*SCALE
	bcc	y_good

redo_particle:
	jsr	init_particle

y_good:

	lda	particle_life,X
	sta	COLOR
	sec
	sbc	#$11
	sta	particle_life,X
	cmp	#$ef
	beq	redo_particle

	lda	particle_x,X
	lsr
	tay

	lda	particle_y,X
	lsr
	jsr	PLOT		; PLOT AT Y,A

	dex
	bpl	draw_particles_loop

	jmp	main_loop




	; init particle
	; particle in X
init_particle:

	; source

	lda	#20*SCALE
	sta	particle_x,X
	lda	#10*SCALE
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
	sta	particle_vy,X

	; we don't actually use this?

;	lda	#32
;	sta	particle_decay,X
	rts


	; -8 to 8
random:

	inc	random_smc+1
	bne	noflo
	inc	random_smc+2
	beq	noflo
	lda	#$d0
	sta	random_smc+2

noflo:

random_smc:
	lda	$d000

	and	#$f
	sec
	sbc	#$8

	rts




	; need this to be at $3F5

	jmp	particle
