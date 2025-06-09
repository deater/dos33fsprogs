.include "lookup.inc"

outside_inn_dialog_start:

.include "outside_inn.inc.lookup"

outside_inn_dialog_end:

.assert (>outside_inn_dialog_end - >outside_inn_dialog_start) < $1E , error, "outside_inn dialog too big"

