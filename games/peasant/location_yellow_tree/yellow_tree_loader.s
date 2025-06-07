; Peasant's Quest

; Yellow Tree Loader

; by Vince `deater` Weaver	vince@deater.net

.include "../location_common/include_common.s"

yellow_tree_loader:

DIALOG_LOCATION=yellow_tree_text_zx02
PRIORITY_LOCATION=yellow_tree_priority_zx02
BG_LOCATION=yellow_tree_zx02
CORE_LOCATION=yellow_tree_core_zx02

.include "../location_common/loader_common.s"

	jmp	$8000

robe_sprite_data:
	.incbin "../sprites_peasant/robe_sprites.zx02"

.include "graphics_yellow_tree/yellow_tree_graphics.inc"
.include "graphics_yellow_tree/yellow_tree_priority.inc"

yellow_tree_text_zx02:
.incbin "../text/DIALOG_YELLOW_TREE.ZX02"

yellow_tree_core_zx02:
.incbin "YELLOW_TREE_CORE.zx02"

.include "../priority_copy.s"
