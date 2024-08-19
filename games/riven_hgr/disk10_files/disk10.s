.include "../zp.inc"
.include "../disk02_files/disk02_defines.inc"
.include "../disk00_files/disk00_defines.inc"

which_disk_bcd:
	.byte	$10		; BCD

which_disk_bin:
	.byte	10

load_address_array:
	.byte	$40,$40,$40,$40	; TITLE, CENTER, LEVEL_15, LEVEL_21
	.byte	$40,$40,$40,$40 ; LEVEL_32,LEVEL_43,LEVEL_54,PILLARS

track_array:
	.byte	0, 2, 8,11	; TITLE, CENTER, LEVEL_15, LEVEL_21
	.byte	14,17,20,23	; LEVEL_32,LEVEL_43,LEVEL_54,PILLARS

sector_array:
	.byte	8, 0, 0, 0	; TITLE, CENTER, LEVEL_15, LEVEL_21
	.byte	0,0,0,0		; LEVEL_32,LEVEL_43,LEVEL_54,PILLARS

length_array:
	.byte	8, 112,48,48	; TITLE, CENTER, LEVEL_15, LEVEL_21
	.byte	48,48,48,112	; LEVEL_32,LEVEL_43,LEVEL_54,PILLARS


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
