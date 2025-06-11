; Peasant's Quest

; Wavy Tree Loader

; by Vince `deater` Weaver	vince@deater.net

.include "../location_common/include_common.s"

wavy_tree_loader:

DIALOG_LOCATION=wavy_tree_text_zx02
PRIORITY_LOCATION=ned_priority_zx02
BG_LOCATION=ned_zx02
CORE_LOCATION=wavy_tree_core_zx02

.include "../location_common/loader_common.s"


        jmp     $8000


.include "graphics_wavy_tree/ned_graphics.inc"
.include "graphics_wavy_tree/ned_priority.inc"

wavy_tree_text_zx02:
.incbin "../text/DIALOG_WAVY_TREE.ZX02"

wavy_tree_core_zx02:
.incbin "WAVY_TREE_CORE.zx02"

.include "../priority_copy.s"
