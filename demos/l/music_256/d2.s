; Apple II graphics/music in 1k

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
	.include "zp.inc"
	.include "hardware.inc"

; for a 256 entry we need to fit in 252 bytes

; 310 bytes -- initial
; 268 bytes -- strip out interrupts
; 262 bytes -- simplify init
; 261 bytes -- optimize init more
; 253 bytes -- optimize var init
; 252 bytes -- bne vs jmp
; 250 bytes -- song only has 16 notes so can never be negative
; 249 bytes -- make terminating value $80 instead of $FF
; 247 bytes -- combine note loop.  makes song a bit faster
; 245 bytes -- try to optimize writing out volume
; 255 bytes -- add in some visualization
; 252 bytes -- re-arrange decode code
; 251 bytes -- load in zero page
; 256 bytes -- expand WAIT to not use jsr
; 258 bytes -- get rid of pha/pla
; 255 bytes -- use PLA to load the data after setting stack to 0
; 249 bytes -- optimize init code to not write 0s to ZP and init $38/$e/$e/$e
;		but instead count on A/B/C over-writing and have the
;		ay buffer over-write the init code
; 247 bytes -- count on X always being $FF when hit delay
; 246 bytes -- make SONG_COUNTDOWN self-modify code
; 241 bytes -- forgot we didn't need to init volume in play_frame anymore
; 238 bytes -- can use Y to save note value in play_frame now
; 237 bytes -- make song terminator #$FF so we don't have to load it
; 235 bytes -- note X is $FF on entry to mockingboard entry
; 233 bytes -- qkumba noticed we can execute the AY config

.zeropage
;.globalzp       frequencies_low
;.globalzp       frequencies_high


d2:
	; this is also the start of AY_REGS
	; we count on A/B/C being played first note
	; so the code gets over-written

	; depends on AY ignoring envelope values if unused

	jsr	SETGR			; enable lo-res graphics
					; A=$D0, Z=1

	ldx	#$FF			; set stack offset
;	bmi	skip_const

	txs				; write 0 to stack pointer

	nop

	; we can execute these... (as qkumba noticed)
	; it's SEC, ASL $0E0E

	.byte	$38,$e,$e,$e		; mixer, A, B, C volume


	;===================
	; music Player Setup

tracker_song = peasant_song

	; assume mockingboard in slot#4

	; inline mockingboard_init

.include "mockingboard_init.s"



game_loop:
	; typically A=0, X=FF, Y=0 here

	; play a frame of music

.include "play_frame.s"
.include "ay3_write_regs.s"

	; X is in theory $ff when we get here

	; delay 20Hz, or 1/20s = 50ms
	;	50,000 cycles

	; 2 + 256*(2+39*5-1) = 49,922

;	ldx	#0		; 2
outer_wait:
	ldy	#39		; 2
inner_wait:
	dey			; 2
	bne	inner_wait	; 3/2

	dex			; 2
	bne	outer_wait	; 3/2

	beq	game_loop


; pad so starts at $80
; use this for visualization
.byte $00,$00,$00,$00
.byte $00,$00,$00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00,$00

; music
.include	"mA2E_2.s"
.include	"notes.inc"
