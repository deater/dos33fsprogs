.include "lookup.inc"

gary_dialog_start:

.include "gary.inc.lookup"

gary_dialog_end:

.assert (>gary_dialog_end - >gary_dialog_start) < $1E , error, "gary dialog too big"


