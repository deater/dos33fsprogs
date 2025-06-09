.include "lookup.inc"

jhonka_dialog_start:

.include "jhonka.inc.lookup"

jhonka_dialog_end:

.assert (>jhonka_dialog_end - >jhonka_dialog_start) < $1E , error, "jhonka dialog too big"

