; Peasant's Quest

; Ned Cottage Loader

; by Vince `deater` Weaver	vince@deater.net

.include "../location_common/include_common.s"

ned_cottage_loader:

DIALOG_LOCATION=ned_cottage_text_zx02
PRIORITY_LOCATION=empty_hut_priority_zx02
BG_LOCATION=empty_hut_zx02
CORE_LOCATION=ned_cottage_core_zx02

.include "../location_common/loader_common.s"


        jmp     $8000


.include "graphics_ned_cottage/empty_hut_graphics.inc"
.include "graphics_ned_cottage/empty_hut_priority.inc"

ned_cottage_text_zx02:
.incbin "../text/DIALOG_NED_COTTAGE.ZX02"

ned_cottage_core_zx02:
.incbin "NED_COTTAGE_CORE.zx02"

.include "../priority_copy.s"
