; Peasant's Quest

; Trogdor's Outer Sanctum Loader

; by Vince `deater` Weaver	vince@deater.net

.include "../location_common/include_common.s"

outer_loader:

DIALOG_LOCATION=outer_text_zx02
PRIORITY_LOCATION=outer_priority_zx02
BG_LOCATION=outer_zx02
CORE_LOCATION=outer_core_zx02

.include "../location_common/loader_common.s"

	jmp     $8000

.include "graphics_outer/outer_graphics.inc"
.include "graphics_outer/outer_priority.inc"

outer_text_zx02:
.incbin "../text/DIALOG_OUTER.ZX02"

outer_core_zx02:
.incbin "OUTER_CORE.zx02"

.include "../priority_copy.s"
