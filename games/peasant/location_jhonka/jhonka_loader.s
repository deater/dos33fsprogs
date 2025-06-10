; Peasant's Quest

; Jhonka Loader

; by Vince `deater` Weaver	vince@deater.net

.include "../location_common/include_common.s"

jhonka_loader:

DIALOG_LOCATION=jhonka_text_zx02
PRIORITY_LOCATION=jhonka_priority_zx02
BG_LOCATION=jhonka_zx02
CORE_LOCATION=jhonka_core_zx02

.include "../location_common/loader_common.s"


        jmp     $8000


.include "graphics_jhonka/jhonka_graphics.inc"
.include "graphics_jhonka/jhonka_priority.inc"

jhonka_text_zx02:
.incbin "../text/DIALOG_JHONKA.ZX02"

jhonka_core_zx02:
.incbin "JHONKA_CORE.zx02"

.include "../priority_copy.s"
