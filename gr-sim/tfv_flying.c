// 0 = use fancy hi-res floating point
// 1 = use reduced fixed point
// 2 = use 6502 instrumented code
#define FIXEDPT	42


#if (FIXEDPT==0)
#include "tfv_flying_float.c"
#elif (FIXEDPT==1)
#include "tfv_flying_fixed.c"
#else
#include "tfv_flying_6502.c"
#endif

