; Peasant's Quest

; Lake East Loader

; by Vince `deater` Weaver	vince@deater.net

.include "../location_common/include_common.s"

lake_east_loader:

DIALOG_LOCATION=lake_east_text_zx02
PRIORITY_LOCATION=lake_e_priority_zx02
BG_LOCATION=lake_e_zx02
CORE_LOCATION=lake_east_core_zx02

.include "../location_common/loader_common.s"


        jmp     $8000


.include "graphics_lake_east/lake_e_graphics.inc"
.include "graphics_lake_east/lake_e_priority.inc"

lake_east_text_zx02:
.incbin "../text/DIALOG_LAKE_EAST.ZX02"

lake_east_core_zx02:
.incbin "LAKE_EAST_CORE.zx02"

.include "../priority_copy.s"
