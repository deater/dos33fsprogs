.include "lookup.inc"

ned_cottage_dialog_start:

.include "ned_cottage.inc.lookup"

ned_cottage_dialog_end:

.assert (>ned_cottage_dialog_end - >ned_cottage_dialog_start) < $1E , error, "ned_cottage dialog too big"

