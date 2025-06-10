; Peasant's Quest

; Haystack Loader

; by Vince `deater` Weaver	vince@deater.net

.include "../location_common/include_common.s"

haystack_loader:

DIALOG_LOCATION=haystack_text_zx02
PRIORITY_LOCATION=haystack_priority_zx02
BG_LOCATION=haystack_zx02
CORE_LOCATION=haystack_core_zx02

.include "../location_common/loader_common.s"


        jmp     $8000


.include "graphics_haystack/haystack_graphics.inc"
.include "graphics_haystack/haystack_priority.inc"

haystack_text_zx02:
.incbin "../text/DIALOG_HAYSTACK.ZX02"

haystack_core_zx02:
.incbin "HAYSTACK_CORE.zx02"

.include "../priority_copy.s"
