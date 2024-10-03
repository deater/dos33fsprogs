.include "lookup.inc"

peasant2_dialog_start:

.include "hay.inc.lookup"
.include "mud.inc.lookup"
.include "archery.inc.lookup"
.include "rock.inc.lookup"
.include "knight.inc.lookup"

peasant2_dialog_end:

.assert (>peasant2_dialog_end - >peasant2_dialog_start) < $1E , error, "peasant2 dialog too big"

