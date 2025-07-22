; Peasant's Quest

; Outside Inn Loader

; by Vince `deater` Weaver	vince@deater.net

.include "../location_common/include_common.s"

outside_inn_loader:

DIALOG_LOCATION=outside_inn_text_zx02
PRIORITY_LOCATION=inn_priority_zx02
BG_LOCATION=inn_zx02
BG_NIGHT_LOCATION=inn_night_zx02
CORE_LOCATION=outside_inn_core_zx02

LOAD_NIGHT=1

.include "../location_common/loader_common.s"


        jmp     $8000


.include "graphics_outside_inn/inn_graphics.inc"
.include "graphics_outside_inn/inn_night_graphics.inc"
.include "graphics_outside_inn/inn_priority.inc"

outside_inn_text_zx02:
.incbin "../text/DIALOG_OUTSIDE_INN.ZX02"

outside_inn_core_zx02:
.incbin "OUTSIDE_INN_CORE.zx02"

.include "../priority_copy.s"
