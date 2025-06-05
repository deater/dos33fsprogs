.include "lookup.inc"

brothers_dialog_start:

.include "archery.inc.lookup"

brothers_dialog_end:

.assert (>brothers_dialog_end - >brothers_dialog_start) < $1E , error, "brothers dialog too big"

