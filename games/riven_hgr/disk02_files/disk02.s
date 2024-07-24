.include "../zp.inc"
.include "../disk01_files/disk01_defines.inc"
.include "../disk03_files/disk03_defines.inc"
;.include "../disk04_files/disk04_defines.inc"
.include "../disk00_files/disk00_defines.inc"

which_disk_bcd:
	.byte	$02		; BCD

which_disk_bin:
	.byte	2

load_address_array:
	.byte	$40,$40,$40,$40	; TITLE, STEPS1, STEPS3, STEPS5
	.byte	$40,$00,$00,$00 ; TOP

track_array:
	.byte	0, 2, 9,16	; TITLE, STEPS1, STEPS3, STEPS5
	.byte	22,0,0,0	; TOP

sector_array:
	.byte	8, 0, 0, 0	; TITLE, STEPS1, STEPS3, STEPS5
	.byte	0,0,0,0		; TOP

length_array:
	.byte	8, 96,84, 96	; TITLE, STEPS1, STEPS3, STEPS5
	.byte	80,0,0,0	; TOP

	; disk 1

disk_exit_disk: ; note: not BCD anymore
	.byte	1
	.byte	3
	.byte	4
	.byte	0

disk_exit_disk_bcd:
	.byte	$01
	.byte	$03
	.byte	$04
	.byte	0


disk_exit_dni_h:
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
disk_exit_dni_l:
	.byte	$01
	.byte	$03
	.byte	$04
	.byte	0

			;
disk_exit_load:
	.byte	LOAD_PATH
	.byte	LOAD_OUTSIDE
	.byte	0
	.byte	LOAD_CYAN
disk_exit_level:
	.byte	RIVEN_STEPS_BASE
	.byte	RIVEN_OUTSIDE
	.byte	0
	.byte	0
disk_exit_direction:
	.byte	DIRECTION_W
	.byte	DIRECTION_N
	.byte	0
	.byte	0
