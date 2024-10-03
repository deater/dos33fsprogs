peasant1_dialog_start:

.include "gary.inc.lookup"
.include "kerrek.inc.lookup"
.include "well.inc.lookup"
.include "tree.inc.lookup"
.include "falls.inc.lookup"

peasant1_dialog_end:

.assert (>peasant1_dialog_end - >peasant1_dialog_start) < $1E , error, "peasant1 dialog too big"
