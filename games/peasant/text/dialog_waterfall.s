.include "lookup.inc"

waterfall_dialog_start:

.include "falls.inc.lookup"

waterfall_dialog_end:

.assert (>waterfall_dialog_end - >waterfall_dialog_start) < $1E , error, "waterfall dialog too big"


