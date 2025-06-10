; Peasant's Quest

; Cottage Loader

; by Vince `deater` Weaver	vince@deater.net

.include "../location_common/include_common.s"

cottage_loader:

DIALOG_LOCATION=cottage_text_zx02
PRIORITY_LOCATION=cottage_priority_zx02
BG_LOCATION=cottage_zx02
CORE_LOCATION=cottage_core_zx02

.include "../location_common/loader_common.s"


        jmp     $8000


.include "graphics_cottage/cottage_graphics.inc"
.include "graphics_cottage/cottage_priority.inc"

cottage_text_zx02:
.incbin "../text/DIALOG_COTTAGE.ZX02"

cottage_core_zx02:
.incbin "COTTAGE_CORE.zx02"

.include "../priority_copy.s"
