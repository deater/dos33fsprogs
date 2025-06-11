.include "lookup.inc"

lady_cottage_dialog_start:

.include "lady_cottage.inc.lookup"

lady_cottage_dialog_end:

.assert (>lady_cottage_dialog_end - >lady_cottage_dialog_start) < $1E , error, "lady_cottage dialog too big"

