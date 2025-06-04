.include "lookup.inc"

knight_dialog_start:

.include "knight.inc.lookup"

knight_dialog_end:

.assert (>knight_dialog_end - >knight_dialog_start) < $1E , error, "knight dialog too big"

