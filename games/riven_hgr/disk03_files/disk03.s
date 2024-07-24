.include "../zp.inc"
.include "../disk02_files/disk02_defines.inc"
;.include "../disk04_files/disk04_defines.inc"
.include "../disk00_files/disk00_defines.inc"

which_disk_bcd:
	.byte	$03		; BCD

which_disk_bin:
	.byte	3

load_address_array:
	.byte	$40,$40,$40,$40	; TITLE, STEPS1,STEPS3,OUTSIDE
	.byte	$40,$00,$00,$00 ;

track_array:
	.byte	0, 2, 9,16	; TITLE, STEPS1,STEPS3,OUTSIDE
	.byte	22,0,0,0	;

sector_array:
	.byte	8, 0, 0, 0	; TITLE, STEPS1,STEPS3,OUTSIDE
	.byte	0,0,0,0		;

length_array:
	.byte	8, 96,84, 96	; TITLE, STEPS1,STEPS3,OUTSIDE
	.byte	80,0,0,0


disk_exit_disk: ; note: not BCD anymore
	.byte	$02
	.byte	0
	.byte	0
	.byte	0

disk_exit_disk_bcd:
	.byte	$02
	.byte	0
	.byte	0
	.byte	0


disk_exit_dni_h:
	.byte	0
	.byte	0
	.byte	0
	.byte	0
disk_exit_dni_l:
	.byte	$02
	.byte	0
	.byte	0
	.byte	0

			;
disk_exit_load:
	.byte	LOAD_TOP
	.byte	0
	.byte	0
	.byte	LOAD_CYAN
disk_exit_level:
	.byte	RIVEN_TOP
	.byte	0
	.byte	0
	.byte	0
disk_exit_direction:
	.byte	DIRECTION_S
	.byte	0
	.byte	0
	.byte	0
