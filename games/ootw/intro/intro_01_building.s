;=======================================
; OOTW -- intro -- outside the building
;=======================================

intro_01_building:

;===============================
;===============================
; Opening scene with car
;===============================
;===============================

	;==================================
	; draw the car driving up
	;==================================
	; draw getting out of the car

	lda	#<building_sequence
	sta	INTRO_LOOPL
	lda	#>building_sequence
	sta	INTRO_LOOPH

	jmp	run_sequence		; returns at end


.include "graphics/01_building/intro_building.inc"
.include "graphics/01_building/intro_car.inc"	; must follow intro_building
.include "graphics/01_building/intro_building_car.inc"


;========================
; Car driving up sequence

building_sequence:
	.byte	255						; load to bg
	.word	intro_building_lzsa				;  this
	.byte	1						; wait 1
	.word	intro_building_lzsa				; overlay this
	.byte	128+126	;	.word	intro_car1_lzsa		; wait 126
	.byte	128+2	;	.word	intro_car2_lzsa		; next
	.byte	128+2	;	.word	intro_car3_lzsa		; next
	.byte	128+2	;	.word	intro_car4_lzsa		; next
	.byte	128+2	;	.word	intro_car5_lzsa		; next
	.byte	128+2	;	.word	intro_car6_lzsa		; next
	.byte	128+2	;	.word	intro_car7_lzsa		; next
	.byte	128+2	;	.word	intro_car8_lzsa		; next
	.byte	128+2	;	.word	intro_car9_lzsa		; next
	.byte	128+126	;	.word	intro_car10_lzsa	; next
;	.byte	0						; finish

;========================
; Getting out of car sequence

outtacar_sequence:
	.byte	255
	.word	intro_building_car_lzsa
	.byte	1
	.word	intro_building_car_lzsa
	.byte	100
	.word	intro_car12_lzsa
	.byte	128+50	;	.word	intro_car13_lzsa
	.byte	128+125	;	.word	intro_car14_lzsa
	.byte	125
	.word	intro_car14_lzsa
	.byte	0


