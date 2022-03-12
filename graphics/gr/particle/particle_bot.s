; particle effect? -- Apple II Lores

; by Vince `deater` Weaver

; 175 bytes at start
; 169 bytes -- use batari RNG
; 163 bytes -- optimize clear screen
; 159 bytes -- WAIT leaves A as 0, X is 0 on other loop
; 154 bytes -- init with HGR
; 150 bytes -- inline particle_init
; 145 bytes -- optimize color code

PARTICLES = 256
SCALE = 2

SEEDHI	=	$43
SEEDLO	=	$44

COLOR		= $30

FULLGR		= $C052
LORES		= $C056		; Enable LORES graphics

HGR2		= $F3D8
HGR		= $F3E2
PLOT		= $F800		; PLOT AT Y,A (A colors output, Y preserved)
SETCOL		= $F864		; COLOR=A
SETGR		= $FB40
WAIT		= $FCA8		; delay 1/2(26+27A+5A^2) us


particle_x	= $2000
particle_y	= $2100
particle_life	= $2200
particle_vx	= $2300
particle_vy	= $2400
particle_decay	= $2600

particle:

	; HGR clears our particle area to 0

	jsr	HGR
	bit	FULLGR
	bit	LORES			; lores

main_loop:

	lda	#100
	jsr	WAIT

	; clear screen

	; X is 0 at least on the second time through

;	ldx	#0
;	txa
clear_loop:
	sta	$400,X
	sta	$500,X
	sta	$600,X
	sta	$700,X
	dex
	bne	clear_loop

	; move particles
	; draw particles

	;ldx	#0		; 256 particles (X should be 0 here)
draw_particles_loop:

	; adjust x

	lda	particle_x,X
;	clc
	adc	particle_vx,X
	sta	particle_x,X

	bmi	redo_particle	; new particle if off screen
	cmp	#40*SCALE
	bcs	redo_particle

	; adjust y

	; first adjust for gravity
	inc	particle_vy,X

	lda	particle_y,X
;	clc
	adc	particle_vy,X
	sta	particle_y,X

	bmi	redo_particle	; new particle if off screen
	cmp	#48*SCALE
	bcc	y_good

redo_particle:

	; init particle
	; particle in X
init_particle:

	; source

	lda	#20*SCALE
	sta	particle_x,X
	lsr
;	lda	#10*SCALE
	sta	particle_y,X

	; color
	lda	#$f
	sta	particle_life,X

	; velocities
	; -8 to 8?

	jsr	random
	cmp	#$80			; asr
	ror

	sta	particle_vx,X

	jsr	random
	sta	particle_vy,X

	; done inline

y_good:

	lda	particle_life,X		; set color
	jsr	SETCOL

	dec	particle_life,X		; decreent color

	bmi	redo_particle		; if <0 then new particle

	lda	particle_x,X		; we're actually *2
	lsr
	tay

	lda	particle_y,X
	lsr
	jsr	PLOT		; PLOT AT Y,A

	dex
	bne	draw_particles_loop

	beq	main_loop


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
;	sec
	sbc	#$8

	rts


	; need this to be at $3F5

	; 140 so 137, $36C

	jmp	particle
