; The Cho lo-res movie

; by deater (Vince Weaver) <vince@deater.net>

.include "../zp.inc"
.include "../hardware.inc"
.include "../qload.inc"

.include "disk00_defines.inc"

; 145 initial run
;  10 pause when on ground
;   9 dragging
;  20 empty
;   1 off by one
;  15 of moiety (switch background)
;  25 final part

BACKGROUND_SWITCH = 200
NUM_OVERLAYS	=	225


cho_start:

	;===================
        ; Setup lo-res graphics
        ;===================

	; clear it first

;	jsr	clear_gr_all

        bit     SET_GR
        bit     LORES
        bit     FULLGR
        bit     PAGE1

        lda     #0
        sta     SCENE_COUNT

        lda     #4
        sta     DRAW_PAGE

        bit     KEYRESET

	;===============================
	;===============================
	; cho walks in
	;===============================
	;===============================

	lda	#<captured_cage_bg
	sta	scene_bg_l_smc+1

	lda	#>captured_cage_bg
	sta	scene_bg_h_smc+1

	lda	#0
	sta	WHICH_OVERLAY

cho_loop:
	; switch background

	lda	WHICH_OVERLAY
	cmp	#BACKGROUND_SWITCH
	bne	no_bg_switch

	lda	#<flipped_bg
	sta	scene_bg_l_smc+1

	lda	#>flipped_bg
	sta	scene_bg_h_smc+1

no_bg_switch:
	; draw scene with overlay

	jsr	draw_scene

	; draw text (only frames 30..102)

	lda	WHICH_OVERLAY
	cmp	#30
	bcc	no_text
	cmp	#101
	bcs	no_text

do_text:

	bit	TEXTGR		; set split mode

	jsr	clear_bottom	; clear bottom to empty spaces

	ldx	WHICH_OVERLAY
	lda	text_l,X
	sta	OUTL
	lda	text_h,X
	sta	OUTH
	jsr	move_and_print_list

	jmp	done_text

no_text:
	bit	FULLGR
done_text:

	; flip pages

	jsr	flip_pages

	inc	WHICH_OVERLAY
	lda	WHICH_OVERLAY
	cmp	#NUM_OVERLAYS
	beq	done_cho


	; in theory we are 500ms (10*50) long here...

	ldx	#7
	jsr	wait_a_bit

	jmp	cho_loop


done_cho:


	;======================
	; done, move on to next
	;======================

	bit     KEYRESET

	lda     #LOAD_START
	sta     WHICH_LOAD

	lda     #$1
	sta     LEVEL_OVER

	rts

	.include "flip_pages.s"
	.include "draw_scene.s"

