; Peasant's Quest

; Inside Lady Loader

; by Vince `deater` Weaver	vince@deater.net

.include "../location_common/include_common.s"

inside_lady_loader:

DIALOG_LOCATION=inside_lady_text_zx02
PRIORITY_LOCATION=inside_cottage_priority_zx02
BG_LOCATION=inside_cottage_zx02
CORE_LOCATION=inside_lady_core_zx02

.include "../location_common/loader_common.s"


        jmp     $8000


.include "graphics_inside_lady/inside_lady_graphics.inc"
.include "graphics_inside_lady/inside_lady_priority.inc"

inside_lady_text_zx02:
.incbin "../text/DIALOG_INSIDE_LADY.ZX02"

inside_lady_core_zx02:
.incbin "INSIDE_LADY_CORE.zx02"

.include "../priority_copy.s"
