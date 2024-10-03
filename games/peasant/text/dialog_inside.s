.include "lookup.inc"

inside_dialog_start:

.include "hidden_glen.inc.lookup"
.include "inside_lady.inc.lookup"
.include "inside_ned.inc.lookup"

inside_dialog_end:

.assert (>inside_dialog_end - >inside_dialog_start) < $1E , error, "inside dialog too big"


