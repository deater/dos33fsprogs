.include "lookup.inc"

inside_lady_dialog_start:

.include "inside_lady.inc.lookup"

inside_lady_dialog_end:

.assert (>inside_lady_dialog_end - >inside_lady_dialog_start) < $1E , error, "inside_lady dialog too big"


