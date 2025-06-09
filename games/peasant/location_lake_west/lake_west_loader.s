; Peasant's Quest

; Lake West Loader

; by Vince `deater` Weaver	vince@deater.net

.include "../location_common/include_common.s"

lake_west_loader:

DIALOG_LOCATION=lake_west_text_zx02
PRIORITY_LOCATION=lake_w_priority_zx02
BG_LOCATION=lake_w_zx02
CORE_LOCATION=lake_west_core_zx02

.include "../location_common/loader_common.s"


        jmp     $8000


.include "graphics_lake_west/lake_w_graphics.inc"
.include "graphics_lake_west/lake_w_priority.inc"

lake_west_text_zx02:
.incbin "../text/DIALOG_LAKE_WEST.ZX02"

lake_west_core_zx02:
.incbin "LAKE_WEST_CORE.zx02"

.include "../priority_copy.s"
