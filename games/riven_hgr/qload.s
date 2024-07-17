; Loader for Riven

; Based on QLOAD by qkumba which loads raw tracks off of disks

; This particular version only supports using a single disk drive
;	(I have other versions that can look for disks across two drives)

; it also loads the QLOAD paramaters from disk separately

QLOAD_TABLE = $1200
QLOAD_DISK	= $1200
LOAD_ADDRESS_ARRAY = QLOAD_TABLE+1
TRACK_ARRAY	= QLOAD_TABLE+9
SECTOR_ARRAY	= QLOAD_TABLE+17
LENGTH_ARRAY	= QLOAD_TABLE+25
DISK_EXIT_DISK	= QLOAD_TABLE+33
DISK_EXIT_DNI_H = QLOAD_TABLE+37
DISK_EXIT_DNI_L = QLOAD_TABLE+41
DISK_EXIT_LOAD	= QLOAD_TABLE+45
DISK_EXIT_LEVEL = QLOAD_TABLE+49
DISK_EXIT_DIRECTION = QLOAD_TABLE+53


.include "zp.inc"

.include "hardware.inc"

.include "common_defines.inc"

.include "qboot.inc"


qload_start:

.if FLOPPY=1
.include "qload_floppy.s"
.else
.include "qload_hd.s"
.endif

; needs to fit in 1 page

.align	$100

; common includes used by everyone

.include "zx02_optim.s"
.include "wait.s"
.include "wait_a_bit.s"
.include "draw_pointer.s"
.include "log_table.s"
.include "graphics_sprites/pointer_sprites.inc"
.include "hgr_14x14_sprite.s"
.include "keyboard.s"
.include "text_print.s"
.include "gr_offsets.s"

.include "print_dni_numbers.s"
.include "number_sprites.inc"

qload_end:

.assert (>qload_end - >qload_start) < $10 , error, "loader too big"
