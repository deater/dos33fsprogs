.include "lookup.inc"

lake_west_dialog_start:

.include "lake_west.inc.lookup"

lake_west_dialog_end:

.assert (>lake_west_dialog_end - >lake_west_dialog_start) < $1E , error, "lake_west dialog too big"

