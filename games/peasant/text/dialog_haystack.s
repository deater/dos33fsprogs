.include "lookup.inc"

haystack_dialog_start:

.include "hay.inc.lookup"

haystack_dialog_end:

.assert (>haystack_dialog_end - >haystack_dialog_start) < $1E , error, "haystack dialog too big"

