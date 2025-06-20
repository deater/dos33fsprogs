; Peasant's Quest

; Knight Loader

; by Vince `deater` Weaver	vince@deater.net

.include "../location_common/include_common.s"

knight_loader:

DIALOG_LOCATION=knight_text_zx02
PRIORITY_LOCATION=knight_priority_zx02
BG_LOCATION=knight_zx02
CORE_LOCATION=knight_core_zx02

.include "../location_common/loader_common.s"


	jmp	$8000


.include "graphics_knight/knight_graphics.inc"
.include "graphics_knight/knight_priority.inc"

knight_text_zx02:
.incbin "../text/DIALOG_KNIGHT.ZX02"

knight_core_zx02:
.incbin "KNIGHT_CORE.zx02"

.include "../priority_copy.s"

