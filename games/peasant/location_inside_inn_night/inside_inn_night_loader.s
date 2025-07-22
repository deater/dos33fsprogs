; Peasant's Quest

; Inside Inn Loader

; by Vince `deater` Weaver	vince@deater.net

.include "../location_common/include_common.s"

inside_inn_loader:

DIALOG_LOCATION=inside_inn_night_text_zx02
PRIORITY_LOCATION=inside_inn_night_priority_zx02
BG_LOCATION=inside_inn_night_zx02
CORE_LOCATION=inside_inn_night_core_zx02

.include "../location_common/loader_common.s"


        jmp     $8000


.include "graphics_inside_inn_night/inside_inn_night_graphics.inc"
.include "graphics_inside_inn_night/inside_inn_night_priority.inc"

inside_inn_night_text_zx02:
.incbin "../text/DIALOG_INSIDE_INN_NIGHT.ZX02"

inside_inn_night_core_zx02:
.incbin "INSIDE_INN_NIGHT_CORE.zx02"

.include "../priority_copy.s"
