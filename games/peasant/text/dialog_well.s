.include "lookup.inc"

well_dialog_start:

.include "well.inc.lookup"

well_dialog_end:

.assert (>well_dialog_end - >well_dialog_start) < $1E , error, "well dialog too big"


