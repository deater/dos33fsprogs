; Peasant's Quest

; o/~ By the beautiful, the beautiful river o/~  (location 3,2)

; by Vince `deater` Weaver	vince@deater.net

.include "../location_common/include_common.s"

river_loader:

DIALOG_LOCATION = river_text_zx02
PRIORITY_LOCATION = river_priority_zx02
BG_LOCATION = river_zx02
CORE_LOCATION = river_core_zx02

.include "../location_common/loader_common.s"

	jmp	$8000

robe_sprite_data:
        .incbin "../sprites_peasant/robe_sprites.zx02"

.include "graphics_river/river_graphics.inc"
.include "graphics_river/river_priority.inc"

river_text_zx02:
.incbin "../text/DIALOG_RIVER.ZX02"

river_core_zx02:
.incbin "RIVER_CORE.zx02"

.include "../priority_copy.s"
