; Peasant's Quest

; Puddle Loader

; by Vince `deater` Weaver	vince@deater.net

.include "../location_common/include_common.s"

puddle_loader:

DIALOG_LOCATION=puddle_text_zx02
PRIORITY_LOCATION=puddle_priority_zx02
BG_LOCATION=puddle_zx02
CORE_LOCATION=puddle_core_zx02

.include "../location_common/loader_common.s"


        jmp     $8000


.include "graphics_puddle/puddle_graphics.inc"
.include "graphics_puddle/puddle_priority.inc"

puddle_text_zx02:
.incbin "../text/DIALOG_PUDDLE.ZX02"

puddle_core_zx02:
.incbin "PUDDLE_CORE.zx02"

.include "../priority_copy.s"
