.include "lookup.inc"

lake_east_dialog_start:

.include "lake_east.inc.lookup"

lake_east_dialog_end:

.assert (>lake_east_dialog_end - >lake_east_dialog_start) < $1E , error, "lake_east dialog too big"

