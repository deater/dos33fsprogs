; Peasant's Quest

; Waterfall Loader

; by Vince `deater` Weaver	vince@deater.net

.include "../location_common/include_common.s"

waterfall_loader:

DIALOG_LOCATION=waterfall_text_zx02
PRIORITY_LOCATION=waterfall_priority_zx02
BG_LOCATION=waterfall_zx02
CORE_LOCATION=waterfall_core_zx02

.include "../location_common/loader_common.s"

	jmp	$8000


robe_sprite_data:
        .incbin "../sprites_peasant/robe_sprites.zx02"

.include "graphics_waterfall/waterfall_graphics.inc"
.include "graphics_waterfall/waterfall_priority.inc"

waterfall_text_zx02:
.incbin "../text/DIALOG_WATERFALL.ZX02"

waterfall_core_zx02:
.incbin "WATERFALL_CORE.zx02"

.include "../priority_copy.s"