frames_l:
	.byte <empty			; 0
	.byte <empty			; 1
	.byte <empty			; 2
	.byte <empty			; 3
	.byte <empty			; 4
	.byte <empty			; 5
	.byte <cho_overlay006,<cho_overlay007,<cho_overlay008	; 6,7,8
	.byte <cho_overlay009,<cho_overlay010,<cho_overlay011	; 9,10,11
	.byte <cho_overlay012,<cho_overlay013,<cho_overlay014	; 12,13,14
	.byte <cho_overlay015,<cho_overlay016,<cho_overlay017	; 15,16,17
	.byte <cho_overlay018,<cho_overlay019,<cho_overlay020	; 18,19,20
	.byte <cho_overlay021,<cho_overlay022,<cho_overlay023	; 21,22,23
	.byte <cho_overlay024,<cho_overlay025,<cho_overlay026	; 24,25,26
	.byte <cho_overlay027,<cho_overlay028,<cho_overlay029	; 27,28,29
	.byte <cho_overlay030,<cho_overlay031,<cho_overlay032	; 30,31,32
	.byte <cho_overlay033,<cho_overlay034,<cho_overlay035	; 33,34,35
	.byte <cho_overlay036,<cho_overlay037,<cho_overlay038	; 36,37,38
	.byte <cho_overlay039,<cho_overlay040,<cho_overlay041	; 39,40,41
	.byte <cho_overlay042,<cho_overlay043,<cho_overlay044	; 42,43,44
	.byte <cho_overlay045,<cho_overlay046,<cho_overlay047	; 45,46,47
	.byte <cho_overlay048,<cho_overlay049,<cho_overlay050	; 48,49,50
	.byte <cho_overlay051,<cho_overlay052,<cho_overlay053	; 51,52,53
	.byte <cho_overlay054,<cho_overlay055,<cho_overlay056	; 54,55,56
	.byte <cho_overlay057,<cho_overlay058,<cho_overlay059	; 57,58,59
	.byte <cho_overlay060,<cho_overlay061,<cho_overlay062	; 60,61,62
	.byte <cho_overlay063,<cho_overlay064,<cho_overlay065	; 63,64,65
	.byte <cho_overlay066,<cho_overlay067,<cho_overlay068	; 66,67,68
	.byte <cho_overlay069,<cho_overlay070,<cho_overlay071	; 69,70,71
	.byte <cho_overlay072,<cho_overlay073,<cho_overlay074	; 72,73,74
	.byte <cho_overlay075,<cho_overlay076,<cho_overlay077	; 75,76,77
	.byte <cho_overlay078,<cho_overlay079,<cho_overlay080	; 78,79,80
	.byte <cho_overlay081,<cho_overlay082,<cho_overlay083	; 81,82,83
	.byte <cho_overlay084,<cho_overlay085,<cho_overlay086	; 84,85,86
	.byte <cho_overlay087,<cho_overlay088,<cho_overlay089	; 87,88,89
	.byte <cho_overlay090,<cho_overlay091,<cho_overlay092	; 90,91,92
	.byte <cho_overlay093,<cho_overlay094,<cho_overlay095	; 93,94,95
	.byte <cho_overlay096,<cho_overlay097,<cho_overlay098	; 96,97,98
	.byte <cho_overlay099,<cho_overlay100,<cho_overlay101	; 99,100,101
	.byte <cho_overlay102,<cho_overlay103,<cho_overlay104	; 102,103,104
	.byte <cho_overlay105,<cho_overlay106,<cho_overlay107	; 105,106,107
	.byte <cho_overlay108,<cho_overlay109,<cho_overlay110	; 108,109,110
	.byte <cho_overlay111,<cho_overlay112,<cho_overlay113	; 111,112,113
	.byte <cho_overlay114,<cho_overlay115,<cho_overlay116	; 114,115,116
	.byte <cho_overlay117,<cho_overlay118,<cho_overlay119	; 117,118,119
	.byte <cho_overlay120,<cho_overlay121,<cho_overlay122	; 120,121,122
	.byte <cho_overlay123,<cho_overlay124,<cho_overlay125	; 123,124,125
	.byte <cho_overlay126,<cho_overlay127,<cho_overlay128	; 126,127,128
	.byte <cho_overlay129,<cho_overlay130,<cho_overlay131	; 129,130,131
	.byte <cho_overlay132,<cho_overlay133,<cho_overlay134	; 132,133,134
	.byte <cho_overlay135,<cho_overlay136,<cho_overlay137	; 135,136,137
	.byte <cho_overlay138,<cho_overlay139,<cho_overlay140	; 138,139,140
	.byte <cho_overlay141,<cho_overlay142,<cho_overlay143	; 141,142,143
	.byte <cho_overlay144,<cho_overlay145			; 144,145

	; note: same image from 146 ... 160 or so (7s?)
	; let's make it a bit shorter, maybe 5s? (10 frames)

	.byte <cho_overlay145,<cho_overlay145,<cho_overlay145
	.byte <cho_overlay145,<cho_overlay145,<cho_overlay145
	.byte <cho_overlay145,<cho_overlay145,<cho_overlay145
	.byte <cho_overlay145

	; restart here with 163

	.byte <cho_overlay163,<cho_overlay164,<cho_overlay165	; 163,164,165
	.byte <cho_overlay166,<cho_overlay167,<cho_overlay168	; 166,167,168
	.byte <cho_overlay169,<cho_overlay170,<cho_overlay171	; 169,170,171

	; nothing 172 ... 206 or 17s (34 frames)
	; maybe wait 10s this time? (20 frames)

	.byte <empty,<empty,<empty,<empty,<empty
	.byte <empty,<empty,<empty,<empty,<empty
	.byte <empty,<empty,<empty,<empty,<empty
	.byte <empty,<empty,<empty,<empty,<empty

	; 206 ... 220 until new background
	.byte <cho_overlay206,<cho_overlay207			; 206,207
	.byte <cho_overlay208,<cho_overlay209,<cho_overlay210	; 208,209,210
	.byte <cho_overlay211,<cho_overlay212,<cho_overlay213	; 211,212,213
	.byte <cho_overlay214,<cho_overlay215,<cho_overlay216	; 214,215,216
	.byte <cho_overlay217,<cho_overlay218,<cho_overlay219	; 217,218,219
	.byte <cho_overlay220					; 220

	; 221 ... 244 + empty
	.byte <cho_overlay221,<cho_overlay222,<cho_overlay223	; 221,222,223
	.byte <cho_overlay224,<cho_overlay225,<cho_overlay226	; 224,225,226
	.byte <cho_overlay227,<cho_overlay228,<cho_overlay229	; 227,228,229
	.byte <cho_overlay230,<cho_overlay231,<cho_overlay232	; 230,231,232
	.byte <cho_overlay233,<cho_overlay234,<cho_overlay235	; 233,234,235
	.byte <cho_overlay236,<cho_overlay237,<cho_overlay238	; 236,237,238
	.byte <cho_overlay239,<cho_overlay240,<cho_overlay241	; 239,240,241
	.byte <cho_overlay242,<cho_overlay243,<cho_overlay244	; 242,243,244
	.byte <empty

