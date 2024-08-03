.include "../zp.inc"
.include "../disk02_files/disk02_defines.inc"
.include "../disk00_files/disk00_defines.inc"

which_disk_bcd:
	.byte	$03		; BCD

which_disk_bin:
	.byte	3

load_address_array:
	.byte	$40,$40,$40,$40	; TITLE, DSTEPS1,DSTEPS3,OUTSIDE
	.byte	$40,$40,$00,$00 ; CAVE, DOORWAY

track_array:
	.byte	0, 2, 8,14	; TITLE, DSTEPS1,DSTEPS3,OUTSIDE
	.byte	21,27,0,0	; CAVE, DOORWAY

sector_array:
	.byte	8, 0, 0, 0	; TITLE, DSTEPS1,DSTEPS3,OUTSIDE
	.byte	0,0,0,0		; CAVE, DOORWAY

length_array:
	.byte	8, 96,96,112	; TITLE, DSTEPS1,DSTEPS3,OUTSIDE
	.byte	96,96,0,0	; CAVE, DOORWAY


disk_exit_disk: ; note: not BCD anymore
	.byte	$02
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0

disk_exit_disk_bcd:
	.byte	$02
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0


disk_exit_dni_h:
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
disk_exit_dni_l:
	.byte	$02
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0

			;
disk_exit_load:
	.byte	LOAD_TOP
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	LOAD_CYAN
disk_exit_level:
	.byte	RIVEN_TOP
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
disk_exit_direction:
	.byte	DIRECTION_S
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
