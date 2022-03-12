; particle effect? -- Apple II Lores

; by Vince `deater` Weaver


; 165 byte original
; 154 skip init code
; 152 avoid saving on stack
; 147 inline init particle
; 144 bytes, remove wait

PARTICLES = 64

HGR_BITS	= $1C
COLOR		= $30
SEEDLO		= $43
SEEDHI		= $44
HGR_COLOR	= $E4

PARTICLE2	= $FD
PARTICLE	= $FE
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

	; just let it init to 0, eventually starts


main_loop:

;	lda	#100
;	jsr	WAIT

	lda	#0			; already 0 from wait
	sta	HGR_COLOR

	ldx	#PARTICLES
	stx	PARTICLE
	stx	PARTICLE2

clear_loop:

	ldy	PARTICLE

	ldx	particle_x,Y
	lda	particle_y,Y
	ldy	#0
	jsr	HPLOT0			; plot at (Y,X), (A)

	dec	PARTICLE
	bpl	clear_loop



	; move particles
	; draw particles
;	ldx	#PARTICLES
draw_particles_loop:

	ldy	PARTICLE2
	tya
	tax

	; adjust x

	lda	particle_x,Y
	clc
	adc	particle_vx,Y
	sta	particle_x,Y

	; don't look for overflow on X, just wrap



	; first adjust for gravity
	inc	particle_vy,X

	; adjust y

	lda	particle_y,Y
	clc
	adc	particle_vy,Y
	sta	particle_y,Y
	cmp	#191
	bcc	y_good

redo_particle:

	; inline

	; init particle
	; particle in X
init_particle:

	; source

	lda	#128			; init x
	sta	particle_x,Y
	lda	#100			; init y
	sta	particle_y,Y

	; color
	lda	#$f
	sta	particle_life,Y

	; velocities
	; -8 to 8?

	jsr	random
	cmp	#$80
	ror

	sta	particle_vx,Y

	jsr	random
	ora	#$f0
	sta	particle_vy,Y


y_good:
	dec	particle_life,X
	beq	redo_particle

	lda	#$ff
	sta	HGR_COLOR

	ldx	particle_x,Y
	lda	particle_y,Y
	ldy	#0
	jsr	HPLOT0			; plot at (Y,X), (A)

	dec	PARTICLE2
	bpl	draw_particles_loop

	bmi	main_loop


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
