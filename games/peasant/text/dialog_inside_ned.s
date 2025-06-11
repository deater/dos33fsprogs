.include "lookup.inc"

inside_ned_dialog_start:

.include "inside_ned.inc.lookup"

inside_ned_dialog_end:

.assert (>inside_ned_dialog_end - >inside_ned_dialog_start) < $1E , error, "inside_ned dialog too big"


