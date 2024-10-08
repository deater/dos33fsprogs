.include "../zp.inc"
.include "../disk01_files/disk01_defines.inc"
.include "../disk03_files/disk03_defines.inc"
.include "../disk04_files/disk04_defines.inc"
.include "../disk10_files/disk10_defines.inc"
.include "../disk00_files/disk00_defines.inc"

which_disk_bcd:
	.byte	$02		; BCD

which_disk_bin:
	.byte	2

load_address_array:
	.byte	$40,$40,$40,$40	; TITLE, STEPS1, STEPS3, TOP
	.byte	$40,$40,$40,$40 ; BRIDGE,ALCOVE

track_array:
	.byte	0, 2, 8,14	; TITLE, STEPS1, STEPS3, TOP
	.byte	18,22,0,0	; BRIDGE,ALCOVE

sector_array:
	.byte	8, 0, 0, 0	; TITLE, STEPS1, STEPS3, TOP
	.byte	0,0,0,0		; BRIDGE,ALCOVE

length_array:
	.byte	8, 96,96,64	; TITLE, STEPS1, STEPS3, TOP
	.byte	64,96,0,0	; BRIDGE,ALCOVE

	; disk 1

disk_exit_disk: ; note: not BCD anymore
	.byte	1
	.byte	3
	.byte	4
	.byte	10
	.byte	0
	.byte	0

disk_exit_disk_bcd:
	.byte	$01
	.byte	$03
	.byte	$04
	.byte	$10
	.byte	0
	.byte	0


disk_exit_dni_h:
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
disk_exit_dni_l:
	.byte	$01
	.byte	$03
	.byte	$04
	.byte	$20
	.byte	0
	.byte	0

			;
disk_exit_load:
	.byte	LOAD_PATH
	.byte	LOAD_DSTEPS1
	.byte	LOAD_BRIDGE1
	.byte	LOAD_15
	.byte	0
	.byte	LOAD_CYAN
disk_exit_level:
	.byte	RIVEN_STEPS_BASE
	.byte	RIVEN_DOWN1
	.byte	RIVEN_BRIDGE1
	.byte	RIVEN_15
	.byte	0
	.byte	0
disk_exit_direction:
	.byte	DIRECTION_W
	.byte	DIRECTION_N
	.byte	DIRECTION_E
	.byte	DIRECTION_N
	.byte	0
	.byte	0
