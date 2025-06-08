; Peasant's Quest

; Cliff Base

; just the cliff base
;	we're going crazy with disk accesses now

; by Vince `deater` Weaver	vince@deater.net

.include "../location_common/include_common.s"

cliff_base_loader:

DIALOG_LOCATION=cliff_text_zx02
;VERB_TABLE=cliff_base_verb_table
PRIORITY_LOCATION=cliff_base_priority_zx02
BG_LOCATION=cliff_base_zx02
CORE_LOCATION=cliff_base_core_zx02

.include "../location_common/loader_common.s"

	jmp	$8000

;robe_sprite_data:
;	.incbin "../sprites_peasant/robe_sprites.zx02"

.include "graphics_cliff/cliff_graphics.inc"
.include "graphics_cliff/cliff_priority.inc"

cliff_text_zx02:
.incbin "../text/DIALOG_CLIFF_BASE.ZX02"

cliff_base_core_zx02:
.incbin "CLIFF_BASE_CORE.zx02"

.include "../priority_copy.s"
