;===========================================
; Library to decode Vortex Tracker PT3 files
; in 6502 assembly for Apple ][ Mockingboard
;
; by Vince Weaver <vince@deater.net>

; Roughly based on the Formats.pas Pascal code from Ay_Emul

; TODO
;   move some of these flags to be bits rather than bytes?
;   enabled could be bit 6 or 7 for fast checking
; NOTE_ENABLED,ENVELOPE_ENABLED,SIMPLE_GLISS,ENV_SLIDING,AMP_SLIDING?

; Header offsets

PT3_VERSION		= $0D
PT3_HEADER_FREQUENCY	= $63
PT3_SPEED		= $64
PT3_LOOP		= $66
PT3_PATTERN_LOC_L	= $67
PT3_PATTERN_LOC_H	= $68
PT3_SAMPLE_LOC_L	= $69
PT3_SAMPLE_LOC_H	= $6A
PT3_ORNAMENT_LOC_L	= $A9
PT3_ORNAMENT_LOC_H	= $AA
PT3_PATTERN_TABLE	= $C9

; Use memset to set things to 0?

NOTE_VOLUME		=0
NOTE_TONE_SLIDING_L	=1
NOTE_TONE_SLIDING_H	=2
NOTE_ENABLED		=3
NOTE_ENVELOPE_ENABLED	=4
NOTE_SAMPLE_POINTER_L	=5
NOTE_SAMPLE_POINTER_H	=6
NOTE_SAMPLE_LOOP	=7
NOTE_SAMPLE_LENGTH	=8
NOTE_TONE_L		=9
NOTE_TONE_H		=10
NOTE_AMPLITUDE		=11
NOTE_NOTE		=12
NOTE_LEN		=13
NOTE_LEN_COUNT		=14
NOTE_ADDR_L		=15
NOTE_ADDR_H		=16
NOTE_ORNAMENT_POINTER_L	=17
NOTE_ORNAMENT_POINTER_H	=18
NOTE_ORNAMENT_LOOP	=19
NOTE_ORNAMENT_LENGTH	=20
NOTE_ONOFF		=21
NOTE_TONE_ACCUMULATOR_L	=22
NOTE_TONE_ACCUMULATOR_H	=23
NOTE_TONE_SLIDE_COUNT	=24
NOTE_ORNAMENT_POSITION	=25
NOTE_SAMPLE_POSITION	=26
NOTE_ENVELOPE_SLIDING	=27
NOTE_NOISE_SLIDING	=28
NOTE_AMPLITUDE_SLIDING	=29
NOTE_ONOFF_DELAY	=30	;ordering of DELAYs is hard-coded now
NOTE_OFFON_DELAY	=31	;ordering of DELAYs is hard-coded now
NOTE_TONE_SLIDE_STEP_L	=32
NOTE_TONE_SLIDE_STEP_H	=33
NOTE_TONE_SLIDE_DELAY	=34
NOTE_SIMPLE_GLISS	=35
NOTE_SLIDE_TO_NOTE	=36
NOTE_TONE_DELTA_L	=37
NOTE_TONE_DELTA_H	=38
NOTE_TONE_SLIDE_TO_STEP	=39

NOTE_STRUCT_SIZE=40


; note, you might have slightly better performance if these are aligned
; so that loads don't have to cross page boundaries

NoteTable_high:
	.res 96,0
NoteTable_low:
	.res 96,0

VolumeTable:
	.res 256,0


;pt3_lib_end:
