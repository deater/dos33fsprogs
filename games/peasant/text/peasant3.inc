peasant3_dialog_start:

.include "jhonka.inc.lookup"
.include "cottage.inc.lookup"
.include "lake_west.inc.lookup"
.include "lake_east.inc.lookup"
.include "outside_inn.inc.lookup"

peasant3_dialog_end:

.assert (>peasant3_dialog_end - >peasant3_dialog_start) < $1E , error, "peasant3 dialog too big"
