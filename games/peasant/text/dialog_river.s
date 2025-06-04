.include "lookup.inc"

river_dialog_start:

.include "rock.inc.lookup"

river_dialog_end:

.assert (>river_dialog_end - >river_dialog_start) < $1E , error, "river dialog too big"

