; Peasant's Quest

; Lady Cottage Loader

; by Vince `deater` Weaver	vince@deater.net

.include "../location_common/include_common.s"

lady_cottage_loader:

DIALOG_LOCATION=lady_cottage_text_zx02
PRIORITY_LOCATION=lady_cottage_priority_zx02
BG_LOCATION=lady_cottage_zx02
BG_NIGHT_LOCATION=lady_cottage_night_zx02
CORE_LOCATION=lady_cottage_core_zx02

LOAD_NIGHT = 1

.include "../location_common/loader_common.s"


        jmp     $8000


.include "graphics_lady_cottage/lady_cottage_graphics.inc"
.include "graphics_lady_cottage/lady_cottage_night_graphics.inc"
.include "graphics_lady_cottage/lady_cottage_priority.inc"

lady_cottage_text_zx02:
.incbin "../text/DIALOG_LADY_COTTAGE.ZX02"

lady_cottage_core_zx02:
.incbin "LADY_COTTAGE_CORE.zx02"

.include "../priority_copy.s"
