.include "lookup.inc"

wavy_tree_dialog_start:

.include "wavy_tree.inc.lookup"

wavy_tree_dialog_end:

.assert (>wavy_tree_dialog_end - >wavy_tree_dialog_start) < $1E , error, "wavy_tree dialog too big"

