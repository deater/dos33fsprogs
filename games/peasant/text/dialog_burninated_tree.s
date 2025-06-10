.include "lookup.inc"

burninated_tree_dialog_start:

.include "burninated_tree.inc.lookup"

burninated_tree_dialog_end:

.assert (>burninated_tree_dialog_end - >burninated_tree_dialog_start) < $1E , error, "burninated_tree dialog too big"

