.include "lookup.inc"

e_lake_dialog_start:

.include "lake_east.inc.lookup"

e_lake_dialog_end:

.assert (>e_lake_dialog_end - >e_lake_dialog_start) < $1E , error, "e_lake dialog too big"

