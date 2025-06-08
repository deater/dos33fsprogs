; Peasant's Quest

; Kerrek1 Loader

; by Vince `deater` Weaver	vince@deater.net


.include "../location_common/include_common.s"

kerrek1_loader:

DIALOG_LOCATION=kerrek1_text_zx02
PRIORITY_LOCATION=kerrek1_priority_zx02
BG_LOCATION=kerrek1_zx02
CORE_LOCATION=kerrek1_core_zx02

.include "../location_common/loader_common.s"

        jmp     $8000

.include "graphics_kerrek1/kerrek1_graphics.inc"
.include "graphics_kerrek1/kerrek1_priority.inc"

kerrek1_text_zx02:
.incbin "../text/DIALOG_KERREK1.ZX02"

kerrek1_core_zx02:
.incbin "KERREK1_CORE.zx02"

.include "../priority_copy.s"