frames_h:
	.byte >empty			; 0
	.byte >empty			; 1
	.byte >empty			; 2
	.byte >empty			; 3
	.byte >empty			; 4
	.byte >empty			; 5
	.byte >cho_overlay006,>cho_overlay007,>cho_overlay008	; 6,7,8
	.byte >cho_overlay009,>cho_overlay010,>cho_overlay011	; 9,10,11
	.byte >cho_overlay012,>cho_overlay013,>cho_overlay014	; 12,13,14
	.byte >cho_overlay015,>cho_overlay016,>cho_overlay017	; 15,16,17
	.byte >cho_overlay018,>cho_overlay019,>cho_overlay020	; 18,19,20
	.byte >cho_overlay021,>cho_overlay022,>cho_overlay023	; 21,22,23
	.byte >cho_overlay024,>cho_overlay025,>cho_overlay026	; 24,25,26
	.byte >cho_overlay027,>cho_overlay028,>cho_overlay029	; 27,28,29
	.byte >cho_overlay030,>cho_overlay031,>cho_overlay032	; 30,31,32
	.byte >cho_overlay033,>cho_overlay034,>cho_overlay035	; 33,34,35
	.byte >cho_overlay036,>cho_overlay037,>cho_overlay038	; 36,37,38
	.byte >cho_overlay039,>cho_overlay040,>cho_overlay041	; 39,40,41
	.byte >cho_overlay042,>cho_overlay043,>cho_overlay044	; 42,43,44
	.byte >cho_overlay045,>cho_overlay046,>cho_overlay047	; 45,46,47
	.byte >cho_overlay048,>cho_overlay049,>cho_overlay050	; 48,49,50
	.byte >cho_overlay051,>cho_overlay052,>cho_overlay053	; 51,52,53
	.byte >cho_overlay054,>cho_overlay055,>cho_overlay056	; 54,55,56
	.byte >cho_overlay057,>cho_overlay058,>cho_overlay059	; 57,58,59
	.byte >cho_overlay060,>cho_overlay061,>cho_overlay062	; 60,61,62
	.byte >cho_overlay063,>cho_overlay064,>cho_overlay065	; 63,64,65
	.byte >cho_overlay066,>cho_overlay067,>cho_overlay068	; 66,67,68
	.byte >cho_overlay069,>cho_overlay070,>cho_overlay071	; 69,70,71
	.byte >cho_overlay072,>cho_overlay073,>cho_overlay074	; 72,73,74
	.byte >cho_overlay075,>cho_overlay076,>cho_overlay077	; 75,76,77
	.byte >cho_overlay078,>cho_overlay079,>cho_overlay080	; 78,79,80
	.byte >cho_overlay081,>cho_overlay082,>cho_overlay083	; 81,82,83
	.byte >cho_overlay084,>cho_overlay085,>cho_overlay086	; 84,85,86
	.byte >cho_overlay087,>cho_overlay088,>cho_overlay089	; 87,88,89
	.byte >cho_overlay090,>cho_overlay091,>cho_overlay092	; 90,91,92
	.byte >cho_overlay093,>cho_overlay094,>cho_overlay095	; 93,94,95
	.byte >cho_overlay096,>cho_overlay097,>cho_overlay098	; 96,97,98
	.byte >cho_overlay099,>cho_overlay100,>cho_overlay101	; 99,100,101
	.byte >cho_overlay102,>cho_overlay103,>cho_overlay104	; 102,103,104
	.byte >cho_overlay105,>cho_overlay106,>cho_overlay107	; 105,106,107
	.byte >cho_overlay108,>cho_overlay109,>cho_overlay110	; 108,109,110
	.byte >cho_overlay111,>cho_overlay112,>cho_overlay113	; 111,112,113
	.byte >cho_overlay114,>cho_overlay115,>cho_overlay116	; 114,115,116
	.byte >cho_overlay117,>cho_overlay118,>cho_overlay119	; 117,118,119
	.byte >cho_overlay120,>cho_overlay121,>cho_overlay122	; 120,121,122
	.byte >cho_overlay123,>cho_overlay124,>cho_overlay125	; 123,124,125
	.byte >cho_overlay126,>cho_overlay127,>cho_overlay128	; 126,127,128
	.byte >cho_overlay129,>cho_overlay130,>cho_overlay131	; 129,130,131
	.byte >cho_overlay132,>cho_overlay133,>cho_overlay134	; 132,133,134
	.byte >cho_overlay135,>cho_overlay136,>cho_overlay137	; 135,136,137
	.byte >cho_overlay138,>cho_overlay139,>cho_overlay140	; 138,139,140
	.byte >cho_overlay141,>cho_overlay142,>cho_overlay143	; 141,142,143
	.byte >cho_overlay144,>cho_overlay145			; 144,145

	.byte >cho_overlay145,>cho_overlay145,>cho_overlay145
	.byte >cho_overlay145,>cho_overlay145,>cho_overlay145
	.byte >cho_overlay145,>cho_overlay145,>cho_overlay145
	.byte >cho_overlay145

	.byte >cho_overlay163,>cho_overlay164,>cho_overlay165	; 163,164,165
	.byte >cho_overlay166,>cho_overlay167,>cho_overlay168	; 166,167,168
	.byte >cho_overlay169,>cho_overlay170,>cho_overlay171	; 169,170,171

	.byte >empty,>empty,>empty,>empty,>empty
	.byte >empty,>empty,>empty,>empty,>empty
	.byte >empty,>empty,>empty,>empty,>empty
	.byte >empty,>empty,>empty,>empty,>empty

	.byte >cho_overlay206,>cho_overlay207			; 206,207
	.byte >cho_overlay208,>cho_overlay209,>cho_overlay210	; 208,209,210
	.byte >cho_overlay211,>cho_overlay212,>cho_overlay213	; 211,212,213
	.byte >cho_overlay214,>cho_overlay215,>cho_overlay216	; 214,215,216
	.byte >cho_overlay217,>cho_overlay218,>cho_overlay219	; 217,218,219
	.byte >cho_overlay220					; 220

	.byte >cho_overlay221,>cho_overlay222,>cho_overlay223	; 221,222,223
	.byte >cho_overlay224,>cho_overlay225,>cho_overlay226	; 224,225,226
	.byte >cho_overlay227,>cho_overlay228,>cho_overlay229	; 227,228,229
	.byte >cho_overlay230,>cho_overlay231,>cho_overlay232	; 230,231,232
	.byte >cho_overlay233,>cho_overlay234,>cho_overlay235	; 233,234,235
	.byte >cho_overlay236,>cho_overlay237,>cho_overlay238	; 236,237,238
	.byte >cho_overlay239,>cho_overlay240,>cho_overlay241	; 239,240,241
	.byte >cho_overlay242,>cho_overlay243,>cho_overlay244	; 242,243,244
	.byte >empty


