; Peasant's Quest

; Gary Loader

; by Vince `deater` Weaver	vince@deater.net

.include "../location_common/include_common.s"

gary_loader:

DIALOG_LOCATION=gary_text_zx02
PRIORITY_LOCATION=gary_priority_zx02
BG_LOCATION=gary_zx02
CORE_LOCATION=gary_core_zx02

.include "../location_common/loader_common.s"

        jmp     $8000

.include "graphics_gary/gary_graphics.inc"
.include "graphics_gary/gary_priority.inc"

gary_text_zx02:
.incbin "../text/DIALOG_GARY.ZX02"

gary_core_zx02:
.incbin "GARY_CORE.zx02"

.include "../priority_copy.s"
