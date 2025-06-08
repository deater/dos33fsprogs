; Peasant's Quest

; Cliff Heights Loader

; Top of the cliff

; by Vince `deater` Weaver	vince@deater.net

.include "../location_common/include_common.s"

DIALOG_LOCATION=cliff_heights_text_zx02
PRIORITY_LOCATION=cliff_heights_priority_zx02
BG_LOCATION=cliff_heights_zx02
CORE_LOCATION=cliff_heights_core_zx02

.include "../location_common/loader_common.s"

	jmp	$8000

.include "graphics_heights/cliff_heights_graphics.inc"
.include "graphics_heights/cliff_heights_priority.inc"

cliff_heights_text_zx02:
.incbin "../text/DIALOG_CLIFF_HEIGHTS.ZX02"

cliff_heights_core_zx02:
.incbin "CLIFF_HEIGHTS_CORE.zx02"

.include "../priority_copy.s"