text_l:
	.byte <empty_text,<empty_text,<empty_text		; 0,1,2
	.byte <empty_text,<empty_text,<empty_text		; 3,4,5
	.byte <empty_text,<empty_text,<empty_text		; 6,7,8
	.byte <empty_text,<empty_text,<empty_text		; 9,10,11
	.byte <empty_text,<empty_text,<empty_text		; 12,13,14
	.byte <empty_text,<empty_text,<empty_text		; 15,16,17
	.byte <empty_text,<empty_text,<empty_text		; 18,19,20
	.byte <empty_text,<empty_text,<empty_text		; 21,22,23
	.byte <empty_text,<empty_text,<empty_text		; 24,25,26
	.byte <empty_text,<empty_text,<empty_text		; 27,28,29
	.byte <cho_text,<cho_text,<cho_text			; 30,31,32
	.byte <cho_text,<cho_text,<cho_text			; 33,34,35
	.byte <faleaay_text,<faleaay_text,<faleaay_text		; 36,37,38
	.byte <empty_text,<kaka_text,<kaka_text			; 39,40,41
	.byte <empty_text,<olua_text,<olua_text			; 42,43,44
	.byte <olua_text,<olua_text,<olua_text			; 45,46,47
	.byte <olua_text,<empty_text,<empty_text		; 48,49,50
	.byte <empty_text,<tahg_text,<tahg_text			; 51,52,53
	.byte <tahg_text,<tahg_text,<tahg_text			; 54,55,56
	.byte <tahg_text,<re_text,<re_text			; 57,58,59
	.byte <re_text,<tah_text,<tah_text			; 60,61,62
	.byte <tah_text,<tah_text,<tahg2_text			; 63,64,65
	.byte <tahg2_text,<tahg2_text,<tahg2_text		; 66,67,68
	.byte <tahg2_text,<empty_text,<empty_text		; 69,70,71
	.byte <me_text,<me_text,<me_text			; 72,73,74
	.byte <me_text,<me_text,<me_text			; 75,76,77
	.byte <me_text,<me_text,<me_text			; 78,79,80
	.byte <me_text,<me2_text,<me2_text			; 81,82,83
	.byte <me2_text,<me2_text,<me2_text			; 84,85,86
	.byte <me2_text,<me2_text,<me2_text			; 87,88,89
	.byte <me2_text,<me2_text,<me2_text			; 90,91,92
	.byte <empty_text,<me3_text,<me3_text			; 93,94,95
	.byte <me3_text,<me3_text,<me3_text			; 96,97,98
	.byte <boku_text,<boku_text,<boku_text			; 99,100,101
	.byte <boku_text,<empty_text,<empty_text		; 102,103,104

