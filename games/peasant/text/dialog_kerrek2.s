.include "lookup.inc"

kerrek2_dialog_start:

.include "kerrek.inc.lookup"

kerrek2_dialog_end:

.assert (>kerrek2_dialog_end - >kerrek2_dialog_start) < $1E , error, "kerrek2 dialog too big"

