.include "lookup.inc"

kerrek1_dialog_start:

.include "kerrek.inc.lookup"

kerrek1_dialog_end:

.assert (>kerrek1_dialog_end - >kerrek1_dialog_start) < $1E , error, "kerrek1 dialog too big"