text_h:
	.byte >empty_text,>empty_text,>empty_text		; 0,1,2
	.byte >empty_text,>empty_text,>empty_text		; 3,4,5
	.byte >empty_text,>empty_text,>empty_text		; 6,7,8
	.byte >empty_text,>empty_text,>empty_text		; 9,10,11
	.byte >empty_text,>empty_text,>empty_text		; 12,13,14
	.byte >empty_text,>empty_text,>empty_text		; 15,16,17
	.byte >empty_text,>empty_text,>empty_text		; 18,19,20
	.byte >empty_text,>empty_text,>empty_text		; 21,22,23
	.byte >empty_text,>empty_text,>empty_text		; 24,25,26
	.byte >empty_text,>empty_text,>empty_text		; 27,28,29
	.byte >cho_text,>cho_text,>cho_text			; 30,31,32
	.byte >cho_text,>cho_text,>cho_text			; 33,34,35
	.byte >faleaay_text,>faleaay_text,>faleaay_text		; 36,37,38
	.byte >empty_text,>kaka_text,>kaka_text			; 39,40,41
	.byte >empty_text,>olua_text,>olua_text			; 42,43,44
	.byte >olua_text,>olua_text,>olua_text			; 45,46,47
	.byte >olua_text,>empty_text,>empty_text		; 48,49,50
	.byte >empty_text,>tahg_text,>tahg_text			; 51,52,53
	.byte >tahg_text,>tahg_text,>tahg_text			; 54,55,56
	.byte >tahg_text,>re_text,>re_text			; 57,58,59
	.byte >re_text,>tah_text,>tah_text			; 60,61,62
	.byte >tah_text,>tahg2_text,>tahg2_text			; 63,64,65
	.byte >tahg2_text,>tahg2_text,>tahg2_text		; 66,67,68
	.byte >tahg2_text,>empty_text,>empty_text		; 69,70,71
	.byte >me_text,>me_text,>me_text			; 72,73,74
	.byte >me_text,>me_text,>me_text			; 75,76,77
	.byte >me_text,>me_text,>me_text			; 78,79,80
	.byte >me_text,>me2_text,>me2_text			; 81,82,83
	.byte >me2_text,>me2_text,>me2_text			; 84,85,86
	.byte >me2_text,>me2_text,>me2_text			; 87,88,89
	.byte >me2_text,>me2_text,>me2_text			; 90,91,92
	.byte >empty_text,>me3_text,>me3_text			; 93,94,95
	.byte >me3_text,>me3_text,>me3_text			; 96,97,98
	.byte >boku_text,>boku_text,>boku_text			; 99,100,101
	.byte >boku_text,>empty_text,>empty_text		; 102,103,104

