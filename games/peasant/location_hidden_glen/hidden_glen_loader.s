; Peasant's Quest

; Hidden Glen Loader

; by Vince `deater` Weaver	vince@deater.net

.include "../location_common/include_common.s"

hidden_glen_loader:

DIALOG_LOCATION=hidden_glen_text_zx02
PRIORITY_LOCATION=hidden_glen_priority_zx02
BG_LOCATION=hidden_glen_zx02
CORE_LOCATION=hidden_glen_core_zx02

.include "../location_common/loader_common.s"


        jmp     $8000


.include "graphics_hidden_glen/hidden_glen_graphics.inc"
.include "graphics_hidden_glen/hidden_glen_priority.inc"

hidden_glen_text_zx02:
.incbin "../text/DIALOG_HIDDEN_GLEN.ZX02"

hidden_glen_core_zx02:
.incbin "HIDDEN_GLEN_CORE.zx02"

.include "../priority_copy.s"
