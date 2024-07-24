.include "../zp.inc"
.include "../disk02_files/disk02_defines.inc"
.include "../disk00_files/disk00_defines.inc"

which_disk_bcd:
	.byte	$01		; BCD

which_disk_bin:
	.byte	1

load_address_array:
	.byte	$40,$40,$40,$40	; TITLE, ARRIVAL, ARRIVAL2, TELESCOPE
	.byte	$40,$40,$00,$00	; ARRIVAL3, PATH

track_array:
        .byte	0, 2, 9,13	; TITLE, ARRIVAL, ARRIVAL2, TELESCOPE
	.byte	19,27,0,0	; ARRIVAL3, PATH

sector_array:
        .byte	8, 0, 0, 0	; TITLE, ARRIVAL, ARRIVAL2, TELESCOPE
	.byte	0,0,0,0		; ARRIVAL3, PATH
length_array:
        .byte	8, 112,64, 112	; TITLE, ARRIVAL, ARRIVAL2, TELESCOPE
	.byte	127,127,0,0	; ARRIVAL3, PATH


disk_exit_disk: ; note: not BCD anymore
	.byte 2		;
	.byte 0
	.byte 0
	.byte 0			; story
disk_exit_disk_bcd:
	.byte $02		;
	.byte 0
	.byte 0
	.byte 0
disk_exit_dni_h:
	.byte $00
	.byte 0
	.byte 0
	.byte 0
disk_exit_dni_l:
	.byte $02
	.byte 0
	.byte 0
	.byte 0

	; want to go to disk02, LOAD_STEPS1, RIVEN_STEPS1, N

disk_exit_load:
	.byte LOAD_STEPS1
	.byte 0
	.byte 0
	.byte LOAD_CYAN
disk_exit_level:
	.byte RIVEN_STEPS1
	.byte 0
	.byte 0
	.byte 0
disk_exit_direction:
	.byte DIRECTION_N
	.byte 0
	.byte 0
	.byte 0