; video 192s roughly frame 6
; 204s "Cho?"		  	+12 frames 30..35

; 207s Faleeay			+15 36
; 209s Kaka wadevol.		+17 40
; 210s Olua wipol wipol.	+18 42
; 213s thinks			+21 48
; 215s Tahg-em-ah		+23 52
; 218s re-ko-ah			+26 58
; 219s tah. tah. tah		+27 60
; 220s tahg-em-ah b'soo re-ko-ah+28 64
; 224 off			+32 70
; 225 Me selap...		+33 72
; 230 Me selap...		+38 82
; 236 Me selap...		+44 94
; 239 Boku!			+47 100
; 240 Boku! (grabs book)	+48 102
;   102 back to normal!

; 30-102 FULLGR

; based on http://www.florestica.com/hpotd/dni_dictionary/cho.html
; and https://mystjourney.com/riven/faqs/

; Originally thought I'd write this directly to the graphics images,
;	but space being $A0 interferes with using $A as transparency
;	and the overlay code is by byte rather than by line so hard
;	to turn it off for just the bottom 4 lines

; Questions: make D'NI lowercase so auto-case kicks in?

empty_text:
.byte 0,20," ",0,$FF

cho_text:
.byte 29,21,"CHO?",0,$FF

faleaay_text:
.byte 27,20,"   __",0
.byte 27,21,"FALEAAY.",0,$FF

kaka_text:
.byte 25,21,"KAKA WADEVOL.",0,$FF

olua_text:
.byte 23,20,"  _",0
.byte 23,21,"OLUA WIPOL WIPOL.",0,$FF

tahg_text:
.byte 25,21,"TAHG-EM-AH",0,$FF

re_text:
.byte 25,21,"RE-KO-AH",0,$FF

tah_text:
.byte 10,21,"TAH... TAH... TAH...",0,$FF

tahg2_text:
.byte 7,21,"TAHG-EM-AH B'SOO RE-KO-AH",0,$FF

me_text:
.byte 0,20," _  _       _  _       _  _      _   _",0
.byte 0,21,"ME SELAP.  ME SELAP.  MU TEKA BOKU ANA.",0,$FF

me2_text:
.byte 0,20," _  _       _  _      _   _      _   _",0
.byte 0,21,"ME SELAP.  MU TEKA BOKU ANA.  BOKU ANA.",0,$FF

me3_text:
.byte 0,20," _  _            _   _      _   _",0
.byte 0,21,"ME SELAP.  IM BOKU ANA.  BOKU ANA.",0,$FF

boku_text:
.byte 10,20,"   _   _     _   _",0
.byte 10,21,"BOKU ANA! BOKU ANA!",0,$FF

cho_graphics:
	.include	"graphics_cho/cho_graphics.inc"

