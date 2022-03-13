crosshair_sprite:

;===============
; crosshair sprite
;===============

crosshair_sprite_l:		; X 654 3 210
.byte	$40			; 0 100 0 000
.byte	$00			; 0 000 0 000
.byte	$40			; 0 100 0 000
.byte	$00			; 0 000 0 000
.byte	$40			; 0 100 0 000
.byte	$00			; 0 000 0 000
.byte	$73			; 0 111 0 011
.byte	$73			; 0 111 0 011
.byte	$00			; 0 000 0 000
.byte	$40			; 0 100 0 000
.byte	$00			; 0 000 0 000
.byte	$40			; 0 100 0 000
.byte	$00			; 0 000 0 000
.byte	$40			; 0 100 0 000

crosshair_sprite_r:		; X 654 3 210
.byte	$01			; 0 000 0 001
.byte	$00			; 0 000 0 000
.byte	$01			; 0 000 0 001
.byte	$00			; 0 000 0 000
.byte	$01			; 0 000 0 001
.byte	$00			; 0 000 0 000
.byte	$66			; 0 110 0 110
.byte	$66			; 0 110 0 110
.byte	$00			; 0 000 0 000
.byte	$01			; 0 000 0 001
.byte	$00			; 0 000 0 000
.byte	$01			; 0 000 0 001
.byte	$00			; 0 000 0 000
.byte	$01			; 0 000 0 001

crosshair_mask_l:		; X 654 3 210
.byte	$bf			; 0 100 0 000
.byte	$ff			; 0 000 0 000
.byte	$bf			; 0 100 0 000
.byte	$ff			; 0 000 0 000
.byte	$bf			; 0 100 0 000
.byte	$ff			; 0 000 0 000
.byte	$8c			; 0 111 0 011
.byte	$8c			; 0 111 0 011
.byte	$ff			; 0 000 0 000
.byte	$bf			; 0 100 0 000
.byte	$ff			; 0 000 0 000
.byte	$bf			; 0 100 0 000
.byte	$ff			; 0 000 0 000
.byte	$bf			; 0 100 0 000

crosshair_mask_r:		; X 654 3 210
.byte	$fe			; 0 000 0 001
.byte	$ff			; 0 000 0 000
.byte	$fe			; 0 000 0 001
.byte	$ff			; 0 000 0 000
.byte	$fe			; 0 000 0 001
.byte	$ff			; 0 000 0 000
.byte	$99			; 0 110 0 110
.byte	$99			; 0 110 0 110
.byte	$ff			; 0 000 0 000
.byte	$fe			; 0 000 0 001
.byte	$ff			; 0 000 0 000
.byte	$fe			; 0 000 0 001
.byte	$ff			; 0 000 0 000
.byte	$fe			; 0 000 0 001


;==================
; select sprite
;==================

select_sprite_l:		; X 654 3 210
.byte	$4f			; 0 100 1 111
.byte	$03			; 0 000 0 011
.byte	$00			; 0 000 0 000
.byte	$00			; 0 000 0 000
.byte	$03			; 0 000 0 011
.byte	$03			; 0 000 0 011
.byte	$00			; 0 000 0 000
.byte	$00			; 0 000 0 000
.byte	$03			; 0 000 0 011
.byte	$03			; 0 000 0 011
.byte	$00			; 0 000 0 000
.byte	$00			; 0 000 0 000
.byte	$03			; 0 000 0 011
.byte	$4f			; 0 100 1 111

select_sprite_r:		; X 654 3 210
.byte	$79			; 0 111 1 001
.byte	$60			; 0 110 0 000
.byte	$00			; 0 000 0 000
.byte	$00			; 0 000 0 000
.byte	$60			; 0 110 0 000
.byte	$60			; 0 110 0 000
.byte	$00			; 0 000 0 000
.byte	$00			; 0 000 0 000
.byte	$60			; 0 110 0 000
.byte	$60			; 0 110 0 000
.byte	$00			; 0 000 0 000
.byte	$00			; 0 000 0 000
.byte	$60			; 0 110 0 000
.byte	$79			; 0 111 1 001

select_mask_l:			; X 654 3 210
.byte	$d0			; 0 100 1 111
.byte	$fc			; 0 000 0 011
.byte	$ff			; 0 000 0 000
.byte	$ff			; 0 000 0 000
.byte	$fc			; 0 000 0 011
.byte	$fc			; 0 000 0 011
.byte	$ff			; 0 000 0 000
.byte	$ff			; 0 000 0 000
.byte	$fc			; 0 000 0 011
.byte	$fc			; 0 000 0 011
.byte	$ff			; 0 000 0 000
.byte	$ff			; 0 000 0 000
.byte	$fc			; 0 000 0 011
.byte	$d0			; 0 100 1 111


select_mask_r:			; X 654 3 210
.byte	$86			; 0 111 1 001
.byte	$9f			; 0 110 0 000
.byte	$ff			; 0 000 0 000
.byte	$ff			; 0 000 0 000
.byte	$9f			; 0 110 0 000
.byte	$9f			; 0 110 0 000
.byte	$ff			; 0 000 0 000
.byte	$ff			; 0 000 0 000
.byte	$9f			; 0 110 0 000
.byte	$9f			; 0 110 0 000
.byte	$ff			; 0 000 0 000
.byte	$ff			; 0 000 0 000
.byte	$9f			; 0 110 0 000
.byte	$86			; 0 111 1 001
