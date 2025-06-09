.include "lookup.inc"

cottage_dialog_start:

.include "cottage.inc.lookup"

cottage_dialog_end:

.assert (>cottage_dialog_end - >cottage_dialog_start) < $1E , error, "cottage dialog too big"

