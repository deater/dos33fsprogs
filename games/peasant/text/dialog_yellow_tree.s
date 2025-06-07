.include "lookup.inc"

yellow_tree_dialog_start:

.include "yellow_tree.inc.lookup"

yellow_tree_dialog_end:

.assert (>yellow_tree_dialog_end - >yellow_tree_dialog_start) < $1E , error, "yellow_tree dialog too big"


