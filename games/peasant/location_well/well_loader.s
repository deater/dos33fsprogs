; Peasant's Quest

; Wishing Well Loader

; by Vince `deater` Weaver	vince@deater.net

.include "../location_common/include_common.s"

well_loader:

DIALOG_LOCATION=well_text_zx02
PRIORITY_LOCATION=well_priority_zx02
BG_LOCATION=well_zx02
CORE_LOCATION=well_core_zx02

.include "../location_common/loader_common.s"

	jmp	$8000

.include "graphics_well/well_graphics.inc"
.include "graphics_well/well_priority.inc"

well_text_zx02:
.incbin "../text/DIALOG_WELL.ZX02"

well_core_zx02:
.incbin "WELL_CORE.zx02"

.include "../priority_copy.s"
