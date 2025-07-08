; Peasant's Quest

; Trogdor's Inner Sanctum Loader

; by Vince `deater` Weaver	vince@deater.net

.include "../location_common/include_common.s"

trogdor_loader:

DIALOG_LOCATION=trogdor_text_zx02
PRIORITY_LOCATION=trogdor_priority_zx02
BG_LOCATION=trogdor_cave_zx02
CORE_LOCATION=trogdor_core_zx02

.include "../location_common/loader_common.s"

	jmp     $8000

.include "graphics_trogdor/trogdor_bg.inc"
.include "graphics_trogdor/trogdor_priority.inc"

trogdor_text_zx02:
.incbin "../text/DIALOG_TROGDOR.ZX02"

trogdor_core_zx02:
.incbin "TROGDOR_CORE.zx02"

.include "../priority_copy.s"

trogdor_end:

.assert (>trogdor_end - >trogdor_loader) < $20 , error, "trogdor too big"
