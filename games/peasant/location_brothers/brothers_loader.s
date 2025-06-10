; Peasant's Quest

; Brothers / Archery Loader

; by Vince `deater` Weaver	vince@deater.net

.include "../location_common/include_common.s"

lake_east_loader:

DIALOG_LOCATION=brothers_text_zx02
PRIORITY_LOCATION=archery_priority_zx02
BG_LOCATION=archery_zx02
CORE_LOCATION=brothers_core_zx02

.include "../location_common/loader_common.s"


        jmp     $8000


.include "graphics_brothers/archery_graphics.inc"
.include "graphics_brothers/archery_priority.inc"

brothers_text_zx02:
.incbin "../text/DIALOG_BROTHERS.ZX02"

brothers_core_zx02:
.incbin "BROTHERS_CORE.zx02"

.include "../priority_copy.s"
