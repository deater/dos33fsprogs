; Peasant's Quest

; Inside Ned Loader

; by Vince `deater` Weaver	vince@deater.net

.include "../location_common/include_common.s"

inside_ned_loader:

DIALOG_LOCATION=inside_ned_text_zx02
PRIORITY_LOCATION=inside_nn_priority_zx02
BG_LOCATION=inside_nn_zx02
CORE_LOCATION=inside_ned_core_zx02

.include "../location_common/loader_common.s"


        jmp     $8000


.include "graphics_inside_ned/inside_ned_graphics.inc"
.include "graphics_inside_ned/inside_ned_priority.inc"

inside_ned_text_zx02:
.incbin "../text/DIALOG_INSIDE_NED.ZX02"

inside_ned_core_zx02:
.incbin "INSIDE_NED_CORE.zx02"

.include "../priority_copy.s"
