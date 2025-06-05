.include "lookup.inc"

puddle_dialog_start:

.include "mud.inc.lookup"

puddle_dialog_end:

.assert (>puddle_dialog_end - >puddle_dialog_start) < $1E , error, "puddle dialog too big"

