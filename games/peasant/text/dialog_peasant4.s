.include "lookup.inc"

peasant4_dialog_start:

.include "ned_cottage.inc.lookup"
.include "wavy_tree.inc.lookup"
.include "kerrek.inc.lookup"
.include "lady_cottage.inc.lookup"
.include "burninated_tree.inc.lookup"

peasant4_dialog_end:

.assert (>peasant4_dialog_end - >peasant4_dialog_start) < $1E , error, "peasant4 dialog too big"

