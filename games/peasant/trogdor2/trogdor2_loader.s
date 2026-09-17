; Peasant's Quest

; Trogdor's Inner Sanctum Loader II

; by Vince `deater` Weaver	vince@deater.net

.include "../location_common/include_common.s"

trogdor_loader:

DIALOG_LOCATION=trogdor2_text_zx02
PRIORITY_LOCATION=trogdor_priority_zx02
BG_LOCATION=trogdor_cave_zx02
CORE_LOCATION=trogdor2_core_zx02

.include "../location_common/loader_common.s"

	jmp     $8000

.include "graphics_trogdor2/trogdor_cave.inc"
.include "graphics_trogdor2/trogdor_priority.inc"

trogdor2_text_zx02:
.incbin "../text/DIALOG_TROGDOR2.ZX02"

trogdor2_core_zx02:
.incbin "TROGDOR2_CORE.zx02"

.include "../priority_copy.s"

trogdor_end:

.assert (>trogdor_end - >trogdor_loader) < $20 , error, "trogdor too big"
