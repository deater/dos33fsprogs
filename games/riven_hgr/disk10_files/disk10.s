.include "../zp.inc"
.include "../disk02_files/disk02_defines.inc"
.include "../disk00_files/disk00_defines.inc"

which_disk_bcd:
	.byte	$10		; BCD

which_disk_bin:
	.byte	10

load_address_array:
	.byte	$40,$40,$40,$40	; TITLE, INSIDE
	.byte	$40,$40,$40,$40 ;

track_array:
	.byte	0, 2, 7,12	; TITLE, INSIDE
	.byte	17,22,27,0	;

sector_array:
	.byte	8, 0, 0, 0	; TITLE, INSIDE
	.byte	0,0,0,0		;

length_array:
	.byte	8, 80,80,80	; TITLE, INSIDE
	.byte	80,80,80,0	;


disk_exit_disk: ; note: not BCD anymore
	.byte	2
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0

disk_exit_disk_bcd:
	.byte	$02
	.byte	$00
	.byte	$00
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
	.byte	RIVEN_ALCOVE
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
disk_exit_direction:
	.byte	DIRECTION_E
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
