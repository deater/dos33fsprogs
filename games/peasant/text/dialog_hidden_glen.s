.include "lookup.inc"

hidden_glen_dialog_start:

.include "hidden_glen.inc.lookup"

hidden_glen_dialog_end:

.assert (>hidden_glen_dialog_end - >hidden_glen_dialog_start) < $1E , error, "hidden_glen dialog too big"


