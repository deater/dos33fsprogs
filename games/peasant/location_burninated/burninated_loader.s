; Peasant's Quest

; Crooked / Burninated Tree Loader

; by Vince `deater` Weaver	vince@deater.net

.include "../location_common/include_common.s"

burninated_loader:

DIALOG_LOCATION=burninated_text_zx02
PRIORITY_LOCATION=crooked_tree_priority_zx02
BG_LOCATION=crooked_tree_zx02
BG_NIGHT_LOCATION=crooked_tree_night_zx02
CORE_LOCATION=burninated_core_zx02

LOAD_NIGHT = 1

.include "../location_common/loader_common.s"


        jmp     $8000


.include "graphics_burninated/crooked_tree_graphics.inc"
.include "graphics_burninated/crooked_tree_night_graphics.inc"
.include "graphics_burninated/crooked_tree_priority.inc"

burninated_text_zx02:
.incbin "../text/DIALOG_BURNINATED_TREE.ZX02"

burninated_core_zx02:
.incbin "BURNINATED_CORE.zx02"

.include "../priority_copy.s"
