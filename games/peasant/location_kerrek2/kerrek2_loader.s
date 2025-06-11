; Peasant's Quest

; Kerrek2 Loader


; by Vince `deater` Weaver	vince@deater.net


.include "../location_common/include_common.s"

kerrek2_loader:

DIALOG_LOCATION=kerrek2_text_zx02
PRIORITY_LOCATION=bottom_prints_priority_zx02
BG_LOCATION=bottom_prints_zx02
CORE_LOCATION=kerrek2_core_zx02

.include "../location_common/loader_common.s"

        jmp     $8000

.include "graphics_kerrek2/bottom_prints_graphics.inc"
.include "graphics_kerrek2/bottom_prints_priority.inc"

kerrek2_text_zx02:
.incbin "../text/DIALOG_KERREK2.ZX02"

kerrek2_core_zx02:
.incbin "KERREK2_CORE.zx02"

.include "../priority_copy.s"

